function [out_imf] = imf(data_set, time, allowed_error)

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

    min_spline = spline(local_min.time, local_min.val, time);
    max_spline = spline(local_max.time, local_max.val, time);
    middle_spline = (min_spline + max_spline) / 2;

    new_data_set = data_set - middle_spline;

    medie = mean(new_data_set);
    if (abs(medie) > allowed_error)
        out_imf = imf(new_data_set, time, allowed_error);
    else
        out_imf = new_data_set;
    end
end

