<p align="center">
  <img src="https://user-images.githubusercontent.com/54551308/187172068-3cb39b99-e362-4f1c-b514-fa846986874d.png" alt="GhostCleaner logo" />
</p>

<h1 align="center">GhostCleaner</h1>

<p align="center">
  <img src="https://github.com/ByCh4n/GhostCleaner/actions/workflows/shellcheck.yml/badge.svg" alt="ShellCheck" />
  <img src="https://img.shields.io/github/license/ByCh4n/GhostCleaner" alt="License" />
  <img src="https://img.shields.io/github/stars/ByCh4n/GhostCleaner?style=social" alt="Stars" />
</p>

A simple, portable log & history cleaner that also fetches system information
(neofetch-style). It is compatible with any distribution that ships `bash`.

## Features

- Cleans a configurable list of common system log files
- Removes `*history` files from the user's home directory
- Fetches system info: OS, uptime, hostname, CPU model & usage, RAM usage
- Interactive shell mode plus one-shot command-line flags
- Portable — runs directly from the cloned repository, no install required

## Requirements

- `bash`
- Root privileges for log cleaning (`sudo`)
- Core utilities: `rm`, `cut`, `grep`, `head`, `touch`

## Installation

```bash
git clone https://github.com/ByCh4n/GhostCleaner.git
cd GhostCleaner
sudo make install
```

> You can also run it directly after cloning — `bash GhostCleaner.sh --help` —
> it is a fully portable script.

## Usage

| Flag | Description |
|------|-------------|
| `--clean-logs` | Remove the log files defined in the list (you may need to restart logging services afterwards) |
| `--clean-history` | Remove files/directories ending with `history` in your home directory |
| `--fetch-info` | Print system information |
| `--shell` | Start the interactive shell |
| `--banner` | Print the banner |
| `--no-banner` | Disable the banner for any option |
| `--help` | Show the help text |
| `--version` | Show the current version |

## Screenshots

**Interactive shell**
![Interactive shell](https://user-images.githubusercontent.com/54551308/187173980-3e9d2ecb-c858-451c-90d0-ed9aba095a0a.png)

**Help output**
![Help](https://user-images.githubusercontent.com/54551308/187174463-c5061a86-74d4-423d-9d35-cafec225c88d.png)
![Help](https://user-images.githubusercontent.com/54551308/187174608-c13e3c50-c4e7-426b-bd28-743f7e380ee9.png)

## Disclaimer

GhostCleaner deletes system logs and shell history. It is intended for
**authorized system maintenance and educational use only** — run it only on
systems you own or administer. The author accepts no liability for data loss or
misuse.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to
discuss what you would like to change.

## Author

**Hüseyin Altıntaş — ByCh4n**

- GitHub: [@ByCh4n](https://github.com/ByCh4n)
- LinkedIn: [huseyinaltns](https://www.linkedin.com/in/huseyinaltns/)
- X: [@huseyinaltns](https://x.com/huseyinaltns)

Special thanks to [@lazypwny751](https://github.com/lazypwny751).

## License

Licensed under the [GPL-3.0](LICENSE) license.
