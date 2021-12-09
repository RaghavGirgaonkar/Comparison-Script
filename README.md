# Comparison-Script

### Pre-requisites

Run the following commands before running any script:

```
python3.6 -m pip install --user --upgrade pip

python3.6 -m pip install --user scipy numpy lmfit statsmodels seaborn pandas importlib_metadata

### **Download the following files from the repository to your working directory before running the script**
1. profilecomparision.py
2. dmdiff.py
3. test.py

```

### My thoughts on the overall script:
Having the overall script run as a python script could be a good approach for the following reasons :
    * Having smaller scripts that can be run independently would help us to modify/ test them easily. We can even run them individually using command line arguements then.
    * The task of providing parameters to generate res files would be easier. We can handle naming conventions easily using regex/ grep anyways.
    * File management becomes easier. The unittest library (example included in the test.py file)
    * Managing different server environments becomes easier. Can use the os.environ package to get the required variables. Can even make the script run on a temporary environment.
    * Already using python script to generate the plots (Done by Nikita). Can use the same script to generate the plots in the test.py file. 
    * The setup and teardown of temporary files becomes more streamlined and programmatic.
