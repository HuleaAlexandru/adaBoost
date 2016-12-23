function class = classifyExample(example, strongClassifier)
    class = 0;
    exampleSum = 0;
    weakClassifiers = strongClassifier.weakClassifiers;
    strongThreshold = strongClassifier.strongThreshold;
    for t = 1:length(weakClassifiers)
        weakClassifier = weakClassifiers(t).h;
        alfa = weakClassifiers(t).alfa;
        if isempty(alfa) || alfa < 0
            break;
        end
        featureSum = getDescriptor(example.ii, weakClassifier.feature);
        %disp(['sum = ', num2str(featureSum), ' threshold ', num2str(weakClassifier.threshold), ' origin: ', num2str(weakClassifier.feature.haarFeatures(1).origin)]);
        classification = featureSum * weakClassifier.parity < weakClassifier.threshold * weakClassifier.parity;
        exampleSum = exampleSum + classification * alfa;
    end
    %disp(['Total sum = ', num2str(exampleSum), ' threshold ', num2str(strongThreshold)]);
    %disp(' ');
    if exampleSum >= strongThreshold
        class = 1;
    end
    %pause;
end