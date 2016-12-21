function features = getRandomFeatures(noRandomFeatures, windowSize)
    features(noRandomFeatures) = struct('haarFeatures', NaN);
    type = [struct('type', '2H'), struct('type', '2V'), struct('type', '3H'), struct('type', '3V'), struct('type', '4')];
    windowHeight = windowSize(1);
    windowWidth = windowSize(2);
    
    % shift supraunitar
    scale = 1.25;
    shift = 1.5;
    i = 1;
    while i <= noRandomFeatures
        randomType = type(randperm(length(type), 1)).type;
        origin = [-1, -1];
        width = -1;
        height = -1;
        
        if strcmp(randomType, '2H')
            currentXOrigin = floor(1:shift:windowWidth - 1);
            currentYOrigin = floor(1:shift:windowHeight);
            origin = [currentYOrigin(randperm(length(currentYOrigin), 1)), currentXOrigin(randperm(length(currentXOrigin), 1))];
            
            powerWidth = 1:floor(log((windowWidth - origin(2) + 1) / 2)/log(scale)) + 1;
            currentWidth = unique(floor(scale .^ (powerWidth - 1)));
            powerHeight = 1:floor(log(windowHeight - origin(1) + 1)/log(scale)) + 1;
            currentHeight = unique(floor(scale .^ (powerHeight - 1)));
           
            width = currentWidth(randperm(length(currentWidth), 1)) * 2;
            height = currentHeight(randperm(length(currentHeight), 1));
        elseif strcmp(randomType, '2V')
            currentXOrigin = floor(1:shift:windowWidth);
            currentYOrigin = floor(1:shift:windowHeight - 1);
            origin = [currentYOrigin(randperm(length(currentYOrigin), 1)), currentXOrigin(randperm(length(currentXOrigin), 1))];
            
            powerWidth = 1:floor(log(windowWidth - origin(2) + 1)/log(scale)) + 1;
            currentWidth = unique(floor(scale .^ (powerWidth - 1)));
            powerHeight = 1:floor(log((windowHeight - origin(1) + 1) / 2)/log(scale)) + 1;
            currentHeight = unique(floor(scale .^ (powerHeight - 1)));
           
            width = currentWidth(randperm(length(currentWidth), 1));
            height = currentHeight(randperm(length(currentHeight), 1)) * 2;
        elseif strcmp(randomType, '3H')
            currentXOrigin = floor(1:shift:windowWidth - 2);
            currentYOrigin = floor(1:shift:windowHeight);
            origin = [currentYOrigin(randperm(length(currentYOrigin), 1)), currentXOrigin(randperm(length(currentXOrigin), 1))];
            
            powerWidth = 1:floor(log((windowWidth - origin(2) + 1) / 3)/log(scale)) + 1;
            currentWidth = unique(floor(scale .^ (powerWidth - 1)));
            powerHeight = 1:floor(log(windowHeight - origin(1) + 1)/log(scale)) + 1;
            currentHeight = unique(floor(scale .^ (powerHeight - 1)));
           
            width = currentWidth(randperm(length(currentWidth), 1)) * 3;
            height = currentHeight(randperm(length(currentHeight), 1));
        elseif strcmp(randomType, '3V')
            currentXOrigin = floor(1:shift:windowWidth);
            currentYOrigin = floor(1:shift:windowHeight - 2);
            origin = [currentYOrigin(randperm(length(currentYOrigin), 1)), currentXOrigin(randperm(length(currentXOrigin), 1))];
            
            powerWidth = 1:floor(log(windowWidth - origin(2) + 1)/log(scale)) + 1;
            currentWidth = unique(floor(scale .^ (powerWidth - 1)));
            powerHeight = 1:floor(log((windowHeight - origin(1) + 1) / 3)/log(scale)) + 1;
            currentHeight = unique(floor(scale .^ (powerHeight - 1)));
           
            width = currentWidth(randperm(length(currentWidth), 1));
            height = currentHeight(randperm(length(currentHeight), 1)) * 3;
        elseif strcmp(randomType, '4')
            currentXOrigin = floor(1:shift:windowWidth - 1);
            currentYOrigin = floor(1:shift:windowHeight - 1);
            origin = [currentYOrigin(randperm(length(currentYOrigin), 1)), currentXOrigin(randperm(length(currentXOrigin), 1))];
            
            powerWidth = 1:floor(log((windowWidth - origin(2) + 1) / 2)/log(scale)) + 1;
            currentWidth = unique(floor(scale .^ (powerWidth - 1)));
            powerHeight = 1:floor(log((windowHeight - origin(1) + 1) / 2)/log(scale)) + 1;
            currentHeight = unique(floor(scale .^ (powerHeight - 1)));
           
            width = currentWidth(randperm(length(currentWidth), 1)) * 2;
            height = currentHeight(randperm(length(currentHeight), 1)) * 2;
        end
        
        feature = getHaarFeature(origin, width, height, randomType);
        features(i) = feature;
        i = i + 1;
    end
end