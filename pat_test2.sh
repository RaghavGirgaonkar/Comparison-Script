source /Data/bcj/INPTA/soft/Pulsar/pulsarbashrc.sh
source /home/asusobhanan/Work/V6/pinta.bashrc

mkdir temp

for i in $@
do
        cp $i temp
done

# Assumes that a template file and a DM.txt file is already present
cp template.fits temp
cp DM.txt temp

pam -e .4sub.fits --setnchn 4 --setnbin 64 -T temp/*

cd temp

for i in $@
do
# The below lines takes the MJD, finds corresponding DM in the DM.txt files
# Unsure of what to do here exactly

#       i="${i:11:5}"
# Above works only for standard nomenclature of files
#        dm=$(grep -w $i DM.txt | awk '{print $2}')

#       echo "Running Pam test involving DMs"
#       pam -m -d ${dm} -D template.fits

        echo "using pat on scrunched $i"
        pat -s template.fits -A PGS -f "tempo2" ${i%.*}.4sub.fits > ${i%.*}.tim

        echo "appending frequencies to $i.pat"
        awk '{print ($3, $2)}' ${i%.*}.tim > ${i%.*}.pat

        # Timing test, need to be aware of formatting of the input files
        cp ../${i%%_*}.par .
        echo "running tempo2"
        tempo2 -nofix -us -output general2 -f ${i%%_*}.par  ${i%.*}.tim -s "{bat} {post} {err}\n" > ${i%.*}.res
done

# Need to comapre .pat, .tim and .res here and generate the score

cd ..
# rm -r temp