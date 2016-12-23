function partitions = getPartitions(positiveSubWindows)
   sets = 1:length(positiveSubWindows);
   for i = 2:length(positiveSubWindows)
       for j = 1:i-1
           if sets(i) == sets(j)
               continue;
           end
           sameSet = overlap(positiveSubWindows(i), positiveSubWindows(j));
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
   
   for i = 2:length(positiveSubWindows)
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
end