function [Ms, Mw, EN, ENr, SYe, SXe, SE, SG, OPP]=Extrema_MorphMatlab(img)
% Search of Extrema using morphological reconstruction by dilation and erosion,
% which are built-in matlab functions written in C++.
% M-function's written by Tuan Nguyen, 21.06.2019
% I/O:
% Ms: segmented image of local extrema
% Mw: segmented image for SRG
% EC: count stack of extremal pixels
% EN: number of extema
% ENs: sum of extreme pixels
% SE: stack of number of local extrema
% SG: stack of extreme values
% SYe, SXe: stacks of coordinates of the first extreme pixels for Seeded Region Growing
% Memory Use (bytes): ~12*8*N+10*8*N=176*N, N-Number of pixels
%
% Used functions: imdilate(), imerode(), strel(), getlabel.m
%
if ndims(img)==3
    img = rgb2gray(img);
end
img = double(img);
[Y,X]=size(img);
% Original image is the mask
mask = img;
% ------->Finding local maxima: RMAX(f)=f-R[by dilate](f-1)<---------------
% Create a marker image
marker1 = img - 1; 
% Structuring element for the dilation: a 3x3 square implies 8-connectivity 
se = strel('square', 3); 
% Perform morphological reconstruction, i.e., geodesic dilation until stability
recon1 = marker1;
recon1_old = zeros(size(recon1), 'double');
num1 = 0; N=0;
while(sum(sum(recon1 - recon1_old)) ~= 0) %until to be stable values =1
   % Retain output of previous iteration
   recon1_old = recon1;%=1   
   % Perform dilation
   recon1 = imdilate(recon1, se);%=1
   bw1 = recon1 > mask;%=2
   recon1(bw1) = mask(bw1);%=2
   % Compute the number of loops
   num1 = num1 + 1; N=N+6;
end
RMAX = img -  recon1;
%---------->Finding local minima: RMIN(f)=R[by erode](f+1)-f<--------------
% Create a marker image
marker2 = img + 1;
% Structuring element for the dilation
% A 3x3 square implies 8-connectivity 
se = strel('square', 3);
% Perform morphological reconstruction
% i.e., geodesic erosion until stability
recon2 = marker2;
recon2_old = zeros(size(recon2), 'double');
num2 = 0;
while(sum(sum(recon2 - recon2_old)) ~= 0) %1
   %Retain output of previous iteration
   recon2_old = recon2;  
   %Perform erosion
   recon2 = imerode(recon2, se); 
   %Restrict the eroded values using the mask
   bw2 = recon2 < mask;
   recon2(bw2) = mask(bw2);
   num2 = num2 + 1; N=N+6;
end
RMIN =  (-1)*(recon2 - img);
E = RMAX+RMIN; 
[Ms, Mw, EC, EN, N1, SYe, SXe, ENr, SE, SG]=getlabel(E, img);
OPP = 9+N+N1/(Y*X);
%ENs=sum(EC);
end