function positiveSubWindows = getPositiveSubWindows(example, strongClassifier, subWindowSize)
    index = 0;
    scale = 1.25;
    shift = 1.5;
    subWindowHeight = subWindowSize(1);
	subWindowWidth = subWindowSize(2);
    
    exampleSize = size(example.ii) - [1, 1];
    exampleHeight = exampleSize(1);
    exampleWidth = exampleSize(2);
    
    maxScale = min(exampleHeight / subWindowHeight, exampleWidth / subWindowWidth);
    powerScaleRange = floor(1:log(maxScale)/log(scale) + 1) - 1;
    scaleRange = scale .^ powerScaleRange;
    
    yOriginRange = floor((exampleHeight - floor(scaleRange * subWindowHeight)) ./ (scaleRange * shift) + 1);
    xOriginRange = floor((exampleWidth - floor(scaleRange * subWindowWidth)) ./ (scaleRange * shift) + 1);
    noOfSubWindows = sum(xOriginRange .* yOriginRange);
    disp(['Number of checked windows ', num2str(noOfSubWindows)]);
    
    positiveSubWindows(noOfSubWindows) = struct('origin', NaN, 'width', NaN, 'height', NaN);
    scaledWeakClassifiers(length(strongClassifier.weakClassifiers)) = struct('h', NaN, 'alfa', NaN);
    scaledStrongThreshold = strongClassifier.strongThreshold;
    
    for currentScale = scaleRange
        disp(['Scale = ', num2str(currentScale)]);
        currentSubWindowHeight = floor(currentScale * subWindowHeight);
        currentSubWindowWidth = floor(currentScale * subWindowWidth);
        for yOrigin = floor(1:currentScale * shift:exampleHeight - currentSubWindowHeight + 1)
            for xOrigin = floor(1:currentScale * shift:exampleWidth - currentSubWindowWidth + 1)
                translation = [yOrigin, xOrigin];
                for wIndex = 1:length(scaledWeakClassifiers)
                    scaledWeakClassifiers(wIndex) = scaleWeakClassifier(strongClassifier.weakClassifiers(wIndex), currentScale, translation);
                end
                scaledStrongClassifier = struct('weakClassifiers', scaledWeakClassifiers, 'strongThreshold', scaledStrongThreshold);
                class = classifyExample(example, scaledStrongClassifier);
                if class == 1
                   index = index + 1;
                   window = struct('origin', translation, 'width', currentSubWindowWidth, 'height', currentSubWindowHeight); 
                   positiveSubWindows(index) = window;
                   
                   %disp(['Scale = ', num2str(currentScale), ' origin = [', num2str(yOrigin), ', ',  num2str(xOrigin), ...
                   %    '] width = ', num2str(currentSubWindowWidth), ' height = ', num2str(currentSubWindowHeight)]); 
                   %pause;
                end
            end
        end
    end
    positiveSubWindows = positiveSubWindows(1:index);
end