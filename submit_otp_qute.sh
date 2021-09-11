#!/bin/sh
# qutebrowser userscript that enters the otp code and presses <Enter>
# designed to be used when prompted with the Okta Verify "Enter Code" form
USAGE="usage: $0 OTP_NAME"

if [ "$#" -ne 1 ]; then
    echo "$USAGE"
    exit 1
fi

OTP_NAME="$1"

# retrieve the otp
otp=$(pass otp "$OTP_NAME")

if [ -z "$otp" ]; then
    echo "Unknown OTP_NAME '$OTP_NAME'"
    exit 1
fi

# insert the otp at the focussed text box and submit it
echo "insert-text $otp;; mode-enter insert;; fake-key <Enter>" >> "$QUTE_FIFO"
