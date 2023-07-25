class Rule6 {
  final String id;
  final String description;
  bool isChecked;

  Rule6({
    required this.id,
    required this.description,
    this.isChecked = false,
  });

  factory Rule6.fromJson(Map<String, dynamic> json) {
    return Rule6(
      id: json['fellingTreeConditionId'],
      description: json['description'],
      isChecked: false,
    );
  }
}
