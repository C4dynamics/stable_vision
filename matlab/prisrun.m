

% 
% exercise 1
%%
fol = [pwd '\test\X1'];
xfiles = dir([fol '\*.png']);

for x = 1 : length(xfiles)
    close all
    prismage_ex1([fol '\' xfiles(x).name], 1)
end


% 
% exercise 2
%%
fol = [pwd '\test\X2'];
xfiles = dir([fol '\*.png']);

for x = 1 : length(xfiles)
    close all
    prismage_ex2([fol '\' xfiles(x).name], 1)
end


% 
% exercise 3
%%
fol = [pwd '\test\X3'];
xfiles = dir([fol '\*.png']);

for x = 1 : length(xfiles)
    close all
    prismage_ex3([fol '\' xfiles(x).name])
end










