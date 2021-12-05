#!env bash

source /Data/bcj/INPTA/soft/Pulsar/pulsarbashrc.sh
source /home/asusobhanan/Work/V6/pinta.bashrc

#python3.6 -m pip install --user --upgrade pip
#python3.6 -m pip install --user scipy numpy lmfit
#python3.6 -m pip install --user statsmodels seaborn pandas importlib_metadata

#read -p "Enter fits1 :" fits1
#read -p "Enter fits2 :" fits2

flag = 0

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

exit_code=$?
if [[ $exit_code = 1 ]]; then
   echo "Test Passed!!!"
   let "flag++"
elif [[ $exit_code = 0 ]]; then
     echo "Test Failed!!!"
fi


echo "********************************"
echo "Running the pdmp DMs Test..."
echo "********************************"

declare -i c=-1
declare -a filenames=()
for i in $@
do
z=$((c+1))
	#echo $z
	#echo $i
        outfile=$(basename $i).txt
	filenames+=($outfile)
	echo "Filename is"
	echo ${filenames[@]}
	echo "Outfile is"
	echo $outfile
        pdmp -mc 64 -g ./$i.summary.ps/cps ./$i > $outfile
	c=$((c+1))
	
done
echo "Going through array of .txt files"

#do awk '/Best DM/ {print $2" "$5}' "${filename[0]}" >> DMs.txt

for j in "${filenames[@]}"
do
	awk '/Best DM/ {print $4" "$7}' $j >> DMs.txt



done

python3 dmdiff.py

declare -a asciifiles=()

#echo "********************************"
#echo "Flag value is" $flag
#echo "********************************"

echo "*****************************************************"
echo "Running Timing and Residual Test..."
echo "*****************************************************"


python3.6 tim_res.py
