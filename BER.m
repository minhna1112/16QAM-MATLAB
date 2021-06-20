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