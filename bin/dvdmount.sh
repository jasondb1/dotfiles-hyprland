#! /bin/bash


if [ -n "$1" ]
then
sudo mount $1 /media/dvd -o loop,ro
echo "Mounting $1 on /media/dvd"
else
echo "No parameters found. Include path to .iso file"
echo "Usage: dvdmount <file>"
fi
