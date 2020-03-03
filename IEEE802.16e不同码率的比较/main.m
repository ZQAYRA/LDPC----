close all
clear all
%��������
% n=2304;                                                                   %%%���볤
% k=1152;                                                                    %%%��Ϣλ����
n=576;                                                                   %%%���볤
k=288;
k1=384;
k2=432;
BER=0;
BER1=0;
BER2=0;
rate=k/n;%%%����
rate1=k1/n;
rate2=k2/n;
IterNum=30;
%����������
ferrlim=30;
Ndb=6;
EbN0db=0:0.5:Ndb;
Npf=ferrlim*k;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for nEN1=1:length(EbN0db)
    en1=10^(EbN0db(nEN1)/10);
    sigma=1/sqrt(2*rate*en1);
    nframe1=0;
    Err=0;
    while nframe1<ferrlim
       nframe1=nframe1+1;
       msg = round(rand(1,k));
       [H,c]=ldpc_matrix(msg);
       code=c;
       I=1-2*code;
       rec=I+sigma*randn(1,n); 
     est_code=BP4(rec,H,sigma, IterNum)
     est_code0= est_code(1:k);
     err=length(find(est_code0~=msg));
      Err=Err+err;
     end
      BER(nEN1)=Err/(ferrlim*k);
     if BER(nEN1)<1/(ferrlim*k);
      BER(nEN1)=.1/(ferrlim*k);
     end  
 end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for nEN1=1:length(EbN0db)
    en1=10^(EbN0db(nEN1)/10);
 sigma1=1/sqrt(2*rate1*en1);
nframe1=0;
     Err1=0;
    while nframe1 < ferrlim
       nframe1=nframe1+1;
       msg1 = round(rand(1,k1));
       [H1,c1]=ldpc_matrix1(msg1);
       code1=c1;
      I1=1-2*code1;
       rec1=I1+sigma1*randn(1,n);
       est_code11=BP4(rec1,H1,sigma1, IterNum);%%%%%%%������BP
       est_code1= est_code11(1:k1);
       err1=length(find(est_code1~=msg1));
      Err1=Err1+err1;
    end
      BER1(nEN1)=Err1/(ferrlim*k1);
     if BER1(nEN1)<1/(ferrlim*k1);
      BER1(nEN1)=.1/(ferrlim*k1);
     end  
 end
 for nEN1=1:length(EbN0db)
    en1=10^(EbN0db(nEN1)/10);
    sigma2=1/sqrt(2*rate2*en1);
    nframe1=0;
    Err2=0;
    while nframe1<ferrlim
       nframe1=nframe1+1;
       msg2 = round(rand(1,k2));
       [H2,c2]=ldpc_matrix2(msg2);
       code2=c2;
       I2=1-2*code2;
       rec2=I2+sigma2*randn(1,n);
       est_code22=BP4(rec2,H2,sigma2, IterNum)
       est_code2= est_code22(1:k2);
       err2=length(find(est_code2~=msg2));
       Err2=Err2+err2;
     end
     BER2(nEN1)=Err2/(ferrlim*k2);
     if BER2(nEN1)<1/(ferrlim*k2);
        BER2(nEN1)=.1/(ferrlim*k2);
     end  
 end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------��������������------------------------------------
figure(2);
semilogy(EbN0db,BER,'ro-');   hold on;                        %%%��С��  %������BER����
semilogy(EbN0db,BER1,'b+-');   hold on;      %%%����
semilogy(EbN0db,BER2,'g-*');   hold on;   
axis([0 Ndb 1/Npf 1])
% xlim([0 6]);
title('����������ܱȽ�');
xlabel('Eb/N0(dB)');
ylabel('�������');
legend('rate=1/2','rate=2/3B','rate=3/4A');%,'����������'

