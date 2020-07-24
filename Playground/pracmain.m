clc; clear; close all;

samsaek = imread('samsaek.tif');
angrysamsaek = imread('angrysamsaek.tif');

length= size(samsaek);
newsamsaek = reshape(samsaek, [length(2:end) 1]);

file = samsaek;
whos file
imhist(rgb2gray(file))

g = intrans(file, 'stretch', mean2(tofloat(file)), 0.9);
 
imadjust(file)
intrans((file), 'neg');
imshow(samsaek);
imshow(angrysamsaek);

%%
clc; clear; close all;

for index = 1:4
    if index==1
        Input = imread('Fig1_1.tif');
    elseif index==2
        Input = imread('Fig1_2.tif');
    elseif index==3
        Input = imread('Fig1_3.tif');
    else
        Input = imread('Fig1_4.tif');
    end
    subplot(4, 4, 4*(index-1)+1), imshow(uint8(Input));
    title('Input Image');
end



%%
close all;
clc;

for index = 1:4
    if index==1
        Input = imread('Fig1_1.tif');
    elseif index==2
        Input = imread('Fig1_2.tif');
    elseif index==3
        Input = imread('Fig1_3.tif');
    else
        Input = imread('Fig1_4.tif');
    end
        
    subplot(4,4,4*(index-1)+1), imshow(uint8(Input)); title('Input Image');
    
    [h,w] = size(Input);
    
    %Input_histogram
    Input_histogram = zeros(1,256);
    for x = 1:h
        for y = 1:w
            Input_histogram(Input(x, y) + 1) = Input_histogram(Input(x, y) + 1) + 1;
        end
    end
    subplot(4,4,4*(index-1)+2);
    bar(Input_histogram);
    title('Input_histogram');
    grid on;
    
    %Normalized_histogram
    Accum = zeros(1,256);
    Normalized_histogram = zeros(1,256);
    total = h * w;
    
    for m = 1:256
        if m == 1
            Accum(m) = Input_histogram(m) / total * 255;
        else
            Accum(m) = Accum(m-1) + Input_histogram(m) / total * 255;
        end
        Normalized_histogram(m) = round(Accum(m));
    end
    
    Output = zeros(h,w);
    for x = 1:h
        for y = 1:w
            Output(x, y) = Normalized_histogram(Input(x,y) + 1); 
        end
    end
    
    subplot(4,4,4*(index-1)+3); imshow(uint8(Output));
    title('Equalization Image');
    grid on;
    
    %Equalization_histogram
    Equalization_histogram = zeros(1,256);
    
    for x = 1:h
        for y = 1:w
            Equalization_histogram(Output(x, y) + 1) = Equalization_histogram(Output(x, y) + 1) + 1;
        end
    end
    
    %figure(index);
    subplot(4,4,4*(index-1)+4);
    bar(Equalization_histogram);
    title('Histogram_Equalization');
    grid on;
end