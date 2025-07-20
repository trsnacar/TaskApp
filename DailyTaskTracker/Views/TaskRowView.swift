import SwiftUI

struct TaskRowView: View {
    let task: Task
    @EnvironmentObject var taskStore: TaskStore
    @State private var showingTaskDetail = false
    
    var body: some View {
        HStack(spacing: 12) {
            // Completion Toggle
            Button(action: {
                taskStore.toggleTaskCompletion(task)
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
            .buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading, spacing: 4) {
                // Task Title
                HStack {
                    Text(task.title)
                        .font(.body)
                        .foregroundColor(task.isCompleted ? .gray : .primary)
                        .strikethrough(task.isCompleted)
                    
                    Spacer()
                    
                    // Priority Indicator
                    Circle()
                        .fill(priorityColor(task.priority))
                        .frame(width: 10, height: 10)
                }
                
                // Creation Date
                Text(formattedDate(task.createdAt))
                    .font(.caption)
                    .foregroundColor(.gray)
                
                // Due Date (if exists)
                if let dueDate = task.dueDate {
                    HStack {
                        Image(systemName: "calendar")
                            .font(.caption)
                            .foregroundColor(.orange)
                        Text("Bitiş: \(formattedDate(dueDate))")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
                }
                
                // Notes (if exists)
                if !task.notes.isEmpty {
                    Text(task.notes)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
            }
            
            Spacer()
            
            // Priority Label
            Text(task.priority.rawValue)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(priorityColor(task.priority).opacity(0.2))
                .foregroundColor(priorityColor(task.priority))
                .cornerRadius(8)
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            showingTaskDetail = true
        }
        .sheet(isPresented: $showingTaskDetail) {
            TaskDetailView(task: task)
                .environmentObject(taskStore)
        }
    }
    
    private func priorityColor(_ priority: Task.Priority) -> Color {
        switch priority {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter.string(from: date)
    }
}

struct TaskDetailView: View {
    @State var task: Task
    @EnvironmentObject var taskStore: TaskStore
    @Environment(\.dismiss) private var dismiss
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Title Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Görev")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        if isEditing {
                            TextField("Görev başlığı", text: $task.title)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        } else {
                            Text(task.title)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    // Priority Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Öncelik")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        if isEditing {
                            Picker("Öncelik", selection: $task.priority) {
                                ForEach(Task.Priority.allCases, id: \.self) { priority in
                                    Text(priority.rawValue).tag(priority)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        } else {
                            HStack {
                                Circle()
                                    .fill(priorityColor(task.priority))
                                    .frame(width: 12, height: 12)
                                Text(task.priority.rawValue)
                                    .font(.body)
                            }
                        }
                    }
                    
                    // Due Date Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bitiş Tarihi")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        if isEditing {
                            DatePicker("Bitiş Tarihi", selection: Binding(
                                get: { task.dueDate ?? Date() },
                                set: { task.dueDate = $0 }
                            ), displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(CompactDatePickerStyle())
                        } else {
                            if let dueDate = task.dueDate {
                                Text(formattedDate(dueDate))
                                    .font(.body)
                            } else {
                                Text("Belirlenmedi")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    // Notes Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notlar")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        if isEditing {
                            TextEditor(text: $task.notes)
                                .frame(minHeight: 100)
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        } else {
                            if !task.notes.isEmpty {
                                Text(task.notes)
                                    .font(.body)
                            } else {
                                Text("Not eklenmedi")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    // Status Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Durum")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)
                            Text(task.isCompleted ? "Tamamlandı" : "Bekliyor")
                                .font(.body)
                        }
                    }
                    
                    // Creation Date
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Oluşturulma Tarihi")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text(formattedDate(task.createdAt))
                            .font(.body)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Görev Detayı")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isEditing {
                        Button("Kaydet") {
                            taskStore.updateTask(task)
                            isEditing = false
                            dismiss()
                        }
                    } else {
                        Button("Düzenle") {
                            isEditing = true
                        }
                    }
                }
            }
        }
    }
    
    private func priorityColor(_ priority: Task.Priority) -> Color {
        switch priority {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter.string(from: date)
    }
}

#Preview {
    TaskRowView(task: Task(title: "Örnek Görev", priority: .high))
        .environmentObject(TaskStore())
}