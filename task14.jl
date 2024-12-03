using HorizonSideRobots

# шахматист
mutable struct markChessRobot
    robot::Robot
    flag::Bool
end

# база шахматист
HorizonSideRobots.move!(robot::markChessRobot, side) = begin
    robot.flag && putmarker!(robot.robot)
    move!(robot.robot, side)
    robot.flag = !robot.flag
end


HorizonSideRobots.isborder(robot::markChessRobot, side) = isborder(robot.robot, side)
HorizonSideRobots.isborder(robot::markChessRobot, sides::NTuple{2, HorizonSide}) = isborder(robot::markChessRobot, sides[1]) && isborder(robot::markChessRobot, sides[2])


r = Robot(animate=1)
ro = markChessRobot(r, 1)

# база
function full!(robot)
    x, y = edge!(robot, (West, Sud))
    snake_move!(robot, (Ost, Nord))
    first_place!(robot, West, Sud, x, y)
end

# ф-ции абстрактно
function edge!(robot, sides::NTuple{2, HorizonSide})
    step_x::Int, step_y::Int = 0, 0
    while !isborder(robot, sides)
        step_x += end_move!(robot, sides[1])
        step_y += end_move!(robot, sides[2])
    end
    return step_x, step_y
end


function end_move!(robot, side)
    count::Int = 0
    while !isborder(robot, side)
        move!(robot, side); count += 1
    end
    return count
end


HorizonSideRobots.isborder(robot, sides::NTuple{2, HorizonSide}) = isborder(robot, sides[1]) && isborder(robot, sides[2])
inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)
right(side::HorizonSide) = HorizonSide((Int(side) + 3) % 4)
left(side::HorizonSide) = HorizonSide((Int(side) + 1) % 4)


function snake_move!(robot, sides::NTuple{2, HorizonSide})
    cond_s = sides[1]
    full_num = end_move!(robot, cond_s)
    while !isborder(robot, sides[2])
        move!(robot, sides[2])
        cond_s = inverse(cond_s)
        num = end_move!(robot, cond_s)
        while full_num > num
            bypass!(robot, cond_s)
            num += end_move!(robot, cond_s) + 1
        end
    end
end


HorizonSideRobots.move!(robot, side, num) = for _ in 1:num move!(robot, side) end


function first_place!(robot, side_x, side_y, x, y)
    edge!(robot, (side_x, side_y))
    side_x, side_y = inverse(side_x), inverse(side_y)
    move!(robot, side_x, x); move!(robot, side_y, y)
end


function bypass!(robot, side)
    !isborder(robot, side) && (move!(robot, side); return)
    move!(robot, right(side))
    bypass!(robot, side)
    move!(robot, left(side))
end
