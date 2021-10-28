clc;
clear;
close all;

ss = input('Enter the probabilities: ');

ss = ss./sum(ss);
ss = sort(ss,'descend');
siling = log2(1/ss(1));
siling = round(siling,1,'significant');
sf = 0;
fano = 0;
n = 1;
Hx = 0;
for i = 1:length(ss)
   Hx = Hx + ss(i)*log2(1/ss(i)); 
end
for k = 1:length(ss)
    info(k) =- (log2(ss(k)));
end
for j = 1:length(ss)-1
   fano = fano+ss(j);
   sf = [sf 0] + [zeros(1,j) fano];
   siling = [siling 0] + [zeros(1,j) ceil(log2(1/ss(j+1)))];
end
for r = 1:length(sf)
    esf = sf(r);
    for p = 1:siling(r)   
        esf = mod(esf,1)*2;
        h(p) = esf-mod(esf,1);      
    end
    hh(r) = h(1)*10^(siling(r)-1);
    for t = 2:siling(r)
        hh(r) = hh(r) + h(t)*10^(siling(r)-t);
    end
end
c = {'0','1'};
disp('Codeword');
for i = 1:length(hh)
    u = 1;                                     
    for t = siling(i):-1:1
        f = floor(hh(i)/10^(t-1));               
        hh(i) = mod(hh(i),10^(t-1));             
        if f == 1
            if u == 1
                d = c{2};                       
            else
                d = [d c{2}];
            end
        else
            if u == 1
                d = c{1};
           else
                d = [d c{1}];
            end
        end
        codex{i,:} = {d};
        u = u+1;
    end
    disp([d])
end
tao = siling(1)*ss(1); 
for u = 1:length(ss)-1 
   tao = tao + siling(u+1)*ss(u+1);
end