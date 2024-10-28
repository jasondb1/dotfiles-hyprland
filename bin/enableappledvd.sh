#! /bin/sh
#
# required sg3 utils
# sudo apt-get install sg3-utils
#
#find out which device is your dvd  ls /dev 
#
#
#magic code to enable aple dvd drive
sg_raw /dev/sr0 EA 00 00 00 00 00 01

