include("robot_lib.jl")


function perimeter_not_start_a(robot)
    edge!(robot, West, Sud)
    for side in [Nord, Ost, Sud, West]
        mark_direct!(robot, side)
    end
end


function perimeter_not_start_b(robot)
    steps_ox, steps_oy = edge!(robot, West, Sud)
    array = [0, 0]
    for side in [Nord, Ost, Sud, West]
        if Int(side) % 2 == 0
            num = only_start_marking!(robot, side, abs(array[1] - steps_oy))
            array[1] = num
        else
            num = only_start_marking!(robot, side, abs(array[2] - steps_ox))
            array[2] = num
        end
    end
end


function perimeter_not_start_c(robot)
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
