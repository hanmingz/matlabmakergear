clear
clc

arduino=serial('COM5','BaudRate',115200); % create serial communication object on port COM4
arduino.Terminator = {10, 'CR/LF'}; %10 13
fopen(arduino); % initiate arduino communication
pause(5);

listen(arduino);
fprintf(arduino,'G28');
disp('home');

file = input('file name: ', 's');

fid = fopen(file);
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
    printing = true;
    while (tline ~= -1)
        cmd = '';
        gcodecmd();
        if isempty(cmd)
            if strcmp(cellstr(echo), 'ok') && printing
                tline = fgetl(fid);
                command = removecomment(tline);
                while strcmp(command, '')
                    tline = fgetl(fid);
                    command = removecomment(tline);
                end
                fprintf(arduino, command);
                disp(tline);
                echo = listen(arduino);
            elseif ~printing
                disp('paused by user');
%           else
%             tline = fgetl(fid);
%             command = removecomment(tline);
%             while strcmp(command, '')
%                 tline = fgetl(fid);
%                 command = removecomment(tline);
%             end
%             fprintf(arduino, command);
%             echo = listen(arduino);
            end
        elseif strcmp(cmd, 'stop')
            disp('stop print');
            break;
        elseif strcmp(cmd, 'pause')
            printing = ~printing;
        elseif ~isempty(cmd)
            fprintf(arduino, cmd);
        end

        
    end
    
catch error
    fclose(fid);
    fclose(arduino); % end communication with arduino
    disp(error);
    disp('error cause com to close');
end

try
    pause(5);
    fclose(fid);
    fclose(arduino); % end communication with arduino
    disp('com closed');
catch
    disp('com already closed');
end
