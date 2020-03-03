tic
m=9;
n=12;
k=n-m;
R=(n-m)/n;
frame_num=10;
Npf=k*frame_num;
EbN0db=0:0.5:6;
for nEN=1:length(EbN0db)
   Err=0; 
   sigma_2=1/(2*10^(EbN0db(nEN)/10)*R);
    for num=1:frame_num
        num;
        s=round(rand(1,n-m));                 %���������Ϊ(n-m)����Ϣ����
        load G
        %getG();
        c=mod(s*G,2);                         %LDPC����

        waveform=bpsk(c);                     %BPSK����           

        y=waveform+sqrt(sigma_2)*randn(1,n);  %���Ը�˹�������ŵ�

        maxiter=100;                        %������������������maxiter
        [v]=BP1(y,H,sigma_2,maxiter);      %LDPC����(������(SPA1)�Ͷ�������(SPA2)�ĺͻ��㷨,��С���㷨(MSA))

        v0=v(m+1:n);
        Err=Err+length(find(s~=v0));               %Ѱ�Ҵ�����Ϣλ

    end
                %�������������BER
    BER(nEN)= Err/Npf
    if BER(nEN)<1/Npf;
       BER(nEN)=.1/Npf;
    end
end
figure(1);
    semilogy(EbN0db,BER,'go-');
    xlabel('�����/dB')
    ylabel('������')
    grid on
    title('average BER')
    axis([0 6 1/Npf 1])
    legend('LDPC����')
toc
t=toc

















