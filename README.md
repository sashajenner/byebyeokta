bye bye okta
============
This is a manual on how to login through Okta portals without a phone.


## Requirements
Install [pass-otp](https://github.com/tadfisher/pass-otp#installation).


## Steps
If you already have multifactor authentication set up, start with step 1.

Otherwise, login up to the point where it asks you to "Set up
(two-|multi)factor authentication", and go to step 4.

1. Login to your organisation's Okta settings. The url is typically of the
   form `https://OKTA_HOME_PAGE/enduser/settings`.

For example,

- The University of Sydney: https://sso.sydney.edu.au/enduser/settings
- Garvan: https://garvan.okta.com/enduser/settings

If you know any others, please let me know.

2. Scroll to "Extra Verification". This is typically at the bottom on the
   right.

3. If you already have Okta Verify or Google Authenticator set up with your
   organisation, remove it.

4. Retrieve the secret one-time password (OTP) key.

    1. Click "Set up" next to "Okta Verify".

    2. If a button appears, click it. It may say "Configure factor" or "Set
       up".

    3. Click "iPhone" or "Android". It doesn't matter which one you pick, you
       won't be needing a phone.

    4. Click "Next".

    5. Click "Can't scan?".

    6. Click the first dropdown menu and select "Setup manually without push
       notification".

    7. Copy the greyed out secret key to your clipboard.

5. Create the OTP generator by running the following command, replacing
   `OTP_NAME` with a name of your choosing. Paste the secret key when prompted.
```sh
pass otp insert -esi byebyeokta OTP_NAME
```

6. Generate the OTP by running the following command.
```sh
pass otp OTP_NAME
```
Copy the output. Alternatively, use the `-c` option to copy it directly.
```sh
pass otp -c OTP_NAME
```

7. Enter the OTP.

    1. Click "Next".

    2. Paste the number in the "Enter Code" text box.

    3. Click "Verify" to finish the setup.

    4. You may have to click "Finish" as well.

8. Now, whenever you are required to enter the OTP code in the future, simply
   generate it by following step 6.


## Authenticator App
Add the secret key to a OTP authenticator app. This is useful if you need to
use a different computer and don't have access to one which you set up
`pass-otp` with.

1. Find a way to add a new account by entering the secret key manually into
   the app. For the Okta Verify app, do the following. The steps are similar for the Google Authenticator app.

    1. Press the "+" button in the top-right corner.

    2. Press "Other".

    3. Press "Enter Key Manually".

    4. Type an Account Name of your choosing.

    5. Type in the secret key. If you have lost the key, run the following command to retrieve it.
    ```sh
    pass OTP_NAME | awk -F '[=&]' '{print $2}'
    ```

    6. Press "Done".

2. Confirm you get the same codes on your phone as when following step 6.
   If not, you may have misspelled the secret key, in which case try again.

3. If you have an old account on a OTP authenticator app which you removed
   in step 3 you can remove it from the app.


## Automating
The goal is to auto fill and submit once prompted to enter the OTP code.

If you know a neat way of doing this in Chrome or Firefox, please let me know.
For qutebrowser, consider binding a key chain to the `submit_otp_qute.sh`
userscript.

1. Copy the script from this repository to your qutebrowser userscripts.
```sh
git clone git@github.com:sashajenner/byebyeokta.git
mkdir -p ~/.local/share/qutebrowser/userscripts
cp byebyeokta/submit_otp_qute.sh ~/.local/share/qutebrowser/userscripts
```

2. You can bind it to `,p` by using the following command in qutebrowser.
```qute
:bind , spawn --userscript submit_otp_qute.sh OTP_NAME
```

3. Test it out. Navigate to a page which requires you to enter the OTP
   code. In normal mode type `,p` or enter the following command.
```qute
:spawn --userscript submit_otp_qute.sh OTP_NAME
```
