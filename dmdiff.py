import numpy as np

arr = np.genfromtxt("DMs.txt")

dmdiff = arr[0,0] - arr[1,0]

errs = np.sqrt(arr[0,1]**2 + arr[1,1]**2)

print("DM Diff = ", dmdiff)
print("Errorbar = ", errs)