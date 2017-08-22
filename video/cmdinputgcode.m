clear all
clc

arduino=serial('COM3','BaudRate',115200); % create serial communication object on port COM4
arduino.Terminator = {10, 'CR/LF'}; %10 13
fopen(arduino); % initiate arduino communication
pause(5);
count = 0;
while arduino.BytesAvailable > 0
    echo = fscanf(arduino);
    disp(echo);
    count = count + 1;
end
fprintf(arduino,'G28');
disp('home');
userinput = 'a';

while strcmp(userinput, 'close') == 0
    userinput = input('cmd:', 's'); %cmd to send in '', cmd for matlab just type
    fprintf(arduino, userinput); 
    
    while arduino.BytesAvailable > 0
        echo = fscanf(arduino);
        disp(echo);
        count = count + 1;
    end
end


pause(5);
fprintf(arduino, 'G01 Z200 F1700');
disp('lower bed');
pause(5);
fclose(arduino); % end communication with arduino
disp('com closed');