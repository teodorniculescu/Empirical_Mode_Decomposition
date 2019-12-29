clear all
close all

N = 2000;
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

subplot(4, 1, 1);
plot(time, data_set_1, 'r');
hold on
plot(time, data_set_2, 'b');
hold on
plot(time, data_set, 'g');
title('Original data set')
xlabel('t_{seconds}')
ylabel('x(t)')
legend({'1st sine', '2nd sine', 'sum'});

lmin = islocalmin(data_set);
lmax = islocalmax(data_set);

% extinderi ale interpolarilor la inceput si final
lmin(1) = 1;
lmin(end) = 1;
lmax(1) = 1;
lmax(end) = 1;
% salvam interpolarile
local_min.time = time(lmin);
local_min.val = data_set(lmin);
local_max.time = time(lmax);
local_max.val = data_set(lmax);
% setam prima valoare cu val urmatoare si ultima valoare cu penultima
% valoare
local_min.val(1) = local_min.val(2);
local_min.val(end) = local_min.val(end-1);
local_max.val(1) = local_max.val(2);
local_max.val(end) = local_max.val(end-1);

subplot(4, 1, 2);
plot(time, data_set, 'g');
hold on
plot(local_min.time, local_min.val, 'b*');
hold on
plot(local_max.time, local_max.val, 'r*');
title('Data set and local minima and maxima')
xlabel('t_{seconds}')
ylabel('x(t)')
legend({'data set', 'local min', 'local max'});

min_spline = spline(local_min.time, local_min.val, time);
max_spline = spline(local_max.time, local_max.val, time);
middle_spline = (min_spline + max_spline) / 2;

subplot(4, 1, 3);
plot(time, data_set, 'g');
hold on
plot(time, min_spline, 'b');
hold on
plot(time, max_spline, 'r');
hold on
plot(time, middle_spline, 'p');
title('Data set and interpolation avg')
xlabel('t_{seconds}')
ylabel('x(t)')
legend({'data set', ' min interpolation', 'max interpolation', ' avg interpolation'});

new_data_set = data_set - middle_spline;
subplot(4, 1, 4);
plot(time, new_data_set, 'b');
title('Data set - avg interpolation = IMF')
xlabel('t_{seconds}')
ylabel('x(t)')
legend({'new data set'});

disp_medie = mean(new_data_set);
disp_minime = islocalmin(new_data_set);
disp_minime_print = length(disp_minime(disp_minime>0));
disp_maxime = islocalmax(new_data_set);
disp_maxime = length(disp_maxime(disp_maxime>0));

fprintf('average %i\n', disp_medie)
fprintf('number minima %i\n', disp_minime)
fprintf('number maxima %i\n', disp_maxime)
fprintf('the average must be as close as possible to 0 and the number of minima = number of maxima to fulfi the IMF criteria\n');

