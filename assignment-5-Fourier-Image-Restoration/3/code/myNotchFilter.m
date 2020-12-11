function [filtered] = myNotchFilter(fourier, u, v, notch, w)
filtered = fourier;

cx = int16(size(fourier, 1)/2)+1;
cy = int16(size(fourier, 2)/2)+1;

disp_u = u - cx;
disp_v = v - cy;

filtered(cx+disp_u-w:cx+disp_u+w, cy+disp_v-w:cy+disp_v+w) = filtered(cx+disp_u-w:cx+disp_u+w, cy+disp_v-w:cy+disp_v+w).*notch;
filtered(cx-disp_u-w:cx-disp_u+w, cy-disp_v-w:cy-disp_v+w) = filtered(cx-disp_u-w:cx-disp_u+w, cy-disp_v-w:cy-disp_v+w).*notch;