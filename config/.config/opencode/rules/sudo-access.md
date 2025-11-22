---
description: Instructions for configuring sudo access in non-interactive sessions
---

If you need to run a command with `sudo` in a non-interactive session, append the `-A` option to the `sudo` command.
This option allows `sudo` to obtain the password using an askpass helper program.

E.g., instead of running:

```bash
sudo some-command
```

Use:

```bash
sudo -A some-command
```
