function scaleImages(sourcePath, destinationPath, scale)
    mkdir(destinationPath);
    sourceList = dir(sourcePath);
    for fileId = 1:length(sourceList)
        filename = sourceList(fileId).name;
        if strcmp(filename, '.') || strcmp(filename, '..')
            continue;
        else
            sourcePicture = imread([sourcePath, '\', filename]);
            destinationPicture = imresize(sourcePicture, scale);
            imwrite(destinationPicture, [destinationPath, '\', filename]);
        end
    end
end