# ecg-signal-classification-matlab
ECG heartbeat classification using MATLAB, signal processing, feature engineering, and machine learning.

This project implements a machine learning pipeline for classifying ECG heartbeat signals into normal and abnormal classes using MATLAB.

## Project Overview

The system uses signal preprocessing, feature engineering, and machine learning techniques to analyze ECG heartbeat data and improve abnormal beat detection performance.

A real-world ECG dataset (CSV format) containing labeled heartbeat signals was used for training and evaluation.

## Processing Pipeline

Raw ECG → Noise Reduction → Feature Extraction → Normalization → Classification → Evaluation

## Signal Preprocessing

A light moving average smoothing filter was applied to reduce noise while preserving important ECG characteristics such as waveform shape and peaks.

The smoothing window was intentionally kept small to avoid distorting key ECG spikes.

## Extracted Features

### Statistical Features
- Mean
- RMS
- Skewness
- Kurtosis

### Amplitude Features
- Maximum value
- Minimum value
- Range
- Peak value

### Morphological Features
- Peak position
- Width at half peak
- Area under curve
- Positive / negative area

### Frequency Feature
- FFT Energy

## Model Training

Multiple models were trained and evaluated using MATLAB Classification Learner, including:
- KNN
- Decision Trees
- Logistic Regression

The project used:
- 5-fold cross-validation
- 5% held-out test set

Validation accuracy remained close to test accuracy, indicating good generalization and low overfitting.

## Results

- Enhanced model achieved ~96–97% test accuracy
- Improved abnormal heartbeat detection
- Reduced false negatives compared to the baseline model
- Feature engineering significantly improved performance over the baseline feature set

## Feature Importance

Feature importance analysis showed that:
- Peak amplitude was the most influential feature
- Skewness and minimum value also contributed significantly to classification performance

## Sample Outputs

### Baseline Model
![Baseline Model](images%20folder/BaselineModel.jpeg)

### Enhanced Model
![Enhanced Model](images%20folder/EnhancedModel.jpeg)

### ECG Signal Preprocessing
![ECG Plot](images%20folder/RawVsSmoothed.jpeg)

### Feature Importance
![Feature Importance](images%20folder/ImportanceAnalysis.jpeg)

Independent (self-initiated) project focused on applying signal processing and machine learning techniques to biomedical data.
