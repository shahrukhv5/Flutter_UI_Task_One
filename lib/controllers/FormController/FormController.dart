import '../../models/FormModel/Worker.dart';

class FormController {
  Worker worker = Worker();

  // Update field values
  void updateFirstName(String firstName) {
    worker.firstName = firstName;
  }

  void updateLastName(String lastName) {
    worker.lastName = lastName;
  }

  void updateEmail(String email) {
    worker.email = email;
  }

  void updatePhoneNumber(String phoneNumber) {
    worker.phoneNumber = phoneNumber;
  }

  void updateAddress(String address) {
    worker.address = address;
  }

  void updateContractName(String contractName) {
    worker.contractName = contractName;
  }

  void updateTaxResidence(String? taxResidence) {
    if (taxResidence != null) {
      worker.taxResidence = taxResidence;
    }
  }

  void updateSeniorityLevel(String? seniorityLevel) {
    if (seniorityLevel != null) {
      worker.seniorityLevel = seniorityLevel;
    }
  }

  void updateScopeOfWork(String scopeOfWork) {
    worker.scopeOfWork = scopeOfWork;
  }

  // Validate the entire form
  String? validateForm() {
    if (worker.firstName.isEmpty || worker.lastName.isEmpty) {
      return 'First and Last Name are required.';
    }
    if (!worker.isValidEmail()) {
      return 'Please enter a valid email.';
    }
    if (!worker.isValidPhoneNumber()) {
      return 'Please enter a valid phone number.';
    }
    if (worker.taxResidence.isEmpty) {
      return 'Please select a tax residence.';
    }
    if (worker.seniorityLevel.isEmpty) {
      return 'Please select a seniority level.';
    }
    return null;
  }
}
