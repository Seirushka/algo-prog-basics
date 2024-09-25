include("robot_lib.jl")


function chess_full!(robot)
    start_x, start_y = edge!(robot, West, Sud)
    num = (start_x % 2 == 0 && start_y % 2 == 0) || (start_x % 2 == 1 && start_y % 2 == 1)
    chess_mark_full!(robot, Ost, Nord, Int(num))
    edge!(robot, West, Sud)
    move!(robot, Nord, start_y)
    move!(robot, Ost, start_x)
end
