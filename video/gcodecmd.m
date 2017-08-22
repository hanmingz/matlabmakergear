
%This runs a matlab gui that runs concurrently with the file
%classification_code.m
function varargout = gcodecmd(varargin)
% Begin initialization code - DO NOT EDIT

        global obj;
        
        h = obj.Grab;
        
        A = h;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %These parameters can be modified according to parameters.txt to
        %obtain optimized results
        A(:, 800:1600) = [];
        A(:,1:650) = [];
        
        A(900:1200,:) = [];
        A(1:600,:) = [];
        background = imopen(A,strel('square',200));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        I2 = A - background;
        I3 = imadjust(I2);
        global categoryClassifier;
        %Perform the actual classification
        [labelIdx, score] = predict(categoryClassifier, I3);
       
        
        resultOfClassification = categoryClassifier.Labels(labelIdx);
        global res;
        res = resultOfClassification;
        disp(resultOfClassification); 
        
        %checking code
        
        


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gcodecmd_OpeningFcn, ...
                   'gui_OutputFcn',  @gcodecmd_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gcodecmd is made visible.
function gcodecmd_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);

% UIWAIT makes gcodecmd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gcodecmd_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function gcodecmd_Callback(hObject, eventdata, handles)
     


assignin('base', 'cmd', cmd);
global cmd;

% --- Executes during object creation, after setting all properties.
function gcodecmd_CreateFcn(hObject, eventdata, handles)
disp('e')
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
