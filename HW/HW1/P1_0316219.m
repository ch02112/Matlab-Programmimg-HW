


function mine(a,b)
x=a(1);
y=a(2);
minepos=randperm(x*y);
minepos=minepos(1:b);
A=zeros(x,y);
A(minepos)=100;

ind_x=1:x-1;
ind_y=2:y;
[xx,yy]=find(A(ind_x+1,ind_y-1)>=100);
yy=yy+1;
tmp=sub2ind(size(A),xx,yy);
A(tmp)=A(tmp)+10;

ind_x=2:x;
ind_y=1:y-1;
[xx,yy]=find(A(ind_x-1,ind_y+1)>=100);
xx=xx+1;
tmp=sub2ind(size(A),xx,yy);
A(tmp)=A(tmp)+10;

ind_x=1:x-1;
ind_y=1:y-1;
[xx,yy]=find(A(ind_x+1,ind_y+1)>=100);
tmp=sub2ind(size(A),xx,yy);
A(tmp)=A(tmp)+10;

ind_x=2:x;
ind_y=2:y;
[xx,yy]=find(A(ind_x-1,ind_y-1)>=100);
xx=xx+1;
yy=yy+1;
tmp=sub2ind(size(A),xx,yy);
A(tmp)=A(tmp)+10;


ind_x=2:x;
ind_y=1:y;
[xx,yy]=find(A(ind_x-1,ind_y)>=100);
xx=xx+1;
tmp=sub2ind(size(A),xx,yy);
A(tmp)=A(tmp)+10;

ind_x=1:x-1;
ind_y=1:y;
[xx,yy]=find(A(ind_x+1,ind_y)>=100);
tmp=sub2ind(size(A),xx,yy);
A(tmp)=A(tmp)+10;

ind_x=1:x;
ind_y=2:y;
[xx,yy]=find(A(ind_x,ind_y-1)>=100);
yy=yy+1;
tmp=sub2ind(size(A),xx,yy);
A(tmp)=A(tmp)+10;

ind_x=1:x;
ind_y=1:y-1;
[xx,yy]=find(A(ind_x,ind_y+1)>=100);
tmp=sub2ind(size(A),xx,yy);
A(tmp)=A(tmp)+10;

ind_x=1:x;
ind_y=1:y;
[xx,yy]=find(A(ind_x,ind_y)>=100);
tmp=sub2ind(size(A),xx,yy);
A(tmp)=100;



x=ceil((1:size(A,2)*90)/90);
y=ceil((1:size(A,1)*90)/90);
[xx,yy]=meshgrid(x,y);
k=sub2ind(size(A),yy,xx);
A2=A(k);



hold on

cm=colormap('summer');
RGB=ind2rgb(A2,cm);



RGB(1:90:end,:,1)=0;
RGB(1:90:end,:,2)=0;
RGB(1:90:end,:,3)=0;
RGB(:,1:90:end,1)=0;
RGB(:,1:90:end,2)=0;
RGB(:,1:90:end,3)=0;

[minx miny]=ind2sub(size(A),minepos)
minz=size(minx)
for ii=1:minz(2)
RGB((2*minx(ii)-1)*45-25:(2*minx(ii)-1)*45+25,(2*miny(ii)-1)*45-25:(2*miny(ii)-1)*45+25,1)=0;
RGB((2*minx(ii)-1)*45-25:(2*minx(ii)-1)*45+25,(2*miny(ii)-1)*45-25:(2*miny(ii)-1)*45+25,2)=0;
RGB((2*minx(ii)-1)*45-25:(2*minx(ii)-1)*45+25,(2*miny(ii)-1)*45-25:(2*miny(ii)-1)*45+25,3)=0;
imshow(RGB);


[xt yt zt]=find(A);

text((yt*2-1)*45-10,(xt*2-1)*45,num2str(zt/10));


end
