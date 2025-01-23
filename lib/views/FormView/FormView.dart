import 'package:flutter/material.dart';
import '../../controllers/FormController/FormController.dart';

class FormView extends StatefulWidget {
  const FormView({super.key});

  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final _formKey = GlobalKey<FormState>();
  final FormController _controller = FormController();
  String selectedWorkerType = 'Fixed Rate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'General Info Form',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF93ABFF),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 2, 16.0, 0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Worker Type Selection
              const Text('Worker Type',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // Ensure proper spacing
                  children: [
                    Expanded(
                      child: _buildOption('Fixed Rate', Icons.credit_card),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildOption('Pay As You', Icons.hourglass_empty),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildOption(
                          'Milestone', Icons.account_balance_wallet),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Personal Information Fields
              const Text('Personal Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First Row: First Name and Last Name
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'First Name',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            TextFormField(
                              onChanged: _controller.updateFirstName,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                hintText: 'Enter first name',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Last Name',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            TextFormField(
                              onChanged: _controller.updateLastName,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                hintText: 'Enter last name',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  // Second Row: Email and Phone Number
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            TextFormField(
                              onChanged: _controller.updateEmail,
                              validator: (value) {
                                return value != null && value.contains('@')
                                    ? null
                                    : 'Enter a valid email.';
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                hintText: 'Enter email',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Phone Number',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            TextFormField(
                              onChanged: _controller.updatePhoneNumber,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone),
                                // Country code icon
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                hintText: 'Enter phone number',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                'Address',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              TextFormField(
                onChanged: _controller.updateAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  hintText: 'Enter address',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Contract Details
              const Text('Contract Detail',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              const Text(
                'Contract Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              TextFormField(
                onChanged: _controller.updateContractName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  hintText: 'Enter contract name',
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tax Residence',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        DropdownButtonFormField<String>(
                          value: _controller.worker.taxResidence,
                          // Use the default or selected value
                          items: ['United States', 'India', 'Germany']
                              .map((country) => DropdownMenuItem(
                                    value: country,
                                    child: Text(country),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _controller.updateTaxResidence(
                                  value); // Update the value in the controller
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            hintText: 'Tax Residence',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Seniority Level',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        DropdownButtonFormField<String>(
                          value: _controller.worker.seniorityLevel,
                          // Use the default or selected value
                          items: ['Level 1', 'Level 2', 'Level 3']
                              .map((level) => DropdownMenuItem(
                                    value: level,
                                    child: Text(level),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _controller.updateSeniorityLevel(
                                  value); // Update the value in the controller
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            hintText: 'Seniority Level',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label
                  Text(
                    "Scope of work",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  // Card Container
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          "Project Overview",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          maxLines: 3,
                          onChanged: _controller.updateScopeOfWork,
                          decoration: const InputDecoration(
                            // labelText: 'Project Overview',
                            hintText: 'Describe the project...',
                          ),
                        ),
                        SizedBox(height: 2),
                        // Character Count
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "320/1000",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final errorMessage = _controller.validateForm();
                    if (errorMessage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Form submitted successfully!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String title, IconData icon) {
    final bool isSelected = selectedWorkerType == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedWorkerType = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          // color: isSelected ? Colors.lightBlue[100] : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Color(0xFF93ABFF) : Colors.grey,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Color(0xFF93ABFF) : Colors.grey),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Color(0xFF93ABFF) : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
