include("robot_lib.jl")


function cross!(robot)
    for side in [Nord, Ost, Sud, West]
        num_steps = mark_direct!(robot, side)
        side = inverse(side)
        move!(robot, side, num_steps)
    end
end
