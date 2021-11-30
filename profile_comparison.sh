#!env bash

source /Data/bcj/INPTA/soft/Pulsar/pulsarbashrc.sh
source /home/asusobhanan/Work/V6/pinta.bashrc

#python3.6 -m pip install --user --upgrade pip
#python3.6 -m pip install --user scipy numpy lmfit
#python3.6 -m pip install --user statsmodels seaborn pandas importlib_metadata

#read -p "Enter fits1 :" fits1
#read -p "Enter fits2 :" fits2

declare -a asciifiles=()

echo "*****************************************************"
echo "Running Profile Comparison Test..."
echo "*****************************************************"
for i in $@
do
        pam -DFT -e fits.scrunched --setnbin 64 -r 0.5 ${i}
	pdv -jDFT -t ${i}.scrunched  | grep -v File | awk '{print $4}' > ${i}.scrunched.txt
	asciifiles+=(${i}.scrunched.txt)
done
 
python3.6 profilecomparision.py ${asciifiles[0]} ${asciifiles[1]}
