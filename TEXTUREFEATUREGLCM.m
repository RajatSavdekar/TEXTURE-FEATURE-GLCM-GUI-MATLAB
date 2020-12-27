%making a vector to store the features values
features=[]


% takinhg image as a input by the function imread()
% and showing it on output by function imread()
i = imread('img.jpg');
subplot(1,3,1)
imshow(i);
title('Original Image');

% converting Original image to grayscale image by function rgb2gray()
% and showing it in output 
gray=rgb2gray(i);
subplot(1,3,2)
imshow(gray);
title('Converted to Grayscale image');

% the grayscale image is used to find the gray level co-occurrence matrix
% or glcm by the function graycomatrix()
glcm=graycomatrix(gray)  


% here the glcm is converted to normalised glcm which is reuired for our
% calculation first we add transpose of glcm to its owm matrix and then 
% divide each element of the new matrix (formed by adding glcm and its 
% transpose) by the sum of elements in it.This gives us normalised glcm
% sum of element of matrix is calculated by function sum(sum()) 
A=glcm;
num_rows=size(A,1) 
num_cols=size(A,2)

for i=1:num_rows
    for j=1:num_cols
        trans(i,j)=A(j,i);
    end
end


for i=1:1:num_rows
    for j=1:1:num_cols
        A(i,j)=A(i,j)+trans(i,j) ;  
    end
end

factor=sum(sum(A));

for i=1:1:num_rows
    for j=1:1:num_cols
        A(i,j)=A(i,j)/factor;
    end
end

disp(A);

% Now after getting normalised glam matrix we use it for texture feature 
% calculation

%First is Energy

energy=0;
for i=1:1:num_rows
    for j=1:1:num_cols
        energy = energy + A(i,j)^2;
    end
end
disp(energy);

%Second Contrast

contrast=0;
for i=1:1:num_rows
    for j=1:1:num_cols
        contrast = contrast + A(i,j).*((i-j)^2);
    end
end
disp(contrast);

%Third Homogeneity

homogeneity=0;
for i=1:1:num_rows
    for j=1:1:num_cols
        homogeneity = homogeneity + A(i,j).*(1/(1+(i-j)^2));
    end
end
disp(homogeneity);


%Fourth Entropy
% we need another matrix for the calculation of entropy so in the below 
% for loop the first step is done.And in the second for loop the final 
% calculation is done.
for i=1:1:num_rows
    for j=1:1:num_cols
  
        B(i,j)=log(A(i,j));
    end
end

entropy=0;
for i=1:1:num_rows
    for j=1:1:num_cols
        entropy = entropy - ( A(i,j)*B(i,j) );
    end
end
disp(entropy); 

% defing the feature in a vector called features and then
% plotting the different values in graph

features=[energy,contrast,homogeneity,entropy]

x=0:0.33:1;

subplot(1,3,3)
plot(x,features,'r--s')
xlabel('X')
ylabel('Texture Features Values')
title('Plot of the energy,contrast,homogeneity,entropy')


