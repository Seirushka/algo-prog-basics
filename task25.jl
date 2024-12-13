using HorizonSideRobots

r = Robot(animate=1)

# a)
function markchess_1!(robot, side)
    putmarker!(robot)
    isborder(robot, side) && return
    move!(robot, side); markchess_0!(robot, side)
end

# b)
function markchess_0!(robot, side)
    isborder(robot, side) && return
    move!(robot, side); markchess_1!(robot, side)
end
