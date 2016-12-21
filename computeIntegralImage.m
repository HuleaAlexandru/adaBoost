function integralImg = computeIntegralImage(grayscaleImage)
	% the only visible function outside the file; choose an implementation of integral image
	integralImgageAutomatically = compuseIntegralImageAutomatically(grayscaleImage);
	integralImageByHand = computeIntegralImageByHand(grayscaleImage);
	
	integralImg = integralImageByHand;
end

function integralImg = compuseIntegralImageAutomatically(grayscaleImage)
	% the integralImage has the first row and the first column filled with zeros; local function
	integralImg = integralImage(grayscaleImage);
end

function integralImg = computeIntegralImageByHand(grayscaleImage)
	% the integralImage has the first row and the first column filled with zeros; local function
	integralImg = double(zeros(size(grayscaleImage, 1) + 1, size(grayscaleImage, 2) + 1));
	castedImage = double(grayscaleImage);
	
	for i = 2:size(grayscaleImage, 1) + 1
		for j = 2:size(grayscaleImage, 2) + 1
			integralImg(i, j) = castedImage(i - 1, j - 1) + integralImg(i, j - 1) + ...
				integralImg(i - 1, j) - integralImg(i - 1, j - 1);
		end
	end
end