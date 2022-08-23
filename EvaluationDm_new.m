function [F, E, SIG2] = EvaluationDm_new(img, SMI, SME, SG, SA)
% Made by Tuan Nguyen, 04.01.2021
% Input:
% img: original grayscale image
% SMI: segmented image
% SME: segmented image of local extremum
% SA: stack of region pixels and their avg
% SG: statck of local extremum and their values
% Output:
% F: evaluation value
% E: Error value
% SIG2: stack of region lengths
if ndims(img)==3
    img = rgb2gray(img);
end
img = double(img);
%
N = length(SG(:,1));
SIG2 = zeros(N,1);
EC = zeros(N,1); 
[Y,X] = size(img);
SM = zeros(Y,X); 
SY=zeros(1,Y*X); SX=zeros(1,Y*X);
NS=0;
y=0;
while (y<Y)
      x=0;      
      while (x<X)
          if SM(y+1,x+1)==0 && SMI(y+1,x+1)~=0
              NS=NS+1; COUNT=1; label=SMI(y+1,x+1); idx=abs(label); ERR=0; len=0; EXT=SG(idx,2); L=SA(idx,1);
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
                            if (y1+j+1>0) && (x1+i+1>0) && (y1+j+1<=Y) && (x1+i+1<=X) && SM(y1+j+1,x1+i+1)==0
                                if SMI(y1+j+1,x1+i+1) == SMI(y1+1,x1+1)                     
                                    SM(y1+j+1,x1+i+1)=NS;
                                    SP=SP+1; COUNT=COUNT+1;
                                    SY(SP)=y1+j;
                                    SX(SP)=x1+i;
                                    yn=y1+j+1; xn=x1+i+1;
                                    SMM = zeros(Y,X);
                                    SMM(yn,xn)=1;
                                    if sign(label)*img(yn,xn)>=sign(label)*EXT
                                        if SME(yn,xn)==0
                                            ERR=ERR+1; len=len+L;
                                            break;
                                        else
                                            break;
                                        end
                                        %
                                    else
                                        id=1;
                                        while id>0
                                            id=0; 
                                            for k=-1:1
                                                for l=-1:1
                                                    if (yn+k>0)&&(yn+k<=Y)&&(xn+l>0)&&(xn+l<=X)&& ...
                                                            (img(yn+k,xn+l)==EXT&&SME(yn+k,xn+l)~=0 || SMI(yn+k,xn+l)~=label) 
                                                        id=1;
                                                        break;
                                                    end
                                                end
                                            end
                                            %
                                            if id==1
                                                break;
                                            else %id=0
                                                a=img(yn,xn);
                                                for k=-1:1
                                                    for l=-1:1
                                                        if (yn+k>0)&&(yn+k<=Y)&&(xn+l>0)&&(xn+l<=X)&& ...
                                                                SMM(yn+k,xn+l)==0 && SMI(yn+k,xn+l)==label && ... 
                                                                sign(label)*img(yn+k,xn+l)>=sign(label)*a
                                                            a=img(yn+k,xn+l);
                                                            ay=yn+k; ax=xn+l;
                                                            id=1;
                                                        end
                                                    end
                                                end
                                                %
                                                if id==0
                                                    ERR=ERR+1;
                                                    break;
                                                else %id=1
                                                    len=len+1; yn=ay; xn=ax;
                                                    SMM(yn,xn)=1;
                                                end
                                                %
                                            end
                                            %
                                        end    
                                    end
                                    
                                    %
                                end
                            end                                     
                        end
                    end
              end
              EC(idx)=ERR/COUNT; SIG2(idx) = len/COUNT^2;
          end 
      x=x+1;
      end       
y=y+1;
end
% Segmentation evaluation
F = sum(SIG2)/N;
E = sum(EC)/N;
end
%%
% function [F, E, SIG2] = EvaluationDm_new(img, SMI, SME, SG, SA)
% % Made by Tuan Nguyen, 04.01.2021
% % Input:
% % img: original grayscale image
% % SMI: segmented image
% % SME: segmented image of local extremum
% % SA: stack of region pixels and their avg from segmentation
% % SG: statck of local extremum and their values from extrema finding
% % Output:
% % F: evaluation value
% % E: Error value
% % SIG2: stack of region lengths
% if ndims(img)==3
%     img = rgb2gray(img);
% end
% img = double(img);
% %
% N = length(SG(:,1));
% SIG2 = zeros(N,1);
% EC = zeros(N,1); 
% [Y,X] = size(img);
% SM = zeros(Y,X); 
% SY=zeros(1,Y*X); SX=zeros(1,Y*X);
% NS=0;
% y=0;
% while (y<Y)
%       x=0;      
%       while (x<X)
%           if SM(y+1,x+1)==0 && SMI(y+1,x+1)~=0
%               NS=NS+1; COUNT=1; label=SMI(y+1,x+1); idx=abs(label); ERR=0; len=0; EXT=SG(idx,2); L=SA(idx,1);
%               SM(y+1,x+1)=NS; 
%               SP=1;
%               SY(SP)=y;
%               SX(SP)=x; 
%               while (SP>0)                         
%                     y1=SY(SP);
%                     x1=SX(SP);
%                     SP=SP-1;
%                     for j=-1:1
%                         for i=-1:1
%                             if (y1+j+1>0) && (x1+i+1>0) && (y1+j+1<=Y) && (x1+i+1<=X) && SM(y1+j+1,x1+i+1)==0
%                                 if SMI(y1+j+1,x1+i+1) == SMI(y1+1,x1+1)                     
%                                     SM(y1+j+1,x1+i+1)=NS;
%                                     SP=SP+1; COUNT=COUNT+1;
%                                     SY(SP)=y1+j;
%                                     SX(SP)=x1+i;
%                                     yn=y1+j+1; xn=x1+i+1;
%                                     SMM = zeros(Y,X);
%                                     SMM(yn,xn)=1;
%                                     if sign(label)*img(yn,xn)>=sign(label)*EXT 
%                                         if SME(yn,xn)==0
%                                             ERR=ERR+1; len=len+L;
%                                             break;
%                                         else %SME(yn,xn)=label
%                                             break;
%                                         end
%                                         %
%                                     else
%                                         id=1;
%                                         while id>0
%                                             id=0;
%                                             if SME(yn,xn)==label || (sign(label)*img(yn,xn)>=sign(label)*EXT)&&(SME(yn,xn)==0)
%                                                 if (sign(label)*img(yn,xn)>=sign(label)*EXT)&&(SME(yn,xn)==0)
%                                                     ERR=ERR+1; len=len+L;
%                                                 end
%                                                 break;
%                                             else % img(yn,xn) < Max or > Min
%                                                 a=img(yn,xn);
%                                                 for k=-1:1
%                                                     for l=-1:1
%                                                         if (yn+k>0)&&(yn+k<=Y)&&(xn+l>0)&&(xn+l<=X)&& ...
%                                                                 SMM(yn+k,xn+l)==0 && SMI(yn+k,xn+l)==label && ...
%                                                                 sign(label)*img(yn+k,xn+l)>=sign(label)*a
%                                                             a=img(yn+k,xn+l);
%                                                             ay=yn+k; ax=xn+l;
%                                                             id=1;
%                                                         end
%                                                     end
%                                                 end
%                                                 %
%                                                 if id==0
%                                                     %ERR=ERR+1; len=len+L;
%                                                     break;
%                                                 else %id=1, tiep tuc tim duong
%                                                     len=len+1; yn=ay; xn=ax;
%                                                     SMM(yn,xn)=1;
%                                                 end
%                                                 %
%                                             end
%                                             %
%                                         end    
%                                     end
%                                     
%                                     %
%                                 end
%                             end                                     
%                         end
%                     end
%               end
%               EC(idx)=ERR/COUNT; SIG2(idx) = len/COUNT^2;
%               %EC(idx)=ERR; SIG2(idx) = len;
%           end 
%       x=x+1;
%       end       
% y=y+1;
% end
% % Segmentation evaluation
% F = sum(SIG2)/N;
% %F = sum(SIG2)/(N*Y*X);
% E = sum(EC)/N;
% end