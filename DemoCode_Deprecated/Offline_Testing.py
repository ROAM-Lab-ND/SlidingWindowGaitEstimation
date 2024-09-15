import yaml
from scipy import signal
import time
import matplotlib.pyplot as plt
import csv

class kernalClass():

    '''
    Class used for storing data pertaining to kernals from yaml files
    Inputs:
        None

    Structure:
        percent - Lists
        RThigh - 
        LThigh - 
        RShank - 
        LShank - 
    '''

    def __init__(self):

        self.percent = None 
        self.RThigh = None 
        self.LThigh = None 
        self.RShank = None 
        self.LShank = None

def yaml_2_kernal(fileName):
    File = open(fileName)
    # Load Data From File and Close
    tempKernalDict = yaml.load(File, Loader = yaml.Loader)
    File.close()
    Kernal = kernalClass()
    Kernal.percent, Kernal.RThigh, Kernal.LThigh, Kernal.RShank, Kernal.LShank = tempKernalDict['percent'], tempKernalDict['RThigh'], tempKernalDict['LThigh'], tempKernalDict['RShank'], tempKernalDict['LShank']
    return Kernal

def double_kernal(singleKernal):
    doubleKernal = kernalClass()
    doubleKernal.percent = singleKernal.percent*2
    doubleKernal.RThigh = singleKernal.RThigh*2
    doubleKernal.LThigh = singleKernal.LThigh*2 
    doubleKernal.RShank = singleKernal.RShank*2 
    doubleKernal.LShank = singleKernal.LShank*2
    return doubleKernal

def flip_kernal(inputKernal):
    outputKernal = kernalClass()
    outputKernal.percent = inputKernal.percent[::-1]
    outputKernal.RThigh = inputKernal.RThigh[::-1]
    outputKernal.LThigh = inputKernal.LThigh[::-1]
    outputKernal.RShank = inputKernal.RShank[::-1]
    outputKernal.LShank = inputKernal.LShank[::-1]
    return outputKernal

def select_data_window(inputData, window_size, current_index):
    # This will likely only be needed for offline post analysis
    outputWindow = dataWindow()
    # idxWindow = (randomIndex+1 - len(slowKernalSingle.percent)):randomIndex+1
    outputWindow.time   = inputData.time[4500:5000] #[(current_index+1 - window_size):current_index+1]
    # print(outputWindow.time)
    outputWindow.RThigh = inputData.RThigh[(current_index+1 - window_size):current_index+1]
    outputWindow.LThigh = inputData.LThigh[(current_index+1 - window_size):current_index+1]
    outputWindow.RShank = inputData.RShank[(current_index+1 - window_size):current_index+1]
    outputWindow.LShank = inputData.LShank[(current_index+1 - window_size):current_index+1]
    return outputWindow

def write_list_to_csv(data, filename):
    """
    Writes the elements of a one-dimensional list to a single row in a specified CSV file.

    Parameters:
    data (list): The one-dimensional list to be written to the CSV file.
    filename (str): The name of the CSV file.

    Returns:
    None
    """
    with open(filename, mode='wb') as file:
        writer = csv.writer(file)
        writer.writerow(data)  # Use writerow instead of writerows

    print("Data has been written to {}".format(filename))

class dataWindow():
    '''
    Class used for storing data pertaining to kernals from yaml files
    Inputs:
        None

    Structure:
        percent - Lists
        RThigh - 
        LThigh - 
        RShank - 
        LShank - 
    '''

    def __init__(self):

        self.time = None 
        self.RThigh = None 
        self.LThigh = None 
        self.RShank = None 
        self.LShank = None


class incomingDataClass():

    '''
    Class used for storing data pertaining to kernals from yaml files
    Inputs:
        None

    Structure:
        time - Lists
        RThigh - 
        LThigh - 
        RShank - 
        LShank - 
    '''

    def __init__(self, fileName):

        File = open(fileName)
        # Load Data From File and Close
        tempKernalDict = yaml.load(File, Loader = yaml.Loader)
        File.close()
        self.time, self.RThigh, self.LThigh, self.RShank, self.LShank = tempKernalDict['time'], tempKernalDict['RThigh'], tempKernalDict['LThigh'], tempKernalDict['RShank'], tempKernalDict['LShank']



# def apply_conv(data, kernal, comparison='convolution'):
#     if comparison == 'convolution':
#         conv = signal.fftconvolve(data, kernal, mode = 'full')
#     else:
#         print("Ahh ahh ahh")
#         conv = 0
#     return conv


slowKernalSingle = yaml_2_kernal('Slow_RP_Reference.yaml')
medKernalSingle = yaml_2_kernal('Med_RP_Reference.yaml')
fastKernalSingle = yaml_2_kernal('Fast_RP_Reference.yaml')

# incomingData = [5] * 14000
incomingData = incomingDataClass('SpeedChangesTest.yaml')

write_list_to_csv(slowKernalSingle.RShank, 'slowTemplateRShank.csv')
write_list_to_csv(incomingData.RShank, 'slowDataRShank.csv')

print(incomingData.RShank)
randomIndex = 4500 # Representative of the current incoming data point

# idxWindowSlow = list(range(randomIndex+1 - len(slowKernalSingle.percent),randomIndex+1,1))
# a[idx]

# slow_Window = incomingData[idxWindowSlow]
slow_Window = select_data_window(incomingData, len(slowKernalSingle.percent), randomIndex)

# print((idxWindowSlow))

slowKernalDouble = double_kernal(slowKernalSingle)
slowKernal = flip_kernal(slowKernalDouble)

print(type(slow_Window.RShank))

# tester = slowKernalDouble.percent.reversed()

# print((slowKernal.RShank))


# print(slow_Window.RShank)

# print(slowKernalDouble.RShank)

# t0 = time.time()
# RShank_conv = signal.fftconvolve(slow_Window.RShank, slowKernal.RShank)
# t1 = time.time()
# 
# print(((RShank_conv/200000).tolist()))
# print((RShank_conv.max()))
# print((RShank_conv.argmax()))
# print(len(RShank_conv))
# perc = (((RShank_conv.argmax()))/(len(RShank_conv)))
# print(((RShank_conv.argmax()))/(len(RShank_conv)))
# 
# plt.plot(slow_Window.RShank, linewidth=2.5)
# plt.plot(slowKernalDouble.RShank, linewidth=2.5)
# plt.plot(((RShank_conv/20000).tolist()), linewidth=2.5)
# plt.plot(slowKernalDouble.RShank[round((perc)*len(slowKernalDouble.RShank)):len(slowKernalDouble.RShank)], linewidth=2.5)
# plt.show()


# plt.plot(slowKernal.RShank, linewidth=2.5)
# plt.plot(slowKernalDouble.RShank, linewidth=2.5)
# plt.show()
