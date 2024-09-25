include("robot_lib.jl")


function out_in_side_perim(robot)
    steps_x, steps_y, bord_x, bord_y = edge_border_count!(robot, West, Sud)
    for side in [Nord, Ost, Sud, West]
        mark_direct!(robot, side)
    end
    while_not_y_border!(robot, Ost, Nord)

    side = West
    while !ismarker(robot)
        side_mark_direct!(robot, side)
        side = side_board(side)
    end
    edge_border_count!(robot, West, Sud)
    if (bord_x % 2 == 0) || (bord_y % 2 == 0)
        move!(robot, Ost, steps_x)
        move!(robot, Nord, steps_y)
    else
        move!(robot, Nord, steps_y)
        move!(robot, Ost, steps_x)
    end
end
