clc; clear; close all;

data = readmatrix("ecg.csv");

signals = data(:,1:end-1);
labels = data(:,end);
labels = categorical(labels,[0 1],["Normal","Abnormal"]);

exampleIndex = 1;

rawExample = signals(exampleIndex,:);
smoothExample = movmean(rawExample,5);

figure;           % plotting raw vs smoothed signal
plot(rawExample); 
hold on;
plot(smoothExample,"LineWidth",1.5);
xlabel("Sample");
ylabel("Amplitude");
title("Raw vs Smoothed ECG Beat");
legend("Raw ECG","Smoothed ECG");
grid on;

numSamples = size(signals,1);

meanVal     = zeros(numSamples,1); % basic extracted features used in the baseline model
maxVal      = zeros(numSamples,1);
minVal      = zeros(numSamples,1);
rangeVal    = zeros(numSamples,1);

rmsVal      = zeros(numSamples,1);  % additional extracted features used in the enhanced model
skewVal     = zeros(numSamples,1);
kurtVal     = zeros(numSamples,1);
fftEnergy   = zeros(numSamples,1);
peakVal     = zeros(numSamples,1);
peakPos     = zeros(numSamples,1);
areaVal     = zeros(numSamples,1);
posAreaVal  = zeros(numSamples,1);
negAreaVal  = zeros(numSamples,1);
widthVal    = zeros(numSamples,1);

for i = 1:numSamples                 % extracting features
    sig = signals(i,:);
    
    sigSmooth = movmean(sig,5);

    meanVal(i)   = mean(sigSmooth);
    maxVal(i)    = max(sigSmooth);
    minVal(i)    = min(sigSmooth);
    rangeVal(i)  = max(sigSmooth) - min(sigSmooth);
    rmsVal(i)    = rms(sigSmooth);
    skewVal(i)   = skewness(sigSmooth);
    kurtVal(i)   = kurtosis(sigSmooth);

    fftVals = abs(fft(sigSmooth));
    fftEnergy(i) = sum(fftVals.^2);

    [peakVal(i), peakPos(i)] = max(sigSmooth);

    areaVal(i) = trapz(abs(sigSmooth));

    posAreaVal(i) = trapz(max(sigSmooth,0));
    negAreaVal(i) = trapz(abs(min(sigSmooth,0)));

    halfPeak = 0.5 * peakVal(i);
    widthVal(i) = sum(sigSmooth > halfPeak);
end

X = [meanVal, maxVal, minVal, rangeVal, rmsVal, skewVal, kurtVal, fftEnergy, ...
     peakVal, peakPos, areaVal, posAreaVal, negAreaVal, widthVal];

X = normalize(X);

featureTable = array2table(X, ...
    "VariableNames", ["meanVal","maxVal","minVal","rangeVal","rmsVal","skewVal","kurtVal","fftEnergy", ...
                      "peakVal","peakPos","areaVal","posAreaVal","negAreaVal","widthVal"]);

featureTable.labels = labels;