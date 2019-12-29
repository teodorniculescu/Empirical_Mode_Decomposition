clear all
close all

N = 8000;
fs = 1000;
time = (0:(N-1)) * (1/fs);

amp1 = 1;
freq1 = 1;
phase1 = 0;
data_set_1 = mysine(amp1, freq1, time, phase1);
amp2 = 1;
freq2 = 4;
phase2 = 0;
data_set_2 = mysine(amp2, freq2, time, phase2);
data_set = data_set_1 + data_set_2;

error = 0.00001;
max_iterations = 1000;  

emd_plot(data_set, error, max_iterations);