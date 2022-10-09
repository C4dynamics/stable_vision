function ppos = prismage_ex1(impath, showfigs)
% function prismage_ax1 gets an image of trinalges and returns their center
% in terms of [row, colomn].
% the triangles in the image should be enclosed by 10 by 10 pixels
% rectangle. 
% to draw the images before and after, set showfigs to true. 
%%

    im = imread(impath);
    [rows, ~, ~] = size(im);
    
    % filter 
%     imf = filter2(fspecial('average', 3), im) / 255; % 3 images. 
    imf = medfilt2(im, [20, 20]); % 3x3: 3 images, 7x7: 4 images, 10x10: 5 images. 
                                    % 25x25 none. 

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
        % find the first rows that have nonzero elements
        
        thisrow = ~isempty(nzr{i});
        
        if ~prevrow && thisrow % new triangle 
            pcol = nzr{i}(1);
            prow = i + 10;
            ppos = [ppos; [prow, pcol]]; %#ok<AGROW>
        end 
        
        
        prevrow = thisrow;
    end

    
    if showfigs      
        
        % original 
        subplot(1, 2, 1)
        imshow(im);
        title('Iamge 1')
        
        % processed
        subplot(1, 2, 2)
        imshow(vim);
        text(ppos(:, 2), ppos(:, 1), num2str([ppos(:, 2), 1000 - ppos(:, 1)]), 'color', 'blue', 'fontsize', 12) 
        title('Image 2')
        
        [~, fname] = fileparts(impath);
        saveas(gcf, ['ex1_' fname '.png'])
    end
end









