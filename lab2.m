close all;
clear all;

%%%%%%%OFDM CHANNEL%%%%%%
%% GENERATING SIGNAL
%Generation Data with 16-QAM

N = 1000;                   %Number of regenerating new samples
a = randi(15,N,128);
input_data = qammod(a,16);

% IDFT Block
data_idft = ifft(input_data');
data_idft = data_idft';

% Add CP
x_parallel = data_idft;
x_parallel = [x_parallel data_idft(:,1:22)];

% Parallel to Serial
x = x_parallel';
x = x(:);

%% CHANNEL

M = N*150;
alpha = (1-exp(-1/3))/(1-exp(-22/3));
k = [1:22];
channel_power = alpha*exp(-k/3);
% p = ceil(M/22);                         %Repeatition parameter of the channel
% channel_power = repmat(channel_power,1,p);
% h = randn(1,M)+1i*randn(1,M);
% h =  h.*sqrt(channel_power(1:M));
h = randn(1,22)+1i*randn(1,22);
h =  h.*sqrt(channel_power);
h=[1 0];
%% Convolution
% X = fft([x' zeros(1,length(h)-1)]);
% H = fft([h zeros(1,length(x')-1)]);
% z = ifft(X.*H);

z = conv(x,h);
z_len = length(z);

%% OUTPUT
w = randn(1,z_len)+1i*randn(1,z_len);
y = z + 0*w';

%% Serial to Parallel/Remove CP
y_parallel = reshape(y(1:M), [1000 150]);
y_parallel = y_parallel(:,1:128);
output_data = fft(y_parallel')';

%% Calculation SER
[number,ratio] = symerr(input_data,output_data,'row-wise');

