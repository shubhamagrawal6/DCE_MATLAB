clc;
clear;
close all;

seq = input("Enter the sequence to encode [3,1,2,4,...]: ");
prob = input("Enter Probabilities [0.1,0.5,0.2,...]: ");
lenseq = length(seq);
numsym = length(prob);
fx = zeros(1,numsym+1);
for i = 2:numsym+1
    fx(i) = fx(i-1) + prob(i-1);
end

l = zeros(1,numsym+1);
u = zeros(1,numsym+1);
u(1) = 1;
fprintf("l(%d): %f || u(%d): %f \n",0,l(i),0,u(i));
for i = 2:lenseq+1
    l(i) = l(i-1) + (u(i-1) - l(i-1))*fx(seq(i-1));
    u(i) = l(i-1) + (u(i-1) - l(i-1))*fx(seq(i-1)+1);
    fprintf("l(%d): %f || u(%d): %f \n",i-1,l(i),i-1,u(i));
end

tag = (l(end) + u(end))/2;
fprintf("The calculated Tag value is: %f \n",tag)

dtag = input("Enter the tag value for decoding: ");
dprob = input("Enter probability of symbols [0.1,0.5,0.2,...]: ");
dlenseq = input("Length of sequence: ");
dnumsym = length(dprob);
dfx = zeros(1,dnumsym+1);
for i = 2:dnumsym+1
    dfx(i) = dfx(i-1) + dprob(i-1);
end
dfx1 = dfx;
dseq = "";
g = 1;
while(1)
    if(strlength(dseq) >= dlenseq)
        break
    elseif(tag < dfx(g))
        init = dfx(g-1);
        fact = dfx(g) - dfx(g-1);
        dseq = strcat(dseq,int2str(g-1));
        for j = 1:dnumsym+1
            dfx(j) = init + dfx1(j)*fact;
        end
        g = 1;
    else
        g = g + 1;
    end
end

fprintf("The decoded sequence is: " + dseq + "\n");
