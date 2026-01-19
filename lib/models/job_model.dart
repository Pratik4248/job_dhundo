class JobModel {
  final String title;
  final String company;
  final String location;
  final String description;
  final String redirectUrl;
  final int? salaryMin;
  final int? salaryMax;

  JobModel({
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
      title: json['title'] ?? '',
      company: json['company']?['display_name'] ?? '',
      location: json['location']?['display_name'] ?? '',
      description: json['description'] ?? '',
      redirectUrl: json['redirect_url'] ?? '',
      salaryMin: json['salary_min'],
      salaryMax: json['salary_max'],
    );
  }
}
