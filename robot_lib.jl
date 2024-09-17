using HorizonSideRobots

#task1
function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end


inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)


function mark_direct!(robot, side)
    n::Int = 0
    while isborder(robot, side) == 0
        move!(robot, side)
        putmarker!(robot)
        n += 1
    end
    return n
end


#task2
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
