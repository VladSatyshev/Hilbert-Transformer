function [signal_double, signal_fp, simin] = get_signal(IN_OUT_WORD_LENGTH, IN_OUT_FRACTION_LENGTH, t, fs, amp, freq)

%     amp = 2^(-1);
% 
%     freq = fs/2*0.096;

    signal_fp = fi(amp*sin(2*pi*freq*t), true, IN_OUT_WORD_LENGTH, IN_OUT_FRACTION_LENGTH);

    signal_double = double(signal_fp);

    simin = cat(2, t, signal_double);

end


