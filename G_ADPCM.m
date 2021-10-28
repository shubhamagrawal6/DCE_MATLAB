%[2.1,2.2,2.3,2.6,2.7,2.8] 
%['10','00','00','01','00','00']
clc;
clear
close all;

xn = input("Enter Sequence for encoding [1.1,1.2,1.3,....]: "); 
n = length(xn);
x_cap = zeros(n);
en = zeros(n);
eqn = zeros(n);
xq = zeros(n);

for i = 1:1:n
    en(i) = xn(i) - x_cap(i);
    eqn(i) = round(en(i));
    xq(i) = x_cap(i) + eqn(i);
    x_cap(i+1) = xq(i);
end

x_cap = x_cap(:,1)';
en = en(:,1)';
eqn = eqn(:,1)';
xq = xq(:,1)';
bin = dec2bin(eqn);

disp("Input Sequence x(n):")
disp(xn)
disp("x_cap(n):")
disp(x_cap)
disp("e(n):")
disp(en)
disp("xq(n):")
disp(xq)
disp("Transmitted Sequence eq(n):")
disp(eqn)
disp("Binary form:")
disp(bin)

op = input("Enter Binary Sequence for decoding ['10','00','00',......]: "); 
op = bin;
eqo = bin2dec(op);
n = length(op);
x_capo = zeros(n);
xqo = zeros(n);

for i = 1:1:n
    xqo(i) = x_capo(i) + eqo(i);
    x_capo(i+1) = xqo(i);
end

x_capo = x_capo(:,1)';
xqo = xqo(:,1)';

disp("Decoding x_cap(n):")
disp(x_capo)
disp("Decoded Output:")
disp(xqo)