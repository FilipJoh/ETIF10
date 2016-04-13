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
extra=16;
LpFilterHAM=fir1(orderLP+extra,2.25/5);
fvtool(LpFilterHAM)

%% T.9
extraHan=12;
LpFilterHan=fir1(orderLP+extraHan,2.25/5,hann(orderLP+extraHan+1));
fvtool(LpFilterHan)
%%
extraRek=0;
LpFilterHan=fir1(orderLP+extraRek,2.25/5,rectwin(orderLP+extraRek+1));
fvtool(LpFilterHan)

%% T1.10 fir2
extra=0;
f=[0 2.0/5.0 2.5/5.0 1];
a=[1 1 0 0];
LpFilterfreq=fir2(orderLP+extra,f,a);
fvtool(LpFilterfreq)

%% firpm
pmextra=0;
LpFilterPM=firpm(orderLP+pmextra,f,a);
fvtool(LpFilterPM)

