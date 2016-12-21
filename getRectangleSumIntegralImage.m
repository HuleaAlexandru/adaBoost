function rectangleSum = getRectangleSumIntegralImage(integralImg, topLeft, bottomRight)
	% vertices are in order top left, top right, bottom left, bottom right
	% for example topLeft = 1,1 ; bottomRight = 2,2 => the rectangle contains the squares (1,1), (1,2), (2,1), (2,2)
	topRight = [topLeft(1), bottomRight(2)];
	bottomLeft = [bottomRight(1), topLeft(2)];
	rectangleSum = integralImg(bottomRight(1) + 1, bottomRight(2) + 1) + integralImg(topLeft(1), topLeft(2)) - ...
		integralImg(topRight(1), topRight(2) + 1) - integralImg(bottomLeft(1) + 1, bottomLeft(2)); 
end