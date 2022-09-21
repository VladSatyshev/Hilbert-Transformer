clear all;
close all;

IN_OUT_WORD_LENGTH = 10;
IN_OUT_FRACTION_LENGTH = 6;
IN_OUT_INT_LENGTH = IN_OUT_WORD_LENGTH - IN_OUT_FRACTION_LENGTH;

RUN_SIMULINK = true;
PLOT_RESPONSE = true;
SAVE_RESPONSE_TO_FILE = true;
COMPARE_RESULTS = true;

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

    % sig1: ampl = 2^(-6); freq = fs/2*0.554;
    % sig2: ampl = 2^(-3); freq = fs/2*0.409;
    % sig3: ampl = 2^(-1); freq = fs/2*0.096;
    % sig4: ampl = 2; freq = fs/2*0.15;
    % sig5: ampl = 2^(3)-2^(-6); freq = fs/2*0.941;

    [signal_in_fi, signal_in_double, simin] = get_signal(IN_OUT_WORD_LENGTH, IN_OUT_FRACTION_LENGTH, t, fs, 2^(-3), fs/2*0.409);

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
        legend('output signal', 'FontSize', 24)
        set(gca,'FontSize', 18)
        xlabel('n', 'FontSize', 24)
        ylabel('signal value', 'FontSize', 24)
    end
end


if SAVE_RESPONSE_TO_FILE
    writetable(array2table(double(out)),'simulink_results/results2.txt')
end

if COMPARE_RESULTS
    results_simulink = double(readlines('simulink_results/results2.txt'));
    results_simulink = results_simulink(2:end-1);
    results_verilog = double(readlines('verilog_results/result2.txt'));
    figure
    stem(results_simulink)
    figure
    stem(results_verilog)
    figure
    hold on
    stem(results_simulink)
    stem(results_verilog)
    hold off
    figure
    stem(abs(results_verilog - results_simulink(1:end-1)))
end

