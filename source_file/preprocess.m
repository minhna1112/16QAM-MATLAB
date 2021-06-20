dataIn = randi([0 1],n,1); % Generate vector of binary data
dataInMatrix = reshape(dataIn,length(dataIn)/k,k);
dataSymbolsIn = bi2de(dataInMatrix);