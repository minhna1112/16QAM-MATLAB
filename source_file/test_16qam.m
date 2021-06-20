M = 16; % Modulation order (alphabet size or number of points in signal constellation)
k = log2(M); % Number of bits per symbol
n = 30000; % Number of bits to process
sps = 1; % Number of samples p er symbol (oversampling factor)


% 
rng default;
dataIn = randi([0 1],n,1); % Generate vector of binary data

stem(dataIn(1:40),'filled');
title('Random Bits');
xlabel('Bit Index');
ylabel('Binary Value');

dataInMatrix = reshape(dataIn,length(dataIn)/k,k);
dataSymbolsIn = bi2de(dataInMatrix);

figure; % Create new figure window.
stem(dataSymbolsIn(1:10));
title('Random Symbols');
xlabel('Symbol Index');
ylabel('Integer Value');

%16 qam
dataMod = qammod(dataSymbolsIn,M,'bin'); % Binary coding with phase offset of zero
dataModG = qammod(dataSymbolsIn,M); % Gray coding with phase offset of zero

EbNo = 10;
%snr = EbNo+10*log10(k)-10*log10(sps);
snr = [11, 12, 13, 14, 15, 16 ,17, 18, 19, 20, 21, 22];


errRates_bin_awgn = zeros(1, length(snr));
errRates_gray_awgn = zeros(1, length(snr));
errRates_bin_rel = zeros(1, length(snr));
errRates_gray_rel = zeros(1, length(snr));

for ii = 1:length(snr)
    %channels
    rlchannel = comm.RayleighChannel("FadingTechnique","Filtered Gaussian noise");
    receivedSignal = awgn(dataMod,snr(ii),'measured');
    receivedSignalG = awgn(dataModG,snr(ii),'measured');
    receiveSignalRel = rlchannel(dataMod);
    receiveSignalRelG = rlchannel(dataModG);
    
    %Demodulation
    dataSymbolsOut = qamdemod(receivedSignal,M,'bin');
    dataSymbolsOutG = qamdemod(receivedSignalG,M);
    dataSymbolsOutRel = qamdemod(receiveSignalRel, M);
    dataSymbolsOutRelG = qamdemod(receiveSignalRelG, M);
    
    
    %1st output
    dataOutMatrix = de2bi(dataSymbolsOut,k);
    dataOut = dataOutMatrix(:); % Return data in column vector
    %2nd output
    dataOutMatrixG = de2bi(dataSymbolsOutG,k);
    dataOutG = dataOutMatrixG(:); % Return data in column vector
    %3rd output
    dataOutMatrixRel = de2bi(dataSymbolsOutRel, k);
    dataOutRel = dataOutMatrixRel(:);
    %4th output
    dataOutMatrixRelG = de2bi(dataSymbolsOutRelG, k);
    dataOutRelG = dataOutMatrixRelG(:);
    
    %Calculate BER
    [numErrors,ber] = biterr(dataIn,dataOut);
    fprintf('\nThe binary coding bit error rate is %5.2e, based on %d errors.\n', ...
        ber,numErrors);
    errRates_bin_awgn(ii) = ber;
    
    [numErrorsG,berG] = biterr(dataIn,dataOutG);
    fprintf('\nThe Gray coding bit error rate is %5.2e, based on %d errors.\n', ...
        berG,numErrorsG);
    errRates_gray_awgn(ii) = berG;
    
    [numErrorsRel,berRel] = biterr(dataIn,dataOutRel);
    fprintf('\nThe binary coding bit error ratevia RL fadingis %5.2e, based on %d errors.\n', ...
        berRel,numErrorsRel);
    errRates_bin_rel(ii) = berRel;
    
    [numErrorsRelG,berRelG] = biterr(dataIn,dataOutRelG);
    fprintf('\nThe Gray bit error rate via RL fading is %5.2e, based on %d errors.\n', ...
        berRelG,numErrorsRelG);
    errRates_gray_rel(ii) = berRelG;
end

save('result_total_16qam_largesnr.mat', "errRates_gray_rel", "errRates_bin_rel", "errRates_gray_awgn", "errRates_bin_awgn", 'snr');