function [Ms, Mw, EC, EN, N, SYe, SXe, ENs, SE, SG]=getlabel(I, img)
% Edited by Tuan Nguyen, 2019, it's faster than Osama's RG from 5
% times
% Ms: Segmented image of local extrema
% Mw: Segmented image of local extrema for SRG
% EC: stack of label count of pixels
% EN: label number, number of extrema 
% N: number of operations
% ENs: number of extreme pixels
% Memory = 80*N, N-number of pixels;
[Y,X] = size(I);
Ms = zeros(Y,X);%8 
Mw = zeros(Y,X);%8
SY=zeros(1,Y*X); SX=zeros(1,Y*X);%16
SYe=zeros(1,Y*X); SXe=zeros(1,Y*X);%16
SE=zeros(Y*X,2);%16
EN=0; N=0; ENs=0;
EC = zeros(1,Y*X); 
COUNT=1;
y=0;
while (y<Y)
      x=0; N=N+3;      
      while (x<X)
          N=N+3;
          if Ms(y+1,x+1)==0 && (I(y+1,x+1)~=0)
              EN=EN+1; SYe(EN)=y+1; SXe(EN)=x+1;%!!!
              ENs=ENs+1;
              u=1;
              N=N+3;%!
              if I(y+1,x+1)==-1
                  u=-1; N=N+1;%!
              end
              NS=EN*u;
              Ms(y+1,x+1)=NS; Mw(y+1,x+1)=NS;
              SP=1;
              SY(SP)=y;
              SX(SP)=x;
              N=N+5;
             while (SP>0)                         
                y1=SY(SP);
                x1=SX(SP);
                SP=SP-1;
                N=N+4;
                for k=-1:1
                    N=N+2;
                    for m=-1:1
                        N=N+2;
                        if (y1+k+1>0) && (x1+m+1>0) && (y1+k+1<=Y) && (x1+m+1<=X) && ...
                            Ms(y1+k+1,x1+m+1)==0 && I(y1+1,x1+1)==I(y1+k+1,x1+m+1)                         
                            Ms(y1+k+1,x1+m+1)=NS;
                            SP=SP+1; 
                            COUNT=COUNT+1;
                            SY(SP)=y1+k;
                            SX(SP)=x1+m;
                            ENs=ENs+1;
                            N=N+5;
                        end                                     
                    end
                end
             end
             EC(EN)=COUNT; SE(EN,1)=COUNT; SE(EN,2)=img(y+1,x+1);
             COUNT=1;
             N=N+2;
          end 
     x=x+1;
      end       
y=y+1;
end
SE(EN+1:end,:)=[];
SG=round(SE); SG(:,1)=1;
end