include("robot_lib.jl")


function perimeter_cross!(robot)
    num_steps_up = step_direct!(robot, Nord)
    num_steps_left = step_direct!(robot, West)
    for side in [Ost, Sud, West, Nord]
        mark_direct!(robot, side)
    end
    move!(robot, Sud, num_steps_up)
    move!(robot, Ost, num_steps_left)
end


function full_cross!(robot)
    num_steps_up = step_direct!(robot, Nord)
    num_steps_left = step_direct!(robot, West)
    side = Ost
    putmarker!(robot)
    full_mark!(robot, side, Sud)
    mark_direct!(robot, side)
    step_direct!(robot, Nord)
    step_direct!(robot, West)
    move!(robot, Sud, num_steps_up)
    move!(robot, Ost, num_steps_left)
end
