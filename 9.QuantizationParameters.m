clc;
clear;
close all;

n = input("Enter bit rate: ");
v = input("Enter voltage range: ");
l = 2^n;
fprintf("No of Quantization levels L: %d\n",l)

del = (v(2)-v(1))/l;
fprintf("Step size: %f\n",del)

x = input("Enter particular Voltage: ");
I = round((x-v(1))/del);
fprintf("I= %f\n",I)

xq = v(1)+del*I;
fprintf("Quantization Level xq: %f\n",xq)

e = xq-x;
fprintf("Quantization Error e: %f\n",e)

dr = 6.02*n;
fprintf("Dynamic Range: %f dB\n",dr)

SNR = 6.02*n+1.76;
fprintf("Signal to Noise Ratio (SNR): %f dB\n",SNR)