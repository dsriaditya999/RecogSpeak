function melfb = make_melFB(num_filters,fs,N)

% A function that creates Mel Filter Bank, with number of filters
% (num_filters) specified

f_start = 300; % Start Frequency
f_stop = 7000; % Stop Frequency
g = 1; % Highest Gain of Mel Filters

f_temp_mel = convert2mel([f_start,f_stop]);

f_mel = linspace(f_temp_mel(1),f_temp_mel(2),num_filters+2); % Equi-Spaced Mel Frequency array

f_array = convert2f(f_mel); % Convert to Corresponding Normal Frequencies

f_approx_sample_array = floor(f_array*(floor(N/2)+1)/fs); % Approximating into available FFT bins

melfb = zeros(num_filters,1+floor(N/2));

for m = 2:num_filters+1
    
    melfb(m-1,1:f_approx_sample_array(m-1)-1) = 0;
    for k = f_approx_sample_array(m-1):f_approx_sample_array(m)
        melfb(m-1,k) = g*(k-f_approx_sample_array(m-1))/(f_approx_sample_array(m)-f_approx_sample_array(m-1));
    end
    for k = f_approx_sample_array(m):f_approx_sample_array(m+1)
        melfb(m-1,k) = g*(f_approx_sample_array(m+1)-k)/(f_approx_sample_array(m+1)-f_approx_sample_array(m));
    end
    
    melfb(m-1,f_approx_sample_array(m+1)+1:end) = 0;
    
end

