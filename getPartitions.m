function [partitions, tPositiveSubWindows] = getPartitions(positiveSubWindows, minNeighbours)
   positiveSubWindowIndices = zeros(1, length(positiveSubWindows));
   
   for i = 1:length(positiveSubWindows)
       noNeighbours = 0;
       for j = 1:length(positiveSubWindows)
           if i == j
               continue
           end
           noNeighbours = noNeighbours + overlap(positiveSubWindows(i), positiveSubWindows(j));
       end
       positiveSubWindowIndices(i) = noNeighbours >= minNeighbours;
   end

   tPositiveSubWindows = positiveSubWindows(positiveSubWindowIndices == 1);
   if ~isempty(tPositiveSubWindows)
       sets = 1:length(tPositiveSubWindows);
       
       for i = 2:length(tPositiveSubWindows)
           for j = 1:i-1
               if sets(i) == sets(j)
                   continue;
               end
               sameSet = overlap(tPositiveSubWindows(i), tPositiveSubWindows(j));
               if sameSet
                   k = j;
                   while k ~= sets(k)
                       k = sets(k);
                   end
                   l = i;
                   while l ~= sets(l)
                       l = sets(l);
                   end
                   minIndex = min(sets(l), sets(k));
                   sets(l) = minIndex;
                   sets(k) = minIndex;
               end
           end
       end

       for i = 2:length(tPositiveSubWindows)
           j = i;
           while j ~= sets(j)
               j = sets(j);
           end
           sets(i) = j;
       end
       
      
       uniqueSets = unique(sets);
       partitions(length(uniqueSets)) = struct('partition', NaN);
       for i = 1:length(uniqueSets)
           setId = uniqueSets(i);
           partitions(i).partition = find(sets == setId);
       end
   else
       partitions = [];
   end    
end