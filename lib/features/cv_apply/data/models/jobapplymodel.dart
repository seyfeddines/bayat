class JobApplicationModel {
  final String fullName;
  final String dateOfBirth;
  final String email;
  final String phone;
  final String wilaya;
  final String baladiya;
  final String address;
  final String intermediaryNumber;
  final int job;

  JobApplicationModel({
    required this.fullName,
    required this.dateOfBirth,
    required this.email,
    required this.phone,
    required this.wilaya,
    required this.baladiya,
    required this.address,
    required this.intermediaryNumber,
    required this.job,
  });

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "date_of_birth": dateOfBirth,
      "email": email,
      "phone": phone,
      "wilaya": wilaya,
      "baladiya": baladiya,
      "address": address,
      "intermediary_number": intermediaryNumber,
      "job": job,
    };
  }
}
