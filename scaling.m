function scaledImage = scaling(strongClassifier, subWindowSize, scale)
    image = ones(subWindowSize) * 0.5;
    
    weakClassifiers = strongClassifier.weakClassifiers;
    for j = 1:length(weakClassifiers)
        feature = weakClassifiers(j).h.feature;
        haarFeatures = feature.haarFeatures;
        for i = 1:length(haarFeatures)
            haarFeature = haarFeatures(i);
            if haarFeature.sign == 1
                haarFeatureOrigin = haarFeature.origin;
                haarFeatureWidth = haarFeature.width;
                haarFeatureHeight = haarFeature.height;
                for row = haarFeatureOrigin(1):haarFeatureOrigin(1) + haarFeatureHeight - 1
                    for col = haarFeatureOrigin(2):haarFeatureOrigin(2) + haarFeatureWidth - 1
                        image(row, col) = 0;
                    end
                end
            elseif haarFeature.sign == -1
                haarFeatureOrigin = haarFeature.origin;
                haarFeatureWidth = haarFeature.width;
                haarFeatureHeight = haarFeature.height;
                for row = haarFeatureOrigin(1):haarFeatureOrigin(1) + haarFeatureHeight - 1
                    for col = haarFeatureOrigin(2):haarFeatureOrigin(2) + haarFeatureWidth - 1
                        image(row, col) = 1;
                    end
                end
            end
        end
    end
    
    scaledImage = imresize(image, scale, 'nearest');
    imshow(scaledImage);
end