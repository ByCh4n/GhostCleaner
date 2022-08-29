# GhostCleaner - 1.0.0

<p align="center">
  <img src="https://user-images.githubusercontent.com/54551308/187172068-3cb39b99-e362-4f1c-b514-fa846986874d.png" alt="Ghost Cleaners Logo"/>
</p>

Simple automated log&history cleaner and fetch information like neofetch, this script compatible with all distro which have bash (bourne again shell).

# Installation:
```bash
git clone https://github.com/ByCh4n/GhostCleaner.git
cd GhostCleaner
sudo make install
```
### Deep note:
also you can use the script directly after cloning the repository like **bash GhostCleaner.sh --help**, it's portable script.

# Usage:

- **ghostcleaner --clean-logs** : it removes existing logs from array, but maybe you need to restart to log services after this option, it can be break any service.

- **ghostcleaner --clean-history** : it removes any files and directories ending with 'history' in your home directory.

- **ghostcleaner --fetch-info** : fetch the system information and print to the screen, it shows "OS", "UPTIME", "HOSTNAME" "USER TYPE", "CPU MODEL", "CPU USAGE", "RAM USAGE (with cached, inactive, active)", "FREE RAM".

- **ghostcleaner --shell** : there is a little shell like 'sh' using 'read. There you can use the options as command.

- **ghostcleaner --banner** : just print the banner.

- **ghostcleaner --no-banner** : set default 'do not print banner' for any option.

- **ghostcleaner --help** : shows this helper text.

- **ghostcleaner --version** : shows the current version of the project.

# ScreenShots from the tool:
- ## Interactive shell of Ghost Cleaner:
![image](https://user-images.githubusercontent.com/54551308/187173980-3e9d2ecb-c858-451c-90d0-ed9aba095a0a.png)

- ## Help option of Ghost Cleaner:
![image](https://user-images.githubusercontent.com/54551308/187174463-c5061a86-74d4-423d-9d35-cafec225c88d.png)
![image](https://user-images.githubusercontent.com/54551308/187174608-c13e3c50-c4e7-426b-bd28-743f7e380ee9.png)

## Contributing:
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License:
[GPL3](https://choosealicense.com/licenses/gpl-3.0/)
