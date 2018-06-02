#!/bin/bash
# rsa-locksmith.sh: Teeny tiny script to brute-force passphrases of RSA private keys
# https://github.com/jakejarvis/rsa-locksmith

WORDLIST="/Users/jake/passwords.txt"

# check if path to key was entered as argument
if [ -z "$1" ]
then 
    echo -n "Enter path to the private key: "
    read KEY
else
    KEY=$1
fi

for PASSPHRASE in $(cat $WORDLIST)
do
    if [[ -n $(echo -n $PASSPHRASE | openssl rsa -passin stdin 2>&1 -in $KEY | grep -v error | grep -v unable) ]]  
    then
        echo -e "\nFOUND PASSPHRASE:" $PASSPHRASE "\n"
        echo -n $PASSPHRASE | openssl rsa -passin stdin 2>&1 -in $KEY
        exit
    fi
done

echo "No match found, maybe try a different wordlist?"