function features = getRandomFeatures(noRandomFeatures, windowSize)
    features(noRandomFeatures) = struct('haarFeatures', NaN);
    type = [struct('type', '2H'), struct('type', '2V'), struct('type', '3H'), struct('type', '3V'), struct('type', '4'), struct('type', 'C')];
    windowHeight = windowSize(1);
    windowWidth = windowSize(2);
    
    i = 1;
    while i <= noRandomFeatures
        randomType = type(randperm(length(type), 1)).type;
        origin = [-1, -1];
        width = -1;
        height = -1;
        
        if strcmp(randomType, '2H')
            currentXOrigin = 1:windowWidth - 1;
            currentYOrigin = 1:windowHeight;
            origin = [currentYOrigin(randperm(length(currentYOrigin), 1)), currentXOrigin(randperm(length(currentXOrigin), 1))];
            
            currentWidth = 1:(windowWidth - origin(2) + 1) / 2;
            currentHeight = 1:windowHeight - origin(1) + 1;
           
            width = currentWidth(randperm(length(currentWidth), 1)) * 2;
            height = currentHeight(randperm(length(currentHeight), 1));
        elseif strcmp(randomType, '2V')
            currentXOrigin = 1:windowWidth;
            currentYOrigin = 1:windowHeight - 1;
            origin = [currentYOrigin(randperm(length(currentYOrigin), 1)), currentXOrigin(randperm(length(currentXOrigin), 1))];
            
            currentWidth = 1:windowWidth - origin(2) + 1;
            currentHeight = 1:(windowHeight - origin(1) + 1) / 2;
           
            width = currentWidth(randperm(length(currentWidth), 1));
            height = currentHeight(randperm(length(currentHeight), 1)) * 2;
        elseif strcmp(randomType, '3H')
            currentXOrigin = 1:windowWidth - 2;
            currentYOrigin = 1:windowHeight;
            origin = [currentYOrigin(randperm(length(currentYOrigin), 1)), currentXOrigin(randperm(length(currentXOrigin), 1))];
            
            currentWidth = 1:(windowWidth - origin(2) + 1) / 3;
            currentHeight = 1:windowHeight - origin(1) + 1;
           
            width = currentWidth(randperm(length(currentWidth), 1)) * 3;
            height = currentHeight(randperm(length(currentHeight), 1));
        elseif strcmp(randomType, '3V')
            currentXOrigin = 1:windowWidth;
            currentYOrigin = 1:windowHeight - 2;
            origin = [currentYOrigin(randperm(length(currentYOrigin), 1)), currentXOrigin(randperm(length(currentXOrigin), 1))];
            
            currentWidth = 1:windowWidth - origin(2) + 1;
            currentHeight = 1:(windowHeight - origin(1) + 1) / 3;
           
            width = currentWidth(randperm(length(currentWidth), 1));
            height = currentHeight(randperm(length(currentHeight), 1)) * 3;
        elseif strcmp(randomType, '4')
            currentXOrigin = 1:windowWidth - 1;
            currentYOrigin = 1:windowHeight - 1;
            origin = [currentYOrigin(randperm(length(currentYOrigin), 1)), currentXOrigin(randperm(length(currentXOrigin), 1))];
            
            currentWidth = 1:(windowWidth - origin(2) + 1) / 2;
            currentHeight = 1:(windowHeight - origin(1) + 1) / 2;
           
            width = currentWidth(randperm(length(currentWidth), 1)) * 2;
            height = currentHeight(randperm(length(currentHeight), 1)) * 2;
        elseif strcmp(randomType, 'C')
            currentXOrigin = 1:windowWidth - 2;
            currentYOrigin = 1:windowHeight - 2;
            origin = [currentYOrigin(randperm(length(currentYOrigin), 1)), currentXOrigin(randperm(length(currentXOrigin), 1))];
            
            currentWidth = 1:(windowWidth - origin(2) + 1) / 3;
            currentHeight = 1:(windowHeight - origin(1) + 1) / 3;
           
            width = currentWidth(randperm(length(currentWidth), 1)) * 3;
            height = currentHeight(randperm(length(currentHeight), 1)) * 3;
        end
        
        feature = getHaarFeature(origin, width, height, randomType);
        features(i) = feature;
        i = i + 1;
    end
end