# db/seeds.rb

# Create Users
user1 = User.create(email: 'user1@example.com', password: 'password1')
user2 = User.create(email: 'user2@example.com', password: 'password2')
user3 = User.create(email: 'user3@example.com', password: 'password3')

# Create Projects
project1 = Project.create(name: 'Project 1', user_id: user1.id)
project2 = Project.create(name: 'Project 2', user_id: user2.id)
project3 = Project.create(name: 'Project 3', user_id: user3.id)

# Create Tasks
task1 = Task.create(name: 'Task 1', description: 'This is Task 1', priority: 'high', latitude: 40.7128,
                    longitude: -74.0060, project_id: project1.id)
task2 = Task.create(name: 'Task 2', description: 'This is Task 2', priority: 'low', latitude: 37.7749,
                    longitude: -122.4194, project_id: project1.id)
task3 = Task.create(name: 'Task 3', description: 'This is Task 3', priority: 'medium', latitude: 51.5074,
                    longitude: -0.1278, project_id: project2.id)
task4 = Task.create(name: 'Task 4', description: 'This is Task 4', priority: 'high', latitude: 35.6895,
                    longitude: 139.6917, project_id: project3.id)
task5 = Task.create(name: 'Task 5', description: 'This is Task 5', priority: 'low', latitude: 48.8566,
                    longitude: 2.3522, project_id: project2.id)
task6 = Task.create(name: 'Task 6', description: 'This is Task 6', priority: 'medium', latitude: 68.8566,
                    longitude: 70.3522, project_id: project3.id)

# Add tasks to project
project1.tasks << [task1, task2]
project2.tasks << [task3, task5]
project3.tasks << [task4, task6]

# Assign tasks to users
TaskAssignment.create(user_id: user1.id, task_id: task3.id)
TaskAssignment.create(user_id: user1.id, task_id: task4.id)
TaskAssignment.create(user_id: user2.id, task_id: task1.id)
TaskAssignment.create(user_id: user2.id, task_id: task4.id)
TaskAssignment.create(user_id: user2.id, task_id: task6.id)
TaskAssignment.create(user_id: user3.id, task_id: task2.id)
TaskAssignment.create(user_id: user3.id, task_id: task5.id)

# Output success message
puts 'Seed data created successfully!'
