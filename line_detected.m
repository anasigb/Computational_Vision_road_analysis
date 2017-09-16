function [H] = line_detected(hough,theta,raw,X,Y)    
 line_detected=zeros(X,Y);
for m=1:6157%the sizes of the hough matrix
    for n=1:321
        if(hough(m,n)>280)
           for x=1:X
                for y=1:Y
                   raw2 = x*cosd(theta(1,n)) + y*sind(theta(1,n));
                    if (raw2<0.5)
                     raw2=floor(raw2);
                    end
                    if (raw2>0.5)
                     raw2=ceil(raw2);
                    end
                   if(raw2==raw(1,m))
                      line_detected(x,y)=1;
                   end
               end  
            end
        end
    end
end
H=line_detected;