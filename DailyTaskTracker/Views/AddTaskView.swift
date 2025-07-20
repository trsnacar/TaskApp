import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var taskStore: TaskStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var priority = Task.Priority.medium
    @State private var notes = ""
    @State private var hasDueDate = false
    @State private var dueDate = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section("Görev Bilgileri") {
                    TextField("Görev başlığı", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Picker("Öncelik", selection: $priority) {
                        ForEach(Task.Priority.allCases, id: \.self) { priority in
                            HStack {
                                Circle()
                                    .fill(priorityColor(priority))
                                    .frame(width: 10, height: 10)
                                Text(priority.rawValue)
                            }
                            .tag(priority)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Bitiş Tarihi") {
                    Toggle("Bitiş tarihi belirle", isOn: $hasDueDate)
                    
                    if hasDueDate {
                        DatePicker("Bitiş Tarihi", selection: $dueDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(CompactDatePickerStyle())
                    }
                }
                
                Section("Notlar") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 100)
                        .overlay(
                            Group {
                                if notes.isEmpty {
                                    Text("Görev hakkında notlar...")
                                        .foregroundColor(.gray.opacity(0.6))
                                        .allowsHitTesting(false)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                        .padding(.top, 8)
                                        .padding(.leading, 4)
                                }
                            }
                        )
                }
                
                Section {
                    Button(action: addTask) {
                        HStack {
                            Spacer()
                            Text("Görev Ekle")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(title.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(10)
                    }
                    .disabled(title.isEmpty)
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("Yeni Görev")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Ekle") {
                        addTask()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    private func addTask() {
        let newTask = Task(
            title: title,
            priority: priority,
            dueDate: hasDueDate ? dueDate : nil,
            notes: notes
        )
        
        taskStore.addTask(newTask)
        dismiss()
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
}

#Preview {
    AddTaskView()
        .environmentObject(TaskStore())
}