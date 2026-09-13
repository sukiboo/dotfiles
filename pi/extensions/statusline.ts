import { execFileSync } from "node:child_process";
import { userInfo } from "node:os";
import type { AssistantMessage } from "@earendil-works/pi-ai";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { truncateToWidth } from "@earendil-works/pi-tui";

const DIFF_CACHE_MS = 2_000;
const COMMAND_TIMEOUT_MS = 500;
const NUMBER_BASE = 1_000;
const NUMBER_UNITS = ["", "k", "m", "b", "t"];
const SEP = "  ";

function fmtNum(value: number): string {
	if (!Number.isFinite(value) || value <= 0) return "0";

	let unit = 0;
	while (value >= NUMBER_BASE && unit < NUMBER_UNITS.length - 1) {
		value /= NUMBER_BASE;
		unit++;
	}

	const decimals = unit === 0 || value >= 100 ? 0 : value >= 10 ? 1 : 2;
	return `${value.toFixed(decimals)}${NUMBER_UNITS[unit]}`;
}

function shortCwd(cwd: string): string {
	const parts = cwd.split("/").filter(Boolean);
	return parts.length < 3 ? cwd : `.../${parts.slice(-2).join("/")}`;
}

function getPiVersion(): string {
	try {
		return execFileSync("pi", ["--version"], {
			encoding: "utf8",
			stdio: ["ignore", "pipe", "ignore"],
			timeout: COMMAND_TIMEOUT_MS,
		}).trim() || "?";
	} catch {
		return "?";
	}
}

const version = getPiVersion();
let diffCache = { cwd: "", at: 0, added: 0, removed: 0 };

function gitDiffStats(cwd: string): { added: number; removed: number } {
	const now = Date.now();
	if (diffCache.cwd === cwd && now - diffCache.at < DIFF_CACHE_MS) return diffCache;

	let added = 0;
	let removed = 0;
	try {
		const output = execFileSync("git", ["diff", "--numstat"], {
			cwd,
			encoding: "utf8",
			stdio: ["ignore", "pipe", "ignore"],
			timeout: COMMAND_TIMEOUT_MS,
		});
		for (const line of output.trim().split("\n")) {
			const [additions, removals] = line.split("\t");
			if (additions !== "-") added += Number(additions) || 0;
			if (removals !== "-") removed += Number(removals) || 0;
		}
	} catch {
		// A non-Git directory or timeout has no diff statistics.
	}

	diffCache = { cwd, at: now, added, removed };
	return diffCache;
}

export default function (pi: ExtensionAPI) {
	let modelId = "no-model";

	pi.on("model_select", async (event) => {
		modelId = event.model.id;
	});

	pi.on("session_start", async (_event, ctx) => {
		modelId = ctx.model?.id || "no-model";
		ctx.ui.setFooter((tui, theme, footerData) => ({
			dispose: footerData.onBranchChange(() => tui.requestRender()),
			invalidate() {},
			render(width: number): string[] {
				let input = 0;
				let output = 0;
				let cost = 0;

				for (const entry of ctx.sessionManager.getEntries()) {
					if (entry.type !== "message" || entry.message.role !== "assistant") continue;
					const usage = (entry.message as AssistantMessage).usage;
					if (!usage) continue;
					input += usage.input + usage.cacheRead + usage.cacheWrite;
					output += usage.output;
					cost += usage.cost.total;
				}

				const cwd = ctx.sessionManager.getCwd();
				const context = ctx.getContextUsage();
				const contextPercent = context?.percent == null ? "?%" : `${context.percent.toFixed(0)}%`;
				const contextSize = context?.contextWindow ? `${Math.round(context.contextWindow / NUMBER_BASE)}k` : "?";
				const diff = gitDiffStats(cwd);
				const parts: string[] = [];

				if (process.env.debian_chroot) parts.push(theme.fg("dim", `(${process.env.debian_chroot})`));
				if (process.env.TERM_PROGRAM !== "vscode") {
					parts.push(
						theme.bold(theme.fg("bashMode", userInfo().username)) +
							":" +
							theme.bold(theme.fg("mdLink", shortCwd(cwd))),
					);
				}
				parts.push(theme.fg("accent", modelId));
				parts.push(theme.fg("warning", contextPercent) + theme.fg("dim", "/") + theme.fg("warning", contextSize));
				parts.push(theme.fg("success", `+${diff.added}`) + theme.fg("dim", "/") + theme.fg("error", `-${diff.removed}`));
				parts.push(theme.fg("muted", `${fmtNum(input)}↑ ${fmtNum(output)}↓`));
				parts.push(theme.fg("customMessageLabel", `$${cost.toFixed(2)}`));
				parts.push(theme.fg("dim", `v${version}`));

				return [truncateToWidth(parts.join(SEP), width)];
			},
		}));
	});
}
