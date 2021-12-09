# Comparison-Script

### Pre-requisites before running the script on your server:

1. Install the following python libraries with the below commands:

```
python3.6 -m pip install --user --upgrade pip

python3.6 -m pip install --user scipy numpy lmfit statsmodels seaborn pandas importlib_metadata

```

2. Download the following files from the repository to your working directory before running the script
```
1. profilecomparision.py
2. dmdiff.py
3. test.py

```
3. Ensure fits files are present in the working directory

### **Syntax to run the combined script:**
```
bash combined_trial.sh <fits file 1> <fits file 2>
```
### **Our thoughts on the overall script:**
```
Having the overall script run as a python script could be a good approach for the following reasons :
1. Having smaller scripts that can be run independently would help us to modify/ test them easily. We can even run them individually using command line arguements then.
2. The task of providing parameters to generate res files would be easier. We can handle naming conventions easily using regex/ grep anyways.
3. File management becomes easier. The unittest library (example included in the test.py file)
4. Managing different server environments becomes easier. Can use the os.environ package to get the required variables. Can even make the script run on a temporary environment.
5. Already using python script to generate the plots (Done by Nikita). Can use the same script to generate the plots in the test.py file. 
6. The setup and teardown of temporary files becomes more streamlined and programmatic.

```
