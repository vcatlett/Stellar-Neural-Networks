clc;
% The three folders with the test data
% The folders should be in the same directory as this script
% Otherwise, you would need to put the full path 
sdir = 'Smooth_test/';
fdir = 'Featured_test/';
ngdir = 'Artifact_test/';

% These 3 lines load all of the .jpg images
sfiles = dir(fullfile(sdir,'*.jpg'));
ffiles = dir(fullfile(fdir,'*.jpg'));
ngfiles = dir(fullfile(ngdir,'*.jpg'));

% These three variables will keep track of the 
% number of incorrect classifications 
% for each type of image
s_wrong = 0;
f_wrong = 0;
ng_wrong = 0;

% Test all of the Smooth
for i = 1:1:100
    img = imread(strcat(sdir,sfiles(i).name));
    img = imresize(img, [227 227]);
    pred = classify(galaxynet,img);
    if pred ~= "Smooth"
        s_wrong = s_wrong + 1;
    end
end

% Test all of the Featured
for i = 1:1:100
    img = imread(strcat(fdir,ffiles(i).name));
    img = imresize(img, [227 227]);
    pred = classify(galaxynet,img);
    if pred ~= "Featured"
        f_wrong = f_wrong + 1;
    end
end

% Test all of the Artifacts
for i = 1:1:9
    img = imread(strcat(ngdir,ngfiles(i).name));
    img = imresize(img, [227 227]);
    pred = classify(galaxynet,img);
    if pred ~= "Artifact"
        ng_wrong = ng_wrong + 1;
    end
end

% Print the total accuracy
fprintf('Accuracy = %.2f%%\n',(216-s_wrong-f_wrong-ng_wrong)*100/(216));