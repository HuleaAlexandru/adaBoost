function [tp, fp, fn, tn] = getConfusionMatrix(examples, strongClassifier)
    strongClassifierThreshold = 0;
    tp = 0; fp = 0; fn = 0; tn = 0;
    for t = 1:length(strongClassifier)
        alfa = strongClassifier(t).alfa;
        if isempty(alfa) || alfa < 0
            break;
        end
        strongClassifierThreshold = strongClassifierThreshold + alfa;
    end
    strongClassifierThreshold = strongClassifierThreshold / 2;
    
    for i = 1:length(examples)
        classifiedExample = classifyExample(examples(i), strongClassifier, strongClassifierThreshold);
        if examples(i).y == 1
            if classifiedExample == 1
                tp = tp + 1;
            else
                fn = fn + 1;
            end
        else
            if classifiedExample == 1
                fp = fp + 1;
            else
                tn = tn + 1;
            end
        end
    end
end