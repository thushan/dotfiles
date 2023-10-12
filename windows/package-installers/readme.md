# Windows Package Management

Contains some helper scripts to `choco`/`scoop` up default installations.

They are organised into multiple package files for each manager:

* `base` - The base packages every installation gets (default)
* `code` - Packages specific to development machines.
* `home` - Packages specific to home / non-work machines.
* `work` - Packages specific to work related machines.

Scripts cannot be run as they're not signed, so allow that:

```powershell
PS> Set-ExecutionPolicy AllSigned
```

Or

```powershell
PS> Set-ExecutionPolicy Bypass -Scope Process
```

## Choco

Choco packages can be installed with `choco-install.ps1` - installs the `choco-base.packages`:

```powershell
PS> ./choco-install.ps1
```

Or a specific package:

```powershell
PS> ./choco-install.ps1 -filename choco-code.packages
```

NOTE:
- Checks for elevated prompt
- Installs Choco if not already installed.

## Scoop

Scoop packages can be installed with `scoop-up.ps1` - installs the `scoop-base.packages`:

```powershell
PS> ./scoop-up.ps1
```

Or a specific package:

```powershell
PS> ./scoop-up.ps1 -filename scoop-code.packages
```

NOTE:
- Installs scoop if not already installed.
