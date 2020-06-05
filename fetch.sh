# configuration
NAME=xiaochi
PASS=xiaochi
API="127.0.0.1:1234"

# read from net
curl "$API/$NAME" | while read line
do
	dt=$( echo "$line" | cut -f 1 )
	# name of other side
	other=$( echo "$line" | cut -f 2 )

	# digest
	dgst=$( echo "$line" | cut -f 4 )

	# signature
	sign=$( echo "$line" | cut -f 5 )

	echo "FROM: $other"
	echo "DATE: $dt"

	echo "$dgst"
	echo $sign | base64 -d | openssl rsautl -verify -pubin -inkey ${other}_rsapublickey.pem
	echo

	echo "$line" | cut -f"6-" | tr "\t" "\n" | while read line
	do
		echo $line | base64 -d |  openssl rsautl -passin pass:"$PASS" -decrypt -inkey rsaprivatekey.pem
		echo
	done
	echo
done



