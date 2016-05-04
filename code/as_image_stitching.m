% function as_image_stitching(cell_array,translation_2D)
% 

img_path_1 = uigetimagefile;
img1 = imread(img_path_1);

img_path_2 = uigetimagefile;
img2 = imread(img_path_2);

img_path_3 = uigetimagefile;
img3 = imread(img_path_3);



cell_array=cell(1,2);

cell_array{1}=img1;
cell_array{2}=img2;
% cell_array{3}=img3;

[deltaX , deltaY] = ExtPhaseCorrelation(cell_array{1}, cell_array{2});

size_x=size(cell_array{1},1);
size_y=size(cell_array{1},2);


img_stitched = uint8(0);
img_stitched(size_x*2,size_y*2) = img_stitched;


y=size_y+deltaX;
x=5;
init_x=1;
init_y=1;

img_stitched(1:size_x,1:size_y)=cell_array{1};
img_stitched(init_x+x:(init_x+x+size_x-1),init_y+y:(init_y+y+size_y-1))=cell_array{2};

imshow(img_stitched);



%%


img_path_1 = uigetimagefile;
img1 = imread(img_path_1);
img_path_2 = uigetimagefile;
img2 = imread(img_path_2);
img_path_3 = uigetimagefile;
img3 = imread(img_path_3);
img_path_4 = uigetimagefile;
img4 = imread(img_path_4);
img_path_5 = uigetimagefile;
img5 = imread(img_path_5);


cell_array=cell(1,5);

cell_array{1}=img1;
cell_array{2}=img2;
cell_array{3}=img3;
cell_array{4}=img4;
cell_array{5}=img5;



size_x=size(cell_array{1},1);
size_y=size(cell_array{1},2);

img_stitched = uint8(0);
img_stitched(size_x*5,size_y*5) = img_stitched;


y=373;
x=0;
init_x=1;
init_y=1;

img_stitched(1:size_x,1:size_y)=cell_array{1};



img_stitched(1:(init_x+x+size_x-1),init_y+y:(init_y+y+size_y-1))=cell_array{2};
other=init_y+y+size_y-1;
img_stitched(init_x+x:(init_x+x+size_x-1),other:(other+y+size_y-1))=cell_array{3};
other=other+y+size_y-1;
img_stitched(init_x+x:(init_x+x+size_x-1),other:(other+y+size_y-1))=cell_array{4};
other=other+y+size_y-1;
img_stitched(init_x+x:(init_x+x+size_x-1),other:(other+y+size_y-1))=cell_array{5};

imshow(img_stitched);











%% imregcorr



test=imregcorr(img2,img1);


Rfixed = imref2d(size(img1));
movingReg = imwarp(img2,test,'OutputView',Rfixed);
imshow(movingReg);



%% histogram



img_path_1 = uigetimagefile;
img1 = imread(img_path_1);

img_path_2 = uigetimagefile;
img2 = imread(img_path_2);

a=imhistmatch(img1,img2);
imshow(a);







%% cross correlation


c = normxcorr2(img1,img2);
figure, surf(c), shading flat

% offset found by correlation
[max_c, imax] = max(abs(c(:)));
[ypeak, xpeak] = ind2sub(size(c),imax(1));
corr_offset = [(xpeak-size(img2,2))
               (ypeak-size(img2,1))];

% relative offset of position of subimages
rect_offset = [(rect_peppers(1)-rect_onion(1))
               (rect_peppers(2)-rect_onion(2))];

% total offset
offset = corr_offset + rect_offset;
xoffset = offset(1);
yoffset = offset(2);


% end