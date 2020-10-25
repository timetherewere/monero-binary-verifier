#!/bin/bash

wget -O binaryfate.asc https://raw.githubusercontent.com/monero-project/monero/master/utils/gpg_keys/binaryfate.asc 1>/dev/null 2>&1
OUTPUT=`gpg --keyid-format long --with-fingerprint binaryfate.asc` 2>&1

SUB1='rsa4096/F0AF4D462A0BDF92 2019-12-12 [SCEA]'
SUB2='81AC 591F E9C4 B65C 5806  AFC3 F0AF 4D46 2A0B DF92'
SUB3='binaryFate <binaryfate@getmonero.org>'

if [[ "$OUTPUT" == *"$SUB1"* && "$OUTPUT" == *"$SUB2"* && "$OUTPUT" == *"$SUB3"* ]]; then
  echo "binaryfate signature key is valid."
else
  echo "binaryfate signature key is NOT valid. Please re-download the signature key and try again."
  exit
fi

{
  gpg --import binaryfate.asc
  wget -O hashes.txt https://www.getmonero.org/downloads/hashes.txt
} 1>/dev/null 2>&1

OUTPUT=$(gpg --verify hashes.txt 2>&1 1>/dev/null)

SUB1="gpg:                using RSA key 81AC591FE9C4B65C5806AFC3F0AF4D462A0BDF92"
SUB2="gpg: Good signature from \"binaryFate <binaryfate@getmonero.org>\" [unknown]"
SUB3="gpg: WARNING: This key is not certified with a trusted signature!"
SUB4="gpg:          There is no indication that the signature belongs to the owner."
SUB5="Primary key fingerprint: 81AC 591F E9C4 B65C 5806  AFC3 F0AF 4D46 2A0B DF92"

echo ""
echo ""
echo "OUTPUT: "
echo "$OUTPUT"
echo ""
echo "comparision test: " 
echo "$SUB1"
echo "$SUB2"
echo "$SUB3"
echo "$SUB4"
echo "$SUB5"
echo ""
echo ""
if [[ "$OUTPUT" == *"$SUB1"* && "$OUTPUT" == *"$SUB2"* && "$OUTPUT" == *"$SUB3"* && "$OUTPUT" == *"$SUB4"* && "$OUTPUT" == *"$SUB5"* ]]; then
  echo "The hash index (hashes.txt) is legitimate."
else
  echo "The hash index (hashes.txt) can not be verified. Please re-download the file and try again."
  exit
fi

{
  SHASUM=`shasum -a 256 $1`
  VERIFICATION_HASH_LINE=`cat hashes.txt | grep $1`
} 1>/dev/null 2>&1
echo "SHASUM: $SHASUM"
echo "Hash from hashfile: $VERIFICATION_HASH_LINE"
if [ "$SHASUM" == "$VERIFICATION_HASH_LINE" ]; then
  echo "The file has been verified and is genuine."
else
  echo "The file can not be verified. DO NOT OPEN IT."
fi
