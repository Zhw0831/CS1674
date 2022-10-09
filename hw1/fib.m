function [val] = fib(n)

if n<=2
    val = 1;
    return
else
    val = fib(n-1) + fib(n-2);
end

end
