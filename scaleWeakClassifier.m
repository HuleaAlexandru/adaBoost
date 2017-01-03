function outWeakClassifier = scaleWeakClassifier(inWeakClassifier, scaleFactor, translation)
    outH = inWeakClassifier.h;
    outAlfa = inWeakClassifier.alfa;
    inFeature = outH.feature.haarFeatures(1);
    
    type = inFeature.type;
    origin = floor(inFeature.origin * scaleFactor) + translation - [1, 1];
    if strncmp(type, '2H', 2)
        width = 2 * floor(inFeature.width * scaleFactor);
        height = floor(inFeature.height * scaleFactor);
        outFeature = getHaarFeature(origin, width, height, type);
        outThreshold = outH.threshold * (width / (2 * inFeature.width)) * (height / inFeature.height);
    elseif strncmp(type, '2V', 2)
        width = floor(inFeature.width * scaleFactor);
        height = 2 * floor(inFeature.height * scaleFactor);
        outFeature = getHaarFeature(origin, width, height, type);
        outThreshold = outH.threshold * (width / inFeature.width) * (height / (2 * inFeature.height));
    elseif strncmp(type, '3H', 2)    
        width = 3 * floor(inFeature.width * scaleFactor);
        height = floor(inFeature.height * scaleFactor);
        outFeature = getHaarFeature(origin, width, height, type);
        outThreshold = outH.threshold * (width / (3 * inFeature.width)) * (height / inFeature.height);
    elseif strncmp(type, '3V', 2)     
        width = floor(inFeature.width * scaleFactor);
        height = 3 * floor(inFeature.height * scaleFactor);
        outFeature = getHaarFeature(origin, width, height, type);
        outThreshold = outH.threshold * (width / inFeature.width) * (height / (3 * inFeature.height));
    elseif strncmp(type, '4', 1)
        width = 2 * floor(inFeature.width * scaleFactor);
        height = 2 * floor(inFeature.height * scaleFactor);
        outFeature = getHaarFeature(origin, width, height, type);
        outThreshold = outH.threshold * (width / (2 * inFeature.width)) * (height / (2 * inFeature.height));
    elseif strncmp(type, 'C', 1)
        width = 3 * floor(inFeature.width * scaleFactor);
        height = 3 * floor(inFeature.height * scaleFactor);
        outFeature = getHaarFeature(origin, width, height, type);
        outThreshold = outH.threshold * (width / (3 * inFeature.width)) * (height / (3 * inFeature.height));
    end
    
    outH.feature = outFeature;
    outH.threshold = outThreshold;
    outWeakClassifier = struct('h', outH, 'alfa', outAlfa);
end
