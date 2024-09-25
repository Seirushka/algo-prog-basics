using HorizonSideRobots

# task 1
function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end


inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)


function mark_direct!(robot, side)
    n::Int = 0
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        n += 1
    end
    return n
end

# task 2
function chess_mark_direct_0!(robot, side, ::Val{0})
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        if !isborder(robot, side)
            move!(robot, side)
        end
    end
end


function chess_mark_direct_1!(robot, side, ::Val{1})
    while !isborder(robot, side)
        putmarker!(robot)
        move!(robot, side)
        if !isborder(robot, side)
            move!(robot, side)
            putmarker!(robot)
        end
    end
end

# task 3
function step_direct!(robot, side)
    count::Int = 0
    while !isborder(robot, side)
        move!(robot, side)
        count += 1
    end
    return count
end


function full_mark!(robot, side, edge)
    while !isborder(robot, edge)
        mark_direct!(robot, side)
        side = inverse(side)
        move!(robot, edge)
        putmarker!(robot)
    end    
end

# task 4
function diagonal_move!(robot, side_ox, side_oy)
    count::Int = 0
    while !isborder(robot, side_ox) && !isborder(robot, side_oy)
        move!(robot, side_ox)
        move!(robot, side_oy)
        putmarker!(robot)
        count += 1
    end
    return count
end


function steps_diagonal_move!(robot, steps, side_ox, side_oy)
    for _ in 1:steps
        move!(robot, side_oy)
        move!(robot, side_ox)
    end
end

# task 5
side_board(side::HorizonSide) = HorizonSide((Int(side) + 3) % 4)


function side_mark_direct!(robot, side)
    n::Int = 0
    side_side = side_board(side)
    putmarker!(robot)
    while isborder(robot, side_side)
        move!(robot, side)
        if !ismarker(robot)
            putmarker!(robot)
            n += 1
        else
            return n
        end
    end
    move!(robot, side_side)
    return n
end


function edge_border_count!(robot, side_ox, side_oy)
    count_ox::Int, count_oy::Int = 0, 0
    bords_num_x::Int, bords_num_y::Int = 0, 0
    while !isborder(robot, side_ox) || !isborder(robot, side_oy)
        count_ox += step_direct!(robot, side_ox)
        if isborder(robot, side_ox)
            bords_num_x += 1
        end
        count_oy += step_direct!(robot, side_oy)
        if isborder(robot, side_oy)
            bords_num_y += 1
        end
    end
    return count_ox, count_oy, bords_num_x, bords_num_y
end


function while_not_y_border!(robot,side_x, side_y)
    while !isborder(robot, side_y)
        while !isborder(robot, side_x)
            if !isborder(robot, side_y)
                move!(robot, side_x)
            else
                return 0 
            end
        end
        move!(robot, side_y)
        side_x = inverse(side_x)
    end
end

# task 6
function edge!(robot, side_ox, side_oy)
    count_ox::Int, count_oy::Int = 0, 0
    while !isborder(robot, side_ox) || !isborder(robot, side_oy)
        count_ox += step_direct!(robot, side_ox)
        count_oy += step_direct!(robot, side_oy)
    end
    return count_ox, count_oy
end


function count_mark!(robot, side, count)
    for _ in 1:count
        putmarker!(robot)
        move!(robot, side)
    end
end


function no_start_marking!(robot, side, count)
    count_mark!(robot, side, count)
    n::Int = mark_direct!(robot, side)
    return count + n
end


function only_start_marking!(robot, side, count)
    move!(robot, side, count)
    putmarker!(robot)
    n::Int = step_direct!(robot, side)
    return count + n
end

# task 8
function perim_edge!(robot, side_x, side_y, size::Int)
    if size % 2 == 1
        edge_x = edge_y = div(size, 2)
        move!(robot, side_x, edge_x)
        move!(robot, side_y, edge_y)
    end
end


function side_mark_check!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
        if ismarker(robot)
            return 0
        end
    end
    return 1
end

# task 9
function chess_mark_full!(robot, side, next, num)
    while !isborder(robot, next)
        if num == 1
            chess_mark_direct_1!(robot, side, Val(1)) 
        end
        chess_mark_direct_0!(robot, side, Val(0))
        side = inverse(side)
        move!(robot, next)
    end
    if num == 1
        chess_mark_direct_1!(robot, side, Val(1)) 
    end
    chess_mark_direct_0!(robot, side, Val(0))
end
