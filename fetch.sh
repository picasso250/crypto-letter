#!/bin/bash

# configuration
NAME=xiaochi
PASS=xiaochi
API="129.226.187.205:1234"

set -e

# read from net
curl -s "$API/$NAME" | while read -e
do
	# date
	dt=$( echo "$REPLY" | cut -f 1 )
	# name of other side
	other=$( echo "$REPLY" | cut -f 2 )

	# digest
	dgst=$( echo "$REPLY" | cut -f 4 )

	# signature
	sign=$( echo "$REPLY" | cut -f 5 )

	echo "FROM: $other"
	echo "DATE: $dt"

	echo "$dgst"
	d2=$( echo $sign | base64 -d | openssl rsautl -verify -pubin -inkey ${other}_rsapublickey.pem )
	if [[ "$dgst" != "$d2" ]]; then
		echo "!!! Invalid signature !!!"
		echo "$d2"
	fi

	rm -f .tmp
	echo "$REPLY" | cut -f"6-" | tr "\t" "\n" | while read line
	do
		echo $line | base64 -d |  openssl rsautl -passin pass:"$PASS" -decrypt -inkey rsaprivatekey.pem >> .tmp
		echo >> .tmp
	done

	d3=$( openssl dgst -sha1 .tmp | cut -d' ' -f2 )
	if [[ "x$dgst" != "x$d3" ]]; then
		echo "!!!! Invalid signature !!!!"
		echo "$d3"
	fi

	cat .tmp
	echo
done

