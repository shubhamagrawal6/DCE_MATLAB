clc;
clear;
close all;

str = input("Enter String ('/WED/WE/WEE/WEB/WET'): ");

[packed,table]=norm2lzw(uint8(str));

[unpacked,table]=lzw2norm(packed);

unpacked = char(unpacked);

isOK = strcmp(str,unpacked)

strvcat(table{257:end})

function [output,table] = lzw2norm(vector)
    if ~isa(vector,'uint16'),
        error('input argument must be a uint16 vector')
    end
    vector = vector(:)';
    table = cell(1,256);
    for index = 1:256,
        table{index} = uint16(index-1);
    end
    output = uint8([]);
    code = vector(1);
    output(end+1) = code;
    character = code;
    for index=2:length(vector),
        element = vector(index);
        if (double(element)+1)>length(table),
            string = table{double(code)+1};
            string = [string character];
        else,
            string = table{double(element)+1};
        end
        output = [output string];
        character = string(1);
        [table,code] = addcode(table,[table{double(code)+1} character]);
        code = element;
    end
end

function code = getcodefor(substr,table)
    code = uint16([]);
    if length(substr)==1,
        code = substr;
    else, 
        for index=257:length(table),
            if isequal(substr,table{index}),
                code = uint16(index-1);   
                break
            end
        end
    end
end

function [table,code] = addcode(table,substr)
    code = length(table)+1;   
    table{code} = substr;
    code = uint16(code-1);    
end

function [output,table] = norm2lzw(vector)
    if ~isa(vector,'uint8'),
        error('input argument must be a uint8 vector')
    end
    vector = uint16(vector(:)');
    table = cell(1,256);
    for index = 1:256,
        table{index} = uint16(index-1);
    end
    output = vector;
    outputindex = 1;
    startindex = 1;
    for index=2:length(vector),
        element = vector(index);
        substr = vector(startindex:(index-1));
        code = getcodefor2([substr element],table);
        if isempty(code),
            output(outputindex) = getcodefor2(substr,table);
            [table,code] = addcode2(table,[substr element]);
            outputindex = outputindex+1;
            startindex = index;
        else,
        end
    end
    substr = vector(startindex:index);
    output(outputindex) = getcodefor2(substr,table);
    output((outputindex+1):end) = [];
end

function code = getcodefor2(substr,table)
    code = uint16([]);
    if length(substr)==1,
        code = substr;
    else, 
        for index=257:length(table),
            if isequal(substr,table{index}),
                code = uint16(index-1);   
                break
            end
        end
    end
end

function [table,code] = addcode2(table,substr)
    code = length(table)+1;   
    table{code} = substr;
    code = uint16(code-1);    
end