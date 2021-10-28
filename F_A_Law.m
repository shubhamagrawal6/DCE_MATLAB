clc;
clear;
close all;

s = input("Enter value: "); 
if (s < 0)
    e = ['1']; 
else 
    e = ['0'];
end

s_abs = abs(s);
s_bin = dec2bin(s_abs,12);
m = 12;

for i = 1: 7
    if ( strcmp('1',( s_bin(i) )))
         m = m - 1;
         break;
    else
        m = m - 1;
    end     
end

scd = m - 4;
sc = dec2bin(scd,3);
e = [e sc];
qc = s_bin(12-m+1:12-m+4);
e = [e qc];
disp("Encoded codeword: ");
disp(e);

e1 = input("Enter codeword for decoding: ");
tx = e;
qc = tx(5:end);
qd = bin2dec(qc);
a = (qd*2) + 33;
sc = tx(2:4);
sd = bin2dec(sc);
b = a * (2^(sd-1));
d = -b;
fprintf("Decoded output: %d\n",d);

qd = d - s;
fprintf("Quant Difference: %d\n",qd)