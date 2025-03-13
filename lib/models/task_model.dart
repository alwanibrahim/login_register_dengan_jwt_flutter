class Task {
  final int id;
  final String title;
  final String description;
  final String status;
  final String? dueDate;
  final String createdAt;
  final String updatedAt;
  final int userId;
  final List<Category> categories;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.categories,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    var list = json['categories'] as List? ?? []; // ✅ Pastikan tidak null
    List<Category> categoryList = list.map((i) => Category.fromJson(i)).toList();

    return Task(
      id: json['id'] ?? 0, // ✅ Jika null, isi dengan default (0)
      title: json['title'] ?? "No Title", // ✅ Default teks
      description: json['description'] ?? "No Description",
      status: json['status'] ?? "pending",
      dueDate: json['due_date'], // Bisa null, tidak masalah
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      userId: json['user_id'] ?? 0,
      categories: categoryList,
    );
  }
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0, // ✅ Jika null, isi dengan default
      name: json['name'] ?? "Uncategorized", // ✅ Default kategori
    );
  }
}
