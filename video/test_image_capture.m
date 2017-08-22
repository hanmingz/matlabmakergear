%%%%%%%%%%%%%%%%%%%%%%%
%This script can be used to sample data from the camera.
%Files are output in the format 'IMG (integer).bmp.
%%%%%%%%%%%%%%%%%%%%%%%

obj = uEyeMexObj;
h = imagesc(obj.Grab);
i = 0;
while true
    w = waitforbuttonpress;
    if w == 0 
        h.CData = obj.Grab;
        f = h.CData;
        imshow(f)
        filename = sprintf('IMG %d.bmp', i);
        imwrite(f,filename);
        i = i+1;
        w = 1;
    end
end