function [hough] = my_hough(edge,theta,raw,X,Y)
hough = zeros(6157,321);%the sizes of theta and the raw vectors
for x=1:X
    for y=1:Y
       if (edge(x,y)==1)
            for i=1:321  
                     raw2=x*cosd(theta(1,i))+y*sind(theta(1,i));
                    if (raw2<0.5)
                     raw2=floor(raw2);
                    end
                    if (raw2>0.5)
                     raw2=ceil(raw2);
                    end
                     position = (raw2 - raw(1,1))/0.5;
                     hough(position+1,i) = hough(position+1,i) + 1;
             end
         end
    end
end
