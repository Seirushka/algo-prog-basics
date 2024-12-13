using HorizonSideRobots

r = Robot(animate=1)


function marklab!(robot)
    ismarker(robot) && return
    putmarker!(robot)
    for side in [Nord, Ost, Sud, West]
        move!(robot, side); marklab!(robot); move!(robot, inverse(side))
    end
end


inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)
