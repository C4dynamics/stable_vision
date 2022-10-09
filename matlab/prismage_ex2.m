function ppos = prismage_ex2(impath, showfigs)
% function prismage_ax2 gets an image of trinalges and returns their center
% in terms of [row, colomn].
% to draw the images before and after, set showfigs to true. 
%%

    im = imread(impath);
    [rows, ~, ~] = size(im);
    
    % filter 
%     imf = filter2(fspecial('average', 3), im) / 255;
    imf = medfilt2(im, [20, 20]); %  
    
    

    % augment 
    imrgb = cat(3, imf, imf, imf);
    
    % convert to hsv
    imhsv = rgb2hsv(imrgb);
%     him = imhsv(:, :, 1);
%     sim = imhsv(:, :, 2);
    vim = imhsv(:, :, 3);
    
    % collect nonzeros in each row
    nzr = cell(rows, 1);
    for r = 1 : rows
        nzr{r} = find(vim(r, :) > 0.5);
    end

    % find positions by true pixels 
    ppos = [];
    
    prevrow = false;
    for i = 1 : length(nzr)
        % four options:
        %   1) not around a triangle.
        %   2) starting a triangle.
        %   3) in a middle of a triangle. 
        %   4) immediately after a triangle. 
        
        thisrow = ~isempty(nzr{i});
        
        if ~prevrow && thisrow % triangle start
            prow = i;
            pcol = nzr{i}(round(numel(nzr{i}) / 2));
            ppos = [ppos; [prow, pcol]]; %#ok<AGROW>
        elseif prevrow && ~thisrow % traingle end 
            theight = i - 1 - ppos(end, 1);
            ppos(end, 1) = ppos(end, 1) + theight / 2; 
        end 
        
        prevrow = thisrow;
    end

    
    if showfigs && ~isempty(ppos)
        
        % original 
        subplot(1, 2, 1)
        imshow(im);
        title('Iamge 1')
        
        % processed
        subplot(1, 2, 2)
        imshow(vim);
        text(ppos(:, 2), ppos(:, 1), num2str(round([ppos(:, 2), 1000 - ppos(:, 1)])), 'color', 'blue', 'fontsize', 12) 
        title('Image 2')
        [~, fname] = fileparts(impath);
        saveas(gcf, ['ex2_' fname '.png'])
    end
end









