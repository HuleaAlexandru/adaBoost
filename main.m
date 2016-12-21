function main(imagePath)
	a = string('hello')
	
	pause;
	rgbImage = imread(imagePath);
	grayscaleImage = rgb2gray(rgbImage);
	
	grayscaleImage = zeros(5);
	for i = 1:5
		for j = 1:5
			grayscaleImage(i,j) = (i-1) * 5 + (j-1);
		end
	end
	
	grayscaleImage
	integralImg = computeIntegralImage(grayscaleImage);

	% generic creation of a feature
	origins = [3 3; 5 5];
	widths = [2; 2];
	heights = [2; 2];
	signs = [-1; 1];
	
	noOfFeatureChunks = length(signs);
	haarFeature = [];
	for i = 1:noOfFeatureChunks
		haarFeature = [haarFeature, struct('origin', origins(i,:), 'width', widths(i), 'height', heights(i), 'sign', signs(i))];
	end
	haarSum = getDescriptor(integralImg, haarFeature);
	
	% creation of a two rectangle feature
	origin = [3 3];
	width = 4;
	height = 4;
	
	twoRectanglehaarFeature = getHaarFeature(origin, width, height, '4');
	haarSum = getDescriptor(integralImg, twoRectanglehaarFeature)
end