clc;
clear;
close all;

p = input('Enter the prime no. for p: ');
q = input('Enter the prime no. for q: ');
n = p*q;
phi = (p-1)*(q-1);

e = 2;
while(mod(phi,e) == 0)
    e = e+1;
end

d = 0;
val1 = 0;
while(val1 ~= 1)
    d = d+1;
    val1 = mod(d*e,phi);
end

fprintf('\nPublic key is %d',e);
fprintf('\nPrivate key is %d',d);

m = input('\n\nEnter plain text: ');
ct = mod(m^e,n);
fprintf('Cipher Text is: %d',ct);

ct = input('\n\nEnter Cipher text: ');
pt = mod(ct^d,n);
fprintf('Plain Text is: %d\n',pt);