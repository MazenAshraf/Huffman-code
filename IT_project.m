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

for i=1:stages
    [x,y]=sort(Modified_Symbols_prob,'descend');
    %min prob
    dummy(y(length(x)),i)=11;
    dummy(y(length(x))-1,i)=10;
    Modified_Symbols_prob(y(length(x))-1)= Modified_Symbols_prob(y(length(x)))+ Modified_Symbols_prob(y(length(x))-1);
    Modified_Symbols_prob(y(length(x)))=0;
    Modified_Symbols_prob=nonzeros(Modified_Symbols_prob');
end    
%Symbols_prob_copy(i,j)
%a=[1,2,3,4;5,6,7,8];
%[a,b]=sort(a,'descend');
%this will loop 9 times in this case

