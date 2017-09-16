I = imread('road.jpg');
gray=rgb2gray(I);
edges=edge(gray,'sobel');
figure(1);
imshow(edges);
title('edges')
%% hough's transformation according to it's matrix
[X,Y]=size(edges);
theta = -(80):0.5:(80); %not all degrees because we don't want the vertical lines
    max_roh=0;
    for theta_index=1:321
       roh=X*cosd(theta_index)+Y*sind(theta_index);
       if (roh>max_roh)%% we need to get the maximum roh to build a matrix 
         max_roh=roh;
       end
    end
    
roh = -ceil(max_roh):0.5:ceil(max_roh);
base=ceil(max_roh);
hough = zeros(6157,321);%the sizes of theta and the raw vectors
for x=1:X
    for y=1:Y
       if (edges(x,y)==1)%if there is an edge in these coordinates
            for theta_index=1:321  
                     roh_index=x*cosd(theta(theta_index))+y*sind(theta(theta_index)); % find it's suitable theta and roh
                    if (roh_index<0.5)
                     roh_index=floor(roh_index);
                    elseif (roh_index>0.5)
                     roh_index=ceil(roh_index);
                    end                             %we found it according to its domain 
                     roh_index = (base+roh_index)*2 +1; %so we need to sheft it according to matrix base
                     hough(roh_index,theta_index) = hough(roh_index,theta_index) + 1; %%increase the number of points that associate these coordinates
             end
         end
    end
end

%% display the result
figure(2);
imagesc(hough);
title('hough"s tranformations for the input picture')

%% searching for road lines
line_detected=zeros(X,Y);
for rohs_iter_index=1:6157 %the sizes of the hough matrix
    for j=1:321
        if(hough(rohs_iter_index,j)>280)
           for x=1:X
                for y=1:Y
                   roh_index = x*cosd(theta(j)) + y*sind(theta(j));%%find the roh index of these x,y coordinates
                    if (roh_index<0.5)
                     roh_index=floor(roh_index);
                    elseif (roh_index>0.5)
                     roh_index=ceil(roh_index);
                    end
                   if(roh_index==roh(1,rohs_iter_index))
                      line_detected(x,y)=1;
                   end
               end  
            end
        end
    end
end

road_line_points=line_detected.*edges;
figure(3);
imagesc(road_line_points);
title('road lines')

            
            
 