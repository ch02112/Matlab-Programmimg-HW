v3=1;
for ii = [1:n]
    if ii==1
        disp(1)
    else
        v3=[0 v3] + [v3 0];
        disp(v3)
    end
end
