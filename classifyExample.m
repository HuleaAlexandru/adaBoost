function classifiedExample = classifyExample(example, strongClassifier, strongClassifierThreshold)
    classifiedExample = 0;
    exampleSum = 0;
    for t = 1:length(strongClassifier)
        weakClassifier = strongClassifier(t).h;
        alfa = strongClassifier(t).alfa;
        if isempty(alfa) || alfa < 0
            break;
        end
        featureSum = getDescriptor(example.ii, weakClassifier.feature);
        classification = featureSum * weakClassifier.parity < weakClassifier.threshold * weakClassifier.parity;
        exampleSum = exampleSum + classification * alfa;
    end
    
    if exampleSum >= strongClassifierThreshold
        classifiedExample = 1;
    end
end