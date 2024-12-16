function recursion_sum(array)
    (isempty(array)) && return
    (length(array) == 1) && return array[1]
    return array[end] + recursion_sum(array[begin:end - 1])
end


count = parse(Int64, readline())
array = Vector{Int}(undef, count)
for i in 1:count num = parse(Int64, readline()); array[i] = num end

println(recursion_sum(array))
