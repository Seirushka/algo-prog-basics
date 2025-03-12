using HorizonSideRobots


function main!()
    shuttle!(robot, Nord) do side
        !isborder(robot, side) end
end


function shuttle!(stop_condition::Function, robot, side) 
    side_n, count::Int = Ost, 0
    while !stop_condition(side) 
        count += 1
        move!(robot, side_n, count) 
        side_n = inverse(side_n) 
    end 
end


HorizonSideRobots.move!(robot, side, num_steps) = for _ in 1:num_steps move!(robot, side) end


inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)
