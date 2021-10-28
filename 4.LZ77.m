clc
clear
close all

x = input('String to be encoded : ', 's');
w = input('Window size : ');

phrases = {x(1)};
encode = [strcat("(0,",x(1),")")];
str = '';
flag = 0;
i=2;
while(i<=strlength(x))
    indicies = [];
    k = i - w;
    j_reverse = w;
    if (k < 1)
        j_reverse = j_reverse + k - 1;
        k = 1;
    end
    p = i;
    str = '';
    for j = k:i-1
       if(x(p) == x(j))
           flag = 1;
           [str1, new] = parsing(x, p, j);
           if(strlength(str1) > strlength(str))
                str = str1;
                i = new;
                start_at = j_reverse;
           end
       end
       j_reverse = j_reverse - 1;
    end
    if(flag==0)
        phrases = [phrases, x(i)];
        encode = [encode, strcat("(0,",x(i),")")];        
        i = i+1;
        continue
    end
    encode = [encode, strcat("(1,",string(start_at),",",string(strlength(str)),")")];
    phrases = [phrases, str];
    flag = 0;
end
disp("String Parsing : ")
disp(phrases)

disp("Encoding : ")
disp(encode)

x1 = input('Enter encodings : ', 's');
x1 = string(strsplit(x1, ' '));
lz_decode(x);

function [phraseString, new_i] = parsing(x, i, j)
    str = '';
    while(x(i) == x(j))
        str = strcat(str, x(i));
        i = i + 1;
        j = j + 1;
        if(i > strlength(x) || j > strlength(x)) 
            break
        end
    end
    phraseString = str;
    new_i = i;
end

function decode_string = lz_decode(encode)
    decode = [];
    decode_string = '';
    for i = 1:length(encode)
        split = strsplit(encode(i), ',');
        if(length(split)==3)
            split1 = strsplit(split(1), '(');
            split3 = strsplit(split(3), ')');
            split2 = double(split(2));
            
            for j = length(decode) + 1 - split2:length(decode) + 1 - split2 + double(split3(1)) - 1
                decode = [decode, decode(j)];
                decode_string = decode_string + decode(j);
            end
        else
            split2 = strsplit(split(2), ')');
            split1 = strsplit(split(1), '(');
            
            decode = [decode, split2(1)];
            decode_string = decode_string + split2(1);
        end
    end

    disp("Decoding : ");
    disp(decode_string);
end