#!/bin/bash
echo "Press and hold any key"
echo "Once you fall asleep you will release the key and bells will play to wake you up"
while [ true ] ; do
read -t 3 -n 1
if [ $? = 0 ] ; then
    while [ true ]; do
        read -t3 -n1
        if [ $? = 0 ]; then
            echo "Waiting for you to fall asleep and release the button"
        else
            while [ true ] ; do
                paplay ~/.config/bell.wav && paplay ~/.config/bell.wav && paplay ~/.config/bell.wav
            done
            exit ;
        fi
    done
else
echo "Waiting for you to press a key..."
fi
done
