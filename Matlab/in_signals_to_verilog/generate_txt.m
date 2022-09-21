clear all;
close all;
% format hex

IN_OUT_WORD_LENGTH = 10;
IN_OUT_FRACTION_LENGTH = 6;
IN_OUT_INT_LENGTH = IN_OUT_WORD_LENGTH - IN_OUT_FRACTION_LENGTH;

N = 500; % number of samples
fs = 1;
dt = 1/fs;
t = [0:dt:dt*N-dt].';
SimTime = max(t);

% sig1: ampl = 2^(-6); freq = fs/2*0.554;
% sig2: ampl = 2^(-3); freq = fs/2*0.409;
% sig3: ampl = 2^(-1); freq = fs/2*0.096;
% sig4: ampl = 2; freq = fs/2*0.15;
% sig5: ampl = 2^(3)-2^(-6); freq = fs/2*0.941;

[signal_double, signal_fp] = get_signal(IN_OUT_WORD_LENGTH, IN_OUT_FRACTION_LENGTH, t, fs, 2^(-3), fs/2*0.409);

% q = quantizer([IN_OUT_WORD_LENGTH IN_OUT_FRACTION_LENGTH], 'nearest');
q = signal_fp.quantizer;
sig = num2hex(q, signal_double);
sig_str = string(sig);
fileID = fopen('sig2.txt','w');
fprintf(fileID, '%s \n', sig_str);

