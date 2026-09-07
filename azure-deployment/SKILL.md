---
name: "azure-deployment"
description: "Deploy and manage Go apps on Azure VMs: systemd, Caddy, Postgres/Redis, firewall, CI/CD. az CLI authenticated."
version: 1
created: "2026-09-07"
updated: "2026-09-07"
---
## When to Use
Use when provisioning Azure infra, deploying Go binaries, systemd/Caddy setup, or debugging deployments.

## Procedure
1. Status check first: account, VMs, service status, logs, firewall, Caddy validate.
2. Provision/step via az directly; systemd + Caddy + Postgres/Redis per convention.
3. Deploy only after CI passes; verify status and logs after restart.

## Pitfalls
- Destructive commands without confirm; restarts without status check; hardcoded secrets; deploys skipping CI.

## Verification
1. Service healthy in status and logs; Caddy validated before reload.