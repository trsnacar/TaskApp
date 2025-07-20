import SwiftUI

struct ContentView: View {
    @EnvironmentObject var taskStore: TaskStore
    @State private var showingAddTask = false
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                // Günlük Görevler
                TaskListView(tasks: taskStore.todaysTasks, title: "Bugünün Görevleri")
                    .tabItem {
                        Image(systemName: "calendar.badge.clock")
                        Text("Bugün")
                    }
                    .tag(0)
                
                // Bekleyen Görevler
                TaskListView(tasks: taskStore.pendingTasks, title: "Bekleyen Görevler")
                    .tabItem {
                        Image(systemName: "list.bullet.circle")
                        Text("Bekleyen")
                    }
                    .tag(1)
                
                // Tamamlanan Görevler
                TaskListView(tasks: taskStore.completedTasks, title: "Tamamlanan Görevler")
                    .tabItem {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Tamamlanan")
                    }
                    .tag(2)
                
                // Tüm Görevler
                TaskListView(tasks: taskStore.tasks, title: "Tüm Görevler")
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Tümü")
                    }
                    .tag(3)
            }
            .accentColor(.blue)
        }
        .overlay(
            // Floating Action Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showingAddTask = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 90)
                }
            }
        )
        .sheet(isPresented: $showingAddTask) {
            AddTaskView()
                .environmentObject(taskStore)
        }
    }
}

struct TaskListView: View {
    let tasks: [Task]
    let title: String
    @EnvironmentObject var taskStore: TaskStore
    
    var body: some View {
        List {
            if tasks.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 60))
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("Henüz görev yok")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    Text("Yeni bir görev eklemek için + butonuna dokunun")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 100)
                .listRowSeparator(.hidden)
            } else {
                ForEach(tasks) { task in
                    TaskRowView(task: task)
                        .environmentObject(taskStore)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let task = tasks[index]
                        taskStore.deleteTask(with: task.id)
                    }
                }
            }
        }
        .navigationTitle(title)
        .listStyle(PlainListStyle())
    }
}

#Preview {
    ContentView()
        .environmentObject(TaskStore())
}