function result = overlap(subWindow1, subWindow2)
    result = 1;

    minOx1 = subWindow1.origin(2);
    minOy1 = subWindow1.origin(1);
    maxOx1 = subWindow1.origin(2) + subWindow1.width - 1;
    maxOy1 = subWindow1.origin(1) + subWindow1.height - 1;
    
    minOx2 = subWindow2.origin(2);
    minOy2 = subWindow2.origin(1);
    maxOx2 = subWindow2.origin(2) + subWindow2.width - 1;
    maxOy2 = subWindow2.origin(1) + subWindow2.height - 1;
    
    if minOx1 > maxOx2 || minOx2 > maxOx1
        result = 0;
    end
    if minOy1 > maxOy2 || minOy2 > maxOy1
        result = 0;
    end
end