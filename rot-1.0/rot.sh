#!/bin/bash

# Check if we have the correct number of arguments
if [ $# -ne 2 ]; then
  echo "Usage: $0 [-e|-d] key"
  exit 1
fi

# Check if the first argument is -e or -d
if [ "$1" == "-e" ]; then
  mode=encrypt
elif [ "$1" == "-d" ]; then
  mode=decrypt
else
  echo "Error: First argument must be -e or -d"
  exit 1
fi

# Check if the second argument is a valid integer
if ! [[ "$2" =~ ^[0-9]+$ ]]; then
  echo "Error: Second argument must be an integer"
  exit 1
fi

# Set the key and alphabet
key=$2
alphabet=(a b c d e f g h i j k l m n o p q r s t u v w x y z)

# Read the message from stdin
read -r -p "Enter message: " message

# Convert the message to lowercase
message=$(echo "$message" | tr '[:upper:]' '[:lower:]')

# Initialize the output
output=""

# Process each character of the message
for (( i=0; i<${#message}; i++ )); do
  char=${message:$i:1}

  # Check if the character is a letter
  if [[ "$char" =~ ^[a-z]$ ]]; then
    # Get the index of the character in the alphabet
    index=$(printf "%d" "'$char")
    index=$((index - 97))

    # Encrypt or decrypt the character
    if [ "$mode" == "encrypt" ]; then
      index=$(((index + key) % 26))
    elif [ "$mode" == "decrypt" ]; then
      index=$(((index - key) % 26))
    fi

    # Append the encrypted/decrypted character to the output
    char=${alphabet[$index]}
  fi

  output+="$char"
done

# Print the output
echo "Your Output For ROT$2 is $output"
