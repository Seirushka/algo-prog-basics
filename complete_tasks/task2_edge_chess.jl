include("robot_lib.jl")


function edge_chess_move!(robot)
    for side in [Nord, Ost, Sud, West]
        if !ismarker(robot)
            marks = chess_mark_direct_0!(robot, side, Val(0))
        end
        marks = chess_mark_direct_1!(robot, side, Val(1))
    end
end
