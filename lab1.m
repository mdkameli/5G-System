close all;
clear all;

%%%%%%%%%%%%%%%%%%
%Gusian random variable u = 3, var =0.1

x = randn(1,1000)+1i*randn(1,1000);
m = mean (x);
v = var(x);

y = (x/sqrt(2))+3;
my = mean(y);
vy = var(y);

snr = 10*log(vy / (sum(abs(y).^2)/length(y))); %each element to the power of the 2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compute the BER 
%In general, you can generate N random numbers in the interval (a,b) with the formula r = a + (b-a).*rand(N,1).
N = 1000;
r = randi([0 1],1,N);
dec = zeros(1,N);
dec(r>0) = 1;
dec(r<=0) = -1;
n = randn(1,N);
y = r+n;





