#!/bin/sh
# qutebrowser userscript that enters the otp code and presses <Enter>
# designed to be used when prompted with the Okta Verify "Enter Code" form
USAGE="usage: $0 OTP_NAME"

if [ "$#" -ne 1 ]; then
    echo "$USAGE"
    exit 1
fi

otp=$(pass otp "$1")

# insert the otp at the focussed text box and submit it
echo "insert-text $otp;; enter-mode insert;; fake-key <Enter>" >> "$QUTE_FIFO"
