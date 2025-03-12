using HorizonSideRobots

r = Robot(animate=1)


function chessmark!(robot::Robot, N::Int)
    y, x = edge!(robot, (West, Sud))
    coord = (x = Ref(0), y = Ref(0))
    robot = (;robot, coord, N)
    rectarea!(robot)
    first_place!(robot, West, Sud, x, y)
end


function HorizonSideRobots.move!(coord::@NamedTuple{x::Base.RefValue{Int64}, y::Base.RefValue{Int64}}, side::HorizonSide)
    if side == Nord coord.y[] += 1 elseif side == Sud coord.y[] -= 1
    elseif side == Ost coord.x[] += 1 else coord.x[] -= 1 end
    nothing
end

function HorizonSideRobots.move!(
    robot::@NamedTuple{robot::Robot,
    coord::@NamedTuple{x::Base.RefValue{Int64}, y::Base.RefValue{Int64}},
    N::Int64}, side::HorizonSide
)
    N = robot.N
    x = mod(robot.coord.x[], 2 * N)
    y = mod(robot.coord.y[], 2 * N)

    (((x in 0:N - 1) && (y in 0:N - 1)) || ((x in N:2 * N - 1) && (y in N:2 * N - 1))) &&
    putmarker!(robot.robot)

    move!(robot.coord, side)
    move!(robot.robot, side)
end


function HorizonSideRobots.isborder(
    robot::@NamedTuple{robot::Robot,
    coord::@NamedTuple{x::Base.RefValue{Int64}, y::Base.RefValue{Int64}},
    N::Int64}, side::HorizonSide
)
    isborder(robot.robot, side)
end


function rectarea!(robot)
    edge!(robot, (West, Sud))
    side = Ost
    movetoend!(robot, side)
    while !isborder(robot, Nord)
        move!(robot, Nord); side = inverse(side); movetoend!(robot, side)
    end
end


function edge!(robot, sides::NTuple{2, HorizonSide})
    array = [0, 0]
    for side in sides
        array[mod(Int(side), 2) + 1] += movetoend!(robot, side)
    end
    return array
end


function movetoend!(robot, side)
    num::Int = 0
    while trymove!(robot, side) num += 1 end
    return num
end


function trymove!(robot, side)
    isborder(robot, side) && return false
    move!(robot, side)
    return true
end


inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)


function first_place!(robot, side_x, side_y, x, y)
    edge!(robot, (side_x, side_y))
    side_x, side_y = inverse(side_x), inverse(side_y)
    move!(robot, side_x, x); move!(robot, side_y, y)
end


HorizonSideRobots.move!(robot, side, num) = for _ in 1:num move!(robot, side) end