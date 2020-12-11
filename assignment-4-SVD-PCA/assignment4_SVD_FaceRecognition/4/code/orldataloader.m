function [trainvecspace, testvecspace, trainnumimg, testnumimg, imgrownum, imgcolnum] = orldataloader()

%Directory Location
orldir = '../../../ORL';
%people =  dir(orldir);
%LOAD TRAINING DATA
imgrownum = 112;
imgcolnum = 92;
trainnumface =39;
totimg= 10;
trainnumimg =6;
testnumimg= totimg-trainnumimg;
trainvecspace = zeros(imgrownum*imgcolnum,trainnumface*trainnumimg);
testvecspace = zeros(imgrownum*imgcolnum,trainnumface*(totimg-trainnumimg));
for i = 1:trainnumface
    currsubfolderDir = append(orldir,'/s',num2str(i));
    myFiles = dir(fullfile(currsubfolderDir,'*.pgm'));
    for k = 1:totimg%length(myFiles)
        baseFileName = myFiles(k).name;
        fullFileName = fullfile(currsubfolderDir, baseFileName);
        currface = imread(fullFileName);
        %disp(size(currface))
        currcolvec = reshape(currface,[imgrownum*imgcolnum 1]);
        %disp(size(currcolvec))
        if k <= trainnumimg
            trainvecspace(:,(i-1)*trainnumimg+k)=currcolvec;
        else
            testvecspace(:,(i-1)*(totimg-trainnumimg)+k-trainnumimg)=currcolvec;
        end
        %imshow(img)
    end
end