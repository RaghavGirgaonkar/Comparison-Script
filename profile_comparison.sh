#!env bash

source /Data/bcj/INPTA/soft/Pulsar/pulsarbashrc.sh
source /home/asusobhanan/Work/V6/pinta.bashrc

#read -p "Enter fits1 :" fits1
#read -p "Enter fits2 :" fits2

declare -a asciifiles=()

for i in $@
do
        pam -DFT -e fits.scrunched --setnchn 8 --setnbin 64 -r 0.5 ${i}
	pdv -jDFT -t ${i}.scrunched  | grep -v File | awk '{print $4}' > ${i}.scrunched.txt
	asciifiles+=(${i}.scrunched.txt)
done
 
python3.6 profilecomparision.py ${asciifiles[0]} ${asciifiles[1]}