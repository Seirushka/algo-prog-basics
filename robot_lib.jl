using HorizonSideRobots

#task 1
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

#task 2
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

#task 3
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

#task 4
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

#task 5
#task 6
function edge!(robot, side_ox, side_oy)
    count_ox::Int, count_oy::Int = 0, 0
    while !isborder(robot, side_ox) || !isborder(robot, side_oy)
        count_ox += step_direct!(robot, side_ox)
        count_oy += step_direct!(robot, side_oy)
    end
    return count_ox, count_oy
end


function count_move!(robot, side, count)
    for _ in 1:count
        putmarker!(robot)
        move!(robot, side)
    end
end


function no_start_marking!(robot, side, count)
    count_move!(robot, side, count)
    n::Int = mark_direct!(robot, side)
    return count + n
end