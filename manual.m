function [] = manual(arduino)
inmanual = 1;
while inmanual == 1
    disp('in manual')
    listen(arduino);
    cmd = input('input command: ', 's');
    if strcmp(cmd, 'wait')
        disp('wait')
        inmanual = 0;
    elseif ~isempty(cmd);
        fprintf(arduino, cmd);
        disp(cmd);
    end
    pause(0.1);
end
end