#!/bin/bash
# File              : osd.sh
# Author            : Jeff LANCE <email@jefflance.me>
# Date              : 27.04.2020
# Last Modified Date: 27.04.2020
# Last Modified By  : Jeff LANCE <email@jefflance.me>
MUSIC_DIR=${HOME}/Musique #path to your music dir
COVER=/tmp/cover.jpg

title="$(mpc -p 6600 --format %title% current)"
artist="$(mpc -p 6600 --format %artist% current)"
album="$(mpc -p 6600 --format %album% current)"

text="\n<b>${title}</b>\n<i>${album}</i>"

get_cover

# notify-send -t 30000 -i "${HOME}/.icons/Shadow/64x64/apps/mplayer.svg" "${artist}" "${text}"
notify-send -t 10000 -i "${COVER}" "${artist}" "${text}"

function get_cover {
    file="$(mpc -p 6600 --format %file% current | awk -F: '{print $3}'  | sed 's/%20/ /g')"
    album_dir="${file%/*}"
    [[ -z "$album_dir" ]] && exit 1
    album_dir="$MUSIC_DIR/$album_dir"

    covers="$(find "$album_dir" -type d -exec find {} -maxdepth 1 -type f -iregex ".*/.*\(${album}\|cover\|folder\|artwork\|front\).*[.]\(jpe?g\|png\|gif\|bmp\)" \; )"
    src="$(echo -n "$covers" | head -n1)"
    rm -f "$COVER"
    if [[ -n "$src" ]] ; then
        #resize the image's width to 300px
        convert "$src" -resize 300x "$COVER"
        if [[ -f "$COVER" ]] ; then
           #scale down the cover to 30% of the original
           printf "\e]20;${COVER};50x50+0+00:op=keep-aspect\a"
        else
            reset_background
        fi
    else
        reset_background
    fi
}
