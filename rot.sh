#!/bin/bash
if [ $# -ne 2 ]; then
  echo "Usage: $0 [-e|-d] key"
  exit 1
fi

if [ "$1" == "-e" ]; then
  mode=encrypt
elif [ "$1" == "-d" ]; then
  mode=decrypt
else
  echo "Error: First argument must be -e or -d"
  exit 1
fi

if ! [[ "$2" =~ ^[0-9]+$ ]]; then
  echo "Error: Second argument must be an integer"
  exit 1
fi

key=$2
alphabet=(a b c d e f g h i j k l m n o p q r s t u v w x y z)

read -r -p "Enter message: " message
message=$(echo "$message" | tr '[:upper:]' '[:lower:]')
output=""
for (( i=0; i<${#message}; i++ )); do
  char=${message:$i:1}
  if [[ "$char" =~ ^[a-z]$ ]]; then
    index=$(printf "%d" "'$char")
    index=$((index - 97))
    if [ "$mode" == "encrypt" ]; then
      index=$(((index + key) % 26))
    elif [ "$mode" == "decrypt" ]; then
      index=$(((index - key) % 26))
    fi
    char=${alphabet[$index]}
  fi
  output+="$char"
done
echo "Your Output For ROT$2 is $output"
