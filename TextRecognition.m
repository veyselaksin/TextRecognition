function varargout = TextRecognition(varargin)
% TEXTRECOGNITION MATLAB code for TextRecognition.fig
%      TEXTRECOGNITION, by itself, creates a new TEXTRECOGNITION or raises the existing
%      singleton*.
%
%      H = TEXTRECOGNITION returns the handle to a new TEXTRECOGNITION or the handle to
%      the existing singleton*.
%
%      TEXTRECOGNITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEXTRECOGNITION.M with the given input arguments.
%
%      TEXTRECOGNITION('Property','Value',...) creates a new TEXTRECOGNITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TextRecognition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TextRecognition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TextRecognition

% Last Modified by GUIDE v2.5 16-May-2021 16:52:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TextRecognition_OpeningFcn, ...
                   'gui_OutputFcn',  @TextRecognition_OutputFcn, ...
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


% --- Executes just before TextRecognition is made visible.
function TextRecognition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TextRecognition (see VARARGIN)

% Choose default command line output for TextRecognition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TextRecognition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TextRecognition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selectImageButton.
function selectImageButton_Callback(hObject, eventdata, handles)
% hObject    handle to selectImageButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image
[file, filePath]=uigetfile({'*.png; *.jpeg; *.tif; *.bmp; *.jpg'}, 'Choose a image');
file=[filePath,file]; % getting image path
image=imread(file); % get image
axes(handles.selectedImage);
imshow(image);



% --- Executes on button press in pushbutton2.texsexexxefds
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in clearButton.
function clearButton_Callback(hObject, eventdata, handles)
% hObject    handle to clearButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.selectedImage,'reset');
cla(handles.languages,'reset');



% --- Executes on selection change in languages.
function languages_Callback(hObject, eventdata, handles)
% hObject    handle to languages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns languages contents as cell array
%        contents{get(hObject,'Value')} returns selected item from languages
contents=cellstr(get(hObject,'String'))
pop_choice=contents(get(hObject,'Value'));
global lang
if(strcmp(pop_choice,'English'))
    lang='English'
elseif(strcmp(pop_choice,'Turkish'))
    lang='Turkish'
elseif(strcmp(pop_choice,'French'))
    lang='French'
elseif(strcmp(pop_choice,'Italian'))
    lang='Italian'
elseif(strcmp(pop_choice,'Spanish'))
    lang='Spanish'
end

% --- Executes during object creation, after setting all properties.
function languages_CreateFcn(hObject, eventdata, handles)
% hObject    handle to languages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in processButton.
function processButton_Callback(hObject, eventdata, handles)
% hObject    handle to processButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 global image % I created a global variable for usign in another function
 global lang  % same with global image reason
 selectedImage= image;
 
 %% Gray Image
 selectedImage=rgb2gray(selectedImage);
 axes(handles.grayImage);
 imshow(selectedImage);
 %% Gausian noise filter
 selectedImage=imnoise(selectedImage,'gaussian');
 axes(handles.grayImage);
 imshow(selectedImage);
 %% Median filter
 selectedImage=medfilt2(selectedImage);
  %% Plot histogram and histogram Image
  selectedImageH=imadjust(selectedImage, [0.1, 0.3], [0.3, 0.6]);
  axes(handles.histogramImage);
  imshow(selectedImageH);
  axes(handles.histogramShow);
  imhist(selectedImageH);

 %% Black and White Image
 treshold=graythresh(selectedImage);
 selectedImage=imbinarize(selectedImage,treshold);
 selectedImageReverse=~selectedImage;
 axes(handles.bwImage);
 imshow(selectedImageReverse);
 %% Recognize text from bw Image
 ocrResults= ocr(selectedImageReverse,'Language',lang);
 recognizedText = ocrResults.Text;
 set(handles.recognizeText,'String', recognizedText);
 
 %% Print Informations
  set(handles.selectedLang, 'String', lang);
  set(handles.tresholdValue, 'String', treshold);
  set(handles.usedNoise, 'String', 'Gaussian Filter');


function recognizeText_Callback(hObject, eventdata, handles)
% hObject    handle to recognizeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recognizeText as text
%        str2double(get(hObject,'String')) returns contents of recognizeText as a double


% --- Executes during object creation, after setting all properties.
function recognizeText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recognizeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
