using HorizonSideRobots
r = Robot(animate=1, 6, 6)

function main!(robot)
    x, y = edge!(robot, (West, Sud))
    count::Int, flag::Bool, side = 0, 0, Ost
    while !isborder(robot, Nord)
        count += full_move_bord_check!(robot, flag, side, Nord)
        side = inverse(side); move!(robot, Nord)
    end
    first_place!(robot, x, y)
    return count
end


function full_move_bord_check!(robot, flag, side, bord_side)
    count_i::Int = 0
    while !isborder(robot, side)
        if !flag
            isborder(robot, bord_side) && (count_i +=1; flag = !flag)
        else 
            !isborder(robot, bord_side) && (flag = !flag)
        end
        move!(robot, side)
    end
    return count_i
end


function first_place!(robot, x, y)
    edge!(robot, (West, Sud))
    move!(robot, Nord, y); move!(robot, Ost, x)
end


function edge!(robot, sides::NTuple{2, HorizonSide})
    step_x::Int, step_y::Int = 0, 0
    while !isborder(robot, sides)
        step_x += step_direct!(robot, sides[1])
        step_y += step_direct!(robot, sides[2])
    end
    return step_x, step_y
end


inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)


HorizonSideRobots.move!(robot, side, steps::Integer) = for _ in 1:steps move!(robot, side) end


HorizonSideRobots.isborder(robot, sides::NTuple{2, HorizonSide}) = isborder(robot, sides[1]) && isborder(robot, sides[2])


function step_direct!(robot, side)
    count::Int = 0
    while !isborder(robot, side)
        move!(robot, side); count += 1
    end
    return count
end
