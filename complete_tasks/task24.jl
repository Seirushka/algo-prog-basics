using HorizonSideRobots

r = Robot(animate=1)


function move2minus!(robot, side)
    isborder(robot, side) && return
    move!(robot, side)
    move2plus!(robot, side)
end


function move2plus!(robot, side)
    isborder(robot, side) && return
    move!(robot, side)
    move2minus!(robot, side)
    move!(robot, inverse(side))
end


inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)