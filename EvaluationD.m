function [D, SIG2] = EvaluationD(img, Mw, SA, NUM)
% Made by Tuan Nguyen, 17.04.2020
% D(I) = (1/N)*(1...N)sum(Sk*ek^2/(W*H));
% Input:
% img: original grayscale image
% Mw: segmented image of local extrema
% SA: stack of region pixels and their avg.
% NUM: number of regions
% Output:
% D: evaluation value
% SIG2: squared diviation summary
% From paper:
% Zhang H., Fritts J.E., Goldman S.A. Image segmentation evaluation: A survey of unsupervised methods. Computer Vision and Image Understanding. 2008; 110(2): 260–280.
if ndims(img)==3
    img = rgb2gray(img);
end
img = double(img);
%
N = length(SA(:,1));
SIG2 = zeros(N,1);
[Y,X] = size(img);
SM = zeros(Y,X); 
SY=zeros(1,Y*X); SX=zeros(1,Y*X);
NS=0;
EC = zeros(1,Y*X); 
y=0;
while (y<Y)
      x=0;      
      while (x<X)
          if SM(y+1,x+1)==0 && Mw(y+1,x+1)~=0
              NS=NS+1; COUNT=1; label=Mw(y+1,x+1); idx=abs(label); Avg=SA(idx,2); Err2=0;
              SM(y+1,x+1)=NS; 
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
                            SP=SP+1; COUNT=COUNT+1;
                            SY(SP)=y1+j;
                            SX(SP)=x1+i;
                            Err2 = Err2 + (img(y1+j+1,x1+i+1)-Avg)^2;
                        end                                     
                    end
                end                               
             end
             EC(NS)=COUNT; SIG2(idx) = Err2*COUNT/(Y*X);
          end 
     x=x+1;
      end       
y=y+1;
end
% Segmentation evaluation
D = sum(SIG2)/NUM;
end