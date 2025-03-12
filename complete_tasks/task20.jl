using HorizonSideRobots

r = Robot(animate=true)


inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)


function full_mark_back!(robot,side::HorizonSide)
    if !isborder(robot,side) move!(robot,side)
    else (putmarker!(robot); return) end 
    full_mark_back!(robot,side)
    move!(robot,inverse(side))
end
