#!/bin/bash

# configuration
NAME=xiaochi
API="129.226.187.205:1234/server.php"
# LENGTH=1024

set -e

# the name of other side
if [[ $# -lt 1 ]]
then
	echo "who do you want to send?"
	exit 1
fi

# you going to send the content of file `letter`
if [[ ! -f "letter" ]]
then
	echo "no file letter"
	exit 1
fi

# the public key for him
pbk="$1_rsapublickey.pem"
if [[ ! -f $pbk ]]
then
	echo "no file $pbk"
	exit 1
fi

cat letter | ./catlen > _letter

# digest
dgst=$( openssl dgst -sha1 _letter | cut -d' ' -f2 )

# construct real send file, as follows:
#   from
#   to
#   digest
#   signature
#   cipher text
echo -n "$NAME	" > .letter
echo -n "$1	" >> .letter
echo -n "$dgst	" >> .letter
echo -n "$dgst" | openssl rsautl -sign -inkey rsaprivatekey.pem | base64 -w 0 >> .letter

cat _letter | while read
do
	echo -n "	" >> .letter
	echo -n "$REPLY" | openssl rsautl -encrypt -pubin -inkey $pbk | base64 -w 0 >> .letter
done

curl -d@.letter "$API"
echo
