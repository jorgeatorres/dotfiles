#!/bin/bash

standard_colors() {
    echo "-- ANSI Colors --"
    for i in {30..37} {90..97}; do
        for j in 0 1 2 4 5; do
            printf "\e[${j};${i}m \\\e[${j};${i}m\e[0m\t"
        done
        echo
    done
    echo;
}

term256_colors() {
    echo "-- 256 Color Terminal Colors --"
    for i in {0..256}; do
        printf "\e[38;5;${i}m \\\e[38;5;${i}m\e[0m "

        if [ $((($i + 1 ) % 10 )) == 0 ]; then
            echo
        fi
    done

    echo
}

printf "1) ANSI Colors\n2) 256 Color Terminal Colors\nChoose your destiny: "
read -n 1 colorset
printf "\n"

if [  "$colorset" == 1 ]; then
    standard_colors;
else
    term256_colors;
fi
