%Instantiate arduino connection and camera
clear
clc
global obj;
obj = uEyeMexObj;
load exModelv2.mat;
global categoryClassifier;
state = 'unmodified';
arduino=serial('COM6','BaudRate',115200); % create serial communication object on port COM4
arduino.Terminator = {10, 'CR/LF'}; %10 13
fopen(arduino); % initiate arduino communication
pause(5);

global res;
res = 'unassigned';
listen(arduino);
fprintf(arduino,'G28');
disp('home');
%Default, input a text containing gcode
%I provided hexa.txt and washer2.txt as test files
try
    file = input('file name: ', 's');
    fid = fopen(file);
catch error
    fclose(arduino);
    disp('error');
    disp('com closed due to error');
end
%send 5 lines to the printer
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
%Communication happens at 5 cmds per second
try
    while (tline ~= -1)
        cmd = '';
        
        gcodecmd(); 
        %GUI modifies a shared variable res, and based on whether res
        %has a certain value, the command is modified appropriately.
        %if you want the stop command to be sent when an action is taken,
        %set cmd = 'stop'
        %The printer stops and then waits for the manual input of the
        %'wait' command to close the connection
        if(strcmp(res, 'NotExtruding') == 1)
          cmd = '';
        elseif(strcmp(res,'Extruding') == 1)
          cmd = 'stop';
        else
           cmd = ''
        end
        
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