%% Test 180 images via 3 groups: N1 - N2 - N3
tic
D=0; S=0;
N=60;
for q=1:N
    filename = sprintf('Group_1_%d.jpg', q);
    img = imread(filename);
    [SME, SMM, EN, ENs, SYe, SXe, SE, SG] = Extrema_MorphCplus2(img);
    %[SMI, loop, SA, sig0, AA] = SRG_Nguyen2020_CLERG(SMM, SYe, SXe, SG, EN, img);
    %[SMI, loop, SA, sig0, AA] = SRG_Nguyen2020_CLERG_full(SMM, SYe, SXe, SG, EN, img);
    %[SMI, loop, SA, sig0, AA] = SRG_Adams1994_full_quasi(SMM, SYe, SXe, SG, EN, img);
    %[SMI, loop, SA, sig0, AA] = SRG_Fan2015_Stabilized(SMM, SYe, SXe, SG, EN, img, 1);
    %[SMI, loop, SA, sig0, AA] = SRG_Fan2005_regular(SMM, SYe, SXe, SG, EN, img);
    method='non-Eulerian';
    [SMI, loop, SA, sig0, AA]=SRG_2004_Level_Set(SMM, SYe, SXe, SG, EN, img, method);
    %
    %Dm
    [Dm, Serr, SIG2] = EvaluationDm_new(img, SMI, SME, SG, SA);
    D=D+Dm; S=S+Serr;
    %F
%     [Dm, SIG2] = EvaluationF(img, SMI, SA, EN);
%     D=D+Dm;
    %D
%     [Dm, SIG2] = EvaluationD(img, SMI, SA, EN);
%     D=D+Dm;
    %SSIM
%     [Dm, A] = EvaluationSSIM(img, SMI, SA);
%     D=D+Dm;
end
toc
D=D/N
S=S/N
%% Time test
T=0;
N=60;
for q=1:N
    filename = sprintf('Group_1_%d.jpg', q);
    img = imread(filename);
    [SME, SMM, EN, ENs, SYe, SXe, SE, SG, Y, X] = Extrema_MorphCplus2(img);
    tic
    %[SMI, loop, SA, sig0, AA] = SRG_Nguyen2020_CLERG(SMM, SYe, SXe, SG, EN, img);
    %[SMI, loop, SA, sig0, AA] = SRG_Nguyen2020_CLERG_full(SMM, SYe, SXe, SG, EN, img);
    %[SMI, loop, SA, sig0, AA] = SRG_Adams1994_full_quasi(SMM, SYe, SXe, SG, EN, img);
    %[SMI, loop, SA, sig0, AA] = SRG_Fan2015_Stabilized(SMM, SYe, SXe, SG, EN, img, 1);
    %[SMI, loop, SA, sig0, AA] = SRG_Fan2005_regular(SMM, SYe, SXe, SG, EN, img);
    %method='non-Eulerian';
    %[SMI, loop, SA, sig0, AA]=SRG_2004_Level_Set(SMM, SYe, SXe, SG, EN, img, method);
    ti = toc;
    T = T+ti;
end
T=T/N
%%