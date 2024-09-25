include("robot_lib.jl")


function marker_check!(robot)
    i = 3
    while !ismarker(robot)
        perim_edge!(robot, West, Sud, i)
        flag = 0
        for side in [Nord, Ost, Sud, West]
            flag = side_mark_check!(robot, side, i)
            if flag == 0
                break
            end
        end
        if flag == 1
            perim_edge!(robot, Ost, Nord, i)
        end
        i += 2
    end
end
