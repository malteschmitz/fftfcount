function [f, a] = fcount3(y, Fs)
%FCOUNT2 Computes frequency f and amplitude a of the maximal signal
%   Uses the maximum of the fft with an log-parabolic interpolation.
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
    % Compute parabolic interpolation
    left = log(Y(idx - 1));
    center = log(a);
    right = log(Y(idx + 1));
    idx = idx + (right - left) ./ (2 * (2 * center - right - left));
    a = exp(center + ((right - left) .^ 2) ./ ...
        (8 * (2 * center - right - left)));
    
    % Compute the max frequency from max index
    f = Fs * (idx - 1) / NFFT;
end

