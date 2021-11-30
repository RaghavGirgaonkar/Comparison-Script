import os
import sys
import subprocess
import unittest

class TestFirstFile(unittest.TestCase):

    def test_first_file(self):
        # Function to run the first .sh script 
        outputs = subprocess.run(["ls", "-l"], shell=True, check=True, capture_output= True) # Just example that we can have the individual commands here
        # Also supports an env parameter (os.environ type), which means we can create temporary local variables easily
        print(outputs.stdout) # returns a binary string here, can even check the stderr stream

        self.assertEqual("Alpha", "Alpha") 
        # Will compare outputs, just sample text input here
        # Can instead capture output from diff 
        # Can read using file operations and run regex if needed

    def test_second_file(self):
        self.assertEqual("Beta", "Not-Beta") # Failed test

    def test_third_file(self):
        self.assertEqual("Gamma", "Gamma") # Passed test

if __name__ == '__main__':
    unittest.main()