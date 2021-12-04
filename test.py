import os
import sys
import subprocess
import unittest

def pulsar_name(filename):
    return filename.split('_')[0]

def pulsar_MJD(filename):
    suffix = filename.split('_')[1]
    return suffix.split('.')[0]

def get_column_from_csv(filename, col):
    with open(filename, 'r') as f:
        return [float(line.split(' ')[col]) for line in f.readlines()]

def server_name():
    return os.uname()[1].split(".")[0]

config = {"tapti":{
    "pardir" : "/Data/mpsurnis/InPTA_parfiles",
    "src_pulsar" : "/Data/bcj/INPTA/soft/Pulsar/pulsarbashrc.sh",
    "src_pinta" : "/home/asusobhanan/Work/V6/pinta.bashrc"
}}

# Can instead capture output from diff 
# Can read using file operations and run regex if needed

class TestScript(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.files = sys.argv[1:]
        print("Running Pam. Files Listed : ")
        for file in cls.files:
            print("Filename : {}, Pulsar Name : {}, MJD : {}".format(file, pulsar_name(file), pulsar_MJD(file)))
            # Preprocessing step. 
            subprocess.run(["pam", "-e", ".4sub.fits", "--setnchn", "4", "--setnbin", "64", "-T", file], check=True)

    def test_compare_1pam(self):
        print("Running Pam Process")
        dms = get_column_from_csv('DMs.txt', 0) # Get DMS from Column 0 in DMs.txt
        status = True
        for dm in dms:
            output = subprocess.run(["pam", "-m", "-d", "{}".format(dm), "-D","template.fits"], check=True)
            status = status and output.returncode == 0
            if(output.returncode != 0):
                print(output)
        self.assertEqual(status, True) # Test passed if we were able to run pam

    def test_compare_2pat(self):
        comp = []
        for file in self.files:
            print("Using pat on scrunched {}".format(file))
            output = subprocess.run(["pat", "-s", "template.fits", "-A", "PGS", "-f", "tempo2", "{}.4sub.fits".format(file), ">", "{}.tim".format(file)], check=True)
            output = subprocess.run(["awk", '{print ($3, $2)}', "{}.tim".format(file), ">", "{}.pat".format(file)])
            if(output.returncode != 0):
                print(output)
            comp.append(get_column_from_csv("{}.pat".format(file), 1)[0]) # getting 1st column , 0th row
        
        status, value = True, comp[0]
        for value in comp:
            status = status and int(value) == int(comp[0])
        self.assertEqual(status, True) # Test passed if all values are equal

    def test_compare_3res(self):
        status = True
        for file in self.files:
            print("copying {}.par file".format(file))
            output = subprocess.run(["cp", "{}/{}.par".format(config[server_name()]["pardir"], pulsar_name(file)), "{}.par".format(pulsar_name(file))], check=True)
            print("Running tempo2 on {}".format(file))
            output = subprocess.run(["tempo2", "-nofix", "-us", "-output", "general2", "-f","{}.par".format(pulsar_name(file)), "{}.tim".format(file), "-s", '\"{bat} {post} {err}\n\"', ">","{}.res".format(file)], check=True)
            status = status and output.returncode == 0
        self.assertEqual(status, True) # Test passed if tempo2 ran successfully

if __name__ == '__main__':
    #subprocess.run(["source",config[server]["src_pulsar"]], check=True)
    #subprocess.run(["source",config[server]["src_pinta"]], check=True)
    print("Running Tests")
    unittest.main(argv=[""]) # FIrst should get ignored ?