import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Text(
          'General Info Form',
          style: TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF93ABFF),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0.w, 2.h, 16.0.w, 0.h),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Worker Type Selection
              Text('Worker Type',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5.h,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // Ensure proper spacing
                  children: [
                    Expanded(
                      child: _buildOption('Fixed Rate', Icons.credit_card),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _buildOption('Pay As You', Icons.hourglass_empty),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _buildOption(
                          'Milestone', Icons.account_balance_wallet),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              // Personal Information Fields
              Text('Personal Information',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5.h,
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
                            Text(
                              'First Name',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                            TextFormField(
                              onChanged: _controller.updateFirstName,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 12.h,
                                ),
                                hintText: 'Enter first name',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last Name',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                            TextFormField(
                              onChanged: _controller.updateLastName,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 12.h,
                                ),
                                hintText: 'Enter last name',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  // Second Row: Email and Phone Number
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
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
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 12.h,
                                ),
                                hintText: 'Enter email',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                            TextFormField(
                              onChanged: _controller.updatePhoneNumber,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone),
                                // Country code icon
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 12.h,
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
              SizedBox(height: 5.h),
              Text(
                'Address',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              TextFormField(
                onChanged: _controller.updateAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  hintText: 'Enter address',
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              // Contract Details
              Text('Contract Detail',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'Contract Name',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              TextFormField(
                onChanged: _controller.updateContractName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  hintText: 'Enter contract name',
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tax Residence',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
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
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            hintText: 'Tax Residence',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Seniority Level',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
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
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            hintText: 'Seniority Level',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label
                  Text(
                    "Scope of work",
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.h),
                  // Card Container
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          "Project Overview",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 5.h),
                        TextFormField(
                          maxLines: 3,
                          onChanged: _controller.updateScopeOfWork,
                          decoration: const InputDecoration(
                            // labelText: 'Project Overview',
                            hintText: 'Describe the project...',
                          ),
                        ),
                        SizedBox(height: 2.h),
                        // Character Count
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "320/1000",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
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
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
        decoration: BoxDecoration(
          // color: isSelected ? Colors.lightBlue[100] : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? Color(0xFF93ABFF) : Colors.grey,
            width: 2.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Color(0xFF93ABFF) : Colors.grey),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                // fontSize: 10.sp, //Optional
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
