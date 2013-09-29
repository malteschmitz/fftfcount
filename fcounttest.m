function fcounttest
    close all;
    
    % Sampling frequency
    Fs = 1000;
    % Sample time
    T = 1/Fs;
    % Length of signal
    L = 1000;
    % Time vector
    t = (0:L-1)*T;

    fin = linspace(119, 121, 100);
    fout1 = zeros(size(fin));
    aout1 = zeros(size(fin));
    fout2 = zeros(size(fin));
    aout2 = zeros(size(fin));
    fout3 = zeros(size(fin));
    aout3 = zeros(size(fin));

    for i = 1:length(fin)
        % Create a 50 Hz sinusoid
        % y = 0.5*sin(2*pi*50*t);
        y = zeros(size(t));
        % Add a fin(i) Hz sinusoid
        y = y + sin(2*pi*fin(i)*t); 
        % Add random noise
        % y = y + randn(size(t));
        [f,a] = fcount1(y, Fs);
        fout1(i) = f;
        aout1(i) = a;
        [f,a] = fcount2(y, Fs);
        fout2(i) = f;
        aout2(i) = a;
        [f,a] = fcount3(y, Fs);
        fout3(i) = f;
        aout3(i) = a;
    end
    
    % Plot estimated frequencies
    figure;
    plot(fin, fin, 'b');
    hold on;
    plot(fin, fout1, 'b');
    plot(fin, fout2, 'g');
    plot(fin, fout3, 'm');
    hold off;
    
    title('Frequency Counting with FFT Interolation');
    xlabel('Input Frequency (Hz)');
    ylabel('Detected Frequency (Hz)');
    legend('Input Frequency', ...
        'max FFT without interpolation', ...
        'max FFT with parabolic interpolation', ...
        'max FFT with log-parabolic interpolation', ...
        'Location', 'NorthWest');
    timesPlot;
    
    % Plot estimated amplitudes
    figure;
    plot(fin, ones(size(fin)), 'b');
    hold on;
    plot(fin, aout1, 'b');
    plot(fin, aout2, 'g');
    plot(fin, aout3, 'm');
    hold off;
    
    title('Amplitude Measuring with FFT Interolation');
    xlabel('Input Frequency (Hz)');
    ylabel('Detected Amplitude');
    legend('Input Amplitude', ...
        'max FFT without interpolation', ...
        'max FFT with parabolic interpolation', ...
        'max FFT with log-parabolic interpolation', ...
        'Location', 'NorthWest');
    axis([119 121 0.8 1.1]);
    timesPlot;
end


