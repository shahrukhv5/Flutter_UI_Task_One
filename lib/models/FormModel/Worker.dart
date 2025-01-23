// models/worker_model.dart
class Worker {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String address;
  String contractName;
  String taxResidence;
  String seniorityLevel;
  String scopeOfWork;

  Worker({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phoneNumber = '',
    this.address = '',
    this.contractName = '',
    this.taxResidence = 'United States',
    this.seniorityLevel = 'Level 1',
    this.scopeOfWork = '',
  });

  bool isValidEmail() {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
        .hasMatch(email);
  }

  bool isValidPhoneNumber() {
    return phoneNumber.isNotEmpty && phoneNumber.length >= 10;
  }
}
