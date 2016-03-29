data = textread('F:\slide\Q3\wireless networking\signal');
figure(1), plot(data);
% Signal encoding part
[m n] = size(data);                                            %signal size
pth = find(0.35<data<0.3);                                     %set the threshold between 0.35 and 0.3
[m1 n1] = size(pth);                                           %get the threshold point
t=1;
signal=[];                                                     %built an empty array to put signal code sequence
for(i = 2:m1-1)
    level = pth(i+1)-pth(i);
    if(level>300)                                              % FM0 decoder 
        a=pth(i);                                              
        b=pth(i+1);
        data_bs = data(a:b);
        a = find(0.625<data_bs);
        data_bs(a)=1;
        b=find(0.625>data_bs);
        data_bs(b)=0;
        btag=(diff(data_bs)==1|diff(data_bs)==-1); 
        flip = find(btag == 1);
        m2 = size(flip);
        for(j = 1:m2-1)
            d = flip(j+1)-flip(j);
            if((d<10)&&(d>6))
                m=signal(1,t-1);
                if(m==0)                                        %0 corresponding two times voltage change in a period so we should 
                else                                            %skip one when the last code already is 0
                                                           
                signal(1,t)=0;
                
                t=t+1;
                end
            end
            if((d>10)&&(d<19))
                signal(1,t)=1;
                t=t+1;
            end
            if((d>19)&&(d<30))
                signal(1,t)='v';
                t=t+1;  
            end
            if(d>30)
                signal(1,t)=3;
                t=t+1;
            end
          
        end
        
    end
    if((level<500)&&(level>150))                               % reader signal tell the real code begin to transmit
        for(j=pth(i):pth(i+1))
            data(j)=2;
        end
        signal(1,t)=2;
        t=t+1;
    end
    if((level<150)&&(level>70))                                % reader signal 1
        for(j=pth(i):pth(i+1))
            data(j)=1;
        end
        signal(1,t)=1;
        t=t+1;
    end
    if((10<level)&&(level<70))                                 %reader signal 0
        for(j=pth(i):pth(i+1))
            data(j)=0;
        end;
        signal(1,t)=0;
        t=t+1;
    end
    if(level<10)               
        for(j=pth(i):pth(i+1))
            data(j)=0.5;
        end
    end

end
figure,plot(data);
fid = fopen('code.txt','w');                                   % put the signal code in txt file
fprintf(fid,'%g',signal);
fclose(fid);