include("robot_lib.jl")


function perimeter_not_start(robot)
    steps_ox, steps_oy = edge!(robot, West, Sud)
    array = [0, 0]
    for side in [Nord, Ost, Sud, West]
        if Int(side) % 2 == 0
            num = no_start_marking!(robot, side, abs(array[1] - steps_oy))
            array[1] = num
        else
            num = no_start_marking!(robot, side, abs(array[2] - steps_ox))
            array[2] = num
        end
    end
end