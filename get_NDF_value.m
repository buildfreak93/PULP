function filter_value = get_NDF_value(resultsset)
    
    
        %filter_value = Shuffle(filter_value); NDF = filter_value(1);
        filter_value = filter_value(1,randperm(size(filter_value,2))); NDF = filter_value(1,1);
        [results_row1,results_column1] = find(results(:,1) == NDF);
        if results(results_row1,trials+1) > 0
            continue
        elseif results(results_row1,trials+1) == 0
            break
        end
    
end
