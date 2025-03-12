using HorizonSideRobots

r = Robot(animate=1)


function doubledist!(robot, side)
    isborder(robot, inverse(side)) && return
    move!(robot, inverse(side))
    doubledist!(robot, side)
    move!(robot, side, 2)
end

HorizonSideRobots.move!(robot, side, num) = for _ in 1:num move!(robot, side) end
inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)
