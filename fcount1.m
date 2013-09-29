function [f, a] = fcount1(y, Fs)
%FCOUNT1 Computes frequency f and amplitude a of the maximal signal
%   Uses the maximum of the fft without interpolation or optimization.
%   x - the input signal
%   Fs - sampling frequency of the input signal

    % Length of signal
    L = length(y);
    % Next power of 2 from length of y
    NFFT = 2 .^ nextpow2(L);
    % Apply gaussian window function to input signal
    y = 2 * gausswin(L)' .* y;
    % Compute FFT and normalize the amplitude to 1
    Y = fft(y, NFFT) / L;
    % Translate Y into single-sided amplitude spectrum
    Y = 2 * abs(Y(1:NFFT / 2 + 1));
    
    % Get the maximum in the spectrum
    [a, idx] = max(Y);
    % Compute the max frequency from max index
    f = Fs * (idx - 1) / NFFT;
end

