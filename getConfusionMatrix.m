function [tp, fp, fn, tn] = getConfusionMatrix(examples, strongClassifier)
    tp = 0; fp = 0; fn = 0; tn = 0;
    for i = 1:length(examples)
        classifiedExample = classifyExample(examples(i), strongClassifier);
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