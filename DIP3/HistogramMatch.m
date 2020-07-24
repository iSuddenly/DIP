%----------------------------------------------------------
% Function to read given image and implement histogram match(specification)
% Input : Img path string
% Effect : Show original & specified img and plot intensity
%----------------------------------------------------------

function [] = HistogramMatch(refImgPath, targetImgPath)

refImg = imread(refImgPath); %Reference img
targetImg = imread(targetImgPath); %Target img

L = 256;

targetHistogram = Histogram(targetImg,L);

[matchedHistogram, matchedHistogramImage] = HistogramSpecification(refImg,targetImg,L);

f1 = figure;
subplot(1,6,1);
imshow(refImg);
title("Reference img");

subplot(1,6,2);
bar(0:1:L,targetHistogram)
title("Reference histogram");

subplot(1,6,3);
imshow(targetImg);
title("Target img");

subplot(1,6,4);
bar(0:1:L,targetHistogram)
title("Target histogram");

subplot(1,6,5);
imshow(matchedHistogramImage);
title("Matched img");

subplot(1,6,6);
bar(0:1:L,matchedHistogram)    
title("Matched histogram");

set(f1, 'Position', [500,500,780,180]);


function [matchedHistogram, matchedHistogramImage] = HistogramSpecification(refImg,targetImg,L)
    refHistogram = Histogram(refImg,L);
    [x , y] =size(refImg);
    rPixelNum=x*y;
    rTransfer = EqTransferFunction(refHistogram,rPixelNum,L);
    
    tHistogram = Histogram(targetImg,L);
    [x , y] =size(targetImg);
    tPixelNum=x*y;
    tTransfer = EqTransferFunction(tHistogram,tPixelNum,L);
    
    g = inverseTransFunction(rTransfer,L);
    result = zeros(L,1);
    lastV = 0;
    for x = 1:L
        result(x) = g(tTransfer(x)+1);
    end
    for x = 1:L
        if result(x) == 0
            result(x) = lastV;
        else
            lastV = result(x);
        end
    end
    matchedHistogramImage = HistogramMapping(targetImg,result);
    matchedHistogram = Histogram(matchedHistogramImage,L);
end

function iTranFun = inverseTransFunction(transFun,L)
    iTranFun = zeros(L,1,'uint8');
    lastV = 0;
    for x = 1:L
        iTranFun(transFun(x)+1)=x;
    end
    for x = 1:L
        if iTranFun(x) == 0
            iTranFun(x) = lastV;
        else
            lastV = iTranFun(x);
        end
    end
end

function histogram=Histogram(image,L)
    histogram=zeros(L,1);%0 to 255
    for intensity=0:L
        intensity_count=sum(sum(image==intensity));
        histogram(intensity+1)=intensity_count;%array start 1
    end
end

function mapImage = HistogramMapping(originalImage,transFunction)
    [x , y] =size(originalImage);
    mapImage = zeros(x,y,'uint8');
    max_len = length(transFunction);
    for intensity=0:(max_len-1)
        temp = uint8(transFunction(intensity+1)*(originalImage==intensity));
        mapImage = mapImage+temp;
    end
end

function transFunction = EqTransferFunction(histogram,pixel_num,L)
    p = histogram/pixel_num;
    c = zeros(L,1);
    c(1) = p(1);
    for l = 2:L
        c(l) = p(l)+c(l-1);
    end
    transFunction=round(c*(L-1));
end

end
