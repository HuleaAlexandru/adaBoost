function haarFeatures = getAllFeatures(subWindowSize)
    % haarFeatures represents a row of structs
    % each struct represents a haarFeature from a category of features: 2H, 2V, 3H, 3V, 4
	haarFeatures = [];
	subWindowHeight = subWindowSize(1);
	subWindowWidth = subWindowSize(2);
    
	% 2H features
    featureHeightRange = 1:subWindowHeight;
    featureWidthRange = 1:subWindowWidth / 2;
    xOriginRange = subWindowWidth - 2 * featureWidthRange + 1;
    yOriginRange = subWindowHeight - featureHeightRange + 1;
    range = sum(yOriginRange) * sum(xOriginRange);
    
    features2H(range) = struct('haarFeatures', []);
    index = 0;
    for featureHeight = featureHeightRange
        for featureWidth = featureWidthRange
            for yOrigin = 1:subWindowHeight - featureHeight + 1
                for xOrigin = 1:subWindowWidth - 2 * featureWidth + 1
                    index = index + 1;
                    features2H(index) = getHaarFeature([yOrigin, xOrigin], 2 * featureWidth, featureHeight, '2H');
                end
            end
        end
    end
	haarFeatures = [haarFeatures, features2H];
	
	% 2V features
	featureHeightRange = 1:subWindowHeight / 2;
    featureWidthRange = 1:subWindowWidth;
    xOriginRange = subWindowWidth - featureWidthRange + 1;
    yOriginRange = subWindowHeight - 2 * featureHeightRange + 1;
    range = sum(yOriginRange) * sum(xOriginRange);
    
    features2V(range) = struct('haarFeatures', []);
    index = 0;
    for featureHeight = featureHeightRange
        for featureWidth = featureWidthRange
            for yOrigin = 1:subWindowHeight - 2 * featureHeight + 1
                for xOrigin = 1:subWindowWidth - featureWidth + 1
                    index = index + 1;
                    features2V(index) = getHaarFeature([yOrigin, xOrigin], featureWidth, 2 * featureHeight, '2V');
                end
            end
        end
    end
	haarFeatures = [haarFeatures, features2V];

	% 3H features
	featureHeightRange = 1:subWindowHeight;
    featureWidthRange = 1:subWindowWidth / 3;
    xOriginRange = subWindowWidth - 3 * featureWidthRange + 1;
    yOriginRange = subWindowHeight - featureHeightRange + 1;
    range = sum(yOriginRange) * sum(xOriginRange);
    
    features3H(range) = struct('haarFeatures', []);
    index = 0;
    for featureHeight = featureHeightRange
        for featureWidth = featureWidthRange
            for yOrigin = 1:subWindowHeight - featureHeight + 1
                for xOrigin = 1:subWindowWidth - 3 * featureWidth + 1
                    index = index + 1;
                    features3H(index) = getHaarFeature([yOrigin, xOrigin], 3 * featureWidth, featureHeight, '3H');
                end
            end
        end
    end
	haarFeatures = [haarFeatures, features3H];
    
	% 3V features
	featureHeightRange = 1:subWindowHeight / 3;
    featureWidthRange = 1:subWindowWidth;
    xOriginRange = subWindowWidth - featureWidthRange + 1;
    yOriginRange = subWindowHeight - 3 * featureHeightRange + 1;
    range = sum(yOriginRange) * sum(xOriginRange);
    
    features3V(range) = struct('haarFeatures', []);
    index = 0;
    for featureHeight = featureHeightRange
        for featureWidth = featureWidthRange
            for yOrigin = 1:subWindowHeight - 3 * featureHeight + 1
                for xOrigin = 1:subWindowWidth - featureWidth + 1
                    index = index + 1;
                    features3V(index) = getHaarFeature([yOrigin, xOrigin], featureWidth, 3 * featureHeight, '3V');
                end
            end
        end
    end
	haarFeatures = [haarFeatures, features3V];
    
	% 4 features
	featureHeightRange = 1:subWindowHeight / 2;
    featureWidthRange = 1:subWindowWidth / 2;
    xOriginRange = subWindowWidth - 2 * featureWidthRange + 1;
    yOriginRange = subWindowHeight - 2 * featureHeightRange + 1;
    range = sum(yOriginRange) * sum(xOriginRange);
    
    features4(range) = struct('haarFeatures', []);
    index = 0;
    for featureHeight = featureHeightRange
        for featureWidth = featureWidthRange
            for yOrigin = 1:subWindowHeight - 2 * featureHeight + 1
                for xOrigin = 1:subWindowWidth - 2 * featureWidth + 1
                    index = index + 1;
                    features4(index) = getHaarFeature([yOrigin, xOrigin], 2 * featureWidth, 2 * featureHeight, '4');
                end
            end
        end
    end
	haarFeatures = [haarFeatures, features4];
    
    % centered features
	featureHeightRange = 1:subWindowHeight / 3;
    featureWidthRange = 1:subWindowWidth / 3;
    xOriginRange = subWindowWidth - 3 * featureWidthRange + 1;
    yOriginRange = subWindowHeight - 3 * featureHeightRange + 1;
    range = sum(yOriginRange) * sum(xOriginRange);
    
    centeredFeatures(range) = struct('haarFeatures', []);
    index = 0;
    for featureHeight = featureHeightRange
        for featureWidth = featureWidthRange
            for yOrigin = 1:subWindowHeight - 3 * featureHeight + 1
                for xOrigin = 1:subWindowWidth - 3 * featureWidth + 1
                    index = index + 1;
                    centeredFeatures(index) = getHaarFeature([yOrigin, xOrigin], 3 * featureWidth, 3 * featureHeight, 'C');
                end
            end
        end
    end
	haarFeatures = [haarFeatures, centeredFeatures];
end