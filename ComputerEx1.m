%% T1.1

wc=0.4*pi;
N=[81 61 41 21];
%N=21;
selector=1;
n=1:N(selector);

h=wc*sin(wc*(n-(N(selector)-1)/2))./(pi.*(n-(N(selector)-1)/2));
h((N(selector)-1)/2)=wc/pi;
figure;
plot(n,h);

[H,w]=freqz(h,1, 'whole');
figure;
plot(w(1:end/2)/2/pi,abs(H(1:end/2)));

%% T1.3
N = 45;
wc=0.4*pi;
n=1:N;
h=-wc*sin(wc*(n-(N-1)/2))./(pi.*(n-(N-1)/2));
h((N-1)/2)=1 - wc/pi;
figure;
plot(n,h);


[H,w]=freqz(h,1, 'whole');
figure;
plot(w(1:end/2)/2/pi,abs(H(1:end/2)));

%% T1.4
orderLP = kaiserord( [2000 2500], [1 0], [0.005 0.005], 10000 )

%% T1.5
orderBP = kaiserord( [1200 1800 3600 4200], [0 1 0], [0.02 0.1 0.02], 12000 )

%% T1.6
orderLPPM = firpmord( [2000 2500], [1 0], [0.005 0.005], 10000 )

%% T1.7
orderSampling = kaiserord( [2000 2500], [1 0], [0.005 0.005], 20000 )
orderRipple = kaiserord( [2000 2500], [1 0], [0.002 0.002], 10000 )
orderEdge = kaiserord( [2300 2500], [1 0], [0.005 0.005], 10000 )
%% T1.8
passbandFreq = 2 / 10;
stopbandFreq = 2.5 / 10;
cutFreq = (passbandFreq + stopbandFreq) / 2;
passRipple = 0.005;
stopRipple = 0.005;
order = orderLP;
while (1)
    LpFilterHAM=fir1(order,cutFreq*2);
    [H,w]=freqz(LpFilterHAM,1,1000, 'whole');
    H = abs(H);
    f = w / 2 / pi;
    if ((max(abs(1 - H(1:201))) < passRipple) && (max(abs(H(251:500))) < stopRipple))
        break        
    else
        order = order + 1;
    end
end
finalorderHamming = order
figure;
plot(f(1:end/2),H(1:end/2),'.');
xlabel('Normalized frequency')
ylabel('Magnitude response')

%% T.9
passbandFreq = 2 / 10;
stopbandFreq = 2.5 / 10;
cutFreq = (passbandFreq + stopbandFreq) / 2;
passRipple = 0.005;
stopRipple = 0.005;
order = orderLP;
while (1)
    LpFilterHAN=fir1(order,cutFreq*2,hann(order+1));
    [H,w]=freqz(LpFilterHAN,1,1000, 'whole');
    H = abs(H);
    f = w / 2 / pi;
    if ((max(abs(1 - H(1:201))) < passRipple) && (max(abs(H(251:500))) < stopRipple))
        break        
    else
        order = order + 1;
    end
end
finalorderHanning = order
figure;
plot(f(1:end/2),H(1:end/2),'.');
xlabel('Normalized frequency')
ylabel('Magnitude response')

%%
passbandFreq = 2 / 10;
stopbandFreq = 2.5 / 10;
cutFreq = (passbandFreq + stopbandFreq) / 2;
passRipple = 0.005;
stopRipple = 0.005;
order = orderLP;
while (1)
    LpFilterREC=fir1(order,cutFreq*2,rectwin(order+1));
    [H,w]=freqz(LpFilterREC,1,1000, 'whole');
    H = abs(H);
    f = w / 2 / pi;
    if ((max(abs(1 - H(1:201))) < passRipple) && (max(abs(H(251:500))) < stopRipple))
        break        
    else
        order = order + 1;
    end
end
finalorderRectangle = order
figure;
plot(f(1:end/2),H(1:end/2),'.');
xlabel('Normalized frequency')
ylabel('Magnitude response')

%% T1.10 fir2
passbandFreq = 2 / 10;
stopbandFreq = 2.5 / 10;
cutFreq = (passbandFreq + stopbandFreq) / 2;
passRipple = 0.005;
stopRipple = 0.005;
fr=[0 cutFreq*2 cutFreq*2 1];
amp=[1 1 0 0];
order = orderLP;
while (1)
    LpFilterFreq=fir2(order,fr,amp);
    [H,w]=freqz(LpFilterFreq,1,1000, 'whole');
    H = abs(H);
    f = w / 2 / pi;
    if ((max(abs(1 - H(1:201))) < passRipple) && (max(abs(H(251:500))) < stopRipple))
        break        
    else
        order = order + 1;
    end
end
finalorder = order
figure;
plot(fr/2, amp, f(1:end/2), H(1:end/2),'.');
lgs = {'Ideal','fir2 default'};
legend(lgs)
xlabel('Normalized frequency')
ylabel('Magnitude response')

%% firpm
passbandFreq = 2 / 10;
stopbandFreq = 2.5 / 10;
cutFreq = (passbandFreq + stopbandFreq) / 2;
passRipple = 0.005;
stopRipple = 0.005;
fr=[0 passbandFreq*2 stopbandFreq*2 1];
amp=[1 1 0 0];
order = orderLPPM;
while (1)
    LpFilterPM=firpm(order,fr,amp);
    [H,w]=freqz(LpFilterPM,1,1000, 'whole');
    H = abs(H);
    f = w / 2 / pi;
    if ((max(abs(1 - H(1:201))) < passRipple) && (max(abs(H(251:500))) < stopRipple))
        break   
    else
        order = order + 1;
    end
end
finalorder = order
figure;
plot(f(1:end/2),H(1:end/2),'o');
xlabel('Normalized frequency')
ylabel('Magnitude response')

%% T1.11

%% Phase Hamming
fvtool(LpFilterHAM);

%% Phase Hanning
fvtool(LpFilterHAN);

%% Phase Rectangle
fvtool(LpFilterREC);

%% Phase frequency sampling
fvtool(LpFilterFreq);

%% Phase PM
fvtool(LpFilterPM);

%% T2.1

[ButtOrd,buttw]=buttord([1.4/3.5 2.1/3.5],[1.05/3.5 2.45/3.5],0.4,50)
[Cheb1Ord,cheb1w]=cheb1ord([1.4/3.5 2.1/3.5],[1.05/3.5 2.45/3.5],0.4,50)
[Cheb2Ord,cheb2w]=cheb2ord([1.4/3.5 2.1/3.5],[1.05/3.5 2.45/3.5],0.4,50)
[EllipOrd,ellipw]=ellipord([1.4/3.5 2.1/3.5],[1.05/3.5 2.45/3.5],0.4,50)

%% T2.2

[B,A]=butter(ButtOrd,buttw);
fvtool(B,A);

[B,A]=cheby1(Cheb1Ord,0.4,cheb1w);
fvtool(B,A);

[B,A]=cheby2(Cheb2Ord,50,cheb2w);
fvtool(B,A);

[B,A]=ellip(EllipOrd,0.4,50,ellipw);
fvtool(B,A);


