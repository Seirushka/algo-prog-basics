include("robot_lib.jl")


function x_cross!(robot)
    for side_x in [West, Ost]
        for side_y in [Nord, Sud]
            num_steps = diagonal_move!(robot, side_x, side_y)
            side_x, side_y = inverse(side_x), inverse(side_y)
            steps_diagonal_move!(robot, num_steps, side_x, side_y)
        end
    end
    putmarker!(robot)
end
