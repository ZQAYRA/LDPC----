close all
clear all
% for p=1:1:5
%��������
% n=2304;                                                                   %%%���볤
% k=1152; 
%%%��Ϣλ����
tic
n=576;                                                                   %%%���볤
k=288; 
BER=0;
rate=k/n;                                                                 %%%����
IterNum=30;

% save msg
% [H,c]=ldpc_matrix(msg);

% [H,c]=bianma(msg)
%����������
ferrlim=5;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
Ndb=6;
EbN0db=0:0.4:Ndb;
Npf=ferrlim*k;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for nEN=1:length(EbN0db)
    en=10^(EbN0db(nEN)/10);
    sigma=1/sqrt(2*rate*en);
    nframe=0;
    Err=0;
    while nframe<ferrlim
       nframe=nframe+1;
       msg = round(rand(1,k));
       [H,c]= bianma(msg);
       code=c;
       I=1-2*code;
       rec=I+sigma*randn(1,n);
       est_code11=BP3(rec,H,IterNum);                                 %%%��С��
       est_code1 = est_code11(1:k);
       err=length(find(est_code1~=msg));
       Err=Err+err;
    end
      BER(nEN)=Err/Npf;
    if BER(nEN)<1/Npf;
       BER(nEN)=.1/Npf;
    end
    disp(nEN/length(EbN0db));
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for nEN1=1:length(EbN0db)
    en1=10^(EbN0db(nEN1)/10);
    sigma=1/sqrt(2*rate*en1);
    nframe1=0;
    Err1=0;
    while nframe1<ferrlim
       nframe1=nframe1+1;
       msg = round(rand(1,k));
       [H,c]= bianma(msg)
       code=c;
       I=1-2*code;
       rec=I+sigma*randn(1,n);       
%        [est_code1,success]= LDPC_decoder(rec1,sigma,H,IterNum);  
       est_code22=BP4(rec,H,sigma, IterNum);%%%%%%%������BP
       est_code2= est_code22(1:k);
       err1=length(find(est_code2~=msg));
       Err1=Err1+err1;
    end
      BER1(nEN1)=Err1/(ferrlim*k);
     if BER1(nEN1)<1/(ferrlim*k);
      BER1(nEN1)=.1/(ferrlim*k); 
     end  
 end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------��������������------------------------------------
figure(2);
semilogy(EbN0db,BER,'ro-');   hold on;                        %%%��С��  %������BER����
semilogy(EbN0db,BER1,'b+-');   hold on;      %%%����

axis([0 Ndb 1/Npf 1])
grid on
% xlim([0 6]);
% title('����������ܱȽ�');
xlabel('SNR/dB');
ylabel('BER');
legend('Min-Sum','BP');%,'����������'
% saveas(2,['C:\Users\DELL\Documents\MATLAB\IEEE802.16e5760.5\IEE5760.5tuxing\',int2str(p),'.fig'])
% end
toc
t=toc
