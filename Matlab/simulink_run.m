clear all;
close all;

IN_OUT_WORD_LENGTH = 10;
IN_OUT_FRACTION_LENGTH = 6;
IN_OUT_INT_LENGTH = IN_OUT_WORD_LENGTH - IN_OUT_FRACTION_LENGTH;

RUN_SIMULINK = true;
PLOT_RESPONSE = true;


hFilt = designfilt('hilbertfir', 'FilterOrder', 54, 'TransitionWidth', 0.1);

h = hFilt.Coefficients;
h_fi = fi(h, true, 14, 13);


if RUN_SIMULINK
    
    % Simulink parameters   
    N = 500; % number of samples
    fs = 1;
    dt = 1/fs;
    t = [0:dt:dt*N-dt].';
    SimTime = max(t);
    
%   simin = get_signals(IN_OUT_WORD_LENGTH, IN_OUT_FRACTION_LENGTH, N, t, fs);

    [signal_in_fi, signal_in_double, simin] = get_signal(IN_OUT_WORD_LENGTH, IN_OUT_FRACTION_LENGTH, t, fs, 2^(-1), fs/2*0.096);

    s = sim('gm_HilbertTransformer_v2', SimTime); 

    in = s.get('in');
    out = s.get('out');



    if PLOT_RESPONSE
        figure
        tiledlayout(2,1);
        nexttile
        stem(in)
        legend('input signal', 'FontSize', 24)
        set(gca,'FontSize', 18)
        xlabel('n', 'FontSize', 24)
        ylabel('signal value', 'FontSize', 24)
        nexttile
        stem(out)
        legend('output signal ideal', 'FontSize', 24)
        set(gca,'FontSize', 18)
        xlabel('n', 'FontSize', 24)
        ylabel('signal value', 'FontSize', 24)
    end
end

