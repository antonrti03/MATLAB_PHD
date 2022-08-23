function [SM, EN, SYr, SXr, SE, SG, OPP]=Extrema_Single_Forstner(img)
% Created by Anton and Tsvetkov, BSUIR, 2019: Forstner [10]
% using Spiral scan order 3x3-neighbors.
%
% img: input graysacle or RGB image
% SE: stack of number of local extrema
% SG: stack of extreme values
% BH: check matrix of maxima
% BL: check matrix of minima
% OPP: Number of comparisons per pixel
% SM: Label matrix of local extrema
% EN: number of extrema
% SYr, SXr: coordinates, seed values of first pixels of extrema.
% Memory Use (bytes): ~72*N, N-Number of pixels
%
% Tuan Q. Pham. Non-maximum Suppression Using fewer than 2 Comparisons per Pixel. Advanced Concepts for Intelligent Vision
% Systems (ACIVS) 12, Sydney, Australia, December 13-16 (2010), pp. 438–451.
%
% Convert RGB to Grayscale image
if ndims(img)==3
    img = rgb2gray(img);
end
% Input paramaters
img = double(img);
[Y, X] = size(img);
SE=zeros(Y*X,2);
SYr=zeros(1,Y*X); SXr=zeros(1,Y*X); ENr=0;
BH = ones(Y,X);  % Local Maxima Matrix
BL = ones(Y,X);  % Local Minima Matrix
SM = zeros(Y,X); % Label matrix for RG
N=0;
EN=0;
y=2; 
while y<Y
    x=2;
    while x<X
        N=N+11;
        % Scanning Mask: [8 1 2; 7 0 3; 6 5 4]
        S8=img(y-1,x-1); S1=img(y-1,x); S2=img(y-1,x+1);
        S7=img(y,x-1);   S0=img(y,x);   S3=img(y,x+1);
        S6=img(y+1,x-1); S5=img(y+1,x); S4=img(y+1,x+1);               
        % 1.Find Local Mixima        
        if BH(y,x)==1
            %N=N+1;
            if S0>S1
                N=N+3;
                BH(y-1,x)=0;%BH(S1)
                BL(y,x)=0;%BL(S0)
                if S0>S2
                    N=N+3;
                    BH(y-1,x+1)=0;%BH(S2)
                    BL(y,x)=0;%BL(S0)
                    if S0>S3
                        N=N+3;
                        BH(y,x+1)=0;%BH(S3)
                        BL(y,x)=0;%BL(S0)
                        if S0>S4
                            N=N+3;
                            BH(y+1,x+1)=0;%BH(S4)
                            BL(y,x)=0;%BL(S0)
                            if S0>S5
                                N=N+3;
                                BH(y+1,x)=0;%BH(S5)
                                BL(y,x)=0;%BL(S0)
                                if S0>S6
                                    N=N+3;
                                    BH(y+1,x-1)=0;%BH(S6)
                                    BL(y,x)=0;%BL(S0)
                                    if S0>S7
                                        N=N+3;
                                        BH(y,x-1)=0;%BH(S7)
                                        BL(y,x)=0;%BL(S0)
                                        if S0>S8
                                            N=N+8;
                                            BH(y-1,x-1)=0;%BH(S8)
                                            BL(y,x)=0;%BL(S0)
                                            EN=EN+1;
                                            SM(y,x)=EN;
                                            ENr=ENr+1; SYr(ENr)=y; SXr(ENr)=x;
                                            SE(EN,1)=1;
                                            SE(EN,2)=img(y,x);
                                        else %S0<=S8
                                            N=N+3;
                                            BL(y-1,x-1)=0;%BL(S8)
                                            BH(y,x)=0;%BH(S0)
                                        end
                                    else %S0<=S7
                                        N=N+3;
                                        BL(y,x-1)=0;%BL(S7)
                                        BH(y,x)=0;%BH(S0)
                                    end
                                else %S0<=S6
                                    N=N+3;
                                    BL(y+1,x-1)=0;%BL(S6)
                                    BH(y,x)=0;%BH(S0)
                                end
                            else %S0<S5
                                N=N+3;
                                BL(y+1,x)=0;
                                BH(y,x)=0;
                            end
                        else %S0<S4
                            N=N+3;
                            BL(y+1,x+1)=0;%BL(S4)
                            BH(y,x)=0;%BH(S0)
                        end
                    else %S0<S3
                        N=N+3;
                        BL(y,x+1)=0;%BL(S3)
                        BH(y,x)=0;%BH(S0)
                    end
                else %S0<=S2
                    N=N+3;
                    BL(y-1,x+1)=0;%BL(S2)
                    BH(y,x)=0;%BH(S0)
                end
            else %S0<S1
                N=N+3;
                BL(y-1,x)=0;%BL(S1)
                BH(y,x)=0;%BH(S0)
            end
        end
       % 2.Find Local Mimima
        if BL(y,x)==1
            %N=N+1;
            if S0<S1
                N=N+3;
                BL(y-1,x)=0;%BL(S1)
                BH(y,x)=0;%BH(S0)
                if S0<S2
                    N=N+3;
                    BL(y-1,x+1)=0;%BL(S2)
                    BH(y,x)=0;%BH(S0)
                    if S0<S3
                        N=N+3;
                        BL(y,x+1)=0;%BL(S3)
                        BH(y,x)=0;%BH(S0)
                        if S0<S4
                            N=N+3;
                            BL(y+1,x+1)=0;%BL(S4)
                            BH(y,x)=0;%BH(S0)
                            if S0<S5
                                N=N+3;
                                BL(y+1,x)=0;%BL(S5)
                                BH(y,x)=0;%BH(S0)
                                if S0<S6
                                    N=N+3;
                                    BL(y+1,x-1)=0;%BL(S6)
                                    BH(y,x)=0;%BH(S0)
                                    if S0<S7
                                        N=N+3;
                                        BL(y,x-1)=0;%BL(S7)
                                        BH(y,x)=0;%BH(S0)
                                        if S0<S8
                                            N=N+8;
                                            BL(y-1,x-1)=0;%BL(S8)
                                            BH(y,x)=0;%BH(S0)
                                            EN=EN+1;
                                            SM(y,x)=-EN;
                                            ENr=ENr+1; SYr(ENr)=y; SXr(ENr)=x;
                                            SE(EN,1)=1;
                                            SE(EN,2)=img(y,x);
                                        else %S0>=S8
                                            N=N+3;
                                            BH(y-1,x-1)=0;%BH(S8)
                                            BL(y,x)=0;%BL(S0)
                                        end
                                    else %S0>=S7
                                        N=N+3;
                                        BH(y,x-1)=0;%BH(S7)
                                        BL(y,x)=0;%BL(S0)
                                    end
                                else %S0>=S6
                                    N=N+3;
                                    BH(y+1,x-1)=0;%BH(S6)
                                    BL(y,x)=0;%BL(S0)
                                end
                            else %S0>S5
                                N=N+3;
                                BH(y+1,x)=0;%BH(S5)
                                BL(y,x)=0;%BL(S0)
                            end
                        else %S0>S4
                            N=N+3;
                            BH(y+1,x+1)=0;%BH(S4)
                            BL(y,x)=0;%BL(S0)
                        end
                    else %S0>S3
                        N=N+3;
                        BH(y,x+1)=0;%BH(S3)
                        BL(y,x)=0;%BL(S0)
                    end
                else %S0>=S2
                    N=N+3;
                    BH(y-1,x+1)=0;%BH(S2)
                    BL(y,x)=0;%BL(S0)
                end
            else %S0>S1
                N=N+3;
                BH(y-1,x)=0;%BH(S1)
                BL(y,x)=0;%BL(S0)
            end
        end
        x = x+1;
    end
    y = y+1;
end
%BH(1,:)=0; BH(end,:)=0; BH(:,1)=0; BH(:,end)=0;
%BL(1,:)=0; BL(end,:)=0; BL(:,1)=0; BL(:,end)=0;
OPP = N/(Y*X);
SG=round(SE);
end