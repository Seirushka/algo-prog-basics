function fibo_a(n)
    (n < 2) && return n
    num_prev, num_cur = 0, 1
    for _ in 2:n
        num_new = num_cur + num_prev
        num_cur, num_prev = num_new, num_cur
    end
    return num_cur
end


function fibo_b(n)
    (n < 2) && return n
    return fibo_b(n - 1) + fibo_b(n - 2)
end


function fibo_c(n, nums = Dict{Int, Int}())
    if n in keys(nums)
        return nums[n]
    else
        if n < 2 nums[n] = n
        else nums[n] = fibo_c(n - 2, nums) + fibo_c(n - 1, nums)
        end
    end
end
