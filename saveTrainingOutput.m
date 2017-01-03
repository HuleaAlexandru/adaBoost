function saveTrainingOutput(outputFile, strongClassifier, subWindowSize)
    fid = fopen(outputFile, 'wt');
    weakClassifiers = strongClassifier.weakClassifiers;
    %fprintf(fid, '%% weakClassifiers\n');
    fprintf(fid, '%i\n', length(weakClassifiers));
    for i = 1:length(weakClassifiers)
        weakClassifier = weakClassifiers(i);
        h = weakClassifier.h;
        alfa = weakClassifier.alfa;
        %fprintf(fid, '%% h\n');
        haarFeatures = h.feature.haarFeatures;
        weakThreshold = h.threshold;
        parity = h.parity;
        
        %fprintf(fid, '%% haarFeatures: origin width height sign\n');
        %fprintf(fid, '%% type\n');
        fprintf(fid, '%s\n', haarFeatures(1).type);
        fprintf(fid, '%i\n', length(haarFeatures));
        for j = 1:length(haarFeatures)
            haarFeature = haarFeatures(j);
            origin = haarFeature.origin;
            width = haarFeature.width;
            height = haarFeature.height;
            sign = haarFeature.sign;
            fprintf(fid, '%i %i %i %i %i\n', origin(1), origin(2), width, height, sign);
        end
        %fprintf(fid, '%% weakThreshold and parity\n');
        fprintf(fid, '%f %i\n', weakThreshold, parity);
        
        %fprintf(fid, '%% alfa\n');
        fprintf(fid, '%f\n', alfa);
    end         
    strongThreshold = strongClassifier.strongThreshold;
    %fprintf(fid, '%% strongThreshold\n');
    fprintf(fid, '%f\n', strongThreshold);
    %fprintf(fid, '%% subWindowSize\n');
    fprintf(fid, '%i %i', subWindowSize(1), subWindowSize(2));
    fclose(fid);
end