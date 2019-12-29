function [output] = isResidue(data)
    output = false;
    disp_minime = islocalmin(data);
    disp_minime = length(disp_minime(disp_minime>0));
    disp_maxime = islocalmax(data);
    disp_maxime = length(disp_maxime(disp_maxime>0));
    
    l1 = abs(disp_maxime - disp_minime) > 1;
    l2 = disp_maxime <= 1;
    l3 = disp_minime <= 1;
    %fprintf('%i %i %i\n', l1, disp_maxime, disp_minime);
    if (l1 || l2 || l3)
        output = true;
    end
end

