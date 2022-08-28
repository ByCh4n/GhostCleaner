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

# TO DO:
#   - betiği ingilizce çıktı verecek şekilde ayarla.
#   - interaktif kabuk için işleri fonksiyonlaştır.
#   - renk ekle.

# Bu betik UTF-8(16) karakterler barındırmaktadır.

# Değişkenlerin Tanımlanması

export fname="${0##*/}" status="true" version="1.0.0" banner="yes" COUNTER="1" DO="shell" i="" CLEAN=()
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
)

for chk in ${req[@]} ; do
    if ! command -v "${chk}" &> /dev/null ; then
        echo -e "\t${0##*/}: command: '${chk}' not found.."
        export status="false"
    fi
done

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

case "${DO}" in
    non-interactive)
        for i in ${CLEAN[@]} ; do
            case "${i}" in
                log)
                    if [[ "${UID}" = 0 ]] ; then
                        if [[ "${banner}" = "yes" ]] ; then
                            print:banner
                        fi
                        read -p "Bu işlem tüm tanımlı tüm log kayıtlarınızı silecek, ayrıca daha sonra log servislerini elle yeniden başlatmanız gerekebilir, devam etmek istiyor musunuz? [e/H]:> " quest
                        case "${quest}" in
                            [eE][vV][eE][tT]|[eE]|[yY])
                                for i in ${LOGFILES[@]} ; do 
                                    if [[ -f "${i}" ]] ; then
                                        rm -rf "${i}"
                                    fi
                                done
                            ;;
                        esac
                    else
                        echo "Bu işlemi faniler yapamaz!"
                        export status="false"
                    fi
                ;;
                hist)
                    if [[ -d "${HOME}" ]] ; then
                        if tohuch -c "${HOME}" &> /dev/null ; then
                            if [[ "${banner}" = "yes" ]] ; then
                                print:banner
                            fi
                            rm -rf "${HOME}/"*history && {
                                echo "${HOME} dizini altındaki tüm 'history' ile biten dosyalar kaldırıldı."
                            } || {
                                echo "Kaldırma işlemi sırasında hata ile karşılaşıldı."
                                export status="false"
                            }
                        else
                            echo "Yetkilendirme hatası lütfen betiği fani olmayan bir kullanıcı yetkileri ile çalıştırın."
                            export status="false"
                        fi
                    else
                        echo "${USER} kullanıcısının ev dizini bulunmamaktadır."
                        export status="false"
                    fi
                ;;
            esac
        done
    ;;
    fetch-info)
        if [[ -f "/etc/os-release" ]] ; then
            source "/etc/os-release"
            export tab="$(printf '\t')"
            export cpu="$(grep "model name" "/proc/cpuinfo" | cut -f 2 -d ":" | head -n 1)"
            export xcpu="$(grep -w "cpu" /proc/stat | cut -d " " -f 3,5)"
            export xcpu="${xcpu// /+}"
            export ycpu="$(grep -w "cpu" /proc/stat | cut -d " " -f 3,5,6)"
            export ycpu="${ycpu// /+}"
            export ucpu="$(( (${xcpu} * 100) / ${xcpu// /+} ))"
            export tmemory="$(( ($(grep "MemTotal" /proc/meminfo | tr -dc "0-9") / 1024) / 1024 ))"
            export fmemory="$(( ($(grep "MemFree" "/proc/meminfo" | tr -dc "0-9") / 1024) / 1024 ))"
            export umemory="$(( ${tmemory} - ${fmemory} ))"
            export time="$(cut -d " " /proc/uptime -f 1)"
            export hour="$(( (${time%.*} / 60) / 60 ))"
            export minute="$(( ${time%.*} / 60 ))"
            if [[ "${UID}" = 0 ]] ; then
                export utype="${USER} yarı tanrı kullanıcıdır dikkatli olun."
            else
                export utype="${USER} fani kullanıcıdır."
            fi
            if [[ "${banner}" = "yes" ]] ; then
                print:banner
            fi
            cat - <<INFO

İşletim Sistemi:${tab} ${NAME} ${VERSION}
Çalışma Zamanı:${tab}${tab} ${hour}h -> ${minute}mn -> ${time%.*}sec
Makine Adı:${tab}${tab} ${HOSTNAME}
Kullanıcı Türü:${tab}${tab} ${utype}
CPU (İşlemci):${tab}${tab}${cpu}
CPU Kullanımı (İşlemci): ${ucpu:0:2}%
Bellek Kullanımı (Ram):${tab} ${tmemory}GB / ${umemory}GB
Serbest Bellek (Ram):${tab} ${fmemory}GB
INFO
        fi
    ;;
    shell)
        export input="" subinput=""
        if [[ "${banner}" = "yes" ]] ; then
            print:banner
        fi
        echo -e "\nMerhaba değerli ${USER} kullanıcısı,\n${0##*/} betiği ${version} sürümünün\netkileşimli kabuğuna hoş geldin, 'yardim' yazaraktan başlayabilirsin.\n"
        while true ; do
            read -p "[${0##*/}.${version}]:> " input
            case "${input}" in
                banner)
                    print:banner
                ;;
                yardim|help)
                    echo "${0##*/} betiğinin yardım metni:"
                ;;
                versiyon|version)
                    echo "ByCh4n tarafından yapılan ${0##*/} sürüm ${version}."
                ;;
                exit|quit|cikis)
                    exit 0
                ;;
                *)
                    echo "Bu sürümde interaktif kabuk desteklenmemektedir."
                    break
                ;;
            esac
        done
    ;;
    print-banner)
        print:banner
    ;;
    help)
        export tab="$(printf '\t')"
        cat - <<HELP
${0##*/} - ${version}, 8 adet seçenek mevcut:
${tab}--clean-logs | -cl
${tab}${tab}bu argüman ile sistemde var olan logları
${tab}${tab}kaldırarak aladan kazanma ve gizlilik sağlanması planlanmaktadır
${tab}${tab}lakin loglar kapatıldıktan sonra aktif log süreçlerinin de yeniden başlatılması gerekir.

${tab}--clean-history | -cl
${tab}${tab}geçerli kullanıcının home dizininde ki kabuğun komut
${tab}${tab}kaydını temizler bu gizlilik açısından önemlidir.

${tab}--fetch-info | -fi
${tab}${tab}sisteminizin aktif olarak ne kadar bellek tükettiği hangi dağıtımı
${tab}${tab}kullandığınız, hangi paket yöneticisini kullandığınız ve ne kadar paketinizin olduğu vb..

${tab}--shell | -sh
${tab}${tab}burada yer alan argümanların özelliklerini basit bir shell'de elle uygulayabileceğiniz bir ortam.

${tab}--banner | -bn
${tab}${tab}${0##*/}'in banner'ını ekrana yazdırır.

${tab}--no-banner | -nb
${tab}${tab}herhangi bir işlemde ön tanımlı olarak ekrana banner yazdırmaz.

${tab}--help | -h
${tab}${tab}bu yardımcı metni gösterir.

${tab}--version | -v
${tab}${tab}sscript'in geçerli sürümünü gösterir.
HELP
    ;;
    version)
        echo "${version}"
    ;;
    *)
        echo "Buralarda '${DO}' adında yapılacak bir iş bilmiyorum."
        export status="false"
    ;;
esac

if [[ "${status}" = "false" ]] ; then
    exit 1
fi