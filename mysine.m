function [output] = mysine(amp, freq, time, phase)
    output = amp * sin(2 * pi * freq * time + phase);
end

