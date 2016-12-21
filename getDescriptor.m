function haarSum = getDescriptor(integralImg, feature)
	% haarFeature is an struct that contains an array of haarFeatureChunks and represents a matrix of weights for the window's elements 
	% haarFeatureChunk is a struct(origin, width, height, sign)
	% the origin represents the point with the lower x and y coordinates
	% sign +/- 1
	haarSum = 0;
	haarFeatureArray = feature.haarFeatures;
	
	dimImage = size(integralImg) - [1,1];
	noOfFeatureChunks = length(haarFeatureArray);
	
	for i = 1:noOfFeatureChunks
		origin = haarFeatureArray(i).origin;
		width = haarFeatureArray(i).width;
		height = haarFeatureArray(i).height;
		sign = haarFeatureArray(i).sign;
	
		dimHaarFeatureChunk = [height, width];
		topLeft = max([1,1], origin);
		bottomRight = min(origin + dimHaarFeatureChunk - [1,1], dimImage);
        chunkSum = 0;
        if topLeft(1) <= bottomRight(1) && topLeft(2) <= bottomRight(2)
            chunkSum = sign * getRectangleSumIntegralImage(integralImg, topLeft, bottomRight);
        end
        haarSum = haarSum + chunkSum;
	end
end