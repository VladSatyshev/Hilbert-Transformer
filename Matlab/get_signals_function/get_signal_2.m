function [signal_double, signal_fp] = get_signal_2(IN_OUT_WORD_LENGTH, IN_OUT_FRACTION_LENGTH, t, fs)

    amp = 2^(2);

    freq = fs/2*0.301;

    signal_fp = fi(amp*sin(2*pi*freq*t), true, IN_OUT_WORD_LENGTH, IN_OUT_FRACTION_LENGTH);

    signal_double = double(signal_fp);

end


