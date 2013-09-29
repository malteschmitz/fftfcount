function fftexample
    close all;

    % Sampling frequency
    Fs = 1000;
    % Sample time
    T = 1 / Fs;
    % Length of signal
    L = 1000;
    % Time vector
    t = (0:L - 1) * T;
    % Sum of a 50 Hz sinusoid and a 120 Hz sinusoid
    x = 0.7 * sin(2 * pi * 50 * t) + sin(2 * pi * 120 * t); 
    % Sinusoids plus noise
    y = x + 2 * randn(size(t));
    
    % Plot the first 50 ms of the signal
    plot(Fs*t(1:50),y(1:50));
    title('Signal Corrupted with Zero-Mean Random Noise');
    xlabel('time (milliseconds)');
    timesPlot;

    % Next power of 2 from length of y
    NFFT = 2 .^ nextpow2(L); 
    
    % Apply gaussian window
    yw = 2 * y .* gausswin(L)';
    
    % Apply FFT and normalize output to 1
    Y = fft(yw, NFFT) / L;

    % Compute frequency range
    f = linspace(-Fs / 2, Fs / 2, NFFT);
    
    % Compute amplitude spectrum -Fs/2..Fs/2
    % from spectrum 0..Fs/2
    Yr = zeros(size(Y));
    Yr(1:NFFT/2) = abs(Y(NFFT/2+1:end));
    Yr(NFFT/2+1:end) = abs(Y(1:NFFT/2));
    
    % Plot amplitude spectrum
    figure;
    plot(f, Yr);
    title('Amplitude Spectrum of y(t)');
    xlabel('Frequency (Hz)');
    ylabel('|Y(f)|');
    timesPlot;
    
    % Compute single-sided frequency range
    f = linspace(0, Fs / 2, NFFT / 2 + 1);
    
    % Compute single-sided amplitude spectrum
    Yr = 2 * abs(Y(1:NFFT / 2 + 1));
    
    % Plot single-sided amplitude spectrum
    figure;
    plot(f, Yr);
    title('Single-Sided Amplitude Spectrum of y(t)');
    xlabel('Frequency (Hz)');
    ylabel('|Y(f)|');
    timesPlot;
end