function [command] = removecomment(tline)
    lngth = length(tline);
    command = '';
    for i = 1:lngth
        if (strcmp(tline(i),';') == 0)
            command = [command, tline(i)];
        elseif (strcmp(tline(i), 32) == 1)
            command = [command, ' '];
        else
            break;
        end
    end
end