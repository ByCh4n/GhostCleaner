#!/bin/bash

#    GhostCleaner is simple system cleaner script - GhostCleaner
#    Copyright (C) 2022  ByCh4n
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Contributors:
#   - ByCh4n
#   - lazypwny751

# Special tahnks to Cyrops.

# Define variables:

export fname="${0##*/}" status="true" version="1.0.0" banner="yes" COUNTER="1" DO="shell" i="" CLEAN=()
export reset="\033[0m" red="\033[0;31m" green="\033[0;32m" blue="\033[0;34m" purple="\033[0;35m" Bcyan="\033[1;36m" Bwhite="\033[1;37m"
export LOGFILES=(
        "/var/log/messages" 
        "/var/log/auth.log"
        "/var/log/kern.log"
        "/var/log/cron.log"
        "/var/log/maillog"
        "/var/log/boot.log" 
        "/var/log/mysqld.log"
        "/var/log/mysql.log"
        "/var/log/qmail"
        "/var/log/httpd" 
        "/var/log/lighttpd" 
        "/var/log/secure" 
        "/var/log/utmp" 
        "/var/log/btmp" 
        "/var/log/httpd" 
        "/var/log/apache" 
        "/var/log/xferlog"
        "/var/log/spooler"
        "/var/log/pureftp.log"
        "/var/log/lastlog"
        "/var/log/daemon.log"
        "/var/log/dmesg"
        "/var/log/apt"
        "/var/log/cups"
        "/var/log/vnetlib"
        "/var/log/nginx"
        "/var/log/syslog"
        "/var/log/wtmp" 
        "/var/log/yum.log"
        "/var/log/pacman.log"
        "/var/log/user.log" 
        "/var/log/postgresql"
        "/var/log/samba"
        "/var/log/apache2"
        "/var/log/system.log" 
        "/var/log/DiagnosticMessages"
        "/Library/Logs" 
        "/Library/Logs/DiagnosticReports" 
        "${HOME}/Library/Logs" 
        "${HOME}/Library/Logs/DiagnosticReports"
)

export req=(
    "rm"
    "cut"
    "grep"
    "head"
    "touch"
)

# Check requirements:

for chk in ${req[@]} ; do
    if ! command -v "${chk}" &> /dev/null ; then
        echo -e "\t${Bwhite}${0##*/}${reset}: command: '${chk}' ${red}not${reset} found.."
        export status="false"
    fi
done

if [[ "${status}" = "false" ]] ; then
    exit 1
fi

# Define functions:

ghost:banner() {
    echo -e "${green}        _______ __                 __   ______ __
        |     __|  |--.-----.-----.|  |_|      |  |.-----.---.-.-----.-----.----.
        |    |  |     |  _  |__ --||   _|   ---|  ||  -__|  _  |     |  -__|   _|
        |_______|__|__|_____|_____||____|______|__||_____|___._|__|__|_____|__|${Bcyan}

                                ⠀⠀⠀⠀⠀⢀⡠⠔⠂⠉⠉⠉⠉⠐⠦⡀⠀⠀⠀⠀⠀⠀
                                ⠀⠀⠀⢀⠔⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⠀⠀⠀⠀
                                ⠀⠀⢠⠋⠀⠀⠀⠀⠖⠉⢳⠀⠀⢀⠔⢢⠸⠀⠀⠀⠀⠀
                                ⠀⢠⠃⠀⠀⠀⠀⢸⠀⢀⠎⠀⠀⢸⠀⡸⠀⡇⠀⠀⠀⠀
                                ⠀⡜⠀⠀⠀⠀⠀⠀⠉⠁⠾⠭⠕⠀⠉⠀⢸⠀⢠⢼⣱⠀
                                ⠀⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡌⠀⠈⠉⠁⠀
                                ⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⣖⡏⡇
                                ⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢄⠀⠀⠈⠀
                                ⢸⠀⢣⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡬⠇⠀⠀⠀
                                ⠀⡄⠘⠒⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢣⠀⠀⠀⠀
                                ⠀⢇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡀⠀⠀⠀
                                ⠀⠘⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡤⠁⠀⠀⠀
                                ⠀⠀⠘⠦⣀⠀⢀⡠⣆⣀⣠⠼⢀⡀⠴⠄⠚${reset}
"
}


ghost:clear:log() {
    local i=""
    if [[ "${UID}" = 0 ]] ; then
        if [[ "${banner}" = "yes" ]] ; then
            ghost:banner
        fi
        read -p "This option will remove all of declared existing log files, but you may need to restart log services manually? [y/N]:> " quest
        case "${quest}" in
            [yY][eE][sS]|[eE][vV][eE][tT]|[eE]|[yY])
                for i in ${LOGFILES[@]} ; do 
                    if [[ -f "${i}" ]] ; then
                        rm -rf "${i}" && {
                        echo -e "${blue}${i}${reset} ${purple}removed${reset}."
                        } || {
                            echo -e "${blue}${i}${reset} could ${red}not${reset} be removed."
                        }
                    fi
                done
            ;;
        esac
    else
        echo -e "Authorization ${red}failure${reset}, please run it as ${purple}root${reset} privalages."
        return 1
    fi
}

ghost:clear:history() {
    if [[ -d "${HOME}" ]] ; then
        if touch -c "${HOME}/"* &> /dev/null ; then
            if [[ "${banner}" = "yes" ]] ; then
                ghost:banner
            fi
            rm -rf "${HOME}/"*history && {
                echo -e "${green}Successfully${reset} removed files and directories ending with '${Bcyan}history${reset}' under ${Bcyan}${HOME}${reset}."
            } || {
                echo -e "${red}Error${reset}(${red}s${reset}) occured while removing the file."
                return 1
            }
        else
            echo -e "Authorization ${red}failure${reset}, please run it as ${purple}root${reset} privalages."
            return 1
        fi
    else
        echo -e "${Bcyan}${USER}${reset} user ${red}haven't${reset} home directory."
        return 1
    fi
}

ghost:fetch:info() {
    # Bellek kısmında, belleğin tamamı kullanılıyor olarak gözükebilir
    # veya serbest bellek 0 değerinde olabilir bu durum sisteminizin çöktüğünü
    # ya da betiğin yanlış çalıştığını göstermez, burada kullanılan bellek cached, active,
    # inactive adresler ile birlikte hesaplanmaktadır, ayrıca swap hesaba dahil edilmez.

    if [[ -f "/etc/os-release" ]] ; then
        source "/etc/os-release"
        local cpu="$(grep "model name" "/proc/cpuinfo" | cut -f 2 -d ":" | head -n 1)"
        local xcpu="$(grep -w "cpu" /proc/stat | cut -d " " -f 3,5)"
        local xcpu="${xcpu// /+}"
        local ycpu="$(grep -w "cpu" /proc/stat | cut -d " " -f 3,5,6)"
        local ycpu="${ycpu// /+}"
        local ucpu="$(( (${xcpu} * 100) / ${xcpu// /+} ))"
        local tmemory="$(( ($(grep "MemTotal" /proc/meminfo | tr -dc "0-9") / 1024) / 1024 ))"
        local fmemory="$(( ($(grep "MemFree" "/proc/meminfo" | tr -dc "0-9") / 1024) / 1024 ))"
        local umemory="$(( ${tmemory} - ${fmemory} ))"
        local time="$(cut -d " " /proc/uptime -f 1)"
        local hour="$(( (${time%.*} / 60) / 60 ))"
        local minute="$(( ${time%.*} / 60 ))"
        if [[ "${ucpu:0:2}" -le 40 ]] ; then
            local ucpu="${green}${ucpu:0:2}${reset}"
        elif [[ "${ucpu:0:2}" -le 70 ]] ; then
            local ucpu="${blue}${ucpu:0:2}${reset}"
        elif [[ "${ucpu:0:2}" -gt 70 ]] ; then
            local ucpu="${red}${ucpu:0:2}${reset}"
        fi
        if [[ "${UID}" = 0 ]] ; then
            local utype="${USER} is half god, be careful."
        else
            local utype="${USER} is a mortal user."
        fi
        if [[ "${banner}" = "yes" ]] ; then
            ghost:banner
        fi
        echo -e "
${Bwhite}Operating System${reset}\t: ${Bcyan}${NAME}${reset} ${green}${VERSION}${reset}
${Bwhite}Up Time${reset}\t\t\t: ${blue}${hour}${Bwhite}h${reset} -> ${blue}${minute}${Bwhite}mn${reset} -> ${blue}${time%.*}${Bwhite}sec${reset}
${Bwhite}Host Name${reset}\t\t: ${Bwhite}${HOSTNAME}${reset}
${Bwhite}User Type${reset}\t\t: ${Bwhite}${utype}${reset}
${Bwhite}CPU (Processor)${reset}\t\t:${blue}${cpu}${reset}
${Bwhite}CPU Usage (Processor)${reset}\t: ${ucpu}${Bwhite}%${reset}
${Bwhite}Memory Usage (Ram)${reset}\t: ${green}${tmemory}GB${reset} ${Bwhite}/${reset} ${purple}${umemory}GB${reset}
${Bwhite}Free Memory (Ram)${reset}\t: ${blue}${fmemory}GB${reset}
"
    fi
}

# Parsing parameters:

while [[ "${#}" -gt 0 ]] ; do
    case "${1}" in
        --clean-logs|-cl)
            shift
            export CLEAN+=("log") DO="non-interactive"
        ;;
        --clean-history|-ch)
            shift
            export CLEAN+=("hist") DO="non-interactive"
        ;;
        --fetch-info|-fi)
            shift
            export DO="fetch-info"
        ;;
        --shell|-sh)
            shift
            export DO="shell"
        ;;
        --banner|-bn)
            shift
            export DO="print-banner"
        ;;
        --no-banner|-nb)
            shift
            export banner="no"
        ;;
        --help|--yardim|-h|-y)
            shift
            export DO="help"
        ;;
        --version|--surum|-v|-s)
            shift
            export DO="version"
        ;;
        *)
            shift
        ;;
    esac
done

# Execution the selected option:

case "${DO}" in
    non-interactive)
        for i in ${CLEAN[@]} ; do
            case "${i}" in
                log)
                    ghost:clear:log || export status="false"
                ;;
                hist)
                    ghost:clear:history || export status="false"
                ;;
            esac
        done
    ;;
    fetch-info)
        ghost:fetch:info
    ;;
    shell)
        export input="" subinput=""
        if [[ "${banner}" = "yes" ]] ; then
            ghost:banner
        fi
        echo -e "Welcome dear ${green}${USER}${reset}, here is interactive ${Bwhite}shell${reset} of the ${Bwhite}${0##*/}${reset}, you can start with type '${Bcyan}help${reset}'.\n"
        while true ; do
            read -p "[${0##*/}-${version}]:> " input
            case "${input}" in
                banner)
                    ghost:banner
                ;;
                log)
                    ghost:clear:log
                ;;
                history|gecmis)
                    ghost:clear:history
                ;;
                info|bilgi)
                    ghost:fetch:info
                ;;
                command|komut)
                    echo -e "${Bwhite}banner${reset} \t${green}=>${reset}${Bwhite} [${reset} ${Bcyan}banner${reset} ${Bwhite}]${reset}
${Bwhite}log${reset} \t${green}=>${reset}${Bwhite} [${reset} ${Bcyan}log${reset} ${Bwhite}]${reset}
${Bwhite}history${reset} ${green}=>${reset}${Bwhite} [${reset} ${Bcyan}history${reset}, ${Bcyan}gecmis${reset} ${Bwhite}]${reset}
${Bwhite}info${reset} \t${green}=>${reset}${Bwhite} [${reset} ${Bcyan}info${reset}, ${Bcyan}bilgi${reset} ${Bwhite}]${reset}
${Bwhite}command${reset} ${green}=>${reset}${Bwhite} [${reset} ${Bcyan}command${reset}, ${Bcyan}komut${reset} ${Bwhite}]${reset}
${Bwhite}help${reset} \t${green}=>${reset}${Bwhite} [${reset} ${Bcyan}help${reset}, ${Bcyan}yardim${reset} ${Bwhite}]${reset}
${Bwhite}version${reset} ${green}=>${reset}${Bwhite} [${reset} ${Bcyan}version${reset}, ${Bcyan}versiyon${reset} ${Bwhite}]${reset}
${Bwhite}exit${reset} \t${green}=>${reset}${Bwhite} [${reset} ${Bcyan}exit${reset}, ${Bcyan}quit${reset}, ${Bcyan}cikis${reset} ${Bwhite}]${reset}"
                ;;
                help|yardim)
                    echo -e "${Bwhite}banner${reset}\tit prints just the ${green}banner${reset}.
${Bwhite}log${reset}\t${red}removes${reset} if exist that declared ${Bcyan}log${reset} files in array.
${Bwhite}history${reset}\t${red}removes${reset} all files and directories ending with '${Bcyan}history${reset}' in your ${green}home${reset} directory.
${Bwhite}info${reset}\t${green}fetch${reset} the system information about your ${purple}computer${reset}.
${Bwhite}command${reset}\tshows ${Bcyan}alternative${reset} ${green}names${reset} of commands in the interactive ${Bwhite}shell${reset}.
${Bwhite}help${reset}\tshows this helper text.
${Bwhite}version${reset}\tshows current version of ${Bwhite}${0##*/}${reset}.
${Bwhite}exit${reset}\t${red}exit${reset} the interactive ${Bwhite}shell${reset}."
                ;;
                version|versiyon)
                    echo -e "Developed by ${green}ByCh4n${reset} ${Bwhite}${0##*/}${reset}, version ${Bcyan}${version}${reset}."
                ;;
                exit|quit|cikis)
                    exit 0
                ;;
                *)
                    echo -e "${Bwhite}${0##*/}${reset}: ${red}case${reset}: '${Bcyan}${input}${reset}' pattern not found."
                ;;
            esac
        done
    ;;
    print-banner)
        ghost:banner
    ;;
    help)
        echo -e "${green}${0##*/}${reset} - ${blue}${version}${reset}, there is ${Bwhite}8${reset} options:
\t${Bwhite}--clean-logs${reset} | ${Bwhite}-cl${reset}
\t\tit removes existing logs from array, but maybe you need to restart to log services
\t\tafter this option, it can be break any service.

\t${Bwhite}--clean-history${reset} | ${Bwhite}-cl${reset}
\t\tit removes any files and directories ending with 'history' in your home directory. 

\t${Bwhite}--fetch-info${reset} | ${Bwhite}-fi${reset}
\t\tfetch the system information and print to the screen, it shows \"OS\", \"UPTIME\", \"HOSTNAME\"
\t\t\"USER TYPE\", \"CPU MODEL\", \"CPU USAGE\", \"RAM USAGE (with cached, inactive, active)\", \"FREE RAM\"

\t${Bwhite}--shell${reset} | ${Bwhite}-sh${reset}
\t\tthere is a little shell like 'sh' using 'read. There you can use the options as command.

\t${Bwhite}--banner${reset} | ${Bwhite}-bn${reset}
\t\tjust print the banner.

\t${Bwhite}--no-banner${reset} | ${Bwhite}-nb${reset}
\t\tset default 'do not print banner' for any option.

\t${Bwhite}--help${reset} | ${Bwhite}-h${reset}
\t\tshows this helper text.

\t${Bwhite}--version${reset} | ${Bwhite}-v${reset}
\t\tshows the current version of the project."
    ;;
    version)
        echo "${version}"
    ;;
    *)
        echo -e "${Bwhite}${0##*/}${reset}: there is ${red}no${reset} job like called by '${Bcyan}${DO}${reset}'."
        export status="false"
    ;;
esac

# Exit cleanly:

if [[ "${status}" = "false" ]] ; then
    exit 1
fi