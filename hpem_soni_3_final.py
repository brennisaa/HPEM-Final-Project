#########################################################################################################################
#This is my official sonification!

import pandas as pd
import numpy as np

#finds the file in your computer and turns it into a "data frame," makeing it interperatable for python.
filename = '/Users/isabellabrenner/Desktop/HPEM_VM_Sample_Data'
df = pd.read_csv(filename + '.csv')

#########################################################################################################################
import matplotlib.pyplot as plt
from scipy import interpolate

#creates functions for our x and y variables that can be called on later that will return the values in green from the csv file.
time = df['Time (h)'].values

py1 = df['Py 1'].values
py2 = df['Py 2'].values
py3 = df['Py 3'].values

suc1 = df['Suc 1'].values
suc2 = df['Suc 2'].values
suc3 = df['Suc 3'].values

fum1 = df['Fum 1'].values
fum2 = df['Fum 2'].values
fum3 = df['Fum 3'].values

tryp1 = df['Tryp 1'].values
tryp2 = df['Tryp 2'].values
tryp3 = df['Tryp 3'].values

#interpolates the data to create a contunous function; i.e., no pauses in the sound.  
py_i = interpolate.interp1d(time, py1, bounds_error=False, fill_value="extrapolate")
suc_i = interpolate.interp1d(time, suc1, bounds_error=False, fill_value="extrapolate")
fum_i = interpolate.interp1d(time, fum1, bounds_error=False, fill_value="extrapolate")
tryp_i = interpolate.interp1d(time, tryp1, bounds_error=False, fill_value="extrapolate")


#plots the data so that you can visualize it while tweaking the sonification.
#helps to ensure that the sonificaiton is an intuitable representation of your data.
plt.plot(time, py1, label='Pyruvate (Drums)')
plt.plot(time, suc1, label='Succinate (Oboe)')
plt.plot(time, fum1, label='Fumarate (Flute)')
plt.plot(time, tryp1, label='Tryptone (Organ)')
plt.legend()
plt.show()

#########################################################################################################################
#scale --> imports different musical scales.
#remap --> rescales the given value or values so that they fall within the given output range. 
from scamp import *
from scamp_extensions.pitch import Scale
from scamp_extensions.utilities import remap

#this creates a real time music session and deterimes the rate of the sound in beats per second.
#altering the rate value will change the spped at which the notes change. 
s = Session()
s.rate = 0.7

#instruments!
#the function (s.print_default_soundfont_presets()) shows you all the available instruments/sounds to choose from. 
inst1 = s.new_part("drum")
inst2 = s.new_part("oboe")
inst3 = s.new_part("flute")
inst4 = s.new_part("organ")


inst1_range = (43,62)
inst2_range = (60,89)
inst3_range = (60,96)
inst4_range = (55,110)

scale = Scale.chromatic(50,70)
volume_range= (0.2,0.4)
domain_start = (0)
domain_end=(20.5)

def play_function(func, domain_start, domain_end, inst, pitch_range, volume_range, scale, time_step=0.01, new_note_thresh=0.001):
    
    accumulation = new_note_thresh
    current_note = None
    
    for t in np.arange(domain_start, domain_end, time_step):
        value = float(func(t))
        if accumulation >= new_note_thresh:
            if current_note is not None:
                current_note.end()
            
            current_note = inst.start_note(
                scale.round(remap(value, *pitch_range, 0,1)),
                remap(value, *volume_range, 0,1))
            
            accumulation -= new_note_thresh    
        accumulation += value * time_step
        wait(time_step)
        
fork(play_function, args=(py_i, domain_start, domain_end, inst1, inst1_range, volume_range, scale), kwargs={"new_note_thresh":0.06})
fork(play_function, args=(suc_i, domain_start, domain_end, inst2, inst2_range, volume_range, scale))
fork(play_function, args=(fum_i, domain_start, domain_end, inst3, inst3_range, volume_range, scale))
fork(play_function, args=(tryp_i, domain_start, domain_end, inst4, inst4_range, volume_range, scale))
wait_for_children_to_finish()

