clc;
clear;
close all;

data = input("Enter String to be encrypted: "); %"ATTACK AT DAWN"
k = input("Enter k value: ");
data = double(char(data));
for i = 1:1:length(data)
    if(data(i) == 32)
        continue;
    end
    if(data(i) <= 90-k)
        data(i) = data(i)+k;
    else
        data(i) = data(i)-26+k;
    end
end
final = char(data);
disp("Encrypted Code: ");
disp(final);

data = input("Enter String to be decrypted: "); 
k = input("Enter k value: ");
data = double(char(data));
for i = 1:1:length(data)
    if(data(i) == 32)
        continue;
    end
    if(data(i) >= 65+k)
        data(i) = data(i)-k;
    else
        data(i) = data(i)+26-k;
    end
end
final = char(data);
disp("Decrypted Code:");
disp(final);