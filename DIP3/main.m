clc; clear; close all;

imgPaths = ["Fig1_1.tif",  "Fig1_2.tif", "Fig1_3.tif", "Fig1_4.tif"];
HistogramEqualize(imgPaths(1));

%%
clc; clear; close all;

refImgPath = "Fig0316(3)(third_from_top).tif";
targetImgPaths = ["Fig0316(1)(top_left).tif", "Fig0316(2)(2nd_from_top).tif"];
HistogramMatch(refImgPath, targetImgPaths(1));