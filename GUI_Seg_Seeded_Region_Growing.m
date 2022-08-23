function varargout = GUI_Seg_Seeded_Region_Growing(varargin)
% GUI_SEG_SEEDED_REGION_GROWING MATLAB code for GUI_Seg_Seeded_Region_Growing.fig
%      GUI_SEG_SEEDED_REGION_GROWING, by itself, creates a new GUI_SEG_SEEDED_REGION_GROWING or raises the existing
%      singleton*.
%
%      H = GUI_SEG_SEEDED_REGION_GROWING returns the handle to a new GUI_SEG_SEEDED_REGION_GROWING or the handle to
%      the existing singleton*.
%
%      GUI_SEG_SEEDED_REGION_GROWING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SEG_SEEDED_REGION_GROWING.M with the given input arguments.
%
%      GUI_SEG_SEEDED_REGION_GROWING('Property','Value',...) creates a new GUI_SEG_SEEDED_REGION_GROWING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Seg_Seeded_Region_Growing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Seg_Seeded_Region_Growing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Seg_Seeded_Region_Growing

% Last Modified by GUIDE v2.5 21-Apr-2021 21:16:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Seg_Seeded_Region_Growing_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Seg_Seeded_Region_Growing_OutputFcn, ...
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


% --- Executes just before GUI_Seg_Seeded_Region_Growing is made visible.
function GUI_Seg_Seeded_Region_Growing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Seg_Seeded_Region_Growing (see VARARGIN)

% Choose default command line output for GUI_Seg_Seeded_Region_Growing
handles.output = hObject;
handles.id_load=0; 
handles.id_run=0; 
handles.id_run_seg=0;
handles.id_evaluation = 0;
handles.dispor=0;
handles.dispgr=0;
handles.disprgb=0;
handles.dispseg=0;
handles.dispsmi=0;
handles.disprgbseg=0;
handles.disphist=0;
handles.dispchange=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Seg_Seeded_Region_Growing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Seg_Seeded_Region_Growing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, path] = uigetfile({'*.bmp';'*.tif';'*.png';'*.dcm'; '*.jpg'; '*.jp2';'*.mat'; '*.*'}, 'Load Image File');
if filename==0
    % user pressed cancel
    return;
end
fullname = strcat(path, filename);
handles.name = filename;

set(handles.url, 'string', fullname); %Show name
handles.fullPath = [path filename];
handles.name = imread(handles.fullPath); 

info = imfinfo(handles.fullPath);
set(handles.size, 'String', sprintf('%d x %d', info.Width, info.Height)); %Show dimentions

%axes(handles.axes1)
%imshow(handles.name);
if handles.dispor == 1
figure, imshow(handles.name), title('Original image'), impixelinfo;
end

handles.id_load = 1;
guidata(hObject,handles)


% --- Executes on selection change in method.
function method_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method


% --- Executes during object creation, after setting all properties.
function method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice = questdlg('Would you like to close?', 'Choice menu', ...
    'yes', 'no', 'no');
switch choice
    case 'yes'
        close;
    case 'no'
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in find.
function find_Callback(hObject, eventdata, handles)
% hObject    handle to find (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global name
if (handles.id_load == 0)
    msgbox('No input image. Please select an image!');
else
handles.id_run = 1;
method = get(handles.method, 'value');
switch method
    case 1   % -> Algorithm H3A, Nguyen, 2019
            tic
            [Ms, Mw, EN, ENr, SYe, SXe, SE, SG, OPP]=Extrema_H3A(handles.name);
            tfind = toc;
            handles.Ms = Ms;
            handles.Mw = Mw;
            handles.EN = EN;
            handles.SYe = SYe;
            handles.SXe = SXe;
            handles.SE = SE;
            handles.SG = SG;
            handles.gray = handles.name;
            if ndims(handles.gray)==3
                handles.gray = rgb2gray(handles.gray);
            end
            handles.gray=double(handles.gray);
            % Covert into RGB segmented image
            Ms= abs(Ms);
            handles.rgb = label2rgb(Ms);
            % Show parameters
            set(handles.edit1, 'string', num2str(ENr));    % Number of extreme pixels
            set(handles.edit2, 'string', num2str(EN));     % Number of extrema
            set(handles.edit4, 'string', num2str(tfind));  % Execution time
            set(handles.edit5, 'string', num2str(OPP));    % Operations per Pixel
            set(handles.edit22, 'string', '112*N');        % Memory use
    case 2 % -> Algorithm BSA, Nguyen, 2019
            tic
            [Ms, Mw, EN, ENr, SYe, SXe, SE, SG, OPP]=Extrema_BSA(handles.name);
            tfind = toc;
            handles.Ms = Ms;
            handles.Mw = Mw;
            handles.EN = EN;
            handles.SYe = SYe;
            handles.SXe = SXe;
            handles.SE = SE;
            handles.SG = SG;
            handles.gray = handles.name;
            if ndims(handles.gray)==3
                handles.gray = rgb2gray(handles.gray);
            end
            handles.gray=double(handles.gray);
            % Covert into RGB segmented image
            Ms= abs(Ms);
            RGB1 = label2rgb(Ms); handles.rgb = RGB1;
            handles.rgb = label2rgb(Ms);
            % Show parameters
            set(handles.edit1, 'string', num2str(ENr));    % Number of extreme pixels
            set(handles.edit2, 'string', num2str(EN));     % Number of extrema
            set(handles.edit4, 'string', num2str(tfind));  % Execution time
            set(handles.edit5, 'string', num2str(OPP));    % Operations per Pixel
            set(handles.edit22, 'string', '128*N');        % Memory use
    case 3 % -> Morphological algorithms (C/C++): built-in functions, Soille, 1999
            tic
            [Ms, Mw, EN, ENr, SYe, SXe, SE, SG]=Extrema_MorphCplus2(handles.name);
            tfind = toc;
            handles.Ms = Ms;
            handles.Mw = Mw;
            handles.EN = EN;
            handles.SYe = SYe;
            handles.SXe = SXe;
            handles.SE = SE;
            handles.SG = SG;
            handles.gray = handles.name;
            if ndims(handles.gray)==3
                handles.gray = rgb2gray(handles.gray);
            end
            handles.gray=double(handles.gray);
            % Covert into RGB segmented image
            Ms= abs(Ms);
            handles.rgb = label2rgb(Ms);
            % Show parameters
            set(handles.edit1, 'string', num2str(ENr));    % Number of pixels
            set(handles.edit2, 'string', num2str(EN));     % Number of extrema
            set(handles.edit4, 'string', num2str(tfind));  % Execution time
            set(handles.edit5, 'string', 'Unknown');
            set(handles.edit22, 'string', '176*N');        % Memory use
    case 4 % -> Morphological algorithms (MATLAB), Soille, 1999
            tic
            [Ms, Mw, EN, ENr, SYe, SXe, SE, SG, OPP]=Extrema_MorphMatlab(handles.name);
            tfind = toc;
            handles.Ms = Ms;
            handles.Mw = Mw;
            handles.EN = EN;
            handles.SYe = SYe;
            handles.SXe = SXe;
            handles.SE = SE;
            handles.SG = SG;
            handles.gray = handles.name;
            if ndims(handles.gray)==3
                handles.gray = rgb2gray(handles.gray);
            end
            handles.gray=double(handles.gray);
            % Covert into RGB segmented image
            Ms= abs(Ms);
            handles.rgb = label2rgb(Ms);
            % Show parameters
            set(handles.edit1, 'string', num2str(ENr));    % Number of pixels
            set(handles.edit2, 'string', num2str(EN));     % Number of extrema
            set(handles.edit4, 'string', num2str(tfind));  % Execution time
            set(handles.edit5, 'string', num2str(OPP));    % Operations per Pixel
            set(handles.edit22, 'string', '176*N');        % Memory use
   case 5 % -> Straigh Forward, 1987
            tic
            [Ms, EN, SYe, SXe, SE, SG, OPP]=Extrema_Single_Straightforward(handles.name);
            tfind = toc;
            handles.Ms = Ms;
            handles.Mw = Ms;
            handles.EN = EN;
            handles.SYe = SYe;
            handles.SXe = SXe;
            handles.SE = SE;
            handles.SG = SG;
            handles.gray = handles.name;
            if ndims(handles.gray)==3
                handles.gray = rgb2gray(handles.gray);
            end
            handles.gray=double(handles.gray);
            % Covert into RGB segmented image
            Ms= abs(Ms);
            handles.rgb = label2rgb(Ms);
            % Show parameters
            set(handles.edit1, 'string', num2str(EN));    % Number of extreme pixels
            set(handles.edit2, 'string', num2str(EN));     % Number of extrema
            set(handles.edit4, 'string', num2str(tfind));  % Execution time
            set(handles.edit5, 'string', num2str(OPP));    % Operations per Pixel
            set(handles.edit22, 'string', '72*N');        % Memory use
    case 6  %-> Spiral Scan, Forstner, 1987
            tic
            [Ms, EN, SYe, SXe, SE, SG, OPP]=Extrema_Single_Forstner(handles.name);
            tfind = toc;
            handles.Ms = Ms;
            handles.Mw = Ms;
            handles.EN = EN;
            handles.SYe = SYe;
            handles.SXe = SXe;
            handles.SE = SE;
            handles.SG = SG;
            handles.gray = handles.name;
            if ndims(handles.gray)==3
                handles.gray = rgb2gray(handles.gray);
            end
            handles.gray=double(handles.gray);
            % Covert into RGB segmented image
            Ms= abs(Ms);
            handles.rgb = label2rgb(Ms);
            % Show parameters
            set(handles.edit1, 'string', num2str(EN));    % Number of extreme pixels
            set(handles.edit2, 'string', num2str(EN));     % Number of extrema
            set(handles.edit4, 'string', num2str(tfind));  % Execution time
            set(handles.edit5, 'string', num2str(OPP));    % Operations per Pixel
            set(handles.edit22, 'string', '72*N');        % Memory use
    case 7 %-> Scanline3x3, Tuan Pham, 2010
            tic
            [Ms, EN, SYe, SXe, SE, SG, OPP]=Extrema_Single_Scanline(handles.name);
            tfind = toc;
            handles.Ms = Ms;
            handles.Mw = Ms;
            handles.EN = EN;
            handles.SYe = SYe;
            handles.SXe = SXe;
            handles.SE = SE;
            handles.SG = SG;
            handles.gray = handles.name;
            if ndims(handles.gray)==3
                handles.gray = rgb2gray(handles.gray);
            end
            handles.gray=double(handles.gray);
            % Covert into RGB segmented image
            Ms= abs(Ms);
            handles.rgb = label2rgb(Ms);
            % Show parameters
            set(handles.edit1, 'string', num2str(EN));    % Number of extreme pixels
            set(handles.edit2, 'string', num2str(EN));     % Number of extrema
            set(handles.edit4, 'string', num2str(tfind));  % Execution time
            set(handles.edit5, 'string', num2str(OPP));    % Operations per Pixel
            set(handles.edit22, 'string', '72*N');        % Memory use
    case 8 %->Spiral Traverse, Tuan Pham, 2010
            tic
            [Ms, EN, SYe, SXe, SE, SG, OPP]=Extrema_Single_SpiralTraverse(handles.name);
            tfind = toc;
            handles.Ms = Ms;
            handles.Mw = Ms;
            handles.EN = EN;
            handles.SYe = SYe;
            handles.SXe = SXe;
            handles.SE = SE;
            handles.SG = SG;
            handles.gray = handles.name;
            if ndims(handles.gray)==3
                handles.gray = rgb2gray(handles.gray);
            end
            handles.gray=double(handles.gray);
            % Covert into RGB segmented image
            Ms= abs(Ms);
            handles.rgb = label2rgb(Ms);
            % Show parameters
            set(handles.edit1, 'string', num2str(EN));    % Number of extreme pixels
            set(handles.edit2, 'string', num2str(EN));     % Number of extrema
            set(handles.edit4, 'string', num2str(tfind));  % Execution time
            set(handles.edit5, 'string', num2str(OPP));    % Operations per Pixel
            set(handles.edit22, 'string', '72*N');        % Memory use

    case 9 % Symmetric scan, Nguyen, 2018
            tic
            [Ms, EN, SYe, SXe, SE, SG, OPP]=Extrema_Single_Symm_Scan(handles.name);
            tfind = toc;
            handles.Ms = Ms;
            handles.Mw = Ms;
            handles.EN = EN;
            handles.SYe = SYe;
            handles.SXe = SXe;
            handles.SE = SE;
            handles.SG = SG;
            handles.gray = handles.name;
            if ndims(handles.gray)==3
                handles.gray = rgb2gray(handles.gray);
            end
            handles.gray=double(handles.gray);
            % Covert into RGB segmented image
            Ms= abs(Ms);
            handles.rgb = label2rgb(Ms);
            % Show parameters
            set(handles.edit1, 'string', num2str(EN));    % Number of extreme pixels
            set(handles.edit2, 'string', num2str(EN));     % Number of extrema
            set(handles.edit4, 'string', num2str(tfind));  % Execution time
            set(handles.edit5, 'string', num2str(OPP));    % Operations per Pixel
            set(handles.edit22, 'string', '72*N');        % Memory use
end
end
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function url_CreateFcn(hObject, eventdata, handles)
% hObject    handle to url (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.id_load == 0)
    msgbox('No intput image. Please select an image!');
else %=1
    if (handles.id_run == 0) %1,0
        msgbox('No output image. Please run program!');
    else % 1,1
        [file, path]=uiputfile({'*.png'; '*.jpg'; '*.jp2'; '*.bmp'; '*.tif'}, 'Save segmented image as');
        if file==0
            % user pressed cancel
            return;
        end
        % go on with saving data ...
        imwrite(handles.rgb, [path file]);
        %filename = sprintf('Result_%s.png', handles.name);
        %imwrite(handles.rgb, filename);
    end
end


% --- Executes on button press in mat.
function mat_Callback(hObject, eventdata, handles)
% hObject    handle to mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.id_load == 0)
    msgbox('No intput image. Please select an image!');
else %=1
    if (handles.id_run == 0) %1,0
        msgbox('No output image. Please find extrema!');
    else % 1,1
        [file, path]=uiputfile('*.mat', 'Save segmented image as');
        if file==0
            % user pressed cancel
            return;
        end
        % go on with saving data ...
        Ms = handles.Ms;
        save([path file],'Ms');
    end
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.dispor = get(hObject, 'value');
guidata(hObject,handles)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.dispgr = get(hObject, 'value');
guidata(hObject,handles)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.dispseg = get(hObject, 'value');
guidata(hObject,handles)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.disprgb = get(hObject, 'value');
guidata(hObject,handles)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.id_run==0
    msgbox('Please find extrema!')
else
% Show segmented image
    if handles.dispor==1
        figure, imshow(handles.name), title('Original image'), impixelinfo;
    end
    if handles.dispgr==1
        figure, imshow(handles.gray, []), title('Grayscale image'), impixelinfo;
    end
    if handles.dispseg==1
        figure, imshow(handles.Ms, []), title('Segmented extreme image'), impixelinfo;
    end
    if handles.disprgb==1
        figure, imshow(handles.rgb, []), title('RGB extreme image'), impixelinfo;
    end
    if handles.disphist==1
        % Histogram of extreme segemnts
        h = histogram(handles.SE(:,1));
        counts = h.Values;
        counts = log10(counts+1);
        x = 1:length(counts);
        figure, bar(x,counts);
        xlabel('Extreme size')
        ylabel('Log10(extreme number)')
        grid on
    end
    if handles.id_run_seg==0
        msgbox('Please run segmentation!')
    else
        if handles.dispsmi==1
            figure, imshow(handles.SMI, []), title('Segmented image'), impixelinfo;
        end
        if handles.disprgbseg==1
            figure, imshow(handles.rgbseg, []), title('Segmented image in RGB'), impixelinfo;
        end
        if handles.dispchange==1
            x1 = 1:handles.loop;
            figure, plot(x1,handles.AA);
            %plot(x1,log10(handles.AA+1));
            %title('Зависимость среднего значения яркости от числа итераций')
            xlabel('Number of iterations')
            %ylabel('Log10(NL)') %NH
            ylabel('Average intensity value')
            grid on
        end
    end
end
%guidata(hObject, handles);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%close;
%run Compression_cwrg.m;


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.id_load == 0)
    msgbox('Please select an image!');
else %=1
    if (handles.id_run == 0) %1,0
        msgbox('Please find extrema!');
    else % 1,1
        if (handles.id_run_seg == 0) %1,0
            msgbox('Please run segmentation!');
        else
            [file, path]=uiputfile('*.mat', 'Save segmented image as');
            if file==0
                % user pressed cancel
                return;
            end
            % go on with saving data ...
            SMI = handles.SMI;
            save([path file],'SMI');
        end
    end
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.id_load == 0)
    msgbox('Please select an image!');
else %=1
    if (handles.id_run == 0) %1,0
        msgbox('Please find extrema!');
    else % 1,1
        if (handles.id_run_seg == 0) %1,0
            msgbox('Please run segmentation!');
        else
            [file, path]=uiputfile({'*.png'; '*.jpg'; '*.jp2'; '*.bmp'; '*.tif'}, 'Save segmented image as');
            if file==0
            % user pressed cancel
                return;
            end
            % go on with saving data ...
            imwrite(handles.rgbseg, [path file]);
            %filename = sprintf('Result_%s.png', handles.name);
            %imwrite(handles.rgb, filename);
        end
    end
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in method2.
function method2_Callback(hObject, eventdata, handles)
% hObject    handle to method2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns method2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method2


% --- Executes during object creation, after setting all properties.
function method2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.id_run == 0)
    msgbox('No input data. Please find extrema!');
else
handles.id_evaluation = 1;
handles.id_run_seg = 1;
method2 = get(handles.method2, 'value');
switch method2
    case 1   % CLERG, Nguyen, 2020
            tic
            [SMI, loop, SA, sig0, AA] = SRG_Nguyen2020_CLERG(handles.Mw, handles.SYe, handles.SXe, handles.SG, handles.EN, handles.name);
            tseg = toc;
            handles.SMI = SMI;
            handles.loop = loop;
            handles.SA = SA;
            handles.sig0 = sig0;
            handles.AA = AA;
            % Covert into RGB segmented image
            SMI= abs(SMI);
            handles.rgbseg = label2rgb(SMI);
            %
            set(handles.edit16, 'string', num2str(tseg));
            set(handles.edit21, 'string', num2str(loop));
    case 2 % CLERG FULL, Nguyen, 2021
            tic
            [SMI, loop, SA, sig0, AA] = SRG_Nguyen2020_CLERG_full(handles.Mw, handles.SYe, handles.SXe, handles.SG, handles.EN, handles.name);
            tseg = toc;
            handles.SMI = SMI;
            handles.loop = loop;
            handles.SA = SA;
            handles.sig0 = sig0;
            handles.AA = AA;
            % Covert into RGB segmented image
            SMI= abs(SMI);
            handles.rgbseg = label2rgb(SMI);
            %
            set(handles.edit16, 'string', num2str(tseg));
            set(handles.edit21, 'string', num2str(loop));
    case 3 % Original SRG (Adams, 1994)
            tic
            [SMI, loop, SA, sig0, AA] = SRG_Adams1994_full_quasi(handles.Mw, handles.SYe, handles.SXe, handles.SG, handles.EN, handles.name);
            tseg = toc;
            handles.SMI = SMI;
            handles.loop = loop;
            handles.SA = SA;
            handles.sig0 = sig0;
            handles.AA = AA;
            % Covert into RGB segmented image
            SMI= abs(SMI);
            handles.rgbseg = label2rgb(SMI);
            %
            set(handles.edit16, 'string', num2str(tseg));
            set(handles.edit21, 'string', num2str(loop));
    case 4 % Stabilized SRG (Fan, 2015)
            L=1;
            tic
            [SMI, loop, SA, sig0, AA] = SRG_Fan2015_Stabilized(handles.Mw, handles.SYe, handles.SXe, handles.SG, handles.EN, handles.name, L);
            tseg = toc;
            handles.SMI = SMI;
            handles.loop = loop;
            handles.SA = SA;
            handles.sig0 = sig0;
            handles.AA = AA;
            % Covert into RGB segmented image
            SMI= abs(SMI);
            handles.rgbseg = label2rgb(SMI);
            %
            set(handles.edit16, 'string', num2str(tseg));
            set(handles.edit21, 'string', num2str(loop));
    case 5 % Regular SRG (Fan, 2005)
            tic
            [SMI, loop, SA, sig0, AA] = SRG_Fan2005_regular(handles.Mw, handles.SYe, handles.SXe, handles.SG, handles.EN, handles.name);
            tseg = toc;
            handles.SMI = SMI;
            handles.loop = loop;
            handles.SA = SA;
            handles.sig0 = sig0;
            handles.AA = AA;
            % Covert into RGB segmented image
            SMI= abs(SMI);
            handles.rgbseg = label2rgb(SMI);
            %
            set(handles.edit16, 'string', num2str(tseg));
            set(handles.edit21, 'string', num2str(loop));
    case 6 % Level set based SRG (Pirikli, 2004)
        tic
            methd='non-Eulerian';
            [SMI, loop, SA, sig0, AA] = SRG_2004_Level_Set(handles.Mw, handles.SYe, handles.SXe, handles.SG, handles.EN, handles.name, methd);
            tseg = toc;
            handles.SMI = SMI;
            handles.loop = loop;
            handles.SA = SA;
            handles.sig0 = sig0;
            handles.AA = AA;
            % Covert into RGB segmented image
            SMI= abs(SMI);
            handles.rgbseg = label2rgb(SMI);
            %
            set(handles.edit16, 'string', num2str(tseg));
            set(handles.edit21, 'string', num2str(loop));
end
end
guidata(hObject,handles)


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.dispsmi = get(hObject, 'value');
guidata(hObject,handles)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.disprgbseg = get(hObject, 'value');
guidata(hObject,handles)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.disphist = get(hObject, 'value');
guidata(hObject,handles)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.dispchange = get(hObject, 'value');
guidata(hObject,handles)

% Hint: get(hObject,'Value') returns toggle state of checkbox



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.id_evaluation == 0)
    msgbox('No input data. Please run segmentation!');
else
            % Evaluation functions
            tic
            [Sd, Serr, SIG2] = EvaluationDm_new(handles.gray, handles.SMI, handles.Ms, handles.SG, handles.SA);
            [F, SIG2] = EvaluationF(handles.gray, handles.SMI, handles.SA, handles.EN);
            [D, SIG2] = EvaluationD(handles.gray, handles.SMI, handles.SA, handles.EN);
            [ssim, A] = EvaluationSSIM(handles.gray, handles.SMI, handles.SA);
            toc
            % Show parameters
            set(handles.edit15, 'string', num2str(Sd));
            set(handles.edit20, 'string', num2str(Serr));
            set(handles.edit17, 'string', num2str(F));       
            set(handles.edit18, 'string', num2str(D));
            set(handles.edit19, 'string', num2str(ssim));
end
guidata(hObject,handles)



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
