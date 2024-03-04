class IA {
  final String? name;
  final String? category;
  final String? imageUrl;
  final String? webUrl;
  final String? entornoEjecucion;
  final String? description;
  final String? tutorialUrl;

  IA({
    this.name,
    this.category,
    this.imageUrl,
    this.webUrl,
    this.entornoEjecucion,
    this.description,
    this.tutorialUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'imageUrl': imageUrl,
      'webUrl': webUrl,
      'entornoEjecucion': entornoEjecucion,
      'description': description,
      'tutorialUrl': tutorialUrl,
    };
  }

  IA.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        category = map['category'],
        imageUrl = map['imageUrl'],
        webUrl = map['webUrl'],
        entornoEjecucion = map['entornoEjecucion'],
        description = map['description'],
        tutorialUrl = map['tutorialUrl'];

  @override
  String toString() {
    return 'IA{name: $name, category: $category, imageUrl: $imageUrl, webUrl: $webUrl, entornoEjecucion: $entornoEjecucion, description: $description, tutorialUrl: $tutorialUrl}';
  }
}
