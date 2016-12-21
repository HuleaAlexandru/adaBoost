function [weakClassifier, error, e] = getWeakClassifier(examples, feature)
	% a weak classifier represents a perceptron - a threshold(teta) and a parity(p) such that
	% h(x) = 1 if p * feature(x) < p * teta
	% 	   = 0 otherwise
	% the error for a threshold is e = min(Sp + (Tn - Sn), Sn + (Tp - Sp))
    
    examplesFeature(length(examples)) = struct('featureSum', 0, 'class', 0, 'weight', 0);
    for i = 1:length(examples)
        featureSum = getDescriptor(examples(i).ii, feature);
        examplesFeature(i) = struct('featureSum', featureSum, 'class', examples(i).y, 'weight', examples(i).w);
    end
    
    cells = struct2cell(examplesFeature);
    cells = reshape(cells, [], length(examples))';
    cells = sortrows(cells, 1);
    
    sortedList = [cells{:}];
    sortedList = reshape(sortedList, length(examples), []);
    
    positiveIndices = find(sortedList(:, 2) == 1);
    negativeIndices = find(sortedList(:, 2) == 0);
    
    tp = sum(sortedList(positiveIndices, 3));
    tn = sum(sortedList(negativeIndices, 3));
    sp = 0;
    sn = 0;
    error = -1;
    thresholdId = 0;
    parity = 0;
    for i = 1:length(examples)
        if sortedList(i, 2) == 0
            sn = sn + sortedList(i, 3);
        else
            sp = sp + sortedList(i, 3);
        end
        
        if i ~= length(examples) && sortedList(i, 1) == sortedList(i + 1, 1)
            continue;
        end
        
        currentError = 0;
        currentParity = 0;
        
        if sp + tn - sn <= sn + tp - sp
            % the error contains sp so the examples will be classified as
            % negative in the left and positive in the right of the
            % threshold
            currentError = sp + tn - sn;
            currentParity = -1; 
        else
            % the positive in the left and the negative in the right
            currentError = sn + tp - sp;
            currentParity = 1;
        end
           
        if error < 0 || currentError < error
            error = currentError;
            thresholdId = i;
            parity = currentParity;
        end
    end
    
    threshold = 0;
    if thresholdId == length(examples)
        threshold = sortedList(thresholdId, 1) + 1;
    else
        threshold = (sortedList(thresholdId, 1) + sortedList(thresholdId + 1, 1)) / 2;
    end
        
    weakClassifier = struct('feature', feature, 'threshold', threshold, 'parity', parity);
    e = zeros(1, length(examples));
    for i = 1:length(examples)
        classification = parity * examplesFeature(i).featureSum < parity * threshold;
        e(i) = abs(classification - examplesFeature(i).class); 
    end
end