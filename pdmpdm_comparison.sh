#!env bash

echo "********************************"
echo "Running the pdmp DMs Test..."
echo "********************************"

declare -i c=-1
declare -a filenames=()
for i in $@
do
	z=$((c+1))
	echo $z
	echo $i
        outfile=$(basename $i).txt
	filenames+=($outfile)
	echo "Filenames is"
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
