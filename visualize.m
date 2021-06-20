load("result_total_16qam_largesnr.mat");


stem(dataIn(1:40),'filled');
title('Random Bits');
xlabel('Bit Index');
ylabel('Binary Value');

figure; % Create new figure window.
stem(dataSymbolsIn(1:10));
title('Random Symbols');
xlabel('Symbol Index');
ylabel('Integer Value');




figure;
  semilogy(snr,errRates_bin_awgn,snr,errRates_gray_awgn);
  legend('Bin', 'Gray');
  xlabel('SNR (dB)');
  ylabel('BER');
  
 saveas(gcf, 'result_1.png')


 figure; 
 semilogy(snr,errRates_bin_rel,snr,errRates_gray_rel);
  legend('Bin', 'Gray');
  xlabel('SNR (dB)');
  ylabel('BER');
  
 saveas(gcf, 'result_2.png')

figure;
  semilogy(snr,errRates_bin_awgn,snr,errRates_bin_rel);
  legend('AWGN', 'Rayleigh Fading');
  xlabel('SNR (dB)');
  ylabel('BER');
  
 saveas(gcf, 'result_3.png')


 figure; 
 semilogy(snr,errRates_gray_awgn,snr,errRates_gray_rel);
  legend('AWGN', 'Rayleigh Fading');
  xlabel('SNR (dB)');
  ylabel('BER');
  
 saveas(gcf, 'result_4.png')