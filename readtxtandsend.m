clear all
clc

arduino=serial('COM5','BaudRate',115200); % create serial communication object on port COM4
arduino.Terminator = {10, 'CR/LF'}; %10 13
fopen(arduino); % initiate arduino communication
pause(5);

listen(arduino);
fprintf(arduino,'G28');
disp('home');

fid = fopen('washer2.txt');
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

while (tline ~= -1)
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

pause(5);
fprintf(arduino, 'G01 Z210 F1700');
disp('lower bed');
pause(5);
fclose(fid);
fclose(arduino); % end communication with arduino
disp('com closed');
