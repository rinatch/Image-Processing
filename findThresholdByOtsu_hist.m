function [threshold_val, threshold_ind, var_w_vec, var_b_vec] = findThresholdByOtsu_hist(hist_x, hist_y) 
    % Initialize
    var_w_vec = []; % Within-class weighted variance
    var_b_vec = []; % Between class variance
    
    % threshold_val = 0
    hist_y = hist_y ./ sum(hist_y);
    
    % Calculate variances
    for i = 1:length(hist_x)-1
        q1 = sum(hist_y(1:i));
        q2 = sum(hist_y(i+1:end));
        mean1 = sum(hist_y(1:i) .* hist_x(1:i)) / q1;
        mean2 = sum(hist_y(i+1:end) .* hist_x(i+1:end)) / q2;
        var1 = sum( (hist_x(1:i)-mean1).^2 .* hist_y(1:i) ) / q1;
        var2 = sum( ((hist_x(i+1:end)-mean2).^2) .* hist_y(i+1:end) ) / q2;
        var_w_vec = [var_w_vec, q1*var1 + q2*var2];
        var_b_vec = [var_b_vec, q1*(1-q1)*((mean1-mean2).^2)];  
    end
    
    %take maximum of between-variance or min within-variance
    [~, ind] = max(var_b_vec);
%     [~, ind] = min(var_w_vec);
    threshold_ind = ind(1);
    threshold_val = hist_x(threshold_ind);
end