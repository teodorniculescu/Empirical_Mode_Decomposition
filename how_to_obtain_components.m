N = 2000;
fs = 1000;
time = (0:(N-1)) * (1/fs);
allowed_error = 0.000001;

amp1 = 1;
freq1 = 1;
phase1 = 0;
data_set_1 = mysine(amp1, freq1, time, phase1);
amp2 = 1;
freq2 = 4;
phase2 = 0;
data_set_2 = mysine(amp2, freq2, time, phase2);
data_set = data_set_1 + data_set_2;

data_imf = imf(data_set, time, allowed_error);
prima_componenta = data_imf;
noul_data_set = data_set - data_imf;

subplot(4, 1, 1);
plot(time, data_set);
hold on;
plot(time, data_imf);
hold on;
plot(time, noul_data_set);
title('First imf with an error of 0.000001 (first signal component)')
xlabel('t_{seconds}')
ylabel('x(t)')
legend({'data set', 'imf (first component)', 'new data set = data_set - imf'});

data_set = noul_data_set;
data_imf = imf(noul_data_set, time, allowed_error);
a_doua_componenta = data_imf;
noul_data_set = data_set - data_imf;

subplot(4, 1, 2);
plot(time, data_set);
hold on;
plot(time, data_imf);
hold on;
plot(time, noul_data_set);
title('second component of the original signal - 1 Hz sine wave')
xlabel('t_{seconds}')
ylabel('x(t)')
legend({'data set', 'imf (second component)', 'new data set = data_set - imf'});


data_set = noul_data_set;
data_imf = imf(noul_data_set, time, 1);
reziduu = data_imf;
noul_data_set = data_set - data_imf;

subplot(4, 1, 3);
plot(time, data_set);
hold on;
plot(time, data_imf);
hold on;
plot(time, noul_data_set);
title('original signal residue (due to the accumulated errors, the resulted signal is noise which does not fulfil the IMF conditions)')
xlabel('t_{seconds}')
ylabel('x(t)')
legend({'data set', 'imf (residue)', 'new data set = data_set - imf'});

new_data_set = noul_data_set;
disp_medie = mean(new_data_set);
disp_minime = islocalmin(new_data_set);
disp_minime = length(disp_minime(disp_minime>0));
disp_maxime = islocalmax(new_data_set);
disp_maxime = length(disp_maxime(disp_maxime>0));
fprintf('average %i\n', disp_medie)
fprintf('number minima %i\n', disp_minime)
fprintf('number maxima %i\n', disp_maxime)
fprintf(' the last data set does not have minima and maxima which does not fulfil the IMF conditions\n ');

subplot(4, 1, 4);
plot(time, prima_componenta);
hold on;
plot(time, a_doua_componenta);
title('')
xlabel('t_{seconds}')
ylabel('x(t)')
legend({'first component', 'second component'});
