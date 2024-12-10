#tasks 19, 20
using HorizonSideRobots

r = Robot(animate=true)


function full_move!(robot, side)
    !isborder(robot, side) && (move!(robot, side); full_move!(robot, side))
    nothing
end


function main!(robot,side::HorizonSide)
    go_to_wall!(robot,side)
    move!(robot,inverse(side))
end


inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)


function full_mark_back!(robot,side::HorizonSide)
    !isborder(robot,side) && move!(robot,side)
    !isborder(robot,side) && (full_mark_back!(robot,side); move!(robot,inverse(side)))
    isborder(robot,side) && putmarker!(robot)
    nothing
end
