# wzod_mastiff_installer
Shell scripts for installing MASTIFF v0.6.0 or MASTIFF v0.7.1 on Ubuntu Linux.

##Background
The MASTIFF Project, which was established by Tyler Hudak of KoreLogic, Inc., provides "a static analysis framework that automates the process of extracting key characteristics from a number of different file formats". (reference: https://git.korelogic.com/mastiff.git/)  Due to the significant number of dependencies, plugins and settings involved with installing a MASTIFF instance as well as inspiration from 4n6k's installation script for installing Volatility, the mastiff_installer was created to simplify the process of installing MASTIFF.

##Requirements
An internet connection and an Linux distribution that uses the Advanced Package Tool (Apt) for managing packages. This script has been tested on default installations of Ubuntu 12.04 and Ubuntu 14.04 (Long-Term Support or LTS versions).

##Capabilities
The shell script, wzod_mastiff_installer.sh, does the following:

* Downloads, verifies, extracts, and installs source archives for everything you will need to complete a full installation of MASTIFF:
  * MASTIFF v0.6.0/v0.7.1
  * disitool
  * distorm3
  * exiftool
  * OfficeDissector
  * pdfid
  * pdf-parser
  * pefile
  * pydeep
  * pyOLEScanner
  * simplejson
  * ssdeep
  * trid (including triddefs)
  * Yara (+ magic module) + Yara-Python
* Adds "mas.py" to your system PATH so that you can run MASTIFF from any location.

##Usage
MASTIFF will be installed to the directory you specify.

    From a terminal, run the bash script and specify the directory to install MASTIFF (example below):
        sudo bash wzod_mastiff_installer.sh /home/zod

In the above example, the following directories will be created:

    /home/zod/mastiff_setup
        Contains dependency source code and the install_log.txt file.
    /home/zod/mastiff-0.6.0
        Contains the MASTIFF v0.6.0 install if using wzod_mastiff_installer.sh script.
    /home/zod/mastiff-0.7.1
        Contains the MASTIFF v0.7.1 install if using wzod_mastiff_0.7.1_installer.sh script.

##Installation
You can download the scripts from the following Github pages:

MASTIFF v0.6.0
https://raw.githubusercontent.com/wzod/wzod_mastiff_installer/master/wzod_mastiff_installer.sh).

SHA256 Hash: 9bbd4c8226e8143fb46a8cd905b57a04019d0f0efde6aa1690089fa51a1a6b0c

MASTIFF v0.7.1
https://github.com/wzod/wzod_mastiff_installer/raw/master/wzod_mastiff_0.7.1_installer.sh

SHA256 Hash: ce4a50796d0297ba8ed3c4dd6e2d436473cbbbd8610944911bf3e6ac04733373

##Credits
Thanks to Tyler Hudak/KoreLogic, Inc. for providing and sharing MASTIFF to aid with automating many aspects relating to static analysis.  For more information regarding the MASTIFF project, go to https://git.korelogic.com/mastiff.git/ and the GitHub repo here https://github.com/KoreLogicSecurity/mastiff.

Also big thanks to 4n6k for sharing 4n6k_volatility_installer.sh (see https://github.com/4n6k/4n6k_volatility_installer), which greatly simplifies the process of installing Volatility along with the necessary dependencies.  As stated, 4n6k's script was the catalyst for putting together this script for MASTIFF.
