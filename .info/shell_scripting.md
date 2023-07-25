# bash must read

https://www.cyberciti.biz/tips/bash-shell-parameter-substitution-2.html

# bash one liners

- recursively remove any node_modules folder

`find . -name "node_modules" -exec rm -rf '{}' +`

# interpolation

`cp learning_{loops,test}.go`

creats a file called learning_loops.go to learning_test.go by copying


```bash
nixCraft
nixCraft → Tutorials → Linux → How To Use Bash Parameter Substitution Like A Pro
🔎 To search, type & hit enter...

How To Use Bash Parameter Substitution Like A Pro
Author: Vivek Gite Last updated: February 21, 2023 36 comments

The $ character is used for parameter expansion, arithmetic expansion and command substitution. You can use it for manipulating and expanding variables on demands without using external commands such as perl, python, sed or awk. This guide shows you how to use parameter expansion modifiers to transform Bash shell variables for your scripting needs.


nixCraft: Privacy First, Reader Supported
nixCraft is a one-person operation. I create all the content myself, with no help from AI or ML. I keep the content accurate and up-to-date.
Your privacy is my top priority. I don’t track you, show you ads, or spam you with emails. Just pure content in the true spirit of Linux and FLOSS.
Fast and clean browsing experience. nixCraft is designed to be fast and easy to use. You won’t have to deal with pop-ups, ads, cookie banners, or other distractions.
Support independent content creators. nixCraft is a labor of love, and it’s only possible thanks to the support of our readers. If you enjoy the content, please support us on Patreon or share this page on social media or your blog. Every bit helps.
Join Patreon ➔
Syntax
You can use variables to store data and configuration options. For example:
dest="/backups"

Use echo or printf command to display variable value. For instnace:
echo "$dest"

OR
printf "$dest\n"

The parameter name or symbol such as $dest to be expanded may be enclosed in braces. For example:
echo "Value ${dest}"

It is optional but serve to protect the variable to be expanded from characters immediately following it which could be interpreted as part of the name.
How To Use Bash Parameter Substitution Like A Pro

1. Setting Up Default Shell Variables Value
The syntax is as follows:

${parameter:-defaultValue}
var=${parameter:-defaultValue}

If parameter not set, use defaultValue. In this example, your shell script takes arguments supplied on the command line. You’d like to provide default value so that the most common value can be used without needing to type them every time. If variable $1 is not set or passed, use root as default value for u:

u=${1:-root}
Consider the following example:

#!/bin/bash
_jail_dir="${1:-/home/phpcgi}"
echo "Setting php-cgi at ${_jail_dir}..."
# rest of the script ...
You can now run this script as follows:

./script.sh /jail              # <--- set php jail at /jail dir
./script.sh /home/httpd/jail   # <---- set php jail at /home/httpd/jail dir
./script.sh                    # <--- set php jail dir at /home/phpcgi (default)
Here is another handy example:

_mkdir(){
        local d="$1"               # get dir name
        local p=${2:-0755}      # get permission, set default to 0755
        [ $# -eq 0 ] && { echo "$0: dirname"; return; }
        [ ! -d "$d" ] && mkdir -m "$p" -p "$d"
}
## call it ##
_mkdir "/var/www/php" 0644
_mkdir "/var/www/static" 0666
# set default permissions to 0755 in _mkdir() #
_mkdir "/var/www/static"
Use this substitution for creating failsafe functions and providing missing command line arguments in scripts.

#1.1: Setting Default Values
The syntax is as follows:

${var:=value}
var=${USER:=value}
The assignment (:=) operator is used to assign a value to the variable if it doesnâ€™t already have one. Try the following examples:

echo "$USER"
Sample outputs:

vivek
Now, assign a value foo to the $USER variable if doesn’t already have one:

echo ${USER:=foo}
Sample outputs:

vivek
Unset value for $USER:

unset USER
echo "${USER:=foo}"
Sample outputs:

foo
This make sure you always have a default reasonable value for your script.

Tip: ${var:-defaultValue} vs ${var:=defaultValue}
Please note that it will not work with positional parameter arguments:

var=${1:=defaultValue}  ### FAIL with an error cannot assign in this way
var=${1:-defaultValue}    ### Perfect
2. Display an Error Message If $VAR Not Passed
If the variable is not defined or not passed, you can stop executing the Bash script with the following syntax:

${varName?Error varName is not defined}
${varName:?Error varName is not defined or is empty}
${1:?"mkjail: Missing operand"}
MESSAGE="Usage: mkjail.sh domainname IPv4"             ### define error message
_domain=${2?"Error: ${MESSAGE}"}  ### you can use $MESSAGE too
This is used for giving an error message for unset parameters. In this example, if the $1 command line arg is not passed, stop executing the script with an error message:

_domain="${1:?Usage: mknginxconf domainName}"
Here is a sample script:

#!/bin/bash
# Purpose: Wrapper script to setup Nginx Load Balancer
# Author: Vivek Gite
_root="/nas.pro/prod/scripts/perl/nginx"
_setup="${_root}/createnginxconf.pl"
_db="${_root}/database/text/vips.db"
_domain="${1:?Usage: mknginxconf domainName}"     ### die if domainName is not passed ####
 
[ ! -f $_db ] && { echo "$0: Error $_db file not found."; exit 1; }
line=$(grep "^${_domain}" $_db) || { echo "$0: Error $_domain not found in $_db."; exit 2; }
 
# Get domain config info into 4 fields:
# f1 - Domain Name|
# f2 - IPv4Vip:httpPort:HttpsPort, IPv6Vip:httpPort:HttpsPort|
# f3 - PrivateIP1:port1,PrivateIP2,port2,...PrivateIPN,portN|
# f4 - LB Type (true [round robin] OR false [session])
# -------------------------------------------------------------------------------
IFS='|'
read -r f1 f2 f3 f4  <<<"$line"
 
# Do we want ssl host config too?
IFS=':'
set -- $f2
ssl="false"
[ "$3" == "443" ] && ssl="true"
 
# Build query
d="$f1:$ssl:$f4"
IFS=','
ips="$f3"
 
# Call our master script to setup nginx reverse proxy / load balancer (LB) for given domain name
$_setup "$d" "$ips"
2.1. Display an Error Message and Run Command
If $2 is not set display an error message for $2 parameter and run cp command on fly as follows:

#!/bin/bash
_file="$HOME/.input"
_message="Usage: chkfile commandname"
 
# Run another command (compact format)
_cmd="${2:? $_message $(cp $_file $HOME/.output)}"
 
$_cmd "$_file"
3. Find Variable Length
You can easily find string length using the following syntax:

${#variableName}
echo "${#variableName}"
len="${#var}"
# print it #
echo "$len"
Here is a sample shell script to add a ftp user:

#!/bin/bash
# Usage : Add a ftp user
_fuser="$1"
_fpass="$2"
 
# die if username/password not provided
[ $# -ne 2 ] && { echo "Usage: addftpuser username password"; exit 1;}
 
# Get username length and make sure it always <= 8
[[ ${#_fuser} -ge 9 ]] && { echo "Error: Username should be maximum 8 characters in length. "; exit 2;}
 
# Check for existing user in /etc/passwd
/usr/bin/getent passwd "${_fuser}" &>/dev/null
 
# Check exit status
[ $? -eq 0 ] && { echo "Error: FTP username \"${_fuser}\" exists."; exit 3; }
 
# Add user
/sbin/useradd -s /sbin/nologin -m  "${_fuser}"
echo "${_fpass}" | /usr/bin/passwd "${_fuser}" --stdin
Each Linux or UNIX command returns a status when it terminates normally or abnormally. You can use command exit status in the shell script to display an error message or take some sort of action. In above example, if getent command is successful, it returns a code which tells the shell script to display an error message. 0 exit status means the command was successful without any errors. $? holds the return value set by the previously executed command.

4. Remove Pattern (Front of $VAR)
The syntax is as follows:

${var#Pattern}
${var##Pattern}
You can strip $var as per given pattern from front of $var. In this example remove /etc/ part and get a filename only, enter:

f="/etc/resolv.conf"
echo "${f#/etc/}"
We see the file name:

resolv.conf
The first syntax removes shortest part of pattern and the second syntax removes the longest part of the pattern. Consider the following example:

_version="20090128"
_url="http://dns.measurement-factory.com/tools/dnstop/src/dnstop-${_version}.tar.gz"
You just want to get filename i.e. dnstop-20090128.tar.gz, enter (try to remove shortest part of $_url) :

echo "${_url#*/}"
Sample outputs:

/dns.measurement-factory.com/tools/dnstop/src/dnstop-20090128.tar.gz
Now try using the longest part of the pattern syntax:

echo "${_url##*/}"
Sample outputs:

dnstop-20090128.tar.gz
This is also useful to get a script name without using /bin/basename:

#!/bin/bash
_self="${0##*/}"
echo "$_self is called"
Create a script called master.info as follows:

#!/bin/bash
# Purpose: Display jail info as per softlink
# Author: Vivek Gite
_j="$@"
 
# find out script name
_self="${0##*/}"
 
[ "$VERBOSE" == "1" ] && echo "Called as $_self for \"$_j\" domain(s)"
 
for j in $_j
do
	export _DOMAIN_NAME=$j
	source functions.sh
	init_jail
        # call appropriate functions as per script-name / softlink
	case $_self in
		uploaddir.info) echo "Upload dir for $j: $(get_domain_upload_dir)" ;;
		tmpdir.info) echo "/tmp dir for $j: $(get_domain_tmp_dir)" ;;
                mem.info) echo "$j domain mem usage (php+lighttpd): $(get_domain_mem_info)" ;;
                cpu.info) echo "$j domain cpu usage (php+lighttpd): $(get_domain_cpu_info)" ;;
                user.info) echo "$j domain user and group info: $(get_domain_users_info)" ;;
                diskquota.info) echo "$j domain disk quota info (mysql+disk): $(get_domain_diskquota_info)" ;;
		*) warn "Usage: $_self"
	esac
done
Finally, create a new softlink as follows:
sudo ln -s master.info uploaddir.info
sudo ln -s master.info tmpdir.info
sudo ln -s master.info mem.info
....
..

You can now call script as follows:
sudo ./mem.info cyberciti.biz
./cpu.info cyberciti.biz nixcraft.com

#4.1: Remove Pattern (Back of $VAR)
The syntax is as follows:

${var%pattern}
${var%%pattern}
Exactly the same as above, except that it applies to the back of $var. In this example remove .tar.gz from $FILE, enter:

FILE="xcache-1.3.0.tar.gz"
echo "${FILE%.tar.gz}"
Here is what I get:

xcache-1.3.0
Rename all *.perl files to *.pl using bash for loop as Apache web server is configured to only use .pl file and not .perl file names:

for p in /scripts/projects/.devl/perl/*.perl
do
	mv "$p" "${p%.perl}.pl"
done
You can combine all of them as follows to create a build scripts:

#!/bin/bash
# Usage: Build suhosin module for RHEL based servers
# Author: Vivek Gite
# ----
# Set default value for $2
VERSION="-${2:-0.9.31}"
URL="http://download.suhosin.org/suhosin${VERSION}.tgz"
vURL="http://download.suhosin.org/suhosin${VERSION}.tgz.sig"
 
# Get tar ball names
FILE="${URL##*/}"
vFILE="${vURL##*/}"
DLHOME="/opt"
SOFTWARE="suhosin"
 
# Remove .tgz and get dir name
DEST="${FILE%.tgz}"
 
# Download software
wget "$URL" -O "${DLHOME}/$FILE"
wget "$vURL" -O "${DLHOME}/$vFILE"
 
# Extract it
tar -zxvf "$FILE"
cd "$DEST"
 
# Build it and install it
phpize --clean && phpize && ./configure && make && read -rp "Update/Install $SOFTWARE [Y/n] ? " answer
shopt -s nocasematch
[[ $answer =~ y|es  ]] && make install
shopt -u nocasematch
If you turn on nocasematch option, shell matches patterns in a case-insensitive fashion when performing matching while executing case or [[ conditional expression.

5. Find And Replace
The syntax is as follows:

${varName/Pattern/Replacement}
${varName/word1/word2}
${os/Unix/Linux}
Find word unix and replace with linux, enter:

x="Use unix or die"
sed 's/unix/linux/' <<<$x
You can avoid using sed as follows:

echo "${x/unix/linux}"
out="${x/unix/linux}"
echo "${out}"
To replace all matches of pattern, enter :

out="${x//unix/linux}"
You can use this to rename or remove files on fly

y=/etc/resolv.conf
cp "${y}" "${y/.conf/.conf.bak}"
Here is another example:

         # RHEL php modules path
	_php_modules="/usr/lib64/php/modules"
	for i in $_php_modules/*
	do
		p="${i##*/}"                  ## Get module name
		ini="/etc/php.d/${p/so/ini}"  ## Get ini file by replacing .so with .ini extension
                # make sure file exists
		[ ! -f "$ini" ] && echo "$i php module exists but $ini file not found."
	done
The following function installs required modules in chrooted php-cgi process

install_php_modules(){
        # get jail name
	local n="${_chrootbase}/${d##/}"
	local p=""
	local ini=""
        # enable only ${_php_modules_enabled} php modules and delete other .ini files if exists in jail
	for i in $_php_modules/*
	do
		p="${i##*/}"
		ini="$n/etc/php.d/${p/so/ini}"
                # find out if module is enabled or not
		if [[ ${_php_modules_enabled} = *${p}*   ]]
		then
			[ "$VERBOSE" == "1" ] && echo " [+] Enabling php module $p"
			$_cp -f "$i" "$n/${_php_modules##/}"      ## install it
			copy_shared_libs "$i"                     ## get shared libs in jail too
		else
			[ -f "${ini}" ] && $_rm -f "${ini}"	  ## if old .ini exists in jail, just delete it
		fi
	done
}
6. Substring Starting Character
The syntax is as follows:

${parameter:offset}
${parameter:offset:length}
${variable:position}
var=${string:position}
Expands to up to length characters of parameter starting at the character specified by offset.

base="/backup/nas"
file="/data.tar.gz"
#### strip extra slash from $file  ####
path="${base}/${file:1}"
Extract craft word only:

x="nixcraft.com"
echo ${x:3:5}"
To extract phone number, enter:

phone="022-124567887"
# strip std code
echo "${phone:4}"
7. Get list of matching variable names
Want to get the names of variables whose names begin with prefix? Try:

VECH="Bus"
VECH1="Car"
VECH2="Train"
echo "${!VECH*}"
Bash get list of all the variables whose names match a certain prefix
8. Convert to upper to lower case or vice versa
Use the following syntax to convert lowercase characters to uppercase:

name="vivek"
# Turn vivek to Vivek (only first character to uppercase)
echo "${name^}" 
# Turn vivek to VIVEK (uppercase)
echo "${name^^}" 
echo "Hi, $USERNAME"
echo "Hi, ${USERNAME^}"
echo "Hi, ${USERNAME^^}"
# Convert everything to lowercase 
dest="/HOME/Vivek/DaTA"
echo "Actual path: ${dest,,}"
# Convert only first character to lowercase 
src="HOME"
echo "${src,}"
Bash shell case conversion
Only convert first character in $dest if it is a capital ‘H’:

dest="Home"
echo "${dest,H}"
dest="Fhome"
echo "${dest,H}"
See “Shell Scripting: Convert Uppercase to Lowercase” for more info.

Summary: String Manipulation and Expanding Variables
For your ready references here are all your handy bash parameter substitution operators. Try them all; enhance your scripting skills like a pro:
Table 1: Bash Parameter Substitution
Variable	Description
${parameter:-defaultValue}	Get default shell variables value
${parameter:=defaultValue}	Set default shell variables value
${parameter:?"Error Message"}	Display an error message if parameter is not set
${#var}	Find the length of the string
${var%pattern}	Remove from shortest rear (end) pattern
${var%%pattern}	Remove from longest rear (end) pattern
${var:num1:num2}	Substring
${var#pattern}	Remove from shortest front pattern
${var##pattern}	Remove from longest front pattern
${var/pattern/string}	Find and replace (only replace first occurrence)
${var//pattern/string}	Find and replace all occurrences
${!prefix*}	Expands to the names of variables whose names begin with prefix.
${var,}
${var,pattern}	Convert first character to lowercase.
${var,,}
${var,,pattern}	Convert all characters to lowercase.
${var^}
${var^pattern}	Convert first character to uppercase.
${var^^}
${var^^pattern}	Convert all character to uppercase.
References:
Do read bash man page using the man command or help command:
man bash
help command

```
