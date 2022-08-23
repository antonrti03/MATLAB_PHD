function [ssimval, A] = EvaluationSSIM(img, Mw, SA)
% Made by Tuan Nguyen, 19.09.2020
% SSIM(y,x) = ssim(A,ref);
% A: approximation image
% ref: refenrence image
% Input:
% img: original grayscale image
% Mw: segmented image of local extrema
% SA: stack of region pixels and their avg.
% Output:
% ssimval: evaluation value
% A: AVG image
% From paper:
% Wang Zhou at []. Image Qualifty Assessment: From Error Visibility to Structural Similarity. IEEE Transactions on Image Processing. 2004; 13(4):600–612.
if ndims(img)==3
    img = rgb2gray(img);
end
img = double(img);
%
[Y,X] = size(img);
SM = zeros(Y,X); A = zeros(Y,X);
SY=zeros(1,Y*X); SX=zeros(1,Y*X);
NS=0;
EC = zeros(1,Y*X); 
y=0;
while (y<Y)
      x=0;      
      while (x<X)
          if SM(y+1,x+1)==0 && Mw(y+1,x+1)~=0
              NS=NS+1; COUNT=1; label=Mw(y+1,x+1); idx=abs(label); Avg=SA(idx,2);
              SM(y+1,x+1)=NS; A(y+1,x+1)=Avg;
              SP=1;
              SY(SP)=y;
              SX(SP)=x; 
             while (SP>0)                         
                   y1=SY(SP);
                   x1=SX(SP);
                   SP=SP-1;
                for j=-1:1
                    for i=-1:1
                        if (y1+j+1>0) && (x1+i+1>0) && (y1+j+1<=Y) && (x1+i+1<=X) && ...
                            SM(y1+j+1,x1+i+1)==0 && Mw(y1+1,x1+1)==Mw(y1+j+1,x1+i+1)                      
                            SM(y1+j+1,x1+i+1)=NS; 
                            A(y1+j+1,x1+i+1)=Avg;
                            SP=SP+1; COUNT=COUNT+1;
                            SY(SP)=y1+j;
                            SX(SP)=x1+i;
                        end                                     
                    end
                end                               
             end
             EC(NS)=COUNT;
          end 
     x=x+1;
      end       
y=y+1;
end
% Segmentation evaluation
ssimval = ssim(A,img);
end