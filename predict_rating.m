x = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
% x = ones(5,1);  % Normalized white Gaussian noise
% noise = matrix(1, 3, [1, 2, 3]); 
% x = filter(1,[1 1/2 1/3 1/4],noise);
% x = x(45904:50000);

a = lpc(x,3);
est_x = filter([0 -a(2:end)],1,x);    % Estimated signal
e = x - est_x;                        % Prediction error
[acs,lags] = xcorr(e,'coeff');        % ACS of prediction error

disp(x);
disp(a);
disp(est_x);
disp(e);

% plot(1:97,x(4001:4097),1:97,est_x(4001:4097),'--');
% title('Original Signal vs. LPC Estimate');
% xlabel('Sample Number'); ylabel('Amplitude'); grid;
% legend('Original Signal','LPC Estimate')

% plot(lags,acs); 
% title('Autocorrelation of the Prediction Error');
% xlabel('Lags'); ylabel('Normalized Value'); grid;
