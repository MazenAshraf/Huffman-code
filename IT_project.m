%Reading image 
Img=imread('image.png');
%Reading size of image to loop over it
[N,M] = size(Img);
%creating a matrix then initate it with zeores
Count=zeros(256,1);
%loop in the img matrix to get repeated symbols
for i = 1:N
   for j = 1:M
         Count(Img(i,j)+1)=Count(Img(i,j)+1)+1;
    end
end
%sorting symbols in descending order to make zero at the end of the 256
%matix
Symbols=sort(Count,'descend');
%getting probablity of each symbol and sorting them
hist = histogram (Img, 256, 'Normalization', 'probability');
Symbols_prob= hist.Values;
%removing all zeros probabilites as we don't need to do any operation on
%sth that won't happen
Modified_Symbols_prob = nonzeros(Symbols_prob');
%n=number of probabilites
%assuming r=2 then number of stages = (probabilties number-1)
%10 probabilites means there are 9 stages
n=length(Modified_Symbols_prob);
stages=n-1;
%is the matrix to store codeword of each symbol
codeword=cell(1,n);
%dumyy is the matrix where to detect min and second min to add and do other
%operations
dummy=zeros(n,stages);
%i will take a copy of the probabilites matrix inorder to do some
%operations without changing the original one
%matrix that i will store the arrows in dummy
indicies=zeros(n,stages);
counter=10;

nn = 0;


for i=1:stages
    [Modified_Symbols_prob,y]=sort(Modified_Symbols_prob,'descend');
    
    %min prob
    dummy(counter,i)=11;
    dummy(counter-1,i)=10;
    Modified_Symbols_prob(counter-1)= Modified_Symbols_prob(counter)+ Modified_Symbols_prob(counter-1);
    %Modified_Symbols_prob(length(Modified_Symbols_prob)=[];
    Modified_Symbols_prob(counter)=0;

   %hena ana bkhly el indices bt2el wahed kol mara 3alshan lama yekon el
   %r=2 fel stage rkm 9 yekon 3ndy 2 indicies bs
   %indicies(1,1)=y(1) and so on
   %if row=10 and i ay rkm gher 1 w a2l mn 10 then
   %h7ot 0 in matrix from inidicies(10:10,i)=0; then increment

    jj=stages;
    for row=1:n    
        indicies(n-jj,i) = y(n-jj);
        jj = jj-1;
        if ((i == 2)|| (i == 3)||(i ==4) || (i==5) || (i==6) || (i ==7)|| (i ==8) || (i == 9)) && row == 10
            indicies(row-nn:row,i) =0;
            nn = nn+1;
        end        
    end
    
    counter=counter-1;
    %y(counter)=0;
    %y=nonzeros(y');
end
   
% for i=1:n 
%    for j=1:stages
%       rownum=indicies(i,j); 
%       if dummy(rownum,j)==10
%           codeword(i)=strcat(codeword(i),'0');
%       elseif dummy(rownum,j)==11
%           codeword(i)=strcat(codeword(i),'1');
%       end
%    end
% end



