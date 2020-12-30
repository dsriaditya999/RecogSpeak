function d = make_delta(c)

N = length(c);

d = zeros(1,N);

for t = 2:N-1
    
    for n = 1:N
        
        if (t+n<= N) && (t-n>=1)
            d(t) = d(t) + n*(d(t+n)-d(t-n));
        end
             
    end
    
    d(t) = 3*d(t)/(N*(N+1)*(2*N+1));
    
end

d(1) = c(1);
d(N) = c(N);


    
     
    
    