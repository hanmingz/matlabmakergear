clear
clc

arduino=serial('COM5','BaudRate',115200); % create serial communication object on port COM4
arduino.Terminator = {10, 'CR/LF'}; %10 13
fopen(arduino); % initiate arduino communication
pause(5);

listen(arduino);
fprintf(arduino,'G28');
disp('home');

try
    file = input('file name: ', 's');
    fid = fopen(file);
catch error
    fclose(arduino);
    disp('error');
    disp('com closed due to error');
end

i = 5;
while i > 0
    tline = fgetl(fid);
    if (tline~= -1) & (strcmp(tline(1),';') == 0)
        disp(tline);
        fprintf(arduino, tline); 
        i = i - 1;
    end
end


echo = fscanf(arduino);

try
    while (tline ~= -1)
        cmd = '';
        gcodecmd();
        if strcmp(cmd, 'stop')
            disp('stop print');
            break;
        elseif strcmp(cmd, 'wait')
            global cmd;
            manual(arduino);
            echo = 'ok';
        end
        
        if strcmp(cellstr(echo), 'ok')
            tline = fgetl(fid);
            command = removecomment(tline);
            while strcmp(command, '')
                tline = fgetl(fid);
                command = removecomment(tline);
            end
            fprintf(arduino, command);
            disp(tline);
        end
        echo = listen(arduino);
    end
    
catch error
    fclose(fid);
    fclose(arduino); % end communication with arduino
    disp(error);
    disp('error cause com to close');
end

manual(arduino);

try
    pause(5);
    fclose(fid);
    fclose(arduino); % end communication with arduino
    disp('com closed');
catch
    disp('com already closed');
end