# task 1
function max_subsum(iter)

    max_sum = cur_sum = iter_0 = zero(eltype(array))

    for num in iter
        cur_sum += num
        (cur_sum < iter_0) && (cur_sum = iter_0)
        (cur_sum > max_sum) && (max_sum = cur_sum)
    end

    return max_sum
end

#task 2
function average_mean(iter)
    mean = sum_line = sum_square = N = zero(eltype(iter))

    for num in iter
        sum_line += num; sum_square += num^2
        N += one(eltype(iter))
    end
    
    mean = (sum_square - sum_line^2 / N) / N

    return sum_line / N, sqrt(mean)
end


function multi_average_mean(iter) # iter многомерный
    mean = sum_line = sum_square = N = zero(eltype(iter))

    for num in iter
        @. sum_line += num
        @. sum_square += num^2
        N += one(eltype(iter))
    end
    
    @. mean = (sum_square - sum_line^2 / N) / N

    return sum_line / N, sqrt(mean)
end

# task 3 - 4
function gorner(iter, arg)
    T = promote_type(eltype(iter), typeof(arg))
    polynom::T = iter[begin]
    derivative = zero(T)

    for coef in Iterators.drop(iter, 1)
        derivative = derivative * arg + polynom
        polynom = polynom * arg + coef
    end

    return polynom, derivative
end

#task 5
function my_gcd(obj10::T, obj20::T) where T
    obj1, obj2 = obj10, obj20

    while !iszero(obj2)
        obj1, obj2 = obj2, mod(obj1, obj2)
    end

    return obj1
end


function my_gcdx(a0::T, b0::T) where T
    a, b = a0, b0
    ua, va = one(T), zero(T)
    ub, vb = zero(T), one(T)
    
    while !iszero(b)
        prev_a = a
        
        k, r = divrem(prev_a, b) # a = k * b + r, r = a mod b
        a, b = b, r
        
        prev_ua, prev_va = ua, va

        ua, va = ub, vb
        ub = prev_ua - k * ub # ub = ua mod ub
        vb = prev_va - k * vb 
    end

    return a, ua, va
end


function my_gcdx_1(a0::T, b0::T) where T
    a, b = a0, b0
    
    if b == zero(T)
        return a, one(T), zero(T)
    end

    gcd, x1, y1 = my_gcdx_1(b, mod(a, b))
    x, y = y1, x1 - y1 * div(a, b)

    return gcd, x, y
end

# task 6 - 7
struct Residue{T, M}
    val::T
    Residue{T, M}(val::T) where {T, M} = new{T, M}(mod(val, M))
end

Residue{T, M}(val) where {T, M} = Residue{T, M}(T(val))

Base. +(a::Residue{T, M}, b::Residue{T, M}) where {T, M} = Residue{T, M}(a.val + b.val)
Base. -(a::Residue{T, M}, b::Residue{T, M}) where {T, M} = Residue{T, M}(a.val - b.val)
Base. *(a::Residue{T, M}, b::Residue{T, M}) where {T, M} = Residue{T, M}(a.val * b.val)

Base.zero(::Type{Residue{T, M}}) where {T, M} = Residue{T, M}(zero(T))
Base.zero(Zn::Residue{T, M}) where {T, M} = zero(Residue{T, M})
Base.one(::Type{Residue{T, M}}) where {T, M} = Residue{T, M}(one(T))
Base.one(Zn::Residue{T, M}) where {T, M} = one(Residue{T, M})

struct Polynomial{T}
    coef::Vector{T}

    function Polynomial{T}(coef) where T
        while !isempty(coef) && iszero(coef[end])
            pop!(coef)
        end
        (isempty(coef)) && (push!(coef, zero(T)))
        return new{T}(coef)
    end
end

ord(polyn::Polynomial) = length(polyn.coef) - 1

polyn_to_tuple(polyn::Polynomial{T}) where T = Tuple(polyn.coef)

Base.zero(::Type{Polynomial{T}}) where T = Polynomial{T}([zero(T)])
Base.zero(polyn::Polynomial{T}) where T = zero(Polynomial{T})
Base.one(::Type{Polynomial{T}}) where T = Polynomial{T}([one(T)])
Base.one(polyn::Polynomial{T}) where T = one(Polynomial{T})

function Base. +(a::Polynomial{T}, b::Polynomial{T}) where T
    (ord(a) >= ord(b)) && (c = copy(a.coef); c[1:ord(b) + 1] .+= b.coef)
    (ord(a) < ord(b)) && (c = copy(b.coef); c[1:ord(a) + 1] .+= a.coef)
    return Polynomial{T}(c)
end

function Base. -(a::Polynomial{T}, b::Polynomial{T}) where T
    (ord(a) >= ord(b)) && (c = copy(a.coef); c[1:ord(b) + 1] .-= b.coef)
    (ord(a) < ord(b)) && (c = copy(b.coef); c[1:ord(a) + 1] .-= a.coef)
    return Polynomial{T}(c)
end

function Base. +(a::Polynomial{T}, num) where T
    res = copy(a.coef)
    res .+= num
    return Polynomial{T}(res)
end

function Base. -(a::Polynomial{T}, num) where T
    res = copy(a.coef)
    res .-= num
    return Polynomial{T}(res)
end

function Base. *(a::Polynomial{T}, b::Polynomial{T}) where T
    c = zeros(T, ord(a) + ord(b) + 1)
    for i = eachindex(a.coef), j = eachindex(b.coef)
        c[i + j - 1] += a.coef[i] * b.coef[j]
    end
    return Polynomial{T}(c)
end

function Base. *(a::Polynomial{T}, num) where T
    res = copy(a.coef)
    res .*= num
    return Polynomial{T}(res)
end

function Base. divrem(a0::Polynomial{T}, b0::Polynomial{T}) where T
    orda, ordb = ord(a0), ord(b0) 
    
    (orda < ordb) && return zero(a0), a0
    
    a, b = a0.coef, b0.coef
    q = zeros(T, orda - ordb + 1)
    r = copy(a)

    for i in (orda + 1):-1:(ordb + 1)
        if r[i] != 0
            coef = trunc(r[i] / b[end])
            q[i - ordb] = coef
            for j in 0:ordb
                r[i - j] -= coef * b[end - j]
            end
        end
    end
    
    return (Polynomial{T}(q), Polynomial{T}(r))
end

Base. div(a::Polynomial{T}, b::Polynomial{T}) where T = divrem(a, b)[begin]
Base. mod(a::Polynomial{T}, b::Polynomial{T}) where T = divrem(a, b)[end]
Base. mod(a::Polynomial{T}, b::Tuple) where T = mod(a, Polynomial{T}(collect(b)))

function (iter::Polynomial{T})(arg) where T
    TT = promote_type(T, typeof(arg))
    polynom::TT = iter.coef[begin]

    for i in Iterators.drop(iter.coef, 1)
        polynom = polynom * arg + i
    end

    return polynom
end
