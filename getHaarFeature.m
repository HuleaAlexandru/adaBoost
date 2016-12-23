function haarFeature = getHaarFeature(origin, width, height, type)
	if strncmp(type, '2H', 2) 
		haarFeature = get2RectangleHorizontalFeature(origin, width, height);
	elseif strncmp(type, '2V', 2) 
		haarFeature = get2RectangleVerticalFeature(origin, width, height);
	elseif strncmp(type, '3H', 2) 
		haarFeature = get3RectangleHorizontalFeature(origin, width, height);
	elseif strncmp(type, '3V', 2) 
		haarFeature = get3RectangleVerticalFeature(origin, width, height);
	elseif strncmp(type, '4', 1)
		haarFeature = get4RectangleFeature(origin, width, height);
    elseif strncmp(type, 'C', 1)
        haarFeature = getCenteredRectangleFeature(origin, width, height);
	end
end

function haarFeature = get2RectangleHorizontalFeature(origin, width, height)
	% (-1, 1) - example of 2-rectangle horizontal feature; edge feature

	leftRectangle = struct('origin', origin, 'width', width / 2, 'height', height, 'sign', -1, 'type', '2H');
	rightRectangle = struct('origin', origin + [0, width / 2], 'width', width / 2, 'height', height, 'sign', 1, 'type', '2H');
	haarFeature = struct('haarFeatures', [leftRectangle, rightRectangle]);
end

function haarFeature = get2RectangleVerticalFeature(origin, width, height)
	% (-1, 1)' - example of 2-rectangle vertical feature; edge feature
	
	upRectangle = struct('origin', origin, 'width', width, 'height', height / 2, 'sign', -1, 'type', '2V');
	downRectangle = struct('origin', origin + [height / 2, 0], 'width', width, 'height', height / 2, 'sign', 1, 'type', '2V');
	haarFeature = struct('haarFeatures', [upRectangle, downRectangle]);
end

function haarFeature = get3RectangleHorizontalFeature(origin, width, height)
	% (-1, 1, -1) - example of 3-rectangle horizontal feature; line feature
	
	leftRectangle = struct('origin', origin, 'width', width / 3, 'height', height, 'sign', -1, 'type', '3H');
	middleRectangle = struct('origin', origin + [0, width / 3], 'width', width / 3, 'height', height, 'sign', 1, 'type', '3H');
	rightRectangle = struct('origin', origin + [0, 2 * width / 3], 'width', width / 3, 'height', height, 'sign', -1, 'type', '3H');
	haarFeature = struct('haarFeatures', [leftRectangle, middleRectangle, rightRectangle]);
end

function haarFeature = get3RectangleVerticalFeature(origin, width, height)
	% (-1, 1, -1)'  - example of 3-rectangle horizontal feature; line feature
	
	upRectangle = struct('origin', origin, 'width', width, 'height', height / 3, 'sign', -1, 'type', '3V');
	middleRectangle = struct('origin', origin + [height / 3, 0], 'width', width, 'height', height / 3, 'sign', 1, 'type', '3V');
	downRectangle = struct('origin', origin + [2 * height / 3, 0], 'width', width, 'height', height / 3, 'sign', -1, 'type', '3V');
	haarFeature = struct('haarFeatures', [upRectangle, middleRectangle, downRectangle]);
end

function haarFeature = get4RectangleFeature(origin, width, height)
	% (-1, 1; 1, -1) - example of 4-rectangle horizontal feature; four rectangle feature

	leftUpRectangle = struct('origin', origin, 'width', width / 2, 'height', height / 2, 'sign', -1, 'type', '4');
	rightUpRectangle = struct('origin', origin + [0, width / 2], 'width', width / 2, 'height', height / 2, 'sign', 1, 'type', '4');
	leftDownRectangle = struct('origin', origin + [height / 2, 0], 'width', width / 2, 'height', height / 2, 'sign', 1, 'type', '4');
	rightDownRectangle = struct('origin', origin + [height / 2, width / 2], 'width', width / 2, 'height', height / 2, 'sign', -1, 'type', '4');
	haarFeature = struct('haarFeatures', [leftUpRectangle, rightUpRectangle, leftDownRectangle, rightDownRectangle]);
end

function haarFeature = getCenteredRectangleFeature(origin, width, height)
    % (-1, -1, -1; -1, 1, -1; -1, -1, -1) - example of centered feature
    upRectangle = struct('origin', origin, 'width', width, 'height', height / 3, 'sign', -1, 'type', 'C');
    leftRectangle = struct('origin', origin + [0, height / 3], 'width', width / 3, 'height', height / 3, 'sign', -1, 'type', 'C');
    centerRectangle = struct('origin', origin + [width / 3, height / 3], 'width', width / 3, 'height', height / 3, 'sign', 1, 'type', 'C');
    rightRectangle = struct('origin', origin + [2 * width / 3, height / 3], 'width', width / 3, 'height', height / 3, 'sign', -1, 'type', 'C');
    downRectangle = struct('origin', origin + [0, 2 * height / 3], 'width', width, 'height', height / 3, 'sign', -1, 'type', 'C');
    haarFeature = struct('haarFeatures', [upRectangle, leftRectangle, centerRectangle, rightRectangle, downRectangle]);
end