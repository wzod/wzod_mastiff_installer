#!/usr/bin/env bash

# mastiff_installer.sh
# v1.0 (3/01/2015)
# Installs MASTIFF for Ubuntu Linux with one command.
# Run this script from the directory in which you'd like to install MASTIFF.
# Tested on stock Ubuntu 12.04 + 14.04
# 

# Original script copyright (C) 2014 4n6k (4n6k.dan@gmail.com)
# Modified by Zod for MASTIFF (2015)
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

# Define constants
PROGNAME="${0}"
INSTALL_DIR="${1}"
SETUP_DIR="${INSTALL_DIR}"/"mastiff_setup"
LOGFILE="${SETUP_DIR}"/"install_mastiff.log"
ARCHIVES=('disitool_v0_3.zip' 'distorm3.zip' 'pdfid_v0_2_1.zip' \
          'pdf-parser_V0_6_0.zip' 'pefile-1.2.10-139.tar.gz' \
          '0.2.tar.gz' 'pyOLEScanner.zip' 'v3.6.5.tar.gz' \
          'ssdeep-2.11.1.tar.gz' 'trid_linux_64.zip' \
	  'v3.3.0.tar.gz' 'officedissector.zip' 'mastiff-0.6.0.tar.gz' )
HASHES=('aef923f49e53c7c2194058f34a73b293d21448deb7e2112819fc1b3b450347b8' \
        'd311d232e108def8acac0d4f6514e7bc070e37d7aa123ab9a9a05b9322321582' \
        'f1b4728dd2ce455b863b930e12c6dec952cb95c0bb3d6924136a6e49aca877c2' \
        '8902abe1a9bdb61887d501546ccf333724bcf7b3e3e02ce2541bc311ad8e98df' \
        '8b7c5d853c97a923d0f6e128d0ae76b962aa75fd608d552f5a32e46276908a16' \
        'df854e4ec8677b8b5f59d6492ce0810a1efd3aa2ab8e67e0d480d8ce9d293f00' \
        '82a1e5bc6ee03055862c4b0fc745c5b6300dc8bdaa6dc3d62bea4a4a7d886905' \
        '9df4baeba729e58a281db852afb8d8b26616017619811b3d40aab52afa3ea78d' \
        'a632ac30fca29ad5627e1bf5fae05d9a8873e6606314922479259531e0c19608' \
        '09a253e54b138fa0d996a6797333ca26e67d618a25a0974287b39425caa1ed6a' \
        'e5f4359082e35ff00ee94af9ee897bb0ab18abf49a2c4fe45968d7a848e5bd83' \
        'fd20492fa422bc9456274a11c89963e6d38c0e81db770b2066cfd3f1521b54f9' \
        'fb935be8210a7b4a309aae2b9c545f9dc46191d4b80f745584885db0c0db4cef' )

# Program usage dialog
usage() {
  echo -e "\nHere is an example of how you should run this script:"
  echo -e "  > sudo bash ${PROGNAME} /home/$USER"
  echo -e "Result: Mastiff will be installed to /home/$USER/mastiff"
  echo -e "***NOTE*** Be sure to use a FULL PATH for the install directory.\n"
}

# Usage check; determine if usage should be printed
chk_usage() {
  if [[ "${INSTALL_DIR}" =~ ^(((-{1,2})([Hh]$|[Hh][Ee][Ll][Pp]$))|$) ]]; then
    usage ; exit 1
  elif ! [[ "${INSTALL_DIR}" =~ ^/.*+$ ]]; then
    usage ; exit 1
  else
    :
  fi
}

# Status header for script progress
status() {
  echo ""
  phantom "===================================================================="
  phantom "#  ${*}"
  phantom "===================================================================="
  echo ""
}

# Setup for initial installation environment
setup() {
  if [[ -d "${SETUP_DIR}" ]]; then
    echo "" ; touch "${LOGFILE}"
    phantom "Setup directory already exists. Skipping..."
  else
    mkdir -p "${SETUP_DIR}" ; touch "${LOGFILE}"
    echo "/usr/local/lib" >> /etc/ld.so.conf.d/mastiff.conf
  fi
  cd "${SETUP_DIR}"
}

# Download Mastiff and its dependencies
download() {
  if [[ -a "${ARCHIVES[7]}" && $(shasum -a 256 "${ARCHIVES[7]}" | cut -d' ' -f1) \
    == "${HASHES[7]}" ]]; then
      phantom "Files already downloaded. Skipping..."
  else
    phantom "This will take a while. Tailing install_mastiff.log for progress..."
    tail_log
    wget -o "${LOGFILE}" \
      "https://didierstevens.com/files/software/disitool_v0_3.zip" \
      "https://distorm.googlecode.com/files/distorm3.zip" \
      "https://didierstevens.com/files/software/pdfid_v0_2_1.zip" \
      "https://didierstevens.com/files/software/pdf-parser_V0_6_0.zip" \
      "https://pefile.googlecode.com/files/pefile-1.2.10-139.tar.gz" \
      "https://github.com/kbandla/pydeep/archive/0.2.tar.gz" \
      "https://github.com/Evilcry/PythonScripts/raw/master/pyOLEScanner.zip" \
      "https://github.com/simplejson/simplejson/archive/v3.6.5.tar.gz" && \
      wget -o "${LOGFILE}" -O ssdeep-2.11.1.tar.gz "http://sourceforge.net/projects/ssdeep/files/ssdeep-2.11.1/ssdeep-2.11.1.tar.gz/download" && \
      wget -o "${LOGFILE}" "http://mark0.net/download/triddefs.zip" \
      "http://mark0.net/download/trid_linux_64.zip" \
      "https://github.com/plusvic/yara/archive/v3.3.0.tar.gz" && \
      wget -o "${LOGFILE}" -O officedissector.zip "https://github.com/grierforensics/officedissector/archive/master.zip" && \
      wget -o "${LOGFILE}" "https://www.korelogic.com/Resources/Tools/mastiff-0.6.0.tar.gz"
    kill_tail
  fi
}

# Verify sha256 hashes of the downloaded archives
verify() {
  local index=0
  for hard_sha256 in "${HASHES[@]}"; do
    local archive ; archive="${ARCHIVES[$index]}"
    local archive_sha256 ; archive_sha256=$(shasum -a 256 "${archive}" | cut -d' ' -f1)
    if [[ "$hard_sha256" == "$archive_sha256" ]]; then
      phantom "= Hash MATCH for ${archive}."
      let "index++"
    else
      phantom "= Hash MISMATCH for ${archive}. Exiting..."
      exit 0
    fi
  done
}

# Extract the downloaded archives
extract() {
  sudo apt-get update && sudo apt-get install unzip -y --force-yes && unzip triddefs.zip
  for archive in "${ARCHIVES[@]}"; do
    local ext ; ext=$(echo "${archive}" | sed 's|.*\.||')
    if [[ "${ext}" =~ ^(tgz|gz)$ ]]; then
      tar -xvf "${archive}"
    elif [[ "${ext}" == "zip" ]]; then
      unzip "${archive}"
    else
      :
    fi
  done
} >>"${LOGFILE}"

# Install Mastiff and its dependencies
install() {
  # Python
    aptget_install
  # distorm3
    cd distorm3 && py_install
  # pefile
    cd pefile-1.2.10-139 && py_install
  # ssdeep
    cd ssdeep-2.11.1 && make_install 
  # pydeep
    cd pydeep-0.2 && py_install
  # simplejson
    cd simplejson-3.6.5 && py_install
  # OfficeDissector
    cd officedissector-master && py_install
  # yara + yara-python
    cd yara-3.3.0 && chmod +x bootstrap.sh && ./bootstrap.sh && \
      ./configure --enable-magic ; make ; make install; 
    cd yara-python && py_install && ldconfig && cd "${SETUP_DIR}"
  # SIFT 3.0 check + fix
    sift_fix
  # Mastiff
    chmod +x disitool.py; cp -v "$PWD"/disitool.py /usr/local/bin/
    chmod +x pdfid.py; cp -v "$PWD"/pdfid.py /usr/local/bin/
    chmod +x pdf-parser.py; cp -v "$PWD"/pdf-parser.py /usr/local/bin/
    chmod +x pyOLEScanner/pyOLEScanner.py; cp -vr "$PWD"/pyOLEScanner /usr/local/src/
    chmod +x trid; cp -v "$PWD"/trid /usr/local/bin/
    cp -v "$PWD"/triddefs.trd /usr/local/etc/
    mkdir -p /usr/local/etc/yara
    wget https://malwarecookbook.googlecode.com/svn-history/r3/trunk/3/5/capabilities.yara
    wget -O readme https://api.github.com/repos/Yara-Rules/rules/contents && grep "download_url" readme | awk '{print $2}' | grep \.yar | sed s/,//g | xargs -I% wget % 
    rename 's/\.yar/\.yara/' "$SETUP_DIR"/*.yar
    mv "$SETUP_DIR"/*.yara /usr/local/etc/yara/
    sed -i '182s/\+//' /usr/local/etc/yara/malicious_document.yara
    mv -f mastiff-0.6.0 .. ; cd ../mastiff-0.6.0 && chmod +x mas.py
    mv "$SETUP_DIR"/officedissector-master/mastiff-plugins/* "$INSTALL_DIR"/mastiff-0.6.0/plugins/Office/
    sudo sed -i '1s|^|#!/usr/bin/python\n|' /usr/local/src/pyOLEScanner/pyOLEScanner.py
    sudo chmod 755 /usr/local/src/pyOLEScanner/pyOLEScanner.py 
    ln -f -s /usr/local/src/pyOLEScanner/pyOLEScanner.py /usr/local/bin/
    ln -f -s  "${PWD}"/mas.py /usr/local/bin/mas.py
    sed -i "/^log_dir/ s|\/work|\/workdir|" "$INSTALL_DIR"/mastiff-0.6.0/mastiff.conf 
    sed -i "/^plugin_dir/ s|\.\/plugins|"$INSTALL_DIR"\/mastiff-0.6.0\/plugins|" "$INSTALL_DIR"/mastiff-0.6.0/mastiff.conf
    sed -i "/^trid\ \=\ / s|\.\/trid|\/usr\/local\/bin|" "$INSTALL_DIR"/mastiff-0.6.0/mastiff.conf
    sed -i "/^trid_db\ \=\ / s|\.\/trid|\/usr\/local\/etc|" "$INSTALL_DIR"/mastiff-0.6.0/mastiff.conf
    sed -i "/^yara_sigs\ \=\ / s|\/usr\/local\/|&"etc"\/|" "$INSTALL_DIR"/mastiff-0.6.0/mastiff.conf
    sed -i "/^disitool\ \=\ / s|"$SETUP_DIR"|\/usr\/local\/bin|" "$INSTALL_DIR"/mastiff-0.6.0/mastiff.conf    
    sed -i "/^olecmd\=/ s|\/usr\/local\/src\/pyOLEScanner\/|\/usr\/local\/bin\/|" "$INSTALL_DIR"/mastiff-0.6.0/mastiff.conf
    cp "$INSTALL_DIR"/mastiff-0.6.0/mastiff.conf ~/.mastiff.conf
    kill_tail
} &>>"${LOGFILE}"

# Shorthand for make/install routine
make_install() {
  ./configure; make; make install; cd ..
}

# Shorthand for build/install Python routine
py_install() {
  python setup.py build install; cd ..
}

# Log script progress graphically
tail_log() {
  if [[ -d /usr/bin/X11 ]]; then
    xterm -e "tail -F ${LOGFILE} | sed "/kill_tail/q" && pkill -P $$ tail;" &
  else
  phantom "No GUI detected. Still running; not showing progress..."
  fi
}

# Kill the graphical script progress window
kill_tail() {
  echo -e "kill_tail" >> "${LOGFILE}"
}

# Install required packages from APT
aptget_install() {
  apt-get update && \
  apt-get install \
    automake build-essential exiftool git libtool make python-dev python-magic \
    python-lxml python-setuptools python-yapsy libmagic-dev  -y --force-yes
}

# Shorthand for done message
done_msg() {
  phantom "Done."
}

# Check for SIFT 3.0 and fix
sift_fix() {
  if [[ -d /usr/share/sift ]]; then
    apt-get install libxml2 libxml2-dev libxslt1.1 libxslt1-dev -y --force-yes
    pip install lxml --upgrade
  else
    :
  fi
}

# Text echo enhancement
phantom() {
  msg="${1}"
    if [[ "${msg}" =~ ^=.*+$ ]]; then 
      speed=".01" 
    else 
      speed=".03"
    fi
  let lnmsg=$(expr length "${msg}")-1
  for (( i=0; i <= "${lnmsg}"; i++ )); do
    echo -n "${msg:$i:1}" | tee -a "${LOGFILE}"
    sleep "${speed}"
  done ; echo ""
}

# Main program execution flow
main() {
  chk_usage
  setup
  status "Downloading Mastiff 0.6.0 and dependency source code..."
    download && done_msg
  status "Verifying archive hash values..."
    verify && done_msg
  status "Extracting archives..."
    extract && done_msg
  status "Installing Mastiff and dependencies..."
    phantom "This will take a while. Tailing install_mastiff.log for progress..."
      tail_log
      install ; done_msg
  status "Finished. You can now run "mas.py" from anywhere."
  phantom "Mastiff location: ${PWD}"
  phantom "Dependency location: ${SETUP_DIR}"
  echo ""
}

main "$@"
