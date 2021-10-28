%Testing ["l","m","n","o","p"] , [0.4,0.2,0.2,0.1,0.1]
clc;
clear all;
close all;

%Take Inputs 
sym = input("Enter the symbols ['x','y','z',...]: ");
prob = input("Enter the Probabilities [0.4,0.2,0.3,...]: ");
lensym = length(sym);
lenprob = length(prob);

%Check Inputs
if lensym ~= lenprob
    disp("Wrong entry...Terminating");
    quit;
end

%Arrange probabilities in descending order
for m=1:lenprob
    for n=1:lenprob
        if(prob(m)>prob(n))
            a=prob(n); 
            prob(n)=prob(m);
            prob(m)=a; 
            a1=sym(n);
            sym(n)=sym(m);
            sym(m)=a1;
        end
    end
end
dispsym = sym;

%Huffman encoding
sum = 0;
codes = strings([1,lensym]);
codemap = containers.Map(sym,codes);
while(sum < 1)
    sum = prob(lenprob) + prob(lenprob-1) + 0.0001;
    sumsym = strcat(sym(lensym-1),sym(lensym));
    sym1len = strlength(sym(lensym-1));
    sym1 = char(sym(lensym-1));
    for itr = 1:sym1len
        codemap(string(sym1(itr))) = strcat(codemap(string(sym1(itr))),"0");
    end 
    sym2len = strlength(sym(lensym));
    sym2 = char(sym(lensym));
    for itr = 1:sym2len
        codemap(string(sym2(itr))) = strcat(codemap(string(sym2(itr))),"1");
    end
    prob(lenprob-1) = sum;
    sym(lensym-1) = sumsym;
    prob(end) = [];
    sym(end) = [];
    lenprob = length(prob);
    lensym = length(sym);
    for m=1:lenprob
        for n=1:lenprob
            if(prob(m)>prob(n))
                a=prob(n); 
                prob(n)=prob(m);
                prob(m)=a; 
                a1=sym(n);
                sym(n)=sym(m);
                sym(m)=a1;
            end
        end
    end
end

%Displaying the codes
vals = values(codemap);
for i = 1:length(dispsym)
    disp(dispsym(i))
    disp(reverse(vals(i)))
end
