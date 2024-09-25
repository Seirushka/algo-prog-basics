include("robot_lib.jl")


function find_hole!(robot)
    i = 1
    while isborder(robot, Nord)
        move!(robot, West, i)
        if isborder(robot, Nord)
            move!(robot, Ost, 2 * i)
            if isborder(robot, Nord)
                move!(robot, West, i)
            else
                break
            end
        else
            break
        end
        if !isborder(robot, Nord)
            return 1
        else
            i += 1
        end
    end 
end
