function prismage_ex3(impath)
% function prismage_ax3 extracts 100 unknown objects from a noisy image.
% to draw the images before and after, set showfigs to true. 
%%

    im = imread(impath);
    [rows, ~, ~] = size(im);
    
%     for nn = 1 : 30
    % filter 
    nn = 11;
%     imf = filter2(fspecial('average', 3), im) / 255;
    imf = medfilt2(im, [nn, nn]); %  
    
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

%     disp([num2str(nn) ', ' num2str(length(ppos))]);
                % 1, 2
                % 2, 2
                % 3, 2
                % 4, 2
                % 5, 2
                % 6, 2
                % 7, 12
                % 8, 442
                % 9, 539
                % 10, 239
                    % 11, 97
                % 12, 30
                % 13, 17
                % 14, 10
                % 15, 4
                % 16, 2
                % 17, 2
                % 18, 0
                % 19, 0
                % 20, 0
                % 21, 0
                % 22, 0
                % 23, 0
                % 24, 0
                % 25, 0
                % 26, 0
                % 27, 0
                % 28, 0
                % 29, 0
                % 30, 0
%     end
    

    % extract one of them 
    istar = 1;
    ifocus = 15;
    im2 = vim(ppos(istar, 1) - ifocus : ppos(istar, 1) + ifocus, ppos(istar, 2) - ifocus : ppos(istar, 2) + ifocus);

        
    % original 
    subplot(1, 2, 1)
    imshow(im);
    title('Iamge 1')

    % processed
    subplot(1, 2, 2)
    imshow(im2);
    title('Image 2')
    text(6, 15, 'X', 'color', 'blue', 'fontsize', 300) 
    
    [~, fname] = fileparts(impath);
    saveas(gcf, ['ex3_' fname '.png'])
end









