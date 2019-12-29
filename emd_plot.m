function [] = emd_plot(data_set, error, max_iterations)
    close all

    [lines, columns] = size(data_set);
    time = (0:(columns-1));

    error = 0.001;
    max_iterations = 10;  

    [result, ds] = EMD(data_set, error, max_iterations);
    [lines, columns] = size(result);

    figure;
    subplot(lines, 1, 1);
    plot(time, data_set);
    title("original signal")
    for i = 1:lines
        if (i == lines)
            subplot(lines, 1, lines);
            plot(time, result(i,:));
            title("residue")
        elseif (i ~= lines - 1)
            subplot(lines, 1, i + 1);
            plot(time, result(i,:));
            title("component " + i)
        end
    end
    
    figure;
    plot(data_set);
    hold on;
    plot(sum(result));
    hold on;
    plot(data_set - sum(result));
    title('Comparison between the original data set and the sum of the components and residue')
    legend({'original', 'component sum', 'error'});
end

