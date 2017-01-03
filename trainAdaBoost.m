function [strongClassifier, subWindowSize] = trainAdaBoost(sourcePath, outputFile)
    % create an example image as struct(x,y) with x the image, y the
    % classification
    sourceList = dir(sourcePath);
    examples(length(sourceList) - 2) = struct('y', 0, 'w', 0, 'ii', NaN);
    index = 0;
    positiveExamples = 0;
	pictureSize = [0, 0];
	noRandomFeatures = 2000; 
	
	tic;
    for fileId = 1:length(sourceList)
        filename = sourceList(fileId).name;
        if strcmp(filename, '.') || strcmp(filename, '..')
            continue;
        else
            index = index + 1;
            picture = imread([sourcePath, '\', filename]);
            if size(picture, 3) ~= 1
                picture = rgb2gray(picture);
            end
			
            pictureSize = size(picture);
            
            classification = 0;
            if strncmp(filename, 'p', 1)
                classification = 1;
                positiveExamples = positiveExamples + 1;
            end
            examples(index) = struct('y', classification, 'w', 0, 'ii', computeIntegralImage(picture));
            clear picture;
        end
    end
    negativeExamples = length(examples) - positiveExamples;
	elapsedTime = toc;
	disp(['Read images and compute integral image for ', num2str(length(examples)), ' images: ', num2str(elapsedTime), ' seconds']);
	
    % initialize weights w1,i = 1/2m or 1/2l
    for exampleId = 1:length(examples)
        if examples(exampleId).y == 0
            examples(exampleId).w = 1 / (2 * negativeExamples);
        else
            examples(exampleId).w = 1 / (2 * positiveExamples);
        end
    end
    
	%tic;
    %allFeatures = getAllFeatures(pictureSize);
	%elapsedTime = toc;
	%disp(['The number of features is ', num2str(length(allFeatures)), ': ', num2str(elapsedTime), ' seconds']);
    %pause;
    
    T = 100;
    iterationsNeeded = T;
    weakClassifiers(T) = struct('h', NaN, 'alfa', -1);
    strongClassifierThreshold = 0;
    strongClassifier = struct('weakClassifiers', weakClassifiers, 'strongThreshold', strongClassifierThreshold);
    for t = 1:T
        tic;
        t
        weights = [examples.w];
        weights = weights / sum(weights);

        for i = 1:length(examples)
            examples(i).w = weights(i);
        end

        % for each feature j train a classifier, determine the optimal
        % threshold and the parity and calculate the error et
        % choose the classifier hj with the lowest error et
        minError = -1;
        bestClassifier = NaN;
        errorVector = NaN;
        
        randomFeatures = getRandomFeatures(noRandomFeatures, pictureSize);
        
        for j = 1:length(randomFeatures)       
           [weakClassifier, currentError, e] = getWeakClassifier(examples, randomFeatures(j)); 
           if minError < 0 || minError > currentError
               minError = currentError;
               bestClassifier = weakClassifier;
               errorVector = e;
            end
        end
        
        % update the weights
        beta = minError / (1 - minError);
        alfa = log(1 / beta);
        weights = weights .* (beta .^ (1 - errorVector));

        for i = 1:length(examples)
            examples(i).w = weights(i);
        end

        weakClassifiers(t) = struct('h', bestClassifier, 'alfa', alfa);
        subWindowSize = pictureSize;
        
        strongClassifierThreshold = strongClassifierThreshold + alfa / 2;
        strongClassifier.weakClassifiers = weakClassifiers;
        strongClassifier.strongThreshold = strongClassifierThreshold;
        [tp, fp, fn, tn] = getConfusionMatrix(examples, strongClassifier);
        [tp, fp, fn, tn]
        
        disp(['Accuracy: ', num2str((tp + tn) / (tp + fp + fn + tn))]);
        disp(['Detection rate: ', num2str(tp / (tp + fn))]);
        disp(['False positive rate: ', num2str(fp / (fp + tn))]);
        elapsedTime = toc;
        disp(['Choose one weak classifier: ', num2str(elapsedTime), ' seconds']);
        
        %if fp == 0 && fn == 0
        %    iterationsNeeded = t;
        %    break;
        %end
    end
    
    weakClassifiers = weakClassifiers(1:iterationsNeeded);
    strongClassifier.weakClassifiers = weakClassifiers;
    saveTrainingOutput(outputFile, strongClassifier, subWindowSize);
end