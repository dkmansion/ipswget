#!/bin/bash
#Get list of ipsw files from Apple download for version specified in variable parameter
while getopts "v:d:p:" option
do
	case "${option}"
		in
			v) version="${OPTARG}";;
			d) devices=${OPTARG};;
			p) path="${OPTARG}";;
	esac
done

clear


black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
gold=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
grey=`tput setaf 8`
yellow=`tput setaf 11`
reset=`tput sgr0`

#echo "${red}red text ${green}green text${reset}"

if [ "${version}" == "" ] && [ "${devices}" == "" ] && [ "${path}" == "" ]; then
	echo "
      ${gold}____ ____  _____ _       __          ______ ______ ______
     /  _// __ \/ ___/| |     / / ../..   / ____// ____//_  __/
     / / / /_/ /\__ \ | | /| / / (    (  / / __ / __/    / /
   _/ / / ____/___/ / | |/ |/ /   \_._/ / /_/ // /___   / /
  /___//_/    /____/  |__/|__/          \____//_____/  /_/${reset}

${gold}ipswget${reset} version ${gold}1.0.0${reset} 2017-07-10 17:19:35 PDT
(c) dkmansion 2016
${gold}Purpose:${reset}	Query Apple for current IPSW (iOS Restore) file list based
		on a supplied version number, and optionally download the files.

${gold}Usage:${reset}
	[options][arguments]

${gold}Options:${reset}
    ${green}-v${reset}	Apple iOS version number to retreive (argument as tuple ie. 1.2.3)
    ${green}-d${reset}	Devices to download the ipsw files for as OCTAL sums. (see arguments)
    ${green}-p${reset}	Path for working downloads.

${gold}Arguments:${reset}
  for option
    ${green}v${reset}	Dotted version string representing iOS version number ${magenta}10.1.2${reset} or ${magenta}9.1${reset}, etc.
    ${green}d${reset}	Summed OCTAL mimicing chmod permission numbering.
      ${magenta}0${reset}	 -- DOES NOT download any files except the list
      ${magenta}1${reset}	 -- gets iPad ipsws
      ${magenta}2${reset}	 -- gets iPhone ipsws
      ${magenta}3${reset}	 -- gets iPad & iPhone ipsws
      ${magenta}4${reset}	 -- gets iPod ipsws
      ${magenta}5${reset}	 -- gets iPad & iPod ipsws
      ${magenta}6${reset}	 -- gets iPhone & iPod ipsws
      ${magenta}7${reset}	 -- gets All (iPad, then iPhone, then iPod) ipsws

	${green}p${reset}	Valid file path where you want to download the files.
			ie ~/downloads

Examples:
	Get the list for 10.3.1, and DOES NOT DOWNLOAD ANY ipsw files (-d = 0)
	${gold}ipswget ${green}-d ${magenta}0 ${green}-v ${magenta}10.3.1 ${green}-p ${magenta}~/Downloads${reset}

	Get the list for 10.3.2 and downloads all iPad ipsws to ~/downloads (-d = 1)
	${gold}ipswget ${green}-d ${magenta}1 ${green}-v ${magenta}10.3.2 ${green}-p ${magenta}~/downloads${reset}

	Get the list for 10.3.2 and downloads all iPad ipsws to current directory (missing -p)
	${gold}ipswget ${green}-d ${magenta}1 ${green}-v ${magenta}10.3.2 ${reset}

"
fi

echo "Version : ${version}"
echo "Devices : " && case "${devices}"
	in
	0) echo -e "\t${red}DOES NOT download any ipsw files ONLY the list.";;
	1) echo -e "\t${green}Will download iPad ipsw files.";;
	2) echo -e "\t${green}Will download iPhone ipsw files.";;
	3) echo -e "\t${green}Will download iPad & iPhone ipsw files.";;
	4) echo -e "\t${green}Will download iPod ipsw files.";;
	5) echo -e "\t${green}Will download iPad & iPod ipsw files.";;
	6) echo -e "\t${green}Will download iPhone & iPod ipsw files.";;
	7) echo -e "\t${green}Will download All (iPad, then iPhone, then iPod) ipsw files.${reset}";;
esac

if [ "${version}" == "" ]; then
	echo "-v Version is required."
else
	if [ "${devices}" == "" ]; then
		echo "-d Devices is needed, though 0 will be assumed if you must include a single OCTAL value with option -d{OCTAL} to tell the script which device file types to download.
		ie. # ./listandgetipsws.sh -v{ios_version} -d{OCTAL}
		eg. # ./listandgetipsws.sh -v10.3.2 -d7  --Gets all device ipsw files for version 10.3.2 available file list.

		Add digits together to get multiple device files.
			0 -- DOES NOT download any files except the list
			1 -- gets iPad
			2 -- gets iPhone
			3 -- gets iPad & iPhone
			4 -- gets iPod
			5 -- gets iPad & iPod
			6 -- gets iPhone & iPod
			7 -- gets All (iPad, then iPhone, then iPod)

		!!! Generally we will use 1, 2, 3 or 0.";

	else
		ac2firmwarecache="~/Library/Group\ Containers/K36BKF7T3D.group.com.apple.configurator/Library/Caches/Firmware"
		mypath="/Users/Shared/acFirmware"

		if [ "${path}" == "" ]; then
			echo -e "No destination Path provided with -p option. \n\nChecking for ${mypath} ..."
			#This path is used for my iOS device management processes.  Feel free to change it to your default.  See the reasoning.readme for this folder use in my organization.
			if [[ -d "${mypath}" ]]; then
				echo "Found '${mypath}'"
				echo "Using '${mypath}' for file downloads"
				path="${mypath}"
			elif [[ -d "'${ac2firmwarecache}'" ]]; then
				echo -e "${mypath} not found.\n
				Found ${ac2firmwarecache}"
				path="${ac2firmwarecache}"
			else
				path=$(pwd);
				echo "${mypath} not found. ${ac2firmwarecache} not found."
				echo "Using current directory ${path} for file downloads"
			fi
		fi


		echo -e "\tDownloading the list of urls for the ipsw restore files for iOS version ${version}"
		##exit
		curl http://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStore.woa/wa/com.apple.jingle.appserver.client.MZITunesClientCheck/version | grep ipsw | grep $version | sort -u | sed 's/<string>//g' | sed 's/<\/string>//g' | grep -v protected | awk '{$1=$1}1' > /tmp/ipswlist_iOS${version}.txt

		# sort the URLs at character 89 to get all device types together.
		sort -u -k 1.89 -o ${path}/iOS${version}_All.txt /tmp/ipswlist_iOS${version}.txt;

		# If $path/lists does not exist make directory

		if [ ! -d "${path}/ipswlists" ]; then
			mkdir -p "${path}/ipswlists"
		fi

		# Create individual url lists for each device type.

		cat /tmp/ipswlist_iOS${version}.txt | grep iPad > ${path}/ipswlists/ipswListiOS${version}_iPad.txt;
		#@TODO::dkmansion - calculate total lines and estimate total file size for downloads chosen.
		cat /tmp/ipswlist_iOS${version}.txt | grep iPhone > ${path}/ipswlists/ipswListiOS${version}_iPhone.txt;

		cat /tmp/ipswlist_iOS${version}.txt | grep iPodtouch > ${path}/ipswlists/ipswListiOS${version}_iPodtouch.txt;

		files=$(echo `wc -l < /tmp/ipswlist_iOS${version}.txt`);
		filesizeestimate=$(($files*2));

		echo $files;
		echo $filesizeestimate;

		exit;

		# destroy the temp file
		rm -rf /tmp/ipswlist_iOS${version}.txt;

		# Change directory to $path to curl the ipsw files into.
		cd ${path};

		# if option -d OCTAL sums to 1 (iPad), 3
		if [ ${devices} == 1 ] || [ ${devices} == 3 ] || [ ${devices} == 5 ] || [ ${devices} == 7 ]; then
			for i in $(cat ${path}/ipswlists/ipswListiOS${version}_iPhone.txt) ; do curl -O $i; done
		fi

		if [ ${devices} == 2 ] || [ ${devices} == 3 ] || [ ${devices} == 6 ] || [ ${devices} == 7 ]; then
			for i in $(cat ${path}/ipswlists/ipswListiOS${version}_iPad.txt) ; do curl -O $i; done
		fi

		if [ ${devices} == 4 ] || [ ${devices} == 5 ] || [ ${devices} == 6 ] || [ ${devices} == 7 ]; then
			for i in $(cat ${path}/ipswlists/ipswListiOS${version}_iPodtouch.txt) ; do curl -O $i; done
		fi
	fi
fi
