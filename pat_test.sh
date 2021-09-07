for i in $@
do
    echo "Scrunching $i to 4 subbands"
    pam -e .4sub.fits  --setnchn 4 --setnbin 64 -T  ${i} # i is the input file

    echo "Running Pam test involving DMs"
    dm=$(grep -w "Best DM" DM.txt | awk '/Best DM/ {print $4}')
    pam -m -d ${dm} -D template.fits
    
    echo "using pat on scrunched $i"
    pat -s template.fits -A PGS -f "tempo2" ${i}.4sub.fits > ${i}.tim
    
    echo "appending frequencies to $i.pat"
    awk '{print ($3, $2)}' ${i}.tim > ${i}.pat

    # Doing the Timing
    
    echo "copying par file"
    cp /Data/bcj/INPTA/newparfilesinpta/${i%%_*}.par  ${i%%_*}.par
    
    echo "running tempo2"
    tempo2 -nofix -us -output general2 -f ${i%%_*}.par  ${i}.tim -s "{bat} {post} {err}\n" > ${i}.res
done

# Difference in frequencies
    # If 0 then pat test passed
# Compare the Res files 
    # If 0 then res test passed

# par and template file paths need to be inputs

## Steps mentioned in mail for last 2 tests :

# Made a template from data file and scrunched data file to
#      one subint and 4 subbands
#      pam -e .4sub.fits  --setnchn 4 --setnbin 64 -T   *rfiClean.fits
#      cp J1939+2134_59106.725493_500.rfiClean.4sub.fits template.fits
#      pam -m -d <pdmp.dm> -D template.fits
#      pat -s <psrname>.template -A PGS -f "tempo2"
#       *.rfiClean.4sub.fits > <psrname>.BAND3.V6.bmrn.tim
#      awk '{print ($3, $2)}' <psrname>.BAND3.V6.b0r0.tim >
#         <psrname>.BAND3.V6.b0r0.pat

#      <pdmp.dm> is DM got from summary file of PDMP for epoch
#      selected for template (59106 in this case)

# 6. Timing :
#      cp /Data/bcj/INPTA/newparfilesinpta/<psrname>.par <psrname>.par
#        in your directory and remove all fit flags
#      tempo2 -us -output general2 -f <psrname>.par  <psrname>.tim
#          -s "{bat} {post} {err}\n" > <psrname>.BAND3.V6.b0r0.res