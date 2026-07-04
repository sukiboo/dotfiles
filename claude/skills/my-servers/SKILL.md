---
name: my-servers
description: >-
  The user's registry of their remote servers and how to connect to and operate
  them over SSH. Use for any task that needs to reach, run commands on, deploy to,
  manage services on, check, or transfer files to/from one of the user's servers
  or VPSes — including vague references like "the server" or "my vps", and cases
  where no specific host is named. Also covers how to connect from a machine that
  lacks the SSH keys.
---

# My servers

The user keeps a few remote machines reachable over SSH, all defined in their
`~/.ssh/config`. That file is the source of truth: it's synced to each of the
user's machines and supplies the alias, address, login user, and key for every
server, so you connect by alias with no extra flags.

## Discovering the hosts

Before connecting, read the config to see what's available:

```
cat ~/.ssh/config
```

Each `Host` block is a reachable server. The name(s) on the `Host` line are the
aliases you pass to `ssh`/`scp`/`rsync`; `HostName`, `User`, and `IdentityFile`
give the address, login, and key. The path is `~/.ssh/config` on both Linux and
macOS — only the home directory differs — so this works on every machine.

## Running commands

Your shell is non-interactive, so a missing or wrong key must *fail fast* rather
than hang on a password prompt you can't see or answer. Disable interactive auth
and cap the connect time:

```
ssh -o BatchMode=yes -o ConnectTimeout=10 <host> "uptime && df -h /"
```

`BatchMode=yes` makes ssh error out immediately instead of prompting when key
auth isn't available — which is also how you detect the "no keys here" case
below. Put everything you need in the quoted command and chain with `&&`/`;` so
you're not paying for a fresh connection each step.

File transfer uses the same aliases:

```
scp ./build.tar.gz <host>:~/
rsync -avz --progress ./dist/ <host>:/var/www/app/
```

## When the keys aren't here

If you're on a machine without the key files (a different laptop, a fresh
container, someone else's box), the BatchMode probe fails with
`Permission denied (publickey)` — or `Could not resolve hostname` if the config
isn't there either. Don't try to guess or pipe in a password: these hosts use key
auth and almost certainly have password login disabled, and non-interactive
password auth is fragile and insecure besides.

Instead, report what you found and offer the two clean paths — let the user pick:

1. **They run it themselves.** In Claude Code they can type
   `! ssh <host> "<command>"` at the prompt; it runs in this session and the
   output comes straight back into the conversation for you to use. Best for a
   one-off.
2. **Install the key.** If they want you connecting directly, they add the host's
   `Host` block to `~/.ssh/config` and drop its key into `~/.ssh/` (`chmod 400`).
   After that the alias works and you can drive it yourself.

## Working posture

The user wants you to just run commands and report back — no confirm-gating on
routine work like service restarts, deploys, tailing logs, or edits. Apply normal
judgment only to genuinely irreversible, destructive actions (wiping data,
dropping a database, `rm -rf` on something with no backup). Otherwise: run it, and
report what you ran and what came back.
