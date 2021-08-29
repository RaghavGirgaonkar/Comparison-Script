#!env bash

source /Data/bcj/INPTA/soft/Pulsar/pulsarbashrc.sh
source /home/asusobhanan/Work/V6/pinta.bashrc

read -p "Enter fits1 :" fits1
read -p "Enter fits2 :" fits2

for i in $fits1 $fits2
do
        pam -DFT -r 0.5 -e fits.scrunched ${i}
	pdv -jDFT -t ${i}.scrunched  | grep -v File | awk '{print $4}' > ${i}.scrunched.txt
done
