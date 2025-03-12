using HorizonSideRobots

r = Robot(animate=1)


function movesym!(robot, side)
    isborder(robot, inverse(side)) && (full_move!(robot, side); return)
    move!(robot, inverse(side))
    movesym!(robot, side)
    move!(robot, inverse(side))
end


inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)


function full_move!(robot, side)
    !isborder(robot, side) && (move!(robot, side); full_move!(robot, side))
    nothing
end