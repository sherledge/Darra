class Investment {
  final String id;
  final String name;
  final String type;
  final String image;
  final String description;
  final double amount;
  final double returns;
  final double profit;
  final int duration; // Duration in days or months
  final bool isActive;

  Investment({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.description,
    required this.amount,
    required this.returns,
    required this.profit,
    required this.duration,
    required this.isActive,
  });
toJson(){
  return{"Name":name,
  "Type":type,
  "Image":image,
  "Description":description,
  "Amount":amount,
  "Profit":profit,
  "Duration":duration,
  "IsActive":isActive,
  };
}
  // Method to convert Investment object to a map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'image':image,
      'description': description,
      'amount': amount,
      'returns': returns,
      'profit': profit,
      'duration': duration,
      'isActive': isActive,
    };
  }

  // Method to create an Investment object from a map (e.g., from Firebase)
  factory Investment.fromMap(Map<String, dynamic> map) {
  return Investment(
    id: map['id'] ?? '',
    name: map['name'] ?? '',
    type: map['type'] ?? '',
    image: map['image']??'',
    description: map['description'] ?? '',
    amount: map['amount']?.toDouble() ?? 0.0,
    returns: map['returns']?.toDouble() ?? 0.0,
    profit: map['profit']?.toDouble() ?? 0.0,
    duration: map['duration']?.toInt() ?? 0,
    isActive: map['isActive'] ?? false,
  );
}
}
