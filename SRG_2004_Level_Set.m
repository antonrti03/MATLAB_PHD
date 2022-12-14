function [Ms, loop, SA, LOCAL_THRESHOLD_MIN, SPEED] = SRG_2004_Level_Set(Ms, SYe, SXe, SG, EN, img, method)
% Rewritten by Tuan Nguyen, 2020.
% m-functions: basepoint2004byWP.m + SRG_2004_Level_Set.m = original
% Input:
% - Ms: segmented iamge;
% - SG: stack of one pixel extreman and their value 
% - SYe, SXe: stacks of coordinates of the first extreme pixels for Seeded Region Growing
% - SE: intensity of local extrema
% - EN: number of extrema
% - img: input grayscale image
% - method: 'non-Eulerian', 'Eulerian'.
% Output:
% - Ms: segmented image of one pixel extrema.
% - SP: number of loops for speed stack.
% - LOCAL_THRESHOLD_MIN: threshold
% - SPEED: speed stack.
% Delta_q=3*2^m/64 (m=8, bitdepth)=12.
%
% Porikli F.M. Automatic image segmentation by Wave Propagation. International Society for Optics and Photonics. 2004; 5298:536?543.
%
% Convert RGB to grayscale image
if ndims(img)==3
    img = rgb2gray(img);
end
[Y,X]=size(img);
%img = double(img);
img = round(double(img));%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
SA=SG;
%
B=8; 
GLOBAL_THRESHOLD = 2^B-1;
LOCAL_THRESHOLD_MIN = 0;
SPEED=zeros(1,2^B-1);
loop=1; 
k=1;
% Choose a method:
switch method
    case 'Eulerian'
        tag=0; %a stopping criteria is fulfilled
    case 'non-Eulerian'
        tag=1; %all points covered
    otherwise
        error('The method is incorrect.');
end
% Wave propagation
EN2=1; SP=0;
while EN2>0
    EN2=0; LOCAL_THRESHOLD=2^B-1; DeltaE=0; 
    %DelMAX=0; DelMIN=0; 
    DeltaN=0; DelNMAX=0; DelNMIN=0;
    while k<=EN
            y = SYe(k); x = SXe(k); label=Ms(y,x); index=abs(label);
            id1=0; id2=0;
            j=-1;
            while j<2
                i=-1;
                while i<2
                    if (j==0)&&(i==0)
                    else
                        y1=y+j; x1=x+i;
                        if (y1>0)&&(x1>0)&&(y1<=Y)&&(x1<=X)&&Ms(y1,x1)==0
                            id1=id1+1; avg=SA(index,2);
                            %if abs(img(y1,x1)-img(y,x)) <= LOCAL_THRESHOLD_MIN
                            if abs(avg-img(y1,x1))<=LOCAL_THRESHOLD_MIN
                                Ms(y1,x1)=label; 
                                EN=EN+1; SYe(EN)=y1; SXe(EN)=x1;
                                idx=SA(index,1); 
                                SA(index,2) = (avg*idx + img(y1,x1))/(idx+1);
                                SA(index,1) = idx+1;
                                id2=id2+1; 
                                DeltaE = DeltaE+img(y1,x1);
%                                 DelMAX=DelMAX+img(y1,x1)*sign(sign(label)+1);
%                                 DelMIN=DelMIN+img(y1,x1)*sign(1-sign(label));
                                DeltaN = DeltaN+1;
                                DelNMAX=DelNMAX+sign(sign(label)+1); 
                                DelNMIN=DelNMIN+sign(1-sign(label));
                            else
                                sigs = abs(img(y1,x1)-avg);
                                if sigs < LOCAL_THRESHOLD, LOCAL_THRESHOLD = sigs; end
                            end
                        end
                    end
                    i=i+1;  
                end
                j=j+1;
            end
            %
            if id1 > id2
                EN2=EN2+1;
                SYe(EN2)=y; SXe(EN2)=x;
            end
        %
        k=k+1;
    end
    %
    if (EN2==0) || (LOCAL_THRESHOLD_MIN > GLOBAL_THRESHOLD)
        break;
    else
        k=1; EN=EN2;
        if DeltaN~=0
            SP=SP+1;
            SPEED(SP)=DeltaE/DeltaN;
        end
        if LOCAL_THRESHOLD_MIN==0
            LOCAL_THRESHOLD_MIN=3*2^B/64;
        else
            if tag==1
                if LOCAL_THRESHOLD_MIN>=LOCAL_THRESHOLD
                    LOCAL_THRESHOLD_MIN=LOCAL_THRESHOLD_MIN+0.1;
                else
                    LOCAL_THRESHOLD_MIN=LOCAL_THRESHOLD+0.05;
                end
            else
                break;
            end
        end
        loop=loop+1;
    end
end
SPEED(SP+1:end)=[];
end
%Full segmentation khi tag=1 'non-Eulerian': khong phu thuoc vao initial points!
%Non-full segmentation khi tag=0 'Eulerian': khong phu thuoc vao initial points!