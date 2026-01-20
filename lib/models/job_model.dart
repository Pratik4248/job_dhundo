class JobModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final String description;
  final String redirectUrl;
  final int? salaryMin;
  final int? salaryMax;

  JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.redirectUrl,
    this.salaryMin,
    this.salaryMax,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      company: json['company']?['display_name'] ?? '',
      location: json['location']?['display_name'] ?? '',
      description: json['description'] ?? '',
      redirectUrl: json['redirect_url'] ?? '',
      salaryMin: json['salary_min'],
      salaryMax: json['salary_max'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': {'display_name': company},
      'location': {'display_name': location},
      'description': description,
      'redirect_url': redirectUrl,
      'salary_min': salaryMin,
      'salary_max': salaryMax,
    };
  }
}
