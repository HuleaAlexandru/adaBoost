function [strongClassifier, subWindowSize] = loadTrainingOutput(inputFile)
    fid = fopen(inputFile, 'r');
    
    line = fgetl(fid);
    result = sscanf(line, '%i');
    noWeakClassifiers = result(1);
    weakClassifiers(noWeakClassifiers) = struct('h', NaN, 'alfa', NaN);
    for i = 1:noWeakClassifiers
        type = fgetl(fid);
        
        line = fgetl(fid);
        result = sscanf(line, '%i');
        noHaarFeatures = result(1);
        haarFeatures(noHaarFeatures) = struct('origin', NaN, 'width', NaN, 'height', NaN, 'sign', NaN, 'type', NaN);
        for j = 1:noHaarFeatures
            line = fgetl(fid);
            result = sscanf(line, '%i %i %i %i %i');
            haarFeatures(j).origin = [result(1), result(2)];
            haarFeatures(j).width = result(3);
            haarFeatures(j).height = result(4);
            haarFeatures(j).sign = result(5);
            haarFeatures(j).type = type;
        end
        feature = struct('haarFeatures', haarFeatures);
        
        line = fgetl(fid);
        result = sscanf(line, '%f %i');
        weakThreshold = result(1);
        parity = result(2);
        h = struct('feature', feature, 'threshold', weakThreshold, 'parity', parity);
        
        line = fgetl(fid);
        result = sscanf(line, '%f');
        alfa = result(1);
        
        weakClassifiers(i).h = h;
        weakClassifiers(i).alfa = alfa;
    end
    
    line = fgetl(fid);
    result = sscanf(line, '%f');
    strongThreshold = result(1);
    strongClassifier = struct('weakClassifiers', weakClassifiers, 'strongThreshold', strongThreshold);
    
    line = fgetl(fid);
    result = sscanf(line, '%i %i');
    subWindowSize = [result(1), result(2)];
    fclose(fid);
end