# A great resource for all things using 'curl'
curl cheat.sh               # How to use cheat.sh
curl cheat.sh/:list         # list of all topics!
curl cheat.sh/latency       # just cool

### Make API requests in Bash
# create credential
account_sid="ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
auth_token="your_auth_token"

available_number=`curl -X GET \
    "https://api.twilio.com/2010-04-01/Accounts/${account_sid}/AvailablePhoneNumbers/US/Local"  \
    -u "${account_sid}:${auth_token}" | \
    sed -n "/PhoneNumber/{s/.*<PhoneNumber>//;s/<\/PhoneNumber.*//;p;}"` \
    && echo $available_number 
