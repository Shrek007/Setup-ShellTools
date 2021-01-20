## This is a test - automated comments

# Display Emojis in the terminal
echo -e "\U0001F600"

# A great resource for all things using 'curl'
curl cheat.sh               # How to use cheat.sh
curl cheat.sh/:list         # list of all topics!
curl cheat.sh/latency       # just cool

# Quick & loud port scanner in bash with 3 second timeout
curl 192.168.1.1:[3000-6000] -m 3 

# Run multiple arguments through a single command
for x in '*.gz'; do gunzip $x; done

## Search for information through text
# grep - simple patterns
curl github.com | grep 'Git'
                | grep -n 'Git'
                | grep 
# egrep - Regex
curl github.com | egrep '/[gG]it/g'    # lower/uppercase
                | egrep 'i/git/g'      # case insensitive, many more options - this isn't a regex tutorial

### Search through Filesystem
# find - files & directories based on name, size, time, user, and permissions
find / "name"                                                                           # simple search
find /usr/bin -type f -user user2 -perm o=rw -size +150m -name "some_cool_file.txt"     # pullin out all the stops

# Swap and replace characters
sed 's/someRegex/replaceWithThis/numberOfFieldsInLineToReplace'

sed 's/pattern/replace/'                            # Default is to only replace the 1st matching instance of a line
sed 's!/home/user1!/home/user2!g'         # Sed can use any char for the separator, such as ':', which is useful when you don't want to have to use escape characters
sed 's/pattern/replace/2'                           # Take from pipe, replace 2 pattern matches per line, output to stdout
sed 's/pattern/replace/g'                           # Take from pipe, replace all pattern matches, output to stdout
sed 's/pattern/replace/g' file.txt > output.txt     # Take from file.txt, dump to output.txt
sed 's/pattern/replace/g' file.txt                  # Take from file.txt, dump to stdout
sed -i 's/pattern/replace/g' output.txt             # Take from output.txt, -i for change to file inline, dump to output.txt

cut -f1- -d : --output-delimiter=;                  # (ex. : becomes ;) Simple substitution of delimiter only, can be piped into from something like cat or echo

# Filter/truncate content to be displayed
cut -f 1 -d : infile.txt > outfile.txt              # Take from infile.txt and dump to outfile.txt
echo "hello,big,world" | cut -f 2 -d ,              # display 2nd of the fields, which are delimited by commas, to stdout
echo "hello,big,world" | cut -f 2- -d ,             # display 2nd field up to last field    
echo "hello,big,world" | cut -f -2 -d ,             # display 2nd filed up to first field
echo "hello,big,world" | cut -f 1,3 -d ,            # display 1st and 3rd fields

# Delete files and objects
rm                                  # standard for deleting the pointers to files and folders
shred                               # Careful!! this overwrites files to hide it's contents, optionally delete's it

### Checksums for files
which md5sum            #location for all different checksum commands
ls -l /usr/bin/*sum     #list all checksum commands
sha256sum file.txt      #choose command to calculate type of checksum



### Make API requests in Bash
# create credential
account_sid="ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
auth_token="your_auth_token"

available_number=`curl -X GET \
    "https://api.twilio.com/2010-04-01/Accounts/${account_sid}/AvailablePhoneNumbers/US/Local"  \
    -u "${account_sid}:${auth_token}" | \
    sed -n "/PhoneNumber/{s/.*<PhoneNumber>//;s/<\/PhoneNumber.*//;p;}"` \
    && echo $available_number 

### Swiss Army Knife - TCP/UDP
# netcat - has diff. versions w/ diff. switches, cross platform - ncat is used by nmap, can be accessed from windows cmd
nc -l 6666                   # [server] open a TCP listener on local port 666, can be tested w/ "curl 127.0.0.1:666"
nc 192.168.0.2 6666          # [client] connect to TCP listener on socket 192.168.0.2:666
nc -e /bin/bash              # takes input received by netcat, and EXECUTES /bin/bash, piping all input to /bin/bash
                                # the -e option is often not supported by certain netcat variants

nc -l -p 6666 -e /bin/bash  # [server] create a listener on local port 6666 which has spawned a bash session and will pipe input to it
nc 192.168.0.2 6666         # [client] effectively connect to bash shell created above

nc -l -p 6666 > file.txt    # [server] create listener, redirect output to file.txt
nc 192.168.0.2 6666         # [client] whatever you type here will show up in file.txt

### Enumeration
# Devices
nmap
rustscan        # faster nmap written in R, and supports python https://github.com/RustScan/RustScan
netdiscover

# Websites
whatweb

### Wifi
# Capturing
aircrack-ng suite       # Identify wifi card, enter monitor mode, listen to traffic,identify target, kick target off network, listen for handshake, then crack hash
                        # \----iwconfig-----/\----airmon-ng-----/\----------airodump-ng------------/\-----aireplay-ng------/\-----airodump-ng-----/\----aircrack-ng----/                           
kesmit

# Cracking
aircrack-ng suite
bettercap               # Does not require a connected wifi client to obtain and crack a hash.... somehow
bully                   # Pixie dust attack (WPS Pixie) attack in less than 10 seconds if vulnerable
reaver                  # Pixie dust attack
airgeddon               # This tool actuallly does a whole bunch of streamlined stuff

# Decryption
hashcat                 # Can crack nearly any hashtype, accelerated by using system hardware

# Analysis / Graphs
aircrack-ng suite
kismet                  # A signal intellegence tool, can monitor signals from far away
wavemon                 # Live signal strength graph and essid scanning... Also the best "help" page I've ever seen in-app
