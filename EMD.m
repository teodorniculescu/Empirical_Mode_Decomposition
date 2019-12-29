function [output, ds] = EMD(data_set, error, max_iterations)
    stop = false;
    output = [];
    ds = [data_set];
    time = 0:(length(data_set) - 1);    
    iteration = 0;
    while (stop == false)
        data_imf = imf_iterations(data_set, time, error, max_iterations);
        iteration = iteration + 1;
        data_set = data_set - data_imf;
        ds = [ds; data_set];
        
        output = [output; data_imf];
        if (isResidue(data_set) == true)
            output = [output; data_set];
            stop = true;
        end 
        
    end
end

