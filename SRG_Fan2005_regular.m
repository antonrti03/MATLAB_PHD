function [Ms, loop, SA, LOCAL_THRESHOLD_MIN, SPEED] = SRG_Fan2005_regular(Ms, SYe, SXe, SG, EN, img)
% Segmentation algorithm: SRG_Fan2005_regular based on SRG_Adams1994_full_quasi
% Made by Tuan Nguyen, Tsvetkov, 2019
% Name: SRG_Fan2005_regular + LE
% Fan J., Zeng G., Body M., Hacid M.S. Seeded region growing: an extensive and comparative study. Pattern Recognition Letters. 2005; 26(8):1139?1156.
% Input:
% - Ms: segmented iamge;
% - SG: stack of one pixel extreman and their value 
% - SYe, SXe: stacks of coordinates of the first extreme pixels for Seeded Region Growing
% - SE: intensity of local extrema
% - EN: number of extrema
% - img: input grayscale image
% Output:
% - Ms: segmented image of one pixel extrema.
% - SP: number of loops for speed stack.
% - LOCAL_THRESHOLD_MIN: threshold
% - SPEED: speed stack.
%
% Convert RGB to grayscale image
if ndims(img)==3
    img = rgb2gray(img);
end
[Y, X] = size(img);
%img = double(img);
img = round(double(img));%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
SA=SG;
%
B=8; 
GLOBAL_THRESHOLD = 2^B-1;
LOCAL_THRESHOLD_MIN=0; 
SPEED=zeros(1,2^B-1);
loop=1; 
k=1;
EN2=1; SP=0;
while EN2>0
    EN2=0; LOCAL_THRESHOLD=2^B-1; DeltaE=0; 
    %DelMAX=0; DelMIN=0; 
    DeltaN=0; DelNMAX=0; DelNMIN=0;
    while k<=EN
            y = SYe(k); x = SXe(k); label=Ms(y,x); index=abs(label);
            id1=0; id2=0; 
            for j=-1:1
                for i=-1:1
                    if (j==0)&&(i==0)
                    else
                        y1=y+j; x1=x+i;
                        if (y1>0)&&(x1>0)&&(y1<=Y)&&(x1<=X)&&Ms(y1,x1)==0
                            id1=id1+1; avg=SA(index,2);
                            %if abs(img(y,x)-img(y1,x1)) <= LOCAL_THRESHOLD_MIN
                            if abs(avg-img(y1,x1)) <= LOCAL_THRESHOLD_MIN
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
                                sigs=0; id=0;
                                for u=-1:1
                                    for v=-1:1
                                        if (u==0 && v==0)
                                        else
                                            if (y+u>0)&&(y+u<=Y)&&(x+v>0)&&(x+v<=X)&&(Ms(y+u,x+v)==0)
                                                id=id+1;
                                                sigs = sigs + abs(img(y+u,x+v)-img(y,x));
                                            end
                                        end
                                    end
                                end
                                if sigs < LOCAL_THRESHOLD, LOCAL_THRESHOLD = sigs; end
                            end
                        end
                    end 
                end
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
    if (EN2==0) || (LOCAL_THRESHOLD_MIN >= GLOBAL_THRESHOLD)
        break;
    else
        k=1; EN=EN2;
        if DeltaN~=0
            SP=SP+1;
            SPEED(SP)=DeltaE/DeltaN;
        end
        if LOCAL_THRESHOLD_MIN>=LOCAL_THRESHOLD
            LOCAL_THRESHOLD_MIN=LOCAL_THRESHOLD_MIN+0.3;
        else
            LOCAL_THRESHOLD_MIN=LOCAL_THRESHOLD+0.1;
        end
        loop=loop+1;
    end
end
SPEED(SP+1:end)=[];
end
%Full segmentation: khong phu thuoc vao initial points!