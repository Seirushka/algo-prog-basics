using HorizonSideRobots


function cross!(robot)
    for side in (Nord, Ost, Sud, West)
        num_steps = mark_direct!(robot, side)
        side = inverse(side)
        move!(robot, side, num_steps)
    end
end


function mark_direct!(robot, side)
    n::Int = 0
    while isborder(robot, side) == false
        putmarker!(robot)
        move!(robot, side)
        n += 1
    end
    return n
end


@enum HorizonSide Nord Ost Sud West
inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)


function HorizonSideRobots.move!(robot, side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end
