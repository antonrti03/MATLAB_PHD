function [Ms, Mw, EN, ENr, SYe, SXe, SE, SG]=Extrema_MorphCplus2(img)
% Search of Extrema using morphological algorithms,
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
% Used functions: imregionalmax(), imregionalmin(), getlabel.m
%
if ndims(img)==3
    img = rgb2gray(img);
end
img = double(img);
BWmax=imregionalmax(img);
BWmax=double(BWmax);
BWmin=imregionalmin(img);
BWmin=(-1)*double(BWmin);
E=BWmax+BWmin;
[Ms, Mw, EC, EN, N, SYe, SXe, ENr, SE, SG]=getlabel(E, img);
%ENs=sum(EC);
end