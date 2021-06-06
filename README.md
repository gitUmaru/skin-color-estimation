# Skin Color Estimation

## About
This code repository is attempts to implement a color model space and skin detection technique of two papers.
1. [A novel skin color model in YCbCr color space and its application to human face detection](https://ieeexplore.ieee.org/document/1038016)
2. [Skin Detection Based on Image Color Segmentation with Histogram and
K-Means Clustering](http://www.eleco.org.tr/openconf_2017/modules/request.php?module=oc_proceedings&action=view.php&id=248&file=1/248.pdf&a=Accept+as+Lecture)

I am planning to use this code to determine the skin color of patient with inflammatory skin conditions. By segmenting the diseased area and only considering the non-diseased area for skin color computation.  The process follows these steps: training a novel skin color model, creating an initial mask to segment diseased skin, and creating a final mask. Using the first paper that I’ve mentioned, I created skin clusters in the YCbCr space. This let me compute the centroid and covariance of several clusters and a mean cluster. Once I developed the mean cluster that incorporated enough skin color, I began to run an initial inference to get a preliminary mask. Lastly, I used thresh holding techniques (Ostu's method) and experimental values found in the paper to further mask the image.


I initially used the implementation by [kamiry](https://github.com/kamiry/Skin-Color-Model), and later built upon it, which was an implementation of the first paper ([1]((https://ieeexplore.ieee.org/document/1038016))).

## Packages
- Tensor Flow
- Keras
- Scikit Learn

## Installation
The following software requires that you have a copy of MATLAB R2020a (or greater) or a compatible version of Octave GNU. I used the following add-ons for MATLAB:
1. [Image Processing Toolbox](https://www.mathworks.com/products/image.html)
2. [Plot Gaussian Ellipsoid](https://www.mathworks.com/matlabcentral/fileexchange/16543-plot_gaussian_ellipsoid)

### Running
You need to specify the image directory in the `main.m` file. After which, you can run the `main.m` MATLAB script.

## Results
![results](https://raw.githubusercontent.com/gitUmaru/skin-color-estimation/main/comperative%20results/full_results.JPG)


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
