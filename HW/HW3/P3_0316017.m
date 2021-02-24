function [ output_args ] = P3_0316017( path )

% get the jpg file in jpgfile
jpgfiles = dir([path '\*.jpg']);
% get jpg size
[jpgnum t] = size(jpgfiles);
jpgcount = 1;
c='z';
nojpg = 0;
highlighsize = 50;
pt = [50 50];
f1 = figure('Name','f1','Position',[0,150,650,500]);

if jpgnum < 1 
    figure(f1);
    nojpg = 1;
else
    figure(f1);
    hold on;
    tempstring = [path '\' jpgfiles(jpgcount).name];
    pic = imread(tempstring);
    % set the 
    pic = setpic(path,jpgfiles,jpgcount,pic);
    imshow(pic);
    title(['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgfiles(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%']);
end

while 1
    if nojpg == 1
        break;
    end
    tt = waitforbuttonpress;
    if tt == 1
        c = get(gcf, 'CurrentCharacter');
        key = get(gcf,'CurrentKey');
        if c == '<'
            % show jpgs
            
            figure(2);
            close(2);
            
            figure(f1);
            jpgcount = (jpgcount-1);
            if jpgcount == 0
                jpgcount = jpgcount + jpgnum;
            end
            pic = setpic(path,jpgfiles,jpgcount,pic);
            imshow(pic);
            title(['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgfiles(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%']);
        elseif c == '>'
            figure(2);
            close(2);
            
            figure(f1);
            jpgcount = (jpgcount+1);
            if jpgcount > jpgnum
                jpgcount = jpgcount - jpgnum;
            end
            pic = setpic(path,jpgfiles,jpgcount,pic);
            imshow(pic);
            title(['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgfiles(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%']);
        % set the size( min max ) as (50  100)
        elseif c == '+'
            if highlighsize < 100
                highlighsize = highlighsize + 10;
                pt= set (pt ,highlighsize , pic ,f1);
                title(['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgfiles(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%']);
            end
        elseif c == '-'
            if highlighsize > 50
                highlighsize = highlighsize - 10;
                pt= set (pt ,highlighsize , pic,f1 );
                title(['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgfiles(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%']);
            end
        elseif strcmp(key,'leftarrow') %up 38 left 37  right 39 down 40
            pt(1) = pt(1) - 50;
            pt= set (pt ,highlighsize , pic,f1 );
            title(['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgfiles(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%']);
        elseif strcmp(key,'uparrow')
            pt(2) = pt(2) - 50;
            pt= set (pt ,highlighsize , pic,f1 );
            title(['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgfiles(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%']);
        elseif strcmp(key,'rightarrow')
            pt(1) = pt(1) + 50;
            pt= set (pt ,highlighsize , pic ,f1);
            title(['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgfiles(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%']);
        elseif strcmp(key,'downarrow')
            pt(2) = pt(2) + 50;
            
            pt= set (pt ,highlighsize , pic ,f1);
            title(['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgfiles(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%']);
        else
            c
        end
        
       % process key board inputs
    else
        rrr = get(gca, 'CurrentPoint');
        pt = rrr(1, 1:2)
        %set square 101*101
        pt= set (pt ,highlighsize , pic ,f1);
        title(['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgfiles(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%']);
        if c == 'q'
            break;
        end
    end
    
    
end

end


function [pic] = setpic(path,jpgfiles,jpgcount,pic)
            tempstring = [path '\' jpgfiles(jpgcount).name];
            pic = imread(tempstring);
            [pica picb picc] = size(pic);
            if(picb > 640 || pica > 480)
               pic=imresize(pic,[480 640],'nearest'); 
            else
                tempzeros = zeros(480,640,3,'uint8');
                tempa = ceil((480 - pica)/2);
                tempb = ceil((640 - picb)/2);
                tempzeros(tempa:tempa+pica-1,tempb:tempb+picb-1,1) = pic(:,:,1);
                tempzeros(tempa:tempa+pica-1,tempb:tempb+picb-1,2) = pic(:,:,2);
                tempzeros(tempa:tempa+pica-1,tempb:tempb+picb-1,3) = pic(:,:,3);
                pic = tempzeros;
            end
end

function [pt] = set (pt ,highlighsize , pic ,f1)
        figure(2);
        % handle the 
        if (pt(1)<=0 || pt(1)>=640)
            figure(f1);
            imshow(pic);
            close(2);
            return;
        end
         if pt(2)<=0 || pt(2) >=480
             figure(f1);
             imshow(pic);
             close(2);
             return;
         end
        if pt(1) < highlighsize+1
            pt(1) = highlighsize+1;
        elseif pt(1) > (640 - highlighsize)
            pt(1) = 640-highlighsize;
        end
        if pt(2) < highlighsize + 1
            pt(2) = highlighsize + 1;
        elseif pt(2) > (480 - highlighsize)
            pt(2) = 480-highlighsize;
        end
        temppic = pic (pt(2)-highlighsize:pt(2)+highlighsize , pt(1)-highlighsize:pt(1)+highlighsize,:);
        temppic = imresize(temppic,[highlighsize*4 highlighsize*4],'nearest');
        imshow(temppic);
        figure(f1);
        picwithrec = insertShape(pic,'Rectangle',[pt(1)-highlighsize , pt(2)-highlighsize , highlighsize*2 , highlighsize*2],'LineWidth',5);
        imshow(picwithrec);
end



