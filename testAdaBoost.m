function positiveSubWindows = testAdaBoost(sourcePath, strongClassifier, subWindowSize)
    sourceList = dir(sourcePath);
    tp = 0; tn = 0; fp = 0; fn = 0;
    if isdir(sourcePath)
        for fileId = 1:length(sourceList)
            filename = sourceList(fileId).name;
            if strcmp(filename, '.') || strcmp(filename, '..')
                continue;
            else
                tic;
                picture = imread([sourcePath, '\', filename]);
                if size(picture, 3) ~= 1
                    picture = rgb2gray(picture);
                end

                testExample = struct('name', filename, 'ii', computeIntegralImage(picture));
                positiveSubWindows = getPositiveSubWindows(testExample, strongClassifier, subWindowSize);     
                elapsedTime = toc;
                disp([testExample.name, ': ', num2str(size(positiveSubWindows, 2)), ' Time: ', num2str(elapsedTime)]);

                if strncmp(testExample.name, 'p', 1)
                    if size(positiveSubWindows, 2) > 0
                        tp = tp + 1;
                    else
                        fn = fn + 1;
                    end
                else
                    if size(positiveSubWindows, 2) > 0
                        fp = fp + 1;
                    else
                        tn = tn + 1;
                    end
                end
                clear picture;
            end
        end
        disp(['Accuracy = ', num2str((tp + tn) / (tp + tn + fp + fn))]);
    else
        tic;     
        picture = imread(sourcePath);
        if size(picture, 3) ~= 1
            picture = rgb2gray(picture);
        end

        testExample = struct('name', sourcePath, 'ii', computeIntegralImage(picture));
        positiveSubWindows = getPositiveSubWindows(testExample, strongClassifier, subWindowSize);     
        elapsedTime = toc;
        disp([testExample.name, ': ', num2str(size(positiveSubWindows, 2)), ' Time: ', num2str(elapsedTime)]);
        
        if size(positiveSubWindows, 2) > 0
            partitions = getPartitions(positiveSubWindows);
            detections = getDetections(positiveSubWindows, partitions);
            figure, imshow(picture), hold on
            for i = 1:length(detections)
                currentDetection = detections(i);
                corners = [currentDetection.topLeft; currentDetection.topRight; currentDetection.bottomRight; currentDetection.bottomLeft; currentDetection.topLeft];
                
                plot(corners(1:2,2), corners(1:2,1), 'LineWidth', 2, 'Color', 'green');
                plot(corners(2:3,2), corners(2:3,1), 'LineWidth', 2, 'Color', 'green');
                plot(corners(3:4,2), corners(3:4,1), 'LineWidth', 2, 'Color', 'green');
                plot(corners(4:5,2), corners(4:5,1), 'LineWidth', 2, 'Color', 'green');
            end
        end
    end
end