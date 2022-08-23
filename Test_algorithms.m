%% Finding Local Extrema
%clear;
%img=imread('G:\PhD1721\VAK_IMG_01\512-2-3.bmp');
%img=imread('H:\PhD1721\Best_case_for_straightfrw_gray.bmp');
%img=imread('H:\PhD1721\Worst_case_for_straightforward_gray.bmp');
%img=imread('H:\PhD1721\Worst_case_for_straightforward_gray.bmp');
%img=imread('H:\PhD1721\Worst_case_for_straightforward_gray_256.bmp');
%img=imread('H:\PhD1721\Best_case_for_straightfrw_gray_256.bmp');
%img=imread('H:\PhD1721\Best_case_for_straightfrw_gray.bmp');
%img=imread('12bmp.bmp');
img=imread('lena256.bmp');
%img=imread('G:\PhD1721\france256.bmp');
%img=imread('H:\PhD1721\Matlab_Segmentation\Modeli\Berkeley_Segmentation_dataset\Plane.jpg');
%img=imread('H:\PhD1721\Matlab_Segmentation\Modeli\Berkeley_Segmentation_dataset\007.jpg');
%img=imread('H:\PhD1721\Matlab_Segmentation\Modeli\Berkeley_Segmentation_dataset\Crow.jpg');
%img=imread('H:\PhD1721\Matlab_Segmentation\Modeli\Berkeley_Segmentation_dataset\Man_and_building.jpg');
%img=imread('G:\PhD1721\Matlab_Segmentation\Modeli\Berkeley_Segmentation_dataset\001.jpg');
%img=imread('G:\PhD1721\Matlab_Segmentation\Modeli\Berkeley_Segmentation_dataset\002.jpg');
%img=imread('G:\PhD1721\Matlab_Segmentation\Modeli\Berkeley_Segmentation_dataset\003.jpg');
%img=imread('G:\PhD1721\Matlab_Segmentation\Modeli\Berkeley_Segmentation_dataset\004.jpg');
%img=imread('G:\PhD1721\Matlab_Segmentation\Modeli\Berkeley_Segmentation_dataset\005.jpg');
%img=imread('G:\PhD1721\Matlab_Segmentation\Modeli\Berkeley_Segmentation_dataset\006.jpg');
%img=imread('Standard_seg_01.bmp');
%img=imread('Standard_seg_02.bmp');
%img=imread('Standard_seg_03.bmp');
%img=imread('Standard_seg_04.bmp');
%img=imread('Group_1_1.jpg');
%img=imread('Group_3_15.jpg');
%img=imread('paper_8.jpg');
% Ouput:
% SME: Segmented Matrix of Extrema; SMM: Segmented Matrix of extreme Marks
% SMI: Segmented Matrix for input Image
% Input:
% img: input image (Gray or RGB)
tic
[SME, SMM, EN, ENs, SYe, SXe, SE, SG, OPP] = Extrema_BSA(img);
%[SME, SMM, EN, ENs, SYe, SXe, SE, SG] = Extrema_MorphCplus2(img);
%[SME, SMM, EN, ENs, OPP, SYe, SXe, SE, SG] = Extrema_MorphMatlab(img);
%[SME, SMM, EN, ENs, SYe, SXe, SE, SG, OPP] = Extrema_H3A(img);
toc
%% Show extrema
SME=abs(SME); SME = label2rgb(SME);
figure, imshow(SME,[]), title('Extrema'), impixelinfo;
%% Show a grayscale image in 3D
if ndims(img)==3
    img = rgb2gray(img);
end
%img = double(img);
figure, surf(img);
%% CLERG = Convergent Local Extreme Region Growing
tic
[SMI, loop, SA, sig0, AA] = SRG_Nguyen2020_CLERG_full(SMM, SYe, SXe, SG, EN, img);
%[SMI, loop, SA, sig0, AA] = SRG_Nguyen2020_CLERG(SMM, SYe, SXe, SG, EN, img);
toc
%%
%SMI=abs(SMI); SMI = label2rgb(SMI);
figure, imshow(SMI,[]), title('CLERG'), impixelinfo;
%% SRG_Adams1994_full_quasi (OSRG)
tic
[SMI, loop, SA, sig0, AA] = SRG_Adams1994_full_quasi(SMM, SYe, SXe, SG, EN, img);
toc
%%
SMI=abs(SMI); SMI = label2rgb(SMI);
figure, imshow(SMI,[]), title('SRG(Adams1994)full+LE'), impixelinfo;
%% SRG_Fan2015USA_Stabilized (SSRG)
L=1;
tic
[SMI, loop, SA, sig0, AA] = SRG_Fan2015_Stabilized(SMM, SYe, SXe, SG, EN, img, L);
toc
%%
SMI=abs(SMI); SMI = label2rgb(SMI);
figure, imshow(SMI,[]), title('Stabilized SRG'), impixelinfo;
%% SRG via regular seed generation, Fan, 2005  (RSRG)
tic
[SMI, loop, SA, sig0, AA] = SRG_Fan2005_regular(SMM, SYe, SXe, SG, EN, img);
toc
%%
SMI=abs(SMI); SMI = label2rgb(SMI);
figure, imshow(SMI,[]), title('SRG via regular seed generation'), impixelinfo
%% LSRG by Wave Propagation by Porikli, 2004  (LSSRG)
%img=imread('paper_8.jpg');
tic
method='non-Eulerian'; % method='non-Eulerian', 'Eulerian'
%[SME, SMM, EN, SYe, SXe, ENs, SE, SG]=Extrema_basepoint2004byWP(img);
[SMI, loop, SA, sig0, AA]=SRG_2004_Level_Set(SMM, SYe, SXe, SG, EN, img, method);
toc
%%
SMI=abs(SMI); SMI = label2rgb(SMI);
figure, imshow(SMI,[]), title('WAVE PROPAGATION'), impixelinfo;
%% Segmentation evaluation Dm(I) our
tic 
[Sd, Serr, SIG2] = EvaluationDm_new(img, SMI, SME, SG, SA);
toc

%% Segmentation evaluation F(I)
NUM=EN;
tic
[F, SIG2] = EvaluationF(img, SMI, SA, NUM);
toc
F
%% Segmentation evaluation D(I)
NUM=EN;
tic
[D, SIG2] = EvaluationD(img, SMI, SA, NUM);
toc
D
%% SSIM: Structural Similarity Index (SSIM)
% Index strukturnovo podobya.
tic
[ssim, A] = EvaluationSSIM(img, SMI, SA);
toc
ssim
%% 