import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:my_web_site/core/ColorManager.dart';
import 'package:my_web_site/helper/app_background.dart';
import 'package:sizer/sizer.dart';

class OrderHereScreen extends StatefulWidget {
  const OrderHereScreen({super.key});

  @override
  State<OrderHereScreen> createState() => _OrderHereScreenState();
}

class _OrderHereScreenState extends State<OrderHereScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  
  // Formspree Configuration - Simple form submission service
  // Your form endpoint from https://formspree.io/
  static const String _formspreeEndpoint = 'https://formspree.io/f/maqwlqlq';
  
  // Alternative: EmailJS Configuration (if you prefer EmailJS)
  // Get these from https://www.emailjs.com/
  static const String _emailJSServiceID = 'YOUR_SERVICE_ID';
  static const String _emailJSTemplateID = 'YOUR_TEMPLATE_ID';
  static const String _emailJSPublicKey = 'YOUR_PUBLIC_KEY';
  
  // Controllers
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _clientEmailController = TextEditingController();
  final TextEditingController _clientPhoneController = TextEditingController();
  final TextEditingController _clientCompanyController = TextEditingController();
  final TextEditingController _appNameController = TextEditingController();
  final TextEditingController _appDescriptionController = TextEditingController();
  final TextEditingController _appFeaturesController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _timelineController = TextEditingController();
  final TextEditingController _additionalNotesController = TextEditingController();
  final TextEditingController _colorSchemeController = TextEditingController();
  final TextEditingController _designInspirationController = TextEditingController();
  final TextEditingController _brandGuidelinesController = TextEditingController();

  // Dropdown values
  String? _selectedAppType;
  String? _selectedPriority;
  String? _selectedDesignStyle;
  String? _selectedDesignComplexity;
  String _selectedCountryCode = '+1'; // Default to US

  // Platform checkboxes
  Set<String> _selectedPlatforms = {};
  
  // Feature checkboxes
  Set<String> _selectedFeatures = {};
  
  // Budget range checkboxes
  Set<String> _selectedBudgetRanges = {};
  
  // Timeline checkboxes
  Set<String> _selectedTimelines = {};
  
  // Design section checkboxes
  Set<String> _selectedDesignStyles = {};
  Set<String> _selectedDesignComplexities = {};
  Set<String> _selectedColorSchemes = {};
  Set<String> _selectedDesignInspirations = {};
  Set<String> _selectedBrandElements = {};

  @override
  void dispose() {
    _clientNameController.dispose();
    _clientEmailController.dispose();
    _clientPhoneController.dispose();
    _clientCompanyController.dispose();
    _appNameController.dispose();
    _appDescriptionController.dispose();
    _appFeaturesController.dispose();
    _budgetController.dispose();
    _timelineController.dispose();
    _additionalNotesController.dispose();
    _colorSchemeController.dispose();
    _designInspirationController.dispose();
    _brandGuidelinesController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedPlatforms.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one target platform'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        _isSubmitting = true;
      });

      try {
        // Formspree is configured

        // Prepare form data
        final formData = {
          'name': _clientNameController.text,
          'email': _clientEmailController.text,
          'phone': _clientPhoneController.text.isNotEmpty 
              ? '$_selectedCountryCode ${_clientPhoneController.text}'
              : 'Not provided',
          'company': _clientCompanyController.text.isNotEmpty ? _clientCompanyController.text : 'Not provided',
          'app_name': _appNameController.text,
          'app_type': _selectedAppType ?? 'Not specified',
          'app_description': _appDescriptionController.text,
          'app_features': _selectedFeatures.isNotEmpty 
              ? '${_selectedFeatures.join(', ')}${_appFeaturesController.text.isNotEmpty ? ' | Additional: ${_appFeaturesController.text}' : ''}'
              : (_appFeaturesController.text.isNotEmpty ? _appFeaturesController.text : 'Not specified'),
          'platforms': _selectedPlatforms.join(', '),
          'priority': _selectedPriority ?? 'Not specified',
          'budget': _selectedBudgetRanges.isNotEmpty 
              ? _selectedBudgetRanges.join(', ')
              : (_budgetController.text.isNotEmpty ? _budgetController.text : 'Not specified'),
          'timeline': _selectedTimelines.isNotEmpty 
              ? _selectedTimelines.join(', ')
              : (_timelineController.text.isNotEmpty ? _timelineController.text : 'Not specified'),
          'additional_notes': _additionalNotesController.text.isNotEmpty ? _additionalNotesController.text : 'None',
          'design_style': _selectedDesignStyles.isNotEmpty 
              ? '${_selectedDesignStyles.join(', ')}${_selectedDesignStyle != null ? ' | Additional: $_selectedDesignStyle' : ''}'
              : (_selectedDesignStyle ?? 'Not specified'),
          'design_complexity': _selectedDesignComplexities.isNotEmpty 
              ? '${_selectedDesignComplexities.join(', ')}${_selectedDesignComplexity != null ? ' | Additional: $_selectedDesignComplexity' : ''}'
              : (_selectedDesignComplexity ?? 'Not specified'),
          'color_scheme': _selectedColorSchemes.isNotEmpty 
              ? '${_selectedColorSchemes.join(', ')}${_colorSchemeController.text.isNotEmpty ? ' | Additional: ${_colorSchemeController.text}' : ''}'
              : (_colorSchemeController.text.isNotEmpty ? _colorSchemeController.text : 'Not specified'),
          'design_inspiration': _selectedDesignInspirations.isNotEmpty 
              ? '${_selectedDesignInspirations.join(', ')}${_designInspirationController.text.isNotEmpty ? ' | Additional: ${_designInspirationController.text}' : ''}'
              : (_designInspirationController.text.isNotEmpty ? _designInspirationController.text : 'Not specified'),
          'brand_guidelines': _selectedBrandElements.isNotEmpty 
              ? '${_selectedBrandElements.join(', ')}${_brandGuidelinesController.text.isNotEmpty ? ' | Additional: ${_brandGuidelinesController.text}' : ''}'
              : (_brandGuidelinesController.text.isNotEmpty ? _brandGuidelinesController.text : 'Not specified'),
          '_subject': 'New Order Request: ${_appNameController.text}',
          '_replyto': _clientEmailController.text,
        };
        
        // Send form using Formspree
        final response = await http.post(
          Uri.parse(_formspreeEndpoint),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(formData),
        );

        setState(() {
          _isSubmitting = false;
        });

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Show success dialog
          _showSuccessDialog(isEmailSent: true);
        } else {
          // Show error message with response details
          _showErrorDialog(
            'Failed to send form.\n\n'
            'Status Code: ${response.statusCode}\n'
            'Response: ${response.body}\n\n'
            'Please check your Formspree endpoint.',
          );
        }
      } catch (e) {
        setState(() {
          _isSubmitting = false;
        });
        _showErrorDialog(
          'Error sending form: ${e.toString()}\n\n'
          'Please check your Formspree configuration and internet connection.',
        );
      }
    }
  }

  String _buildEmailBody() {
    final buffer = StringBuffer();
    buffer.writeln('=== NEW ORDER REQUEST ===\n');
    
    buffer.writeln('CLIENT INFORMATION:');
    buffer.writeln('Name: ${_clientNameController.text}');
    buffer.writeln('Email: ${_clientEmailController.text}');
    buffer.writeln('Phone: ${_clientPhoneController.text.isNotEmpty ? _clientPhoneController.text : "Not provided"}');
    buffer.writeln('Company: ${_clientCompanyController.text.isNotEmpty ? _clientCompanyController.text : "Not provided"}');
    buffer.writeln('');
    
    buffer.writeln('APP DETAILS:');
    buffer.writeln('App Name: ${_appNameController.text}');
    buffer.writeln('App Type: ${_selectedAppType ?? "Not specified"}');
    buffer.writeln('Description: ${_appDescriptionController.text}');
    buffer.writeln('Features: ${_appFeaturesController.text.isNotEmpty ? _appFeaturesController.text : "Not specified"}');
    buffer.writeln('');
    
    buffer.writeln('TARGET PLATFORMS:');
    buffer.writeln(_selectedPlatforms.join(', '));
    buffer.writeln('');
    
    buffer.writeln('PROJECT DETAILS:');
    buffer.writeln('Priority: ${_selectedPriority ?? "Not specified"}');
    buffer.writeln('Budget: ${_budgetController.text.isNotEmpty ? _budgetController.text : "Not specified"}');
    buffer.writeln('Timeline: ${_timelineController.text.isNotEmpty ? _timelineController.text : "Not specified"}');
    buffer.writeln('Additional Notes: ${_additionalNotesController.text.isNotEmpty ? _additionalNotesController.text : "None"}');
    buffer.writeln('');
    
    buffer.writeln('DESIGN REQUIREMENTS:');
    buffer.writeln('Style Preference: ${_selectedDesignStyle ?? "Not specified"}');
    buffer.writeln('Complexity Level: ${_selectedDesignComplexity ?? "Not specified"}');
    buffer.writeln('Color Scheme: ${_colorSchemeController.text.isNotEmpty ? _colorSchemeController.text : "Not specified"}');
    buffer.writeln('Design Inspiration: ${_designInspirationController.text.isNotEmpty ? _designInspirationController.text : "Not specified"}');
    buffer.writeln('Brand Guidelines: ${_brandGuidelinesController.text.isNotEmpty ? _brandGuidelinesController.text : "Not specified"}');
    
    return buffer.toString();
  }

  void _showSuccessDialog({bool isEmailSent = true}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff020923),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 24.sp),
              SizedBox(width: 2.w),
              Text(
                'Order Submitted!',
                style: GoogleFonts.albertSans(
                  color: ColorManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            isEmailSent
                ? 'Thank you for your order. We have received your request and will contact you soon.'
                : 'Thank you for your order. Your form has been submitted successfully.\n\nNote: EmailJS is not configured yet, so the email was not sent. Please configure EmailJS to receive email notifications.',
            style: GoogleFonts.albertSans(
              color: ColorManager.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Reset form
                _formKey.currentState!.reset();
                _selectedPlatforms.clear();
                _selectedFeatures.clear();
                _selectedBudgetRanges.clear();
                _selectedTimelines.clear();
                _selectedDesignStyles.clear();
                _selectedDesignComplexities.clear();
                _selectedColorSchemes.clear();
                _selectedDesignInspirations.clear();
                _selectedBrandElements.clear();
                _selectedAppType = null;
                _selectedPriority = null;
                _selectedDesignStyle = null;
                _selectedDesignComplexity = null;
                _selectedCountryCode = '+1'; // Reset to default
              },
              child: Text(
                'OK',
                style: GoogleFonts.albertSans(
                  color: ColorManager.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff020923),
          title: Row(
            children: [
              Icon(Icons.error, color: Colors.red, size: 24.sp),
              SizedBox(width: 2.w),
              Text(
                'Error',
                style: GoogleFonts.albertSans(
                  color: ColorManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: GoogleFonts.albertSans(
              color: ColorManager.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: GoogleFonts.albertSans(
                  color: ColorManager.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isRequired = true,
    int maxLines = 1,
    bool isMobile = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 0.4.h : 0.5.h),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F1F35).withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.albertSans(
            color: ColorManager.white,
            fontSize: isMobile ? 10.sp : 5.sp,
          ),
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            labelStyle: GoogleFonts.albertSans(
              color: ColorManager.white.withValues(alpha: 0.8),
              fontSize: isMobile ? 9.sp : 4.5.sp,
            ),
            hintStyle: GoogleFonts.albertSans(
              color: ColorManager.white.withValues(alpha: 0.5),
              fontSize: isMobile ? 9.sp : 4.5.sp,
            ),
            fillColor: const Color(0xFF0F1F35).withValues(alpha: 0.55),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ColorManager.blue.withValues(alpha: 0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ColorManager.blue.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ColorManager.blue,
                width: 2,
              ),
            ),
          ),
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter $label';
                  }
                  return null;
                }
              : null,
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField({bool isMobile = false}) {
    // Common country codes
    final countryCodes = [
      {'code': '+1', 'country': 'US/CA', 'flag': '🇺🇸'},
      {'code': '+44', 'country': 'UK', 'flag': '🇬🇧'},
      {'code': '+33', 'country': 'FR', 'flag': '🇫🇷'},
      {'code': '+49', 'country': 'DE', 'flag': '🇩🇪'},
      {'code': '+39', 'country': 'IT', 'flag': '🇮🇹'},
      {'code': '+34', 'country': 'ES', 'flag': '🇪🇸'},
      {'code': '+31', 'country': 'NL', 'flag': '🇳🇱'},
      {'code': '+32', 'country': 'BE', 'flag': '🇧🇪'},
      {'code': '+41', 'country': 'CH', 'flag': '🇨🇭'},
      {'code': '+46', 'country': 'SE', 'flag': '🇸🇪'},
      {'code': '+47', 'country': 'NO', 'flag': '🇳🇴'},
      {'code': '+45', 'country': 'DK', 'flag': '🇩🇰'},
      {'code': '+358', 'country': 'FI', 'flag': '🇫🇮'},
      {'code': '+48', 'country': 'PL', 'flag': '🇵🇱'},
      {'code': '+351', 'country': 'PT', 'flag': '🇵🇹'},
      {'code': '+353', 'country': 'IE', 'flag': '🇮🇪'},
      {'code': '+61', 'country': 'AU', 'flag': '🇦🇺'},
      {'code': '+64', 'country': 'NZ', 'flag': '🇳🇿'},
      {'code': '+81', 'country': 'JP', 'flag': '🇯🇵'},
      {'code': '+82', 'country': 'KR', 'flag': '🇰🇷'},
      {'code': '+86', 'country': 'CN', 'flag': '🇨🇳'},
      {'code': '+91', 'country': 'IN', 'flag': '🇮🇳'},
      {'code': '+971', 'country': 'AE', 'flag': '🇦🇪'},
      {'code': '+966', 'country': 'SA', 'flag': '🇸🇦'},
      {'code': '+27', 'country': 'ZA', 'flag': '🇿🇦'},
      {'code': '+55', 'country': 'BR', 'flag': '🇧🇷'},
      {'code': '+52', 'country': 'MX', 'flag': '🇲🇽'},
      {'code': '+54', 'country': 'AR', 'flag': '🇦🇷'},
      {'code': '+90', 'country': 'TR', 'flag': '🇹🇷'},
      {'code': '+7', 'country': 'RU', 'flag': '🇷🇺'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 0.4.h : 0.5.h),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F1F35).withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // Country Code Dropdown
            Container(
              width: isMobile ? 25.w : 12.w,
              margin: EdgeInsets.only(left: isMobile ? 1.w : 0.5.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0F1F35).withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ColorManager.blue.withValues(alpha: 0.3),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCountryCode,
                  isExpanded: true,
                  dropdownColor: const Color(0xFF0F1F35),
                  style: GoogleFonts.albertSans(
                    color: ColorManager.white,
                    fontSize: isMobile ? 9.sp : 4.5.sp,
                  ),
                  items: countryCodes.map((country) {
                    return DropdownMenuItem<String>(
                      value: country['code'] as String,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            country['flag'] as String,
                            style: TextStyle(fontSize: isMobile ? 12.sp : 8.sp),
                          ),
                          SizedBox(width: 0.5.w),
                          Text(
                            country['code'] as String,
                            style: GoogleFonts.albertSans(
                              color: ColorManager.white,
                              fontSize: isMobile ? 9.sp : 4.5.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        _selectedCountryCode = value;
                      }
                    });
                  },
                ),
              ),
            ),
            SizedBox(width: isMobile ? 1.w : 0.5.w),
            // Phone Number Input
            Expanded(
              child: TextFormField(
                controller: _clientPhoneController,
                keyboardType: TextInputType.phone,
                style: GoogleFonts.albertSans(
                  color: ColorManager.white,
                  fontSize: isMobile ? 10.sp : 5.sp,
                ),
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '(555) 123-4567',
                  labelStyle: GoogleFonts.albertSans(
                    color: ColorManager.white.withValues(alpha: 0.8),
                    fontSize: isMobile ? 9.sp : 4.5.sp,
                  ),
                  hintStyle: GoogleFonts.albertSans(
                    color: ColorManager.white.withValues(alpha: 0.5),
                    fontSize: isMobile ? 9.sp : 4.5.sp,
                  ),
                  fillColor: const Color(0xFF0F1F35).withValues(alpha: 0.55),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: ColorManager.blue.withValues(alpha: 0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: ColorManager.blue.withValues(alpha: 0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: ColorManager.blue,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: isMobile ? 1.w : 0.5.w),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
    bool isRequired = true,
    bool isMobile = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 0.4.h : 0.5.h),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0F1F35).withValues(alpha: 0.6),
              const Color(0xFF1A2F4A).withValues(alpha: 0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorManager.blue.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.blue.withValues(alpha: 0.1),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: GoogleFonts.albertSans(
              color: ColorManager.white.withValues(alpha: 0.8),
              fontSize: isMobile ? 9.sp : 4.5.sp,
            ),
            fillColor: const Color(0xFF0F1F35).withValues(alpha: 0.55),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ColorManager.blue.withValues(alpha: 0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ColorManager.blue.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ColorManager.blue,
                width: 2,
              ),
            ),
          ),
          dropdownColor: const Color(0xFF0F1F35),
          style: GoogleFonts.albertSans(
            color: ColorManager.white,
            fontSize: isMobile ? 10.sp : 5.sp,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.albertSans(
                  color: ColorManager.white,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select $label';
                  }
                  return null;
                }
              : null,
        ),
      ),
    );
  }

  Widget _buildPlatformCheckboxes() {
    final platforms = [
      {'name': 'iOS', 'icon': Icons.phone_iphone},
      {'name': 'Android', 'icon': Icons.android},
      {'name': 'Web', 'icon': Icons.language},
      {'name': 'Windows', 'icon': Icons.desktop_windows},
      {'name': 'macOS', 'icon': Icons.laptop_mac},
      {'name': 'Linux', 'icon': Icons.computer},
    ];

    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0F1F35).withValues(alpha: 0.7),
            const Color(0xFF1A2F4A).withValues(alpha: 0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorManager.blue.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.blue.withValues(alpha: 0.15),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 1.h : 0.6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Target Platforms *',
            style: GoogleFonts.albertSans(
              color: ColorManager.white,
              fontSize: isMobile ? 9.sp : 4.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isMobile ? 0.5.h : 0.3.h),
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ColorManager.orange,
                size: isMobile ? 12.sp : 8.sp,
              ),
              SizedBox(width: 0.5.w),
              Expanded(
                child: Text(
                  '💡 Tip: Select one or more platforms below',
                  style: GoogleFonts.albertSans(
                    color: ColorManager.orange.withValues(alpha: 0.9),
                    fontSize: isMobile ? 8.sp : 3.5.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 0.8.h : 0.4.h),
          Wrap(
            spacing: isMobile ? 1.w : 0.6.w,
            runSpacing: isMobile ? 0.6.h : 0.3.h,
            children: platforms.map((platform) {
              final isSelected = _selectedPlatforms.contains(platform['name']);
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      platform['icon'] as IconData,
                      size: isMobile ? 14.sp : 9.sp,
                      color: isSelected ? Colors.white : ColorManager.white,
                    ),
                    SizedBox(width: isMobile ? 0.4.w : 0.25.w),
                    Text(
                      platform['name'] as String,
                      style: GoogleFonts.albertSans(
                        color: isSelected ? Colors.white : ColorManager.white,
                        fontSize: isMobile ? 9.sp : 4.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedPlatforms.add(platform['name'] as String);
                    } else {
                      _selectedPlatforms.remove(platform['name'] as String);
                    }
                  });
                },
                backgroundColor: const Color(0xFF0F1F35).withValues(alpha: 0.6),
                selectedColor: ColorManager.blue.withValues(alpha: 0.7),
                checkmarkColor: Colors.white,
                side: BorderSide(
                  color: isSelected ? ColorManager.blue : ColorManager.blue.withValues(alpha: 0.5),
                  width: isMobile ? 1.5 : 0.8,
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 1.w : 0.5.w,
                  vertical: isMobile ? 0.4.h : 0.2.h,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCheckboxes() {
    final features = [
      {'name': 'User Authentication', 'icon': Icons.person},
      {'name': 'Payment Processing', 'icon': Icons.payment},
      {'name': 'Push Notifications', 'icon': Icons.notifications},
      {'name': 'Social Media Integration', 'icon': Icons.share},
      {'name': 'GPS/Location Services', 'icon': Icons.location_on},
      {'name': 'Camera/Photo Upload', 'icon': Icons.camera_alt},
      {'name': 'Chat/Messaging', 'icon': Icons.chat},
      {'name': 'Search Functionality', 'icon': Icons.search},
      {'name': 'Offline Mode', 'icon': Icons.cloud_off},
      {'name': 'Analytics Dashboard', 'icon': Icons.analytics},
      {'name': 'Admin Panel', 'icon': Icons.admin_panel_settings},
      {'name': 'Multi-language Support', 'icon': Icons.language},
    ];

    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0F1F35).withValues(alpha: 0.7),
            const Color(0xFF1A2F4A).withValues(alpha: 0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorManager.blue.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.blue.withValues(alpha: 0.15),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 1.h : 0.6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ColorManager.orange,
                size: isMobile ? 12.sp : 8.sp,
              ),
              SizedBox(width: 0.5.w),
              Expanded(
                child: Text(
                  '💡 Tip: Select features below instead of typing (or add custom features)',
                  style: GoogleFonts.albertSans(
                    color: ColorManager.orange.withValues(alpha: 0.9),
                    fontSize: isMobile ? 8.sp : 3.5.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 0.8.h : 0.4.h),
          Wrap(
            spacing: isMobile ? 1.w : 0.6.w,
            runSpacing: isMobile ? 0.6.h : 0.3.h,
            children: features.map((feature) {
              final isSelected = _selectedFeatures.contains(feature['name']);
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      feature['icon'] as IconData,
                      size: isMobile ? 12.sp : 7.sp,
                      color: isSelected ? Colors.white : ColorManager.white,
                    ),
                    SizedBox(width: isMobile ? 0.4.w : 0.25.w),
                    Text(
                      feature['name'] as String,
                      style: GoogleFonts.albertSans(
                        color: isSelected ? Colors.white : ColorManager.white,
                        fontSize: isMobile ? 8.sp : 3.5.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedFeatures.add(feature['name'] as String);
                    } else {
                      _selectedFeatures.remove(feature['name'] as String);
                    }
                  });
                },
                backgroundColor: const Color(0xFF0F1F35).withValues(alpha: 0.6),
                selectedColor: ColorManager.blue.withValues(alpha: 0.7),
                checkmarkColor: Colors.white,
                side: BorderSide(
                  color: isSelected ? ColorManager.blue : ColorManager.blue.withValues(alpha: 0.5),
                  width: isMobile ? 1.5 : 0.8,
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 0.8.w : 0.4.w,
                  vertical: isMobile ? 0.4.h : 0.2.h,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: isMobile ? 1.h : 0.6.h),
          Text(
            'Additional Custom Features (optional):',
            style: GoogleFonts.albertSans(
              color: ColorManager.white.withValues(alpha: 0.8),
              fontSize: isMobile ? 8.sp : 3.5.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 0.4.h : 0.3.h),
          _buildTextField(
            label: '',
            hint: 'Add any other features not listed above',
            controller: _appFeaturesController,
            maxLines: 2,
            isRequired: false,
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetCheckboxes() {
    final budgetRanges = [
      {'name': 'Under \$5,000', 'icon': Icons.attach_money},
      {'name': '\$5,000 - \$10,000', 'icon': Icons.attach_money},
      {'name': '\$10,000 - \$25,000', 'icon': Icons.attach_money},
      {'name': '\$25,000 - \$50,000', 'icon': Icons.attach_money},
      {'name': '\$50,000 - \$100,000', 'icon': Icons.attach_money},
      {'name': 'Over \$100,000', 'icon': Icons.attach_money},
      {'name': 'Flexible/Budget TBD', 'icon': Icons.swap_horiz},
    ];

    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0F1F35).withValues(alpha: 0.7),
            const Color(0xFF1A2F4A).withValues(alpha: 0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorManager.blue.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.blue.withValues(alpha: 0.15),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 1.h : 0.6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ColorManager.orange,
                size: isMobile ? 12.sp : 8.sp,
              ),
              SizedBox(width: 0.5.w),
              Expanded(
                child: Text(
                  '💡 Tip: Select your budget range below (or specify custom range)',
                  style: GoogleFonts.albertSans(
                    color: ColorManager.orange.withValues(alpha: 0.9),
                    fontSize: isMobile ? 8.sp : 3.5.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 0.8.h : 0.4.h),
          Wrap(
            spacing: isMobile ? 1.w : 0.6.w,
            runSpacing: isMobile ? 0.6.h : 0.3.h,
            children: budgetRanges.map((budget) {
              final isSelected = _selectedBudgetRanges.contains(budget['name']);
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      budget['icon'] as IconData,
                      size: isMobile ? 12.sp : 7.sp,
                      color: isSelected ? Colors.white : ColorManager.white,
                    ),
                    SizedBox(width: isMobile ? 0.4.w : 0.25.w),
                    Text(
                      budget['name'] as String,
                      style: GoogleFonts.albertSans(
                        color: isSelected ? Colors.white : ColorManager.white,
                        fontSize: isMobile ? 8.sp : 3.5.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedBudgetRanges.add(budget['name'] as String);
                    } else {
                      _selectedBudgetRanges.remove(budget['name'] as String);
                    }
                  });
                },
                backgroundColor: const Color(0xFF0F1F35).withValues(alpha: 0.6),
                selectedColor: ColorManager.blue.withValues(alpha: 0.7),
                checkmarkColor: Colors.white,
                side: BorderSide(
                  color: isSelected ? ColorManager.blue : ColorManager.blue.withValues(alpha: 0.5),
                  width: isMobile ? 1.5 : 0.8,
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 0.8.w : 0.4.w,
                  vertical: isMobile ? 0.4.h : 0.2.h,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: isMobile ? 1.h : 0.6.h),
          Text(
            'Custom Budget Range (optional):',
            style: GoogleFonts.albertSans(
              color: ColorManager.white.withValues(alpha: 0.8),
              fontSize: isMobile ? 8.sp : 3.5.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 0.4.h : 0.3.h),
          _buildTextField(
            label: '',
            hint: 'Specify a custom budget range if needed',
            controller: _budgetController,
            isRequired: false,
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCheckboxes() {
    final timelines = [
      {'name': 'ASAP / Urgent', 'icon': Icons.flash_on},
      {'name': '1-2 Months', 'icon': Icons.calendar_today},
      {'name': '3-4 Months', 'icon': Icons.calendar_today},
      {'name': '5-6 Months', 'icon': Icons.calendar_today},
      {'name': '6+ Months', 'icon': Icons.calendar_today},
      {'name': 'Flexible Timeline', 'icon': Icons.swap_horiz},
    ];

    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0F1F35).withValues(alpha: 0.7),
            const Color(0xFF1A2F4A).withValues(alpha: 0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorManager.blue.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.blue.withValues(alpha: 0.15),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 1.h : 0.6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ColorManager.orange,
                size: isMobile ? 12.sp : 8.sp,
              ),
              SizedBox(width: 0.5.w),
              Expanded(
                child: Text(
                  '💡 Tip: Select your timeline below (or specify custom timeline)',
                  style: GoogleFonts.albertSans(
                    color: ColorManager.orange.withValues(alpha: 0.9),
                    fontSize: isMobile ? 8.sp : 3.5.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 0.8.h : 0.4.h),
          Wrap(
            spacing: isMobile ? 1.w : 0.6.w,
            runSpacing: isMobile ? 0.6.h : 0.3.h,
            children: timelines.map((timeline) {
              final isSelected = _selectedTimelines.contains(timeline['name']);
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      timeline['icon'] as IconData,
                      size: isMobile ? 12.sp : 7.sp,
                      color: isSelected ? Colors.white : ColorManager.white,
                    ),
                    SizedBox(width: isMobile ? 0.4.w : 0.25.w),
                    Text(
                      timeline['name'] as String,
                      style: GoogleFonts.albertSans(
                        color: isSelected ? Colors.white : ColorManager.white,
                        fontSize: isMobile ? 8.sp : 3.5.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedTimelines.add(timeline['name'] as String);
                    } else {
                      _selectedTimelines.remove(timeline['name'] as String);
                    }
                  });
                },
                backgroundColor: const Color(0xFF0F1F35).withValues(alpha: 0.6),
                selectedColor: ColorManager.blue.withValues(alpha: 0.7),
                checkmarkColor: Colors.white,
                side: BorderSide(
                  color: isSelected ? ColorManager.blue : ColorManager.blue.withValues(alpha: 0.5),
                  width: isMobile ? 1.5 : 0.8,
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 0.8.w : 0.4.w,
                  vertical: isMobile ? 0.4.h : 0.2.h,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: isMobile ? 1.h : 0.6.h),
          Text(
            'Custom Timeline (optional):',
            style: GoogleFonts.albertSans(
              color: ColorManager.white.withValues(alpha: 0.8),
              fontSize: isMobile ? 8.sp : 3.5.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 0.4.h : 0.3.h),
          _buildTextField(
            label: '',
            hint: 'Specify a custom timeline if needed',
            controller: _timelineController,
            isRequired: false,
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildDesignStyleCheckboxes(bool isMobile) {
    final designStyles = [
      {'name': 'Modern & Minimalist', 'icon': Icons.clean_hands},
      {'name': 'Bold & Colorful', 'icon': Icons.palette},
      {'name': 'Professional & Corporate', 'icon': Icons.business},
      {'name': 'Playful & Creative', 'icon': Icons.brush},
      {'name': 'Elegant & Sophisticated', 'icon': Icons.diamond},
      {'name': 'Tech & Futuristic', 'icon': Icons.rocket_launch},
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 1.h : 0.6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ColorManager.orange,
                size: isMobile ? 12.sp : 8.sp,
              ),
              SizedBox(width: 0.5.w),
              Expanded(
                child: Text(
                  '💡 Tip: Select design styles below (or use dropdown)',
                  style: GoogleFonts.albertSans(
                    color: ColorManager.orange.withValues(alpha: 0.9),
                    fontSize: isMobile ? 8.sp : 3.5.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 0.8.h : 0.4.h),
          Wrap(
            spacing: isMobile ? 1.w : 0.6.w,
            runSpacing: isMobile ? 0.6.h : 0.3.h,
            children: designStyles.map((style) {
              final isSelected = _selectedDesignStyles.contains(style['name']);
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      style['icon'] as IconData,
                      size: isMobile ? 12.sp : 7.sp,
                      color: isSelected ? Colors.white : ColorManager.white,
                    ),
                    SizedBox(width: isMobile ? 0.4.w : 0.25.w),
                    Text(
                      style['name'] as String,
                      style: GoogleFonts.albertSans(
                        color: isSelected ? Colors.white : ColorManager.white,
                        fontSize: isMobile ? 8.sp : 3.5.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedDesignStyles.add(style['name'] as String);
                    } else {
                      _selectedDesignStyles.remove(style['name'] as String);
                    }
                  });
                },
                backgroundColor: const Color(0xFF0F1F35).withValues(alpha: 0.6),
                selectedColor: ColorManager.orange.withValues(alpha: 0.7),
                checkmarkColor: Colors.white,
                side: BorderSide(
                  color: isSelected ? ColorManager.orange : ColorManager.orange.withValues(alpha: 0.5),
                  width: isMobile ? 1.5 : 0.8,
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 0.8.w : 0.4.w,
                  vertical: isMobile ? 0.4.h : 0.2.h,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDesignComplexityCheckboxes(bool isMobile) {
    final complexities = [
      {'name': 'Simple', 'icon': Icons.looks_one},
      {'name': 'Moderate', 'icon': Icons.looks_two},
      {'name': 'Complex', 'icon': Icons.looks_3},
      {'name': 'Very Complex', 'icon': Icons.looks_4},
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 1.h : 0.6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ColorManager.orange,
                size: isMobile ? 12.sp : 8.sp,
              ),
              SizedBox(width: 0.5.w),
              Expanded(
                child: Text(
                  '💡 Tip: Select complexity level below (or use dropdown)',
                  style: GoogleFonts.albertSans(
                    color: ColorManager.orange.withValues(alpha: 0.9),
                    fontSize: isMobile ? 8.sp : 3.5.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 0.8.h : 0.4.h),
          Wrap(
            spacing: isMobile ? 1.w : 0.6.w,
            runSpacing: isMobile ? 0.6.h : 0.3.h,
            children: complexities.map((complexity) {
              final isSelected = _selectedDesignComplexities.contains(complexity['name']);
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      complexity['icon'] as IconData,
                      size: isMobile ? 12.sp : 7.sp,
                      color: isSelected ? Colors.white : ColorManager.white,
                    ),
                    SizedBox(width: isMobile ? 0.4.w : 0.25.w),
                    Text(
                      complexity['name'] as String,
                      style: GoogleFonts.albertSans(
                        color: isSelected ? Colors.white : ColorManager.white,
                        fontSize: isMobile ? 8.sp : 3.5.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedDesignComplexities.add(complexity['name'] as String);
                    } else {
                      _selectedDesignComplexities.remove(complexity['name'] as String);
                    }
                  });
                },
                backgroundColor: const Color(0xFF0F1F35).withValues(alpha: 0.6),
                selectedColor: ColorManager.orange.withValues(alpha: 0.7),
                checkmarkColor: Colors.white,
                side: BorderSide(
                  color: isSelected ? ColorManager.orange : ColorManager.orange.withValues(alpha: 0.5),
                  width: isMobile ? 1.5 : 0.8,
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 0.8.w : 0.4.w,
                  vertical: isMobile ? 0.4.h : 0.2.h,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildColorSchemeCheckboxes(bool isMobile) {
    final colorSchemes = [
      {'name': 'Blue & White', 'icon': Icons.color_lens},
      {'name': 'Dark Theme', 'icon': Icons.dark_mode},
      {'name': 'Light Theme', 'icon': Icons.light_mode},
      {'name': 'Warm Colors', 'icon': Icons.wb_sunny},
      {'name': 'Cool Colors', 'icon': Icons.ac_unit},
      {'name': 'Monochrome', 'icon': Icons.filter_b_and_w},
      {'name': 'Vibrant Colors', 'icon': Icons.auto_awesome},
      {'name': 'Pastel Colors', 'icon': Icons.brush},
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 1.h : 0.6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ColorManager.orange,
                size: isMobile ? 12.sp : 8.sp,
              ),
              SizedBox(width: 0.5.w),
              Expanded(
                child: Text(
                  '💡 Tip: Select color schemes below (or describe custom colors)',
                  style: GoogleFonts.albertSans(
                    color: ColorManager.orange.withValues(alpha: 0.9),
                    fontSize: isMobile ? 8.sp : 3.5.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 0.8.h : 0.4.h),
          Wrap(
            spacing: isMobile ? 1.w : 0.6.w,
            runSpacing: isMobile ? 0.6.h : 0.3.h,
            children: colorSchemes.map((scheme) {
              final isSelected = _selectedColorSchemes.contains(scheme['name']);
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      scheme['icon'] as IconData,
                      size: isMobile ? 12.sp : 7.sp,
                      color: isSelected ? Colors.white : ColorManager.white,
                    ),
                    SizedBox(width: isMobile ? 0.4.w : 0.25.w),
                    Text(
                      scheme['name'] as String,
                      style: GoogleFonts.albertSans(
                        color: isSelected ? Colors.white : ColorManager.white,
                        fontSize: isMobile ? 8.sp : 3.5.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedColorSchemes.add(scheme['name'] as String);
                    } else {
                      _selectedColorSchemes.remove(scheme['name'] as String);
                    }
                  });
                },
                backgroundColor: const Color(0xFF0F1F35).withValues(alpha: 0.6),
                selectedColor: ColorManager.orange.withValues(alpha: 0.7),
                checkmarkColor: Colors.white,
                side: BorderSide(
                  color: isSelected ? ColorManager.orange : ColorManager.orange.withValues(alpha: 0.5),
                  width: isMobile ? 1.5 : 0.8,
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 0.8.w : 0.4.w,
                  vertical: isMobile ? 0.4.h : 0.2.h,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: isMobile ? 1.h : 0.6.h),
          Text(
            'Custom Color Scheme (optional):',
            style: GoogleFonts.albertSans(
              color: ColorManager.white.withValues(alpha: 0.8),
              fontSize: isMobile ? 8.sp : 3.5.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 0.4.h : 0.3.h),
          _buildTextField(
            label: '',
            hint: 'Describe your preferred color palette or brand colors',
            controller: _colorSchemeController,
            maxLines: 2,
            isRequired: false,
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildDesignInspirationCheckboxes(bool isMobile) {
    final inspirations = [
      {'name': 'Apple Design', 'icon': Icons.phone_iphone},
      {'name': 'Google Material', 'icon': Icons.android},
      {'name': 'Dribbble Style', 'icon': Icons.palette},
      {'name': 'Behance Portfolio', 'icon': Icons.design_services},
      {'name': 'Minimalist Apps', 'icon': Icons.apps},
      {'name': 'Gaming UI', 'icon': Icons.sports_esports},
      {'name': 'E-commerce Sites', 'icon': Icons.shopping_cart},
      {'name': 'Social Media Apps', 'icon': Icons.share},
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 1.h : 0.6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ColorManager.orange,
                size: isMobile ? 12.sp : 8.sp,
              ),
              SizedBox(width: 0.5.w),
              Expanded(
                child: Text(
                  '💡 Tip: Select inspiration types below (or add custom links)',
                  style: GoogleFonts.albertSans(
                    color: ColorManager.orange.withValues(alpha: 0.9),
                    fontSize: isMobile ? 8.sp : 3.5.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 0.8.h : 0.4.h),
          Wrap(
            spacing: isMobile ? 1.w : 0.6.w,
            runSpacing: isMobile ? 0.6.h : 0.3.h,
            children: inspirations.map((inspiration) {
              final isSelected = _selectedDesignInspirations.contains(inspiration['name']);
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      inspiration['icon'] as IconData,
                      size: isMobile ? 12.sp : 7.sp,
                      color: isSelected ? Colors.white : ColorManager.white,
                    ),
                    SizedBox(width: isMobile ? 0.4.w : 0.25.w),
                    Text(
                      inspiration['name'] as String,
                      style: GoogleFonts.albertSans(
                        color: isSelected ? Colors.white : ColorManager.white,
                        fontSize: isMobile ? 8.sp : 3.5.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedDesignInspirations.add(inspiration['name'] as String);
                    } else {
                      _selectedDesignInspirations.remove(inspiration['name'] as String);
                    }
                  });
                },
                backgroundColor: const Color(0xFF0F1F35).withValues(alpha: 0.6),
                selectedColor: ColorManager.orange.withValues(alpha: 0.7),
                checkmarkColor: Colors.white,
                side: BorderSide(
                  color: isSelected ? ColorManager.orange : ColorManager.orange.withValues(alpha: 0.5),
                  width: isMobile ? 1.5 : 0.8,
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 0.8.w : 0.4.w,
                  vertical: isMobile ? 0.4.h : 0.2.h,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: isMobile ? 1.h : 0.6.h),
          Text(
            'Custom Design Inspiration (optional):',
            style: GoogleFonts.albertSans(
              color: ColorManager.white.withValues(alpha: 0.8),
              fontSize: isMobile ? 8.sp : 3.5.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 0.4.h : 0.3.h),
          _buildTextField(
            label: '',
            hint: 'Links to apps or websites you like, or describe your vision',
            controller: _designInspirationController,
            maxLines: 3,
            isRequired: false,
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildBrandElementsCheckboxes(bool isMobile) {
    final brandElements = [
      {'name': 'Logo Available', 'icon': Icons.image},
      {'name': 'Brand Guidelines', 'icon': Icons.description},
      {'name': 'Color Palette', 'icon': Icons.palette},
      {'name': 'Typography', 'icon': Icons.text_fields},
      {'name': 'Icon Set', 'icon': Icons.auto_awesome},
      {'name': 'Illustrations', 'icon': Icons.draw},
      {'name': 'Photography', 'icon': Icons.camera_alt},
      {'name': 'No Brand Assets', 'icon': Icons.close},
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 1.h : 0.6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ColorManager.orange,
                size: isMobile ? 12.sp : 8.sp,
              ),
              SizedBox(width: 0.5.w),
              Expanded(
                child: Text(
                  '💡 Tip: Select brand elements you have below (or describe custom assets)',
                  style: GoogleFonts.albertSans(
                    color: ColorManager.orange.withValues(alpha: 0.9),
                    fontSize: isMobile ? 8.sp : 3.5.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 0.8.h : 0.4.h),
          Wrap(
            spacing: isMobile ? 1.w : 0.6.w,
            runSpacing: isMobile ? 0.6.h : 0.3.h,
            children: brandElements.map((element) {
              final isSelected = _selectedBrandElements.contains(element['name']);
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      element['icon'] as IconData,
                      size: isMobile ? 12.sp : 7.sp,
                      color: isSelected ? Colors.white : ColorManager.white,
                    ),
                    SizedBox(width: isMobile ? 0.4.w : 0.25.w),
                    Text(
                      element['name'] as String,
                      style: GoogleFonts.albertSans(
                        color: isSelected ? Colors.white : ColorManager.white,
                        fontSize: isMobile ? 8.sp : 3.5.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedBrandElements.add(element['name'] as String);
                    } else {
                      _selectedBrandElements.remove(element['name'] as String);
                    }
                  });
                },
                backgroundColor: const Color(0xFF0F1F35).withValues(alpha: 0.6),
                selectedColor: ColorManager.orange.withValues(alpha: 0.7),
                checkmarkColor: Colors.white,
                side: BorderSide(
                  color: isSelected ? ColorManager.orange : ColorManager.orange.withValues(alpha: 0.5),
                  width: isMobile ? 1.5 : 0.8,
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 0.8.w : 0.4.w,
                  vertical: isMobile ? 0.4.h : 0.2.h,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: isMobile ? 1.h : 0.6.h),
          Text(
            'Custom Brand Guidelines (optional):',
            style: GoogleFonts.albertSans(
              color: ColorManager.white.withValues(alpha: 0.8),
              fontSize: isMobile ? 8.sp : 3.5.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 0.4.h : 0.3.h),
          _buildTextField(
            label: '',
            hint: 'Do you have a logo, brand guidelines, or design assets?',
            controller: _brandGuidelinesController,
            maxLines: 3,
            isRequired: false,
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
    bool isMobile = false,
    IconData? icon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 1.h : 1.2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: EdgeInsets.all(isMobile ? 0.6.h : 0.5.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorManager.orange.withValues(alpha: 0.3),
                        ColorManager.orange.withValues(alpha: 0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    icon,
                    color: ColorManager.orange,
                    size: isMobile ? 14.sp : 12.sp,
                  ),
                ),
                SizedBox(width: 1.w),
              ],
              Text(
                title,
                style: GoogleFonts.albertSans(
                  color: ColorManager.orange,
                  fontSize: isMobile ? 14.sp : 7.sp,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: ColorManager.orange.withValues(alpha: 0.3),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 0.8.h : 0.8.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildFancyDesignSection(bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0F1F35).withValues(alpha: 0.7),
              const Color(0xFF1A2F4A).withValues(alpha: 0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ColorManager.orange.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.orange.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: EdgeInsets.all(isMobile ? 1.5.h : 1.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isMobile ? 0.8.h : 1.h),
                  decoration: BoxDecoration(
                    color: ColorManager.orange.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.palette,
                    color: ColorManager.orange,
                    size: isMobile ? 16.sp : 14.sp,
                  ),
                ),
                SizedBox(width: 1.5.w),
                Text(
                  'Design Requirements',
                  style: GoogleFonts.albertSans(
                    color: ColorManager.orange,
                    fontSize: isMobile ? 14.sp : 6.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 1.2.h : 1.h),
            
            // Design Style Preference with checkboxes
            Container(
              padding: EdgeInsets.all(isMobile ? 1.h : 1.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0F1F35).withValues(alpha: 0.5),
                    const Color(0xFF1A2F4A).withValues(alpha: 0.4),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorManager.orange.withValues(alpha: 0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.orange.withValues(alpha: 0.1),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.style,
                        color: ColorManager.orange,
                        size: isMobile ? 14.sp : 8.sp,
                      ),
                      SizedBox(width: 0.8.w),
                      Text(
                        'Design Style Preference',
                        style: GoogleFonts.albertSans(
                          color: ColorManager.white,
                          fontSize: isMobile ? 10.sp : 5.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 0.8.h : 0.6.h),
                  _buildDesignStyleCheckboxes(isMobile),
                  SizedBox(height: isMobile ? 1.h : 0.6.h),
                  Text(
                    'Or use dropdown (optional):',
                    style: GoogleFonts.albertSans(
                      color: ColorManager.white.withValues(alpha: 0.7),
                      fontSize: isMobile ? 8.sp : 3.5.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: isMobile ? 0.4.h : 0.3.h),
                  _buildDropdown(
                    label: '',
                    items: [
                      'Modern & Minimalist',
                      'Bold & Colorful',
                      'Professional & Corporate',
                      'Playful & Creative',
                      'Custom/Other',
                    ],
                    value: _selectedDesignStyle,
                    onChanged: (value) {
                      setState(() {
                        _selectedDesignStyle = value;
                      });
                    },
                    isRequired: false,
                    isMobile: isMobile,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: isMobile ? 1.h : 0.8.h),
            
            // Design Complexity Level with checkboxes
            Container(
              padding: EdgeInsets.all(isMobile ? 1.h : 1.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0F1F35).withValues(alpha: 0.5),
                    const Color(0xFF1A2F4A).withValues(alpha: 0.4),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorManager.orange.withValues(alpha: 0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.orange.withValues(alpha: 0.1),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.layers,
                        color: ColorManager.orange,
                        size: isMobile ? 14.sp : 8.sp,
                      ),
                      SizedBox(width: 0.8.w),
                      Text(
                        'Design Complexity Level',
                        style: GoogleFonts.albertSans(
                          color: ColorManager.white,
                          fontSize: isMobile ? 10.sp : 5.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 0.8.h : 0.6.h),
                  _buildDesignComplexityCheckboxes(isMobile),
                  SizedBox(height: isMobile ? 1.h : 0.6.h),
                  Text(
                    'Or use dropdown (optional):',
                    style: GoogleFonts.albertSans(
                      color: ColorManager.white.withValues(alpha: 0.7),
                      fontSize: isMobile ? 8.sp : 3.5.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: isMobile ? 0.4.h : 0.3.h),
                  _buildDropdown(
                    label: '',
                    items: [
                      'Simple',
                      'Moderate',
                      'Complex',
                      'Very Complex',
                    ],
                    value: _selectedDesignComplexity,
                    onChanged: (value) {
                      setState(() {
                        _selectedDesignComplexity = value;
                      });
                    },
                    isRequired: false,
                    isMobile: isMobile,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: isMobile ? 1.h : 0.8.h),
            
            // Color Scheme with checkboxes
            Container(
              padding: EdgeInsets.all(isMobile ? 1.h : 1.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0F1F35).withValues(alpha: 0.5),
                    const Color(0xFF1A2F4A).withValues(alpha: 0.4),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorManager.orange.withValues(alpha: 0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.orange.withValues(alpha: 0.1),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.color_lens,
                        color: ColorManager.orange,
                        size: isMobile ? 14.sp : 8.sp,
                      ),
                      SizedBox(width: 0.8.w),
                      Text(
                        'Color Scheme / Brand Colors',
                        style: GoogleFonts.albertSans(
                          color: ColorManager.white,
                          fontSize: isMobile ? 10.sp : 5.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 0.8.h : 0.6.h),
                  _buildColorSchemeCheckboxes(isMobile),
                ],
              ),
            ),
            
            SizedBox(height: isMobile ? 1.h : 0.8.h),
            
            // Design Inspiration with checkboxes
            Container(
              padding: EdgeInsets.all(isMobile ? 1.h : 1.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0F1F35).withValues(alpha: 0.5),
                    const Color(0xFF1A2F4A).withValues(alpha: 0.4),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorManager.orange.withValues(alpha: 0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.orange.withValues(alpha: 0.1),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: ColorManager.orange,
                        size: isMobile ? 14.sp : 8.sp,
                      ),
                      SizedBox(width: 0.8.w),
                      Text(
                        'Design Inspiration / References',
                        style: GoogleFonts.albertSans(
                          color: ColorManager.white,
                          fontSize: isMobile ? 10.sp : 5.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 0.8.h : 0.6.h),
                  _buildDesignInspirationCheckboxes(isMobile),
                ],
              ),
            ),
            
            SizedBox(height: isMobile ? 1.h : 0.8.h),
            
            // Brand Guidelines with checkboxes
            Container(
              padding: EdgeInsets.all(isMobile ? 1.h : 1.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0F1F35).withValues(alpha: 0.5),
                    const Color(0xFF1A2F4A).withValues(alpha: 0.4),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorManager.orange.withValues(alpha: 0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.orange.withValues(alpha: 0.1),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.folder_special,
                        color: ColorManager.orange,
                        size: isMobile ? 14.sp : 8.sp,
                      ),
                      SizedBox(width: 0.8.w),
                      Text(
                        'Brand Guidelines / Assets',
                        style: GoogleFonts.albertSans(
                          color: ColorManager.white,
                          fontSize: isMobile ? 10.sp : 5.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 0.8.h : 0.6.h),
                  _buildBrandElementsCheckboxes(isMobile),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double wi = MediaQuery.of(context).size.width;
    final bool isMobile = wi < 600;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: ColorManager.blue,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff020923),
        title: Text(
          'Order Here',
          style: GoogleFonts.albertSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          const AppBackground(),
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 4.w : 8.w,
                vertical: isMobile ? 1.h : 1.2.h,
              ),
              child: CustomScrollView(
                slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Client Information
                      _buildSection(
                        title: 'Client Information',
                        children: [
                          _buildTextField(
                            label: 'Full Name *',
                            hint: 'Enter your full name',
                            controller: _clientNameController,
                            isMobile: isMobile,
                          ),
                          _buildTextField(
                            label: 'Email *',
                            hint: 'your.email@example.com',
                            controller: _clientEmailController,
                            isMobile: isMobile,
                          ),
                          _buildPhoneNumberField(isMobile: isMobile),
                          _buildTextField(
                            label: 'Company/Organization',
                            hint: 'Your company name (optional)',
                            controller: _clientCompanyController,
                            isRequired: false,
                            isMobile: isMobile,
                          ),
                        ],
                        isMobile: isMobile,
                      ),

                      // App Details
                      _buildSection(
                        title: 'App Details',
                        icon: Icons.apps,
                        children: [
                          _buildTextField(
                            label: 'App Name *',
                            hint: 'Enter your app name',
                            controller: _appNameController,
                            isMobile: isMobile,
                          ),
                          _buildDropdown(
                            label: 'App Type *',
                            items: [
                              'Mobile App',
                              'Web App',
                              'Desktop App',
                              'Cross-Platform App',
                              'Progressive Web App (PWA)',
                              'Other',
                            ],
                            value: _selectedAppType,
                            onChanged: (value) {
                              setState(() {
                                _selectedAppType = value;
                              });
                            },
                            isMobile: isMobile,
                          ),
                          _buildTextField(
                            label: 'App Description *',
                            hint: 'Describe what your app does',
                            controller: _appDescriptionController,
                            maxLines: 4,
                            isMobile: isMobile,
                          ),
                          _buildFeatureCheckboxes(),
                        ],
                        isMobile: isMobile,
                      ),

                      // Target Platforms
                      _buildSection(
                        title: 'Target Platforms',
                        icon: Icons.devices,
                        children: [
                          _buildPlatformCheckboxes(),
                        ],
                        isMobile: isMobile,
                      ),

                      // Project Details
                      _buildSection(
                        title: 'Project Details',
                        icon: Icons.assignment,
                        children: [
                          _buildDropdown(
                            label: 'Project Priority *',
                            items: [
                              'Low',
                              'Medium',
                              'High',
                              'Urgent',
                            ],
                            value: _selectedPriority,
                            onChanged: (value) {
                              setState(() {
                                _selectedPriority = value;
                              });
                            },
                            isMobile: isMobile,
                          ),
                          _buildBudgetCheckboxes(),
                          SizedBox(height: isMobile ? 1.h : 0.8.h),
                          _buildTimelineCheckboxes(),
                          _buildTextField(
                            label: 'Additional Notes',
                            hint: 'Any other information you\'d like to share',
                            controller: _additionalNotesController,
                            maxLines: 4,
                            isRequired: false,
                            isMobile: isMobile,
                          ),
                        ],
                        isMobile: isMobile,
                      ),

                      // Design Requirements
                      _buildFancyDesignSection(isMobile),

                      SizedBox(height: 3.h),

                      // Submit Button
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorManager.blue,
                                ColorManager.blue.withValues(alpha: 0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.blue.withValues(alpha: 0.4),
                                blurRadius: 15,
                                spreadRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _isSubmitting ? null : _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 8.w : 6.w,
                                vertical: isMobile ? 2.h : 1.5.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              disabledBackgroundColor: Colors.transparent,
                            ),
                            child: _isSubmitting
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: isMobile ? 16.sp : 14.sp,
                                        height: isMobile ? 16.sp : 14.sp,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Text(
                                        'Submitting...',
                                        style: GoogleFonts.albertSans(
                                          color: Colors.white,
                                          fontSize: isMobile ? 14.sp : 7.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: isMobile ? 16.sp : 14.sp,
                                      ),
                                      SizedBox(width: 1.w),
                                      Text(
                                        'Submit Order',
                                        style: GoogleFonts.albertSans(
                                          color: Colors.white,
                                          fontSize: isMobile ? 14.sp : 7.sp,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black.withValues(alpha: 0.3),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),

                      SizedBox(height: 3.h),
                    ],
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
}
