% ***** was used previously to generate 510 signals for Simulink *****

function in = get_signals(IN_OUT_WORD_LENGTH,IN_OUT_FRACTION_LENGTH, N, t, fs)

    amp = [2^(-6), 2^(-5), 2^(-4), 2^(-3), 2^(-2), 2^(-1), 2^(0), 2^(1), 2^(2), 2^(3)-2^(-6)];
%     amp = [2^(-7), 2^(-6), 2^(-5), 2^(-4), 2^(-3), 2^(-2), 2^(-1), 2^(0), 2^(1), 2^(2), 2^(3)-2^(-7)];
%     amp = [2^(-6)];
    freq = fs/2*[0.052, 0.059, 0.081, 0.096, 0.16, 0.176, 0.194, 0.212, 0.23, 0.247, 0.265, 0.283, 0.301, 0.319, 0.337, 0.355, 0.373, 0.391, 0.409, 0.428, 0.446, 0.464, 0.481, 0.501, 0.519, 0.537, 0.554, 0.573, 0.591, 0.608, 0.627, 0.645, 0.663, 0.682, 0.7, 0.718, 0.735, 0.754, 0.77, 0.788, 0.806, 0.823, 0.84, 0.857, 0.873, 0.89, 0.905, 0.919, 0.931, 0.941, 0.948];

    % allocate 2d array for signals
    signals = zeros(N, length(amp)*length(freq));
    
    column = 0;
    for i=1:length(amp)
        for j=1:length(freq)
            column = column + 1;
            signals(:, column) = double(fi(amp(i)*sin(2*pi*freq(j)*t), true, IN_OUT_WORD_LENGTH, IN_OUT_FRACTION_LENGTH));
        end
    end 
    in = cat(2, t, signals);
end


