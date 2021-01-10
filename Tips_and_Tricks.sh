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

# Swap and replace characters
sed 's/someRegex/replaceWithThis/numberOfFieldsInLineToReplace'

sed 's/pattern/replace/'                            # Default is to only replace the 1st matching instance of a line
sed 's!/home/user1!/home/user2!g'         # Sed can use any char for the separator, such as ':', which is useful when you don't want to have to use escape characters
sed 's/pattern/replace/2'                           # Take from pipe, replace 2 pattern matches per line, output to stdout
sed 's/pattern/replace/g'                           # Take from pipe, replace all pattern matches, output to stdout
sed 's/pattern/replace/g' file.txt > output.txt     # Take from file.txt, dump to output.txt
sed 's/pattern/replace/g' file.txt                  # Take from file.txt, dump to stdout
sed -i 's/pattern/replace/g' output.txt             # Take from output.txt, -i for change to file inline, dump to output.txt

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
