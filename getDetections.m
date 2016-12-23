function detections = getDetections(positiveSubWindows, partitions)
   noPartitions = length(partitions);
   detections(noPartitions) = struct('topLeft', NaN, 'topRight', NaN, 'bottomRight', NaN, 'bottomLeft', NaN);
   for i = 1:noPartitions
       topLeft = [0, 0];
       topRight = [0, 0];
       bottomRight = [0, 0];
       bottomLeft = [0, 0];
       
       for j = 1:length(partitions(i).partition)
           subWindowId = partitions(i).partition(j);
           topLeft = topLeft + positiveSubWindows(subWindowId).origin;
           topRight = topRight + positiveSubWindows(subWindowId).origin + [0, positiveSubWindows(subWindowId).width] - [0, 1];
           bottomRight = bottomRight + positiveSubWindows(subWindowId).origin + ...
                [positiveSubWindows(subWindowId).height,  positiveSubWindows(subWindowId).width] - [1, 1];
           bottomLeft = bottomLeft + positiveSubWindows(subWindowId).origin + [positiveSubWindows(subWindowId).height, 0] - [1, 0];
       end
       topLeft = floor(topLeft / length(partitions(i).partition));
       topRight = floor(topRight / length(partitions(i).partition));
       bottomRight = floor(bottomRight / length(partitions(i).partition));
       bottomLeft = floor(bottomLeft / length(partitions(i).partition));
       
       detections(i) = struct('topLeft', topLeft, 'topRight', topRight, 'bottomRight', bottomRight, 'bottomLeft', bottomLeft); 
   end
end