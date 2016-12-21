function haarFeatures = getAllFeatures(subWindowSize)
    % haarFeatures represents a row of structs
    % each struct represents a haarFeature from a category of features: 2H, 2V, 3H, 3V, 4
	haarFeatures = [];
	subWindowHeight = subWindowSize(1);
	subWindowWidth = subWindowSize(2);
	scale = 1.25;
	shift = 1.5;
    
	% 2H features
    powerHeight = 1:floor(log(subWindowHeight)/log(scale)) + 1;
    featureHeightRange = unique(double(floor(scale .^ (powerHeight - 1))));
    powerWidth = 1:floor(log(subWindowWidth / 2)/log(scale)) + 1;
    featureWidthRange = unique(double(floor(scale .^ (powerWidth - 1))));
    xOriginRange = double(floor((subWindowWidth - 2 * featureWidthRange) / shift + 1));
    yOriginRange = double(floor((subWindowHeight - featureHeightRange) / shift + 1));
    range = sum(yOriginRange) * sum(xOriginRange);
    
    features2H(range) = struct('haarFeatures', []);
    index = 0;
    for featureHeight = featureHeightRange
        for featureWidth = featureWidthRange
            for yOrigin = floor(1:shift:subWindowHeight - featureHeight + 1)
                for xOrigin = floor(1:shift:subWindowWidth - 2 * featureWidth + 1)
                    index = index + 1;
                    features2H(index) = getHaarFeature([yOrigin, xOrigin], 2 * featureWidth, featureHeight, '2H');
                end
            end
        end
    end
	haarFeatures = [haarFeatures, features2H];
	
	% 2V features
	powerHeight = 1:floor(log(subWindowHeight / 2)/log(scale)) + 1;
    featureHeightRange = unique(double(floor(scale .^ (powerHeight - 1))));
    powerWidth = 1:floor(log(subWindowWidth)/log(scale)) + 1;
    featureWidthRange = unique(double(floor(scale .^ (powerWidth - 1))));
    xOriginRange = double(floor((subWindowWidth - featureWidthRange) / shift + 1));
    yOriginRange = double(floor((subWindowHeight - 2 * featureHeightRange) / shift + 1));
    range = sum(yOriginRange) * sum(xOriginRange);
    
    features2V(range) = struct('haarFeatures', []);
    index = 0;
	for featureHeight = featureHeightRange
		for featureWidth = featureWidthRange
			for yOrigin = floor(1:shift:subWindowHeight - 2 * featureHeight + 1)
				for xOrigin = floor(1:shift:subWindowWidth - featureWidth + 1)
                    index = index + 1;
					features2V(index) = getHaarFeature([yOrigin, xOrigin], featureWidth, 2 * featureHeight, '2V');
				end
			end
		end
	end
	haarFeatures = [haarFeatures, features2V];

	% 3H features
	powerHeight = 1:floor(log(subWindowHeight)/log(scale)) + 1;
    featureHeightRange = unique(double(floor(scale .^ (powerHeight - 1))));
    powerWidth = 1:floor(log(subWindowWidth / 3)/log(scale)) + 1;
    featureWidthRange = unique(double(floor(scale .^ (powerWidth - 1))));
    xOriginRange = double(floor((subWindowWidth - 3 * featureWidthRange) / shift + 1));
    yOriginRange = double(floor((subWindowHeight - featureHeightRange) / shift + 1));
    range = sum(yOriginRange) * sum(xOriginRange);
    
    features3H(range) = struct('haarFeatures', []);
    index = 0;
	for featureHeight = featureHeightRange
		for featureWidth = featureWidthRange
			for yOrigin = floor(1:shift:subWindowHeight - featureHeight + 1)
				for xOrigin = floor(1:shift:subWindowWidth - 3 * featureWidth + 1)
                    index = index + 1;
					features3H(index) = getHaarFeature([yOrigin, xOrigin], 3 * featureWidth, featureHeight, '3H');
				end
			end
		end
	end
	haarFeatures = [haarFeatures, features3H];
    
	% 3V features
	powerHeight = 1:floor(log(subWindowHeight / 3)/log(scale)) + 1;
    featureHeightRange = unique(double(floor(scale .^ (powerHeight - 1))));
    powerWidth = 1:floor(log(subWindowWidth)/log(scale)) + 1;
    featureWidthRange = unique(double(floor(scale .^ (powerWidth - 1))));
    xOriginRange = double(floor((subWindowWidth - featureWidthRange) / shift + 1));
    yOriginRange = double(floor((subWindowHeight - 3 * featureHeightRange) / shift + 1));
    range = sum(yOriginRange) * sum(xOriginRange);
    
    features3V(range) = struct('haarFeatures', []);
    index = 0;
	for featureHeight = featureHeightRange
		for featureWidth = featureWidthRange
			for yOrigin = floor(1:shift:subWindowHeight - 3 * featureHeight + 1)
				for xOrigin = floor(1:shift:subWindowWidth - featureWidth + 1)
                    index = index + 1;
					features3V(index) = getHaarFeature([yOrigin, xOrigin], featureWidth, 3 * featureHeight, '3V');
				end
			end
		end
	end
	haarFeatures = [haarFeatures, features3V];
    
	% 4 features
	powerHeight = 1:floor(log(subWindowHeight / 2)/log(scale)) + 1;
    featureHeightRange = unique(double(floor(scale .^ (powerHeight - 1))));
    powerWidth = 1:floor(log(subWindowWidth / 2)/log(scale)) + 1;
    featureWidthRange = unique(double(floor(scale .^ (powerWidth - 1))));
    xOriginRange = double(floor((subWindowWidth - 2 * featureWidthRange) / shift + 1));
    yOriginRange = double(floor((subWindowHeight - 2 * featureHeightRange) / shift + 1));
    range = sum(yOriginRange) * sum(xOriginRange);
    
    features4(range) = struct('haarFeatures', []);
    index = 0;    
	for featureHeight = featureHeightRange
		for featureWidth = featureWidthRange
			for yOrigin = floor(1:shift:subWindowHeight - 2 * featureHeight + 1)
				for xOrigin = floor(1:shift:subWindowWidth - 2 * featureWidth + 1)
                    index = index + 1;
					features4(index) = getHaarFeature([yOrigin, xOrigin], 2 * featureWidth, 2 * featureHeight, '4');
				end
			end
		end
	end
	haarFeatures = [haarFeatures, features4];
end