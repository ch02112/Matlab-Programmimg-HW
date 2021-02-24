function [ a ] = P1_0316017( boardsize , minenum )
% boardsize :  2-element vector representing the board size
% minenum : mine number

%create matrix
map = zeros(boardsize(1),boardsize(2));
f1 = zeros(boardsize(1),boardsize(2));
f2 = zeros(boardsize(1),boardsize(2));
f3 = zeros(boardsize(1),boardsize(2));
f4 = zeros(boardsize(1),boardsize(2));
ff1 = zeros(boardsize(1),boardsize(2));
ff2 = zeros(boardsize(1),boardsize(2));
ff3 = zeros(boardsize(1),boardsize(2));
ff4 = zeros(boardsize(1),boardsize(2));

% random the mine
k = randperm(boardsize(1).*boardsize(2));
map(k(1:minenum)) = 9;

% count numbers 
f1(:,1:boardsize(2)-1)= (map(:,2:boardsize(2))>map(:,1:boardsize(2)-1));
f2(:,2:boardsize(2))= (map(:,2:boardsize(2))<map(:,1:boardsize(2)-1));
f3(1:boardsize(1)-1,:)= (map(2:boardsize(1),:)>map(1:boardsize(1)-1,:));
f4(2:boardsize(1),:)= (map(2:boardsize(1),:)<map(1:boardsize(1)-1,:));
ff1(1:boardsize(1)-1,1:boardsize(2)-1)=(map(2:boardsize(1),2:boardsize(2))>map(1:boardsize(1)-1,1:boardsize(2)-1));
ff2(2:boardsize(1),2:boardsize(2))=(map(2:boardsize(1),2:boardsize(2))<map(1:boardsize(1)-1,1:boardsize(2)-1));
ff3(1:boardsize(1)-1,2:boardsize(2))=(map(2:boardsize(1),1:boardsize(2)-1)>map(1:boardsize(1)-1,2:boardsize(2)));
ff4(2:boardsize(1),1:boardsize(2)-1)=(map(2:boardsize(1),1:boardsize(2)-1)<map(1:boardsize(1)-1,2:boardsize(2)));

temp = map+f1+f2+f3+f4+ff1+ff2+ff3+ff4+1;

% get the row col and value
[m_t,k_t,val]=find(temp);



%create a n*n(10) square and draw lines
x=ceil((1:size(temp,2) * 10) / 10);
y=ceil((1:size(temp,1) * 10) / 10);
[xx,yy] = meshgrid ( x , y );
temp2 = sub2ind(size(temp) , yy , xx );
t = temp(temp2);
t(:,1:10:end) = 11;
t(1:10:end,:) = 11;
t(end,:) = 11;
t(:,end) = 11;
% set and draw mines
for(i = 1:size(val))
    if( val(i) == 10 )
        t(m_t(i)*10-8,k_t(i)*10-8:k_t(i)*10) = 11;
        t(m_t(i)*10,k_t(i)*10-8:k_t(i)*10) = 11;
        t(m_t(i)*10-8:m_t(i)*10,k_t(i)*10-8) = 11;
        t(m_t(i)*10-8:m_t(i)*10,k_t(i)*10) = 11;
    end
end


% RGB matrix
mmm4 = [0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 0.0;
        0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.0 0.0;
        0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.0 0.0];

% draw picture
RGB = ind2rgb(t,mmm4');
imshow(RGB);

%draw text
for(i = 1:size(val))
    if(val(i)<10 && val(i)>1)
        text(k_t(i)*10-5,m_t(i)*10-5,num2str(val(i)-1));
    end
end

return

end