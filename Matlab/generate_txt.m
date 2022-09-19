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

[signal_double, signal_fp] = get_signal_6(IN_OUT_WORD_LENGTH, IN_OUT_FRACTION_LENGTH, t, fs);

% q = quantizer([IN_OUT_WORD_LENGTH IN_OUT_FRACTION_LENGTH], 'nearest');
q = signal_fp.quantizer;
sig = num2hex(q, signal_double);
sig_str = string(sig);
fileID = fopen('sig6.txt','w');
fprintf(fileID, '%s \n', sig_str);

