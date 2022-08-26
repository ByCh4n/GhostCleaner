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

# Bu betik UTF-8(16) karakterler barındırmaktadır.

# Değişkenlerin Tanımlanması

export fname="${0##*/}" status="true" version="1.0.0" COUNTER="1" DO="shell" i="" CLEAN=()
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

# Fonksiyonların Tanımlanması

print:banner() {
    echo "        _______ __                 __   ______ __
        |     __|  |--.-----.-----.|  |_|      |  |.-----.---.-.-----.-----.----.
        |    |  |     |  _  |__ --||   _|   ---|  ||  -__|  _  |     |  -__|   _|
        |_______|__|__|_____|_____||____|______|__||_____|___._|__|__|_____|__|

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
                                ⠀⠀⠘⠦⣀⠀⢀⡠⣆⣀⣠⠼⢀⡀⠴⠄⠚"
}

# Argümanların Ayrıştırılması

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
        --help|--yardim|-h|-y)
            shift
            export DO="help"
        ;;
        --version|--surum|-v|-h)
            shift
            export DO="version"
        ;;
        *)
            shift
        ;;
    esac
done

case "${DO}" in
    non-interactive)
        for i in ${CLEAN[@]} ; do
            case "${i}" in
                log)
                    :
                ;;
                hist)
                    :
                ;;
            esac
        done
    ;;
    fetch-info)
        :
    ;;
    shell)
        :
    ;;
    help)
        echo -e "${fname} - ${version}, there is 6 options:\n\n\t--clean-logs | -cl\n\t\tbu argüman ile sistemde var olan logları kaldırarak aladan kazanma ve gizlilik sağlanması planlanmaktadır lakin loglar kapatıldıktan sonra aktif log süreçlerinin de yeniden başlatılması gerekir.\n\n\t--clean-history | -cl\n\t\tgeçerli kullanıcının home dizininde ki kabuğun komut kaydını temizler bu gizlilik açısından önemlidir.\n\n\t--fetch-info | -fi\n\t\tsisteminizin aktif olarak ne kadar bellek tükettiği hangi dağıtımı kullandığınız, hangi paket yöneticisini kullandığınız ve ne kadar paketinizin olduğu vb..\n\n\t--shell | -sh\n\t\tburada yer alan argümanların özelliklerini basit bir shell'de elle uygulayabileceğiniz bir ortam.\n\n\t--help | -h\n\t\tbu yardımcı metni gösterir.\n\n\t--version | -v\n\t\tsscript'in geçerli sürümünü gösterir."
    ;;
    version)
        echo "${version}"
    ;;
    *)
        :
    ;;
esac