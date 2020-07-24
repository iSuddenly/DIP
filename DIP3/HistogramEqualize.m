%----------------------------------------------------------
% Function to read given image and implement histogram equalization
% Input : Img path string
% Effect : Show original & equalized img and plot intensity 
%----------------------------------------------------------

function [] = HistogramEqualize(imgPath)

inputImg = imread(imgPath); %Input img

[h,w] = size(inputImg);
input = zeros(1,256); %Input img intensity vector
for x = 1:h
    for y = 1:w
        input(inputImg(x, y) + 1) = input(inputImg(x, y) + 1) + 1;
    end
end

acc = zeros(1,256);
normalized = zeros(1,256);
total = h * w;

for m = 1:256
    if m == 1
        acc(m) = input(m) / total * 255;
    else
        acc(m) = acc(m-1) + input(m) / total * 255;
    end
    normalized(m) = round(acc(m));
end

outputImg = zeros(h,w); %Output img
for x = 1:h
    for y = 1:w
        outputImg(x, y) = normalized(inputImg(x,y) + 1); 
    end
end

output = zeros(1,256); %Output img intensity vector
for x = 1:h
    for y = 1:w
        output(outputImg(x, y) + 1) = output(outputImg(x, y) + 1) + 1;
    end
end


f1 = figure;

subplot(1,4,1);
imshow(inputImg);

subplot(1,4,2);
bar(input);
title('Input');

subplot(1,4,3);
imshow(uint8(outputImg));

subplot(1,4,4);
bar(output);
title('Output');

set(f1, 'Position', [500,500,780,180]);