function [] = otsuAccuracy()
    clc;
    close all;
    
    %apply otsu's method on source image 
    img = imread("src_BW5.jpg");
    tic
    T = generalThreshold(img);
    toc
    %get BW image - otsu's result
    BW = im2bw(im2gray(img),T/255);
    imshow(BW);
    title('otsus method on source image');
    
    %read gound truth image from Weizmann institue of science data base
    A = imread('Human_seg5.jpg');
    I = im2gray(A); 
    %get BW_groundTruth image
    BW_groundTruth =  imbinarize(I);
    figure;
    imshow(BW_groundTruth);
    title('ground truth image');
    %calculate the similarity between otsu's method and the gound truth
    similarity = bfscore(BW, BW_groundTruth);
    figure;
    imshowpair(BW, BW_groundTruth);
    title(['Using Otsu - BF Score = ' num2str(similarity)]);
end