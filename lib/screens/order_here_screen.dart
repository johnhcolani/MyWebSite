import 'package:flutter/material.dart';
import 'package:my_web_site/core/ColorManager.dart';
import 'package:my_web_site/helper/app_background.dart';

class OrderHereScreen extends StatefulWidget {
  const OrderHereScreen({super.key});

  @override
  State<OrderHereScreen> createState() => _OrderHereScreenState();
}

class _OrderHereScreenState extends State<OrderHereScreen> {
  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _appNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _featuresController = TextEditingController();
  final _budgetController = TextEditingController();
  final _timelineController = TextEditingController();
  final _additionalNotesController = TextEditingController();
  final _designStyleController = TextEditingController();
  final _colorSchemeController = TextEditingController();
  final _designInspirationController = TextEditingController();
  final _brandGuidelinesController = TextEditingController();

  // Platform selection
  Map<String, bool> platforms = {
    'iOS': false,
    'Android': false,
    'Web': false,
    'Windows': false,
    'macOS': false,
    'Linux': false,
  };

  // App type selection
  String? selectedAppType;
  final List<String> appTypes = [
    'Mobile App',
    'Web Application',
    'Desktop Application',
    'Cross-Platform App',
    'Progressive Web App (PWA)',
    'Other',
  ];

  // Priority selection
  String? selectedPriority;
  final List<String> priorities = [
    'Low',
    'Medium',
    'High',
    'Urgent',
  ];

  // Design complexity selection
  String? selectedDesignComplexity;
  final List<String> designComplexities = [
    'Simple',
    'Moderate',
    'Complex',
    'Very Complex',
  ];

  // Design style selection
  String? selectedDesignStyle;
  final List<String> designStyles = [
    'Modern & Minimalist',
    'Bold & Colorful',
    'Professional & Corporate',
    'Playful & Creative',
    'Elegant & Sophisticated',
    'Custom/Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _appNameController.dispose();
    _descriptionController.dispose();
    _featuresController.dispose();
    _budgetController.dispose();
    _timelineController.dispose();
    _additionalNotesController.dispose();
    _designStyleController.dispose();
    _colorSchemeController.dispose();
    _designInspirationController.dispose();
    _brandGuidelinesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    final bool isMobile = wi < 600;
    final bool isTablet = wi >= 600 && wi < 1024;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorManager.blue,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff020923),
        title: const Text('Order Here', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          const AppBackground(),
          SafeArea(
            child: Form(
              key: _formKey,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(isMobile ? 16.0 : (isTablet ? 24.0 : 32.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            'Order Your App',
                            style: TextStyle(
                              fontSize: isMobile ? 28 : (isTablet ? 32 : 36),
                              fontWeight: FontWeight.bold,
                              color: ColorManager.white,
                            ),
                          ),
                          SizedBox(height: he * 0.02),
                          Text(
                            'Please fill out the form below with all the details about your app project.',
                            style: TextStyle(
                              fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
                              color: ColorManager.white.withValues(alpha: 0.8),
                            ),
                          ),
                          SizedBox(height: he * 0.03),

                          // Client Information Section
                          _buildSectionTitle('Client Information', isMobile),
                          SizedBox(height: he * 0.015),
                          _buildTextField(
                            controller: _nameController,
                            label: 'Full Name *',
                            hint: 'Enter your full name',
                            isRequired: true,
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.015),
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email Address *',
                            hint: 'your.email@example.com',
                            keyboardType: TextInputType.emailAddress,
                            isRequired: true,
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.015),
                          _buildTextField(
                            controller: _phoneController,
                            label: 'Phone Number *',
                            hint: '+1 (555) 123-4567',
                            keyboardType: TextInputType.phone,
                            isRequired: true,
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.015),
                          _buildTextField(
                            controller: _companyController,
                            label: 'Company/Organization',
                            hint: 'Your company name (optional)',
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.03),

                          // App Details Section
                          _buildSectionTitle('App Details', isMobile),
                          SizedBox(height: he * 0.015),
                          _buildTextField(
                            controller: _appNameController,
                            label: 'App Name *',
                            hint: 'What would you like to name your app?',
                            isRequired: true,
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.015),
                          _buildDropdown(
                            label: 'App Type *',
                            value: selectedAppType,
                            items: appTypes,
                            onChanged: (value) {
                              setState(() {
                                selectedAppType = value;
                              });
                            },
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.015),
                          _buildTextField(
                            controller: _descriptionController,
                            label: 'App Description *',
                            hint: 'Describe what your app does and its main purpose...',
                            maxLines: 5,
                            isRequired: true,
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.015),
                          _buildTextField(
                            controller: _featuresController,
                            label: 'Key Features & Requirements',
                            hint: 'List the main features and functionalities you need...',
                            maxLines: 6,
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.03),

                          // Platform Selection Section
                          _buildSectionTitle('Target Platforms *', isMobile),
                          SizedBox(height: he * 0.015),
                          Text(
                            'Select all platforms where you want your app to be available:',
                            style: TextStyle(
                              fontSize: isMobile ? 13 : 15,
                              color: ColorManager.white.withValues(alpha: 0.8),
                            ),
                          ),
                          SizedBox(height: he * 0.01),
                          _buildPlatformCheckboxes(isMobile),
                          SizedBox(height: he * 0.03),

                          // Project Details Section
                          _buildSectionTitle('Project Details', isMobile),
                          SizedBox(height: he * 0.015),
                          _buildDropdown(
                            label: 'Priority Level',
                            value: selectedPriority,
                            items: priorities,
                            onChanged: (value) {
                              setState(() {
                                selectedPriority = value;
                              });
                            },
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.015),
                          _buildTextField(
                            controller: _budgetController,
                            label: 'Budget Range',
                            hint: r'e.g., $5,000 - $10,000 or Flexible',
                            keyboardType: TextInputType.text,
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.015),
                          _buildTextField(
                            controller: _timelineController,
                            label: 'Desired Timeline',
                            hint: 'e.g., 3 months, ASAP, Flexible',
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.015),
                          _buildTextField(
                            controller: _additionalNotesController,
                            label: 'Additional Notes',
                            hint: 'Any other information you think we should know...',
                            maxLines: 4,
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.03),

                          // Design Requirements Section
                          _buildSectionTitle('Design Requirements', isMobile),
                          SizedBox(height: he * 0.015),
                          _buildDropdown(
                            label: 'Design Style Preference',
                            value: selectedDesignStyle,
                            items: designStyles,
                            onChanged: (value) {
                              setState(() {
                                selectedDesignStyle = value;
                              });
                            },
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.015),
                          _buildTextField(
                            controller: _colorSchemeController,
                            label: 'Color Scheme / Brand Colors',
                            hint: 'e.g., Primary: #FF5733, Secondary: #33C3F0, or describe your color preferences',
                            maxLines: 2,
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.015),
                          _buildDropdown(
                            label: 'Design Complexity Level',
                            value: selectedDesignComplexity,
                            items: designComplexities,
                            onChanged: (value) {
                              setState(() {
                                selectedDesignComplexity = value;
                              });
                            },
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.015),
                          _buildTextField(
                            controller: _designInspirationController,
                            label: 'Design Inspiration / References',
                            hint: 'Share links to apps or websites you like, or describe the look and feel you want...',
                            maxLines: 4,
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.015),
                          _buildTextField(
                            controller: _brandGuidelinesController,
                            label: 'Brand Guidelines / Assets',
                            hint: 'Do you have brand guidelines, logo files, or other design assets? Describe or mention if you will provide them.',
                            maxLines: 3,
                            isMobile: isMobile,
                          ),
                          SizedBox(height: he * 0.04),

                          // Submit Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.orange,
                                padding: EdgeInsets.symmetric(
                                  vertical: isMobile ? 16 : 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Submit Order',
                                style: TextStyle(
                                  fontSize: isMobile ? 16 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: he * 0.02),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isMobile) {
    return Text(
      title,
      style: TextStyle(
        fontSize: isMobile ? 20 : 24,
        fontWeight: FontWeight.bold,
        color: ColorManager.orange,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isRequired = false,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required bool isMobile,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: ColorManager.white,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(color: ColorManager.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
            filled: true,
            fillColor: const Color(0xFF0F1F35).withValues(alpha: 0.55),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ColorManager.blue.withValues(alpha: 0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ColorManager.blue.withValues(alpha: 0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ColorManager.orange, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: maxLines > 1 ? 12 : 16),
          ),
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  if (label.contains('Email') && !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required bool isMobile,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: ColorManager.white,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorManager.blue.withValues(alpha: 0.3)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 16),
            ),
            dropdownColor: const Color(0xff1A202C),
            style: TextStyle(color: ColorManager.white),
            icon: Icon(Icons.arrow_drop_down, color: ColorManager.orange),
            hint: Text(
              'Select ${label.replaceAll('*', '')}',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            validator: label.contains('*')
                ? (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  }
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildPlatformCheckboxes(bool isMobile) {
    return Wrap(
      spacing: isMobile ? 12 : 16,
      runSpacing: 12,
      children: platforms.entries.map((entry) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: entry.value
                  ? ColorManager.orange
                  : ColorManager.blue.withValues(alpha: 0.3),
              width: entry.value ? 2 : 1,
            ),
          ),
          child: CheckboxListTile(
            title: Text(
              entry.key,
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                color: ColorManager.white,
              ),
            ),
            value: entry.value,
            activeColor: ColorManager.orange,
            checkColor: Colors.white,
            onChanged: (bool? value) {
              setState(() {
                platforms[entry.key] = value ?? false;
              });
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
            dense: true,
          ),
        );
      }).toList(),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Check if at least one platform is selected
      bool hasPlatformSelected = platforms.values.any((selected) => selected);
      if (!hasPlatformSelected) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select at least one platform'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Collect form data
      String selectedPlatforms = platforms.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .join(', ');

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xff1A202C),
            title: Text(
              'Order Submitted!',
              style: TextStyle(color: ColorManager.orange),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thank you for your order!',
                  style: TextStyle(
                    color: ColorManager.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'App Name: ${_appNameController.text}',
                  style: TextStyle(color: ColorManager.white),
                ),
                Text(
                  'Platforms: $selectedPlatforms',
                  style: TextStyle(color: ColorManager.white),
                ),
                SizedBox(height: 8),
                Text(
                  'We will contact you soon at ${_emailController.text}',
                  style: TextStyle(color: ColorManager.white),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Reset form
                  _formKey.currentState!.reset();
                  _nameController.clear();
                  _emailController.clear();
                  _phoneController.clear();
                  _companyController.clear();
                  _appNameController.clear();
                  _descriptionController.clear();
                  _featuresController.clear();
                  _budgetController.clear();
                  _timelineController.clear();
                  _additionalNotesController.clear();
                  _designStyleController.clear();
                  _colorSchemeController.clear();
                  _designInspirationController.clear();
                  _brandGuidelinesController.clear();
                  setState(() {
                    platforms.updateAll((key, value) => false);
                    selectedAppType = null;
                    selectedPriority = null;
                    selectedDesignStyle = null;
                    selectedDesignComplexity = null;
                  });
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: ColorManager.orange),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
