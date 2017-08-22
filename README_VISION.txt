CAMERA USAGE README - 

To use the uEye Camera with Matlab please follow these instructions:

1. Ensure you have the files uEyeEnum.m, uEyeMex.cpp, uEyeMex.h, uEyeMexObj.m 
in Matlab's compilation folder(basically wherever you have a script that requires the use of the camera.

2.Through Matlabs store only, install a C/C++ Compiler(MinGW) and Mex(Matrix library).

3. Install the uEye Camera Drivers

4. From the matlab command line run the following:
	mex uEyeMex.cpp '-IC:\Program Files\IDS\uEye\Develop\include' '-LC:\Program Files\IDS\uEye\Develop\Lib' -luEye_api_64

5. This will create a file named uEyeMex.mexw64 in the folder - if this is created, you can use the camera with the following code:
Instantiate with your_obj_name = uEyeMexObj;
Grab Images with a_matrix_variable = your_obj_name.Grab;