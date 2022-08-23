function [Ms, loop, SA, LOCAL_THRESHOLD_MIN, SPEED] = SRG_Nguyen2020_CLERG(Ms, SYe, SXe, SG, EN, img)
% Segmentation algorithm CLERG+LE (proposed by Tuan Nguyen, Tsviatkou, 2020)
% Name: CLERG+LE full (Model CLERG+LE)
% Input:
% - Ms: segmented iamge;
% - SG: stack of one pixel extreman and their value 
% - SYe, SXe: stacks of coordinates of the first extreme pixels for Seeded Region Growing
% - SE: intensity of local extrema
% - EN: number of extrema
% - img: input grayscale image
% Output:
% - Ms: segmented image of one pixel extrema.
% - loop: loop number of SRG.
% - LOCAL_THRESHOLD_MIN: threshold
% - SA: average values of segments
% - SPEED: Check stack.
%
% Convert RGB to grayscale image
if ndims(img)==3
    img = rgb2gray(img);
end
[Y, X] = size(img);
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
            y = SYe(k); x = SXe(k); label=Ms(y,x); index=abs(label); EXT=SG(index,2); sgn=sign(label);
            id1=0; id2=0;
            for j=-1:1
                for i=-1:1
                    if (j==0)&&(i==0)
                    else
                        y1=y+j; x1=x+i;
                        if (y1>0)&&(x1>0)&&(y1<=Y)&&(x1<=X)&&Ms(y1,x1)==0
                            avg=SA(index,2); id1=id1+1;
                            if img(y1,x1)==EXT-LOCAL_THRESHOLD_MIN*sgn
                                Ms(y1,x1)=label; 
                                EN=EN+1; SYe(EN)=y1; SXe(EN)=x1;
                                idx=SA(index,1);
                                SA(index,2) = (avg*idx + img(y1,x1))/(idx+1);
                                SA(index,1) = idx+1;
                                DeltaE = DeltaE+img(y1,x1); 
%                                 DelMAX=DelMAX+img(y1,x1)*sign(sign(label)+1);
%                                 DelMIN=DelMIN+img(y1,x1)*sign(1-sign(label));
                                DeltaN = DeltaN+1;
                                DelNMAX=DelNMAX+sign(sign(label)+1); 
                                DelNMIN=DelNMIN+sign(1-sign(label));
                                id2=id2+1;
                            else
                                if abs(EXT-img(y1,x1))>LOCAL_THRESHOLD_MIN && abs(EXT-img(y1,x1))<LOCAL_THRESHOLD
                                    LOCAL_THRESHOLD=abs(EXT-img(y1,x1));
                                end   
                            end
                        end
                    end 
                end
            end
            %
        if id1>id2
            EN2=EN2+1;
            SYe(EN2)=y; SXe(EN2)=x;
        end
        %
        k=k+1;
    end
    %
    if (EN2==0) || (LOCAL_THRESHOLD_MIN>=GLOBAL_THRESHOLD) || (LOCAL_THRESHOLD==2^B-1)
        break;
    else
        k=1; EN=EN2;
        if DeltaN~=0
            SP=SP+1;
            SPEED(SP)=DeltaE/DeltaN;
        end
        LOCAL_THRESHOLD_MIN=LOCAL_THRESHOLD;
        loop=loop+1;
    end
end
%
SPEED(SP+1:end)=[];
%
end