#!/usr/bin/env bash
###### DISABLED BY PREPENDING '.' TO FILE NAME
# https://github.com/p-e-w/argos
DIR=$(dirname "$0")
SCRIPT_PATH="$0"
# File name: utc.1c.1s.sh
echo 
#   name.[int:positionNumber][char:position].[int:amount][char:h|m|s (hours, minutes, seconds)].sh
utc_now="$(date -u "+%Y-%m-%d  •  %H:%M:%S  •  UTC")"
# which geo-cli &> /dev/null && 
# utc_now+="    MYG $(geo-cli dev release)"

# LOG_ENTRY=$(journalctl /usr/bin/gnome-shell -n 1 --output=cat --no-pager)
# echo "$utc_now"
# echo "$utc_now | <span color='#1c1c00' weight='normal'>$utc_now</span> | length=46"

# Check out /home/dawsonmyers/.local/share/gnome-shell/extensions/argos@pew.worldwidemann.com/emoji for icon list
    #  Actually they're not icons, just emoji
# echo "$utc_now | iconName=clock11"
echo "$utc_now | iconName=clock"
# echo "$utc_now | iconName=starred"

# echo "<span color='#acc' weight='normal'><small><tt>$utc_now</tt></small></span> | length=46"

##### Menus are broken 
echo "---"
# utc_now_full="$(date -u "+%m-%d %H:%M:%S UTC")"
# echo "$utc_now_full | iconName=folder-symbolic"
echo "View GNOME Shell Log | bash='journalctl /usr/bin/gnome-shell -f'"
echo "--"
echo "Looking Glass | eval='imports.ui.main.createLookingGlass(); imports.ui.main.lookingGlass.toggle();'"

## /usr/bin/env bash

# URL="github.com/p-e-w/argos"
# DIR=$(dirname "$0")

# echo "Argos"
# echo "---"
# echo "$URL | iconName=help-faq-symbolic href='https://$URL'"
# echo "$DIR | iconName=folder-symbolic href='file://$DIR'"
