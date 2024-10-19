function Main
% Main function now outlines the steps of implementing this project: 
% NOTHINGS IMPLMENTED YET; THIS IS THE PLANNING STAGE

    % Step 1: Load the Map (a 2D or 3D binary occupancy grid or custom terrain)
    map = createClutteredField(); % NOT IMPLEMENTED function to generate a rough terrain

    % Step 2: Initialize the Robot and Sensors
    robot = differentialDriveKinematics('TrackWidth', 0.5, 'VehicleInputs', 'VehicleSpeedHeadingRate');
    lidarSensor = createLidarSensor(); % Define a Lidar sensor
    initialPose = [0, 0, 0]; % [x, y, theta] initial pose at Point A

    % Step 3: Set the Start and Goal Points
    startLocation = [0, 0]; % Starting point (Point A)
    goalLocation = [10, 10]; % Ending point (Point B)

    % Step 4: Path Planning using A* Algorithm or PRM
    path = planPath(map, startLocation, goalLocation); % Use A* or PRM for planning
    
    % Step 5: Visualize the planned path
    figure;
    show(map);
    hold on;
    plot(path(:,1), path(:,2), 'r--', 'LineWidth', 2);
    plot(startLocation(1), startLocation(2), 'bo', 'MarkerSize', 10, 'DisplayName', 'Start');
    plot(goalLocation(1), goalLocation(2), 'go', 'MarkerSize', 10, 'DisplayName', 'Goal');
    
    % Step 6: Path Following with Pure Pursuit Controller
    controller = controllerPurePursuit('Waypoints', path, ...
                                       'DesiredLinearVelocity', 0.5, ...
                                       'MaxAngularVelocity', 1.0, ...
                                       'LookaheadDistance', 0.5);

    % Simulate the robot following the path
    simulateRobot(robot, controller, initialPose, path, map);
    
    disp('Simulation complete!');
end
