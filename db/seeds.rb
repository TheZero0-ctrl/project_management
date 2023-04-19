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
task1 = Task.create(name: 'Task 1', description: 'This is Task 1', priority: 'high', project_id: project1.id,
                    latitude: 40.7128, longitude: -74.0060)
task2 = Task.create(name: 'Task 2', description: 'This is Task 2', priority: 'low', project_id: project1.id,
                    latitude: 37.7749, longitude: -122.4194)
task3 = Task.create(name: 'Task 3', description: 'This is Task 3', priority: 'medium', project_id: project2.id,
                    latitude: 51.5074, longitude: -0.1278)
task4 = Task.create(name: 'Task 4', description: 'This is Task 4', priority: 'high', project_id: project3.id,
                    latitude: 35.6895, longitude: 139.6917)
task5 = Task.create(name: 'Task 5', description: 'This is Task 5', priority: 'low', project_id: project3.id,
                    latitude: 48.8566, longitude: 2.3522)
task6 = Task.create(name: 'Task 6', description: 'This is Task 6', priority: 'medium', project_id: project2.id,
                    latitude: 68.8566, longitude: 70.3522)

# Assign tasks to users
user1.assigned_tasks << [task3, task4]
user2.assigned_tasks << [task1, task4, task6]
user3.assigned_tasks << [task2, task5]

# Output success message
puts 'Seed data created successfully!'
