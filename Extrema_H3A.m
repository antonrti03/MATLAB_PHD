function [SM, Mw, EN, ENr, SYe, SXe, SE, SG, OPP]=Extrema_H3A(img)
% H3A verion 2, written by Tuan Nguyen, Tsviatkou, 2019
% SEGMENT SEARCH FOR LOCAL EXTREMUMS OF IMAGES BASED ON ANALYSIS OF
% BRIGHTHNESS OF ADJACENT HOMOGENNEOUS AREAS
% (H3A –Homogeneous Adjacent Aria Analysis)
%
% I/O
% SM: Label matrix of local extrema
% Mw: segmented image for SRG
% EM: label matrix of extrem regions
% ER: check matrix for RG
% SE: stack of number of local extrema
% SG: stack of extreme values
% SYe, SXe: stacks of coordinates of the first extreme pixels for Seeded Region Growing
% NS: label value
% EN: number of extrema
% ENr: number of extremal pixels
% OPP: Operations per Pixel
% Memory Use (bytes): ~112*N, N-Number of pixels
%
% Convert RGB to Grayscale image
if ndims(img)==3
    img = rgb2gray(img);
end
img=double(img);
%
[Y,X]=size(img);
%
N=0; EN=0; ENr=0; SN=0;
Len=Y*X;
SY=zeros(1,Len); SX=zeros(1,Len); %=8*2
SYr=zeros(1,Len); SXr=zeros(1,Len);%=8*2
SYe=zeros(1,Len); SXe=zeros(1,Len);%=8*2
SE=zeros(Len,2);%8*2
SM = zeros(Y,X);%8
EM=zeros(Y,X); %8
ER = zeros(Y,X);%8
Mw = zeros(Y,X);%8
y=0;
while y<Y
    x=0; N=N+3;
    while x<X
        N=N+3;
        if EM(y+1,x+1)==0 
            SN=SN+1;
            EM(y+1,x+1)=SN; ER(y+1,x+1)=SN; Emax=0; Emin=0; coun=1;
            ENr=ENr+1; SYr(ENr)=y+1; SXr(ENr)=x+1;
            SP=1; SY(SP)=y; SX(SP)=x; 
            N=N+13;
            while (SP>0)
                y1=SY(SP);
                x1=SX(SP);
                SP=SP-1;
                j=-1; N=N+5;
                while j<2
                    i=-1;
                    while i<2
                        if (j==0)&&(i==0)
                            N=N+1;
                        else
                            N=N+2;%!
                            if (y1+1+j>0)&&(x1+1+i>0)&&(y1+1+j<=Y)&&(x1+1+i<=X)&&ER(y1+1+j,x1+1+i)~=SN
                                ER(y1+1+j,x1+1+i)=SN; N=N+2;%!
                                if img(y1+1,x1+1)==img(y1+1+j,x1+1+i)&&EM(y1+1+j,x1+1+i)==0                         
                                    EM(y1+1+j,x1+1+i)=SN;
                                    SP=SP+1; coun=coun+1;
                                    SY(SP)=y1+j;
                                    SX(SP)=x1+i;
                                    ENr=ENr+1; SYr(ENr)=y1+1+j; SXr(ENr)=x1+1+i;
                                    N=N+9;
                                else
                                    N=N+1;
                                    if img(y1+1,x1+1)<img(y1+1+j,x1+1+i)
                                        Emin=1; N=N+2;
                                    else
                                        Emax=1; N=N+2;
                                    end
                                end
                            end
                        end
                        i=i+1; 
                    end
                    j=j+1; 
                end
            end
            %
            if (Emax==1)&&(Emin==1) %non-extremum
                ENr=ENr-coun; N=N+2;
            else
                EN=EN+1; SYe(EN)=y+1; SXe(EN)=x+1;
                NS=EN*(Emax-Emin); %(MAX -> Emax=1,Emin=0 -> NS>0; MIN -> Emax=0,Emin=1 -> NS<0)
                SE(EN,1)=coun; %SG(EN,1)=1;
                SE(EN,2)=img(y+1,x+1); %SG(EN,2)=img(y+1,x+1);
                Mw(SYe(EN),SXe(EN))=NS;%!!!
                for k=(ENr-coun+1):ENr
                    y1=SYr(k); x1=SXr(k);
                    SM(y1,x1)=NS;
                end
                N=N+8+coun*3;
            end
        end
        x=x+1;
    end
    y=y+1;
end
%Operations Per Pixel
OPP=N/(Y*X);
%
SE(EN+1:end,:)=[];
SG=round(SE); SG(:,1)=1;
end