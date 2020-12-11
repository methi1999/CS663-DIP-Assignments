function [trainvecspace, testvecspace, unknownvecspace, trainnumimg, testnumimg] = orldataloader()

%Directory Location
orldir = '../../../ORL';
%people =  dir(orldir);
%LOAD TRAINING DATA
imgrownum = 112;
imgcolnum = 92;
trainnumface = 32;
totimg= 10;
trainnumimg = 6;
testnumimg= totimg-trainnumimg;
trainvecspace = zeros(imgrownum*imgcolnum,trainnumface*trainnumimg);
testvecspace = zeros(imgrownum*imgcolnum,trainnumface*(totimg-trainnumimg));
unknownvecspace = zeros(imgrownum*imgcolnum,8*10);
for i = 1:32
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

for i = 33:40
    currsubfolderDir = append(orldir,'/s',num2str(i));
    myFiles = dir(fullfile(currsubfolderDir,'*.pgm'));
    for k = 1:totimg%length(myFiles)
        baseFileName = myFiles(k).name;
        fullFileName = fullfile(currsubfolderDir, baseFileName);
        currface = imread(fullFileName);
        %disp(size(currface))
        currcolvec = reshape(currface,[imgrownum*imgcolnum 1]);
        %disp(size(currcolvec))
        unknownvecspace(:,(i-32-1)*10+k)=currcolvec;        
        %imshow(img)
    end
end