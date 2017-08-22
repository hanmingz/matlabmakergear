function [echo] = listen(arduino)
    if arduino.BytesAvailable > 0
        while arduino.BytesAvailable > 0
            echo = fscanf(arduino);
            disp(echo);
        end
    else
        echo = '';
    end
end