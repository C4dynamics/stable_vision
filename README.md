# stable_vision

the functions in this project identify isosceles triangles in noisy images and return their size and position. 
another function identifies unknown goemetric shape in a noisy image.  
the noise reduction in the matlab programs is done by using a median filter. in the python programs by 2d fft.

data: 
test/X1: noisy images with different number of isosceles triangles bounded within a 20-pixels rectangle. 
test/X2: noisy images with different number of isosceles triangles of unknown size (20-200 pixels bounding rectangle).   
test/X3: a single noisy image of 100 replicas of a 20-pixels unknown shape.

matlab: matlab functions to process the test data
python: python functions to process the test data.








