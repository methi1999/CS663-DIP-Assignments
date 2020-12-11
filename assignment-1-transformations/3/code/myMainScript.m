
clear
clc
tic;
%% Q3a
% We note that, intuitively, the exact original distribution of the histogram $h(I)$ does
% not matter in deriving the mean intensity of the image after performing
% equalization across the two regions. We demonstrate this fact by a simple
% proof.
%
% After equalization is performed, the distribution is uniform on $[0,a]$
% and $(a,1]$, with a probability mass of $\alpha$ in $[0,a]$. Let us
% calculate the expected mean after equalization. The expected mean is
% equal to $E[X]$, where $X$ is a random sample drawn from this distribution.
% We have
%
% $E[X] = \int_{x=0}^{x=a}xf(x)dx + \int_{x=a}^{x=1}xf(x)dx$
% 
% We note that, if $x \in [0,a], f(x) = \frac{\alpha}{a}$, and if $x \in
% (a,1], f(x) = \frac{1-\alpha}{1-a}$.
%
% Integrating, we get 
% $E[X] = \frac{1+a-\alpha}{2}.$
%% Q3b
% Continuing the previous question, we note that when $a$ is the median,
% then we necessarily have $\alpha = \frac{1}{2}$. Thus, plugging this in
% to the previous formula, we have 
% $E[X] = \frac{2a+1}{4}.$ 
%
% An important point to understand why we cannot simplify the answer
% further, i.e actually find the set of values of $a$ that are both mean
% and median, is to show that actually all $a$ can be both the mean and the
% median and thus the extra condition on $a$ being the mean of the original
% distribution is useless. A simple proof runs like this: assume the entire
% pdf to be concentrated on a point $a$. This point will be both mean and
% median of it's distribution; hence, every point can satisfy such a
% property.
%% Q3c
% We believe such a method (as described in part b) holds promise on
% underexposed or over exposed images. Such images contain a peak in their
% histogram at an extrema (very low or very high intensity). When
% conventional histogram equalization is applied, contrast is lost in such
% an image. For example if conventional histogram equalisation were applied
% to an under exposed image dark shades would get mapped to a brighter one.
% On the other hand if a median based piece wise equalisation is performed
% we can ensure that a dark tone can only be remapped to another value
% locally. This improves the contrast of the image, as can be observed in
% part d.
%% Q3d
% As can be observed below, conventional histogram equalisation maps black
% values to grey which is an undesirable manipulation of the image, whereas
% piece wise histogram equalization manages to bring out similar detail 
% among higher intensity pixels without ruining contrast. 
[orig, new] = myIntensitytxm('../data/underexposedimage.jpg');
[orig1, new1] = myHE('../data/underexposedimage.jpg');

subplot(3,2,1),imagesc(orig);
title('Original Image');
colorbar;
subplot(3,2,2);
plot(imhist(orig));
xlabel('Intensity');
ylabel('No. of pixels')
title('Histogram');
subplot(3,2,3),imagesc(new);
title('Piecewise Histogram Equalised');
colorbar;
subplot(3,2,4);
plot(imhist(new));
xlabel('Intensity');
ylabel('No. of pixels')
title('Histogram');
subplot(3,2,5),imagesc(new1);
title('Histogram Equalised')
colorbar;
subplot(3,2,6);
plot(imhist(new1));
xlabel('Intensity');
ylabel('No. of pixels')
title('Histogram');
axis tight;
colormap gray;
toc;