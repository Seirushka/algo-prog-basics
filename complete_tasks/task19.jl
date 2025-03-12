using HorizonSideRobots

r = Robot(animate=true)


function full_move!(robot, side)
    !isborder(robot, side) && (move!(robot, side); full_move!(robot, side))
    nothing
end
