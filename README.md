# MyWebSite - Flutter Portfolio & Order Management App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue)

**A comprehensive Flutter application demonstrating modern mobile and web development practices, responsive design, form handling, and API integration.**

[Features](#-features) • [Flutter Concepts](#-flutter-concepts-explained) • [Project Structure](#-project-structure) • [Getting Started](#-getting-started) • [Learning Guide](#-learning-guide)

</div>

---

## 📱 About This Project

This is a **production-ready Flutter application** that serves as both a portfolio website and an order management system. It demonstrates real-world Flutter development patterns, responsive design principles, state management, form validation, and external API integration.

### What Makes This Project Special?

- ✨ **Cross-Platform**: Runs seamlessly on iOS, Android, Web, Windows, macOS, and Linux
- 🎨 **Responsive Design**: Adapts beautifully to mobile, tablet, and desktop screens
- 📝 **Complex Form Handling**: Advanced form with validation, checkboxes, dropdowns, and API submission
- 🎯 **Modern UI/UX**: Custom gradients, animations, glassmorphism effects, and smooth transitions
- 🔌 **API Integration**: Real-world example of HTTP requests and form submission services
- 🏗️ **Clean Architecture**: Well-organized codebase following Flutter best practices

---

## ✨ Features

### Core Functionality
- **Portfolio Showcase**: Display projects and services with image galleries
- **Order Form**: Comprehensive multi-section form with validation, checkbox guidance, and country code selection
- **Responsive Navigation**: Sliding drawer menu with smooth animations
- **About Us**: Company information and contact details
- **Services Page**: Detailed service offerings

### Technical Highlights
- **Responsive Layout**: Uses `LayoutBuilder` and `MediaQuery` for adaptive UI
- **Form Validation**: Custom validators with user-friendly error messages
- **Smart Form UX**: Checkbox-based selections with helpful guidance tips
- **International Support**: Country code selector for phone numbers (30+ countries)
- **State Management**: `StatefulWidget` with `setState` for reactive UI
- **External APIs**: Formspree integration for form submissions
- **Custom Widgets**: Reusable components following DRY principles
- **Asset Management**: Optimized image loading and display

### Form Features
- **Checkbox Guidance System**: Visual tips help users select options instead of typing
  - **Key Features**: 12 common app features (User Auth, Payment, Push Notifications, etc.)
  - **Budget Ranges**: 7 predefined budget options with custom range option
  - **Timeline Options**: 6 timeline selections (ASAP, 1-2 months, etc.)
  - **Design Styles**: 6 design style preferences (Modern, Bold, Professional, etc.)
  - **Design Complexity**: 4 complexity levels (Simple to Very Complex)
  - **Color Schemes**: 8 color palette options (Dark Theme, Light Theme, etc.)
  - **Design Inspiration**: 8 inspiration types (Apple Design, Google Material, etc.)
  - **Brand Elements**: 8 brand asset options (Logo, Guidelines, Typography, etc.)
- **Country Code Selector**: Phone number field with 30+ country codes and flag emojis
- **Multi-Selection Support**: Users can select multiple options where applicable
- **Custom Input Options**: Text fields available for additional custom entries

---

## 🎓 Flutter Concepts Explained

This section breaks down key Flutter concepts used in this project, making it perfect for learning!

### 1. **Widget Tree & Composition**

Flutter apps are built using **widgets** - everything is a widget! This project demonstrates widget composition:

```dart
// Example from home_screen.dart
Scaffold(
  body: Stack(
    children: [
      AppBackground(),      // Background widget
      MobileScreen(),       // Main content widget
      SlidingMenu(),        // Navigation widget
    ],
  ),
)
```

**Key Concepts:**
- **StatelessWidget**: Widgets that don't change (like `AppBackground`)
- **StatefulWidget**: Widgets that can change state (like `HomeScreen`)
- **Widget Composition**: Building complex UIs by combining simple widgets

### 2. **State Management**

This project uses Flutter's built-in state management with `StatefulWidget`:

```dart
class _OrderHereScreenState extends State<OrderHereScreen> {
  // State variables
  final _formKey = GlobalKey<FormState>();
  Set<String> _selectedPlatforms = {};
  
  // Update UI when state changes
  void _updateSelection(String platform) {
    setState(() {
      _selectedPlatforms.add(platform);
    });
  }
}
```

**Learning Points:**
- `setState()` triggers UI rebuilds
- State variables hold data that can change
- `GlobalKey<FormState>` manages form state

### 3. **Responsive Design**

The app adapts to different screen sizes using multiple techniques:

```dart
// Method 1: MediaQuery
double width = MediaQuery.of(context).size.width;
final bool isMobile = width < 600;

// Method 2: LayoutBuilder
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 500) {
      return MobileScreen();
    } else {
      return WebScreen();
    }
  },
)

// Method 3: Sizer package
fontSize: isMobile ? 10.sp : 5.sp,  // Responsive font size
padding: EdgeInsets.all(isMobile ? 1.h : 0.6.h),  // Responsive padding
```

**Why This Matters:**
- Ensures app works on phones, tablets, and desktops
- Provides optimal user experience across devices
- Demonstrates Flutter's flexibility

### 4. **Form Handling & Validation**

The order form demonstrates comprehensive form management:

```dart
// Form key for validation
final _formKey = GlobalKey<FormState>();

// Text controllers
final TextEditingController _clientNameController = TextEditingController();

// Validation
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your name';
  }
  return null;
}

// Form submission
if (_formKey.currentState!.validate()) {
  // Submit form
}
```

**Key Concepts:**
- `TextEditingController`: Manages text field values
- `GlobalKey<FormState>`: Accesses form state
- Validators: Functions that check input correctness
- Form submission: Handling user data

### 4.5. **Checkbox Guidance System & User Experience**

This project implements an innovative checkbox-based form system with visual guidance:

```dart
// Example: Feature checkboxes with guidance
Widget _buildFeatureCheckboxes() {
  return Container(
    child: Column(
      children: [
        // Guidance tip
        Row(
          children: [
            Icon(Icons.info_outline, color: ColorManager.orange),
            Text('💡 Tip: Select features below instead of typing'),
          ],
        ),
        // Checkbox options
        Wrap(
          children: features.map((feature) {
            return FilterChip(
              selected: _selectedFeatures.contains(feature['name']),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedFeatures.add(feature['name']);
                  } else {
                    _selectedFeatures.remove(feature['name']);
                  }
                });
              },
              label: Row(
                children: [
                  Icon(feature['icon']),
                  Text(feature['name']),
                ],
              ),
            );
          }).toList(),
        ),
        // Optional custom input
        TextField(
          hintText: 'Additional custom features',
        ),
      ],
    ),
  );
}
```

**Benefits:**
- **Faster Form Completion**: Users click instead of typing
- **Better Data Quality**: Predefined options reduce errors
- **Visual Guidance**: Tips help users understand what to do
- **Flexibility**: Custom input options available when needed
- **Multi-Selection**: Users can select multiple options

### 4.6. **Country Code Selector**

International phone number support with visual country selection:

```dart
Widget _buildPhoneNumberField() {
  return Row(
    children: [
      // Country code dropdown
      DropdownButton<String>(
        value: _selectedCountryCode,
        items: countryCodes.map((country) {
          return DropdownMenuItem(
            value: country['code'],
            child: Row(
              children: [
                Text(country['flag']),  // Flag emoji
                Text(country['code']),  // Country code
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedCountryCode = value!;
          });
        },
      ),
      // Phone number input
      Expanded(
        child: TextFormField(
          controller: _clientPhoneController,
          keyboardType: TextInputType.phone,
        ),
      ),
    ],
  );
}
```

**Features:**
- 30+ country codes with flag emojis
- Visual country identification
- Automatic formatting in form submission
- Responsive design for mobile and web

### 5. **Custom Widgets & Reusability**

The project follows DRY (Don't Repeat Yourself) principles:

```dart
// Reusable text field widget
Widget _buildTextField({
  required String label,
  required String hint,
  required TextEditingController controller,
  bool isRequired = true,
  bool isMobile = false,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
    ),
    validator: isRequired ? (value) => ... : null,
  );
}
```

**Benefits:**
- Code reusability
- Consistent styling
- Easier maintenance
- Cleaner codebase

### 6. **HTTP Requests & API Integration**

Real-world example of API calls:

```dart
import 'package:http/http.dart' as http;

Future<void> _submitForm() async {
  final response = await http.post(
    Uri.parse(_formspreeEndpoint),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(formData),
  );
  
  if (response.statusCode == 200) {
    // Success handling
  } else {
    // Error handling
  }
}
```

**Learning Points:**
- Async/await for asynchronous operations
- HTTP package for network requests
- Error handling with try-catch
- JSON encoding/decoding

### 7. **Navigation & Routing**

The app uses drawer navigation:

```dart
// Sliding menu implementation
AnimatedPositioned(
  left: _isMenuOpen ? 0 : -drawerWidth,
  duration: Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  child: Drawer(...),
)
```

**Concepts:**
- `Navigator`: Manages screen navigation
- Animations: Smooth transitions
- Drawer: Side navigation menu

### 8. **Styling & Theming**

Custom colors and consistent styling:

```dart
// ColorManager.dart - Centralized color management
class ColorManager {
  static const white = Color(0xFFCFD7D7);
  static const orange = Color(0xFFE1BC69);
  static const blue = Color(0xFF69ABE1);
}

// Usage
Container(
  color: ColorManager.blue,
  decoration: BoxDecoration(
    gradient: LinearGradient(...),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [...],
  ),
)
```

**Best Practices:**
- Centralized color management
- Consistent design system
- Reusable style constants

### 9. **Asset Management**

Images and resources are managed through `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/
    - assets/images/
```

**Usage:**
```dart
Image.asset('assets/images/logo.png')
```

### 10. **Package Management**

The project uses several useful packages:

- **sizer**: Responsive sizing (`10.sp`, `5.h`, `3.w`)
- **google_fonts**: Custom typography
- **http**: HTTP requests
- **webview_flutter**: Embedded web content
- **url_launcher**: Opening external URLs
- **marquee**: Scrolling text animations

---

## 📁 Project Structure

```
lib/
├── core/                    # Core functionality
│   ├── ColorManager.dart    # Centralized color definitions
│   ├── auto_scroll_image.dart
│   └── widgets/
│       └── home_widget.dart # Reusable home widgets
│
├── data/                    # Data models
│   └── image_data.dart      # Image data structures
│
├── helper/                  # Helper utilities
│   ├── app_background.dart  # Background widget
│   ├── sliding_menu.dart    # Navigation drawer
│   ├── alert_dialog_data.dart
│   ├── image_list_view.dart
│   └── menu_item.dart
│
├── screens/                 # Screen widgets
│   ├── home_screen.dart     # Main home screen
│   ├── mobile_screen.dart   # Mobile layout
│   ├── web_screen.dart      # Web layout
│   ├── order_here_screen.dart # Order form (complex!)
│   ├── portfolio_screen.dart
│   ├── services_screen.dart
│   ├── about_us_screen.dart
│   └── portfolio_webview_screen.dart
│
└── main.dart               # App entry point
```

### Architecture Pattern

This project follows a **layered architecture**:

1. **Presentation Layer** (`screens/`): UI components and screens
2. **Business Logic Layer** (`core/`, `helper/`): Reusable widgets and utilities
3. **Data Layer** (`data/`): Data models and structures

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: 3.0.0 or higher
- **Dart SDK**: 3.0.0 or higher
- **IDE**: VS Code, Android Studio, or IntelliJ IDEA
- **Platform-specific tools**:
  - Android: Android Studio with Android SDK
  - iOS: Xcode (macOS only)
  - Web: Chrome browser

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/johnhcolani/MyWebSite.git
   cd MyWebSite
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For mobile (iOS/Android)
   flutter run
   
   # For web
   flutter run -d chrome
   
   # For desktop
   flutter run -d windows  # or macos, linux
   ```

### Configuration

#### Formspree Setup (for Order Form)

1. Go to [Formspree.io](https://formspree.io/)
2. Sign up and create a new form
3. Copy your form endpoint (e.g., `https://formspree.io/f/abc123`)
4. Update `lib/screens/order_here_screen.dart`:
   ```dart
   static const String _formspreeEndpoint = 'https://formspree.io/f/YOUR_FORM_ID';
   ```

#### Order Form Structure

The order form is organized into 5 main sections:

1. **Client Information**
   - Full Name, Email, Phone Number (with country code), Company

2. **App Details**
   - App Name, App Type, Description, Key Features (with checkbox guidance)

3. **Target Platforms**
   - Platform selection with checkboxes (iOS, Android, Web, Windows, macOS, Linux)

4. **Project Details**
   - Priority, Budget Range (with checkbox options), Timeline (with checkbox options), Additional Notes

5. **Design Requirements**
   - Design Style Preference (checkboxes + dropdown)
   - Design Complexity Level (checkboxes + dropdown)
   - Color Scheme (checkboxes + custom input)
   - Design Inspiration (checkboxes + custom input)
   - Brand Guidelines (checkboxes + custom input)

**Form Features:**
- ✅ Visual guidance tips on every checkbox section
- ✅ Multi-selection support for most fields
- ✅ Custom input options for flexibility
- ✅ Country code selector for international phone numbers
- ✅ Comprehensive validation
- ✅ Form submission via Formspree API

---

## 📚 Learning Guide

### For Beginners

**Start Here:**
1. Read `main.dart` - Understand app entry point
2. Explore `home_screen.dart` - See how screens are structured
3. Study `ColorManager.dart` - Learn about constants and organization
4. Check `helper/app_background.dart` - Simple widget example

**Key Files to Study:**
- `lib/main.dart` - App initialization
- `lib/screens/home_screen.dart` - Responsive layout
- `lib/core/ColorManager.dart` - Design system
- `lib/helper/sliding_menu.dart` - Navigation and animations

### For Intermediate Developers

**Focus Areas:**
1. **Form Handling**: Deep dive into `order_here_screen.dart`
   - Form validation
   - State management with multiple checkbox sets
   - Checkbox guidance system implementation
   - Country code selector widget
   - API integration
   - Custom widgets

2. **Responsive Design**: Study `mobile_screen.dart` and `web_screen.dart`
   - MediaQuery usage
   - LayoutBuilder patterns
   - Conditional rendering

3. **Custom Widgets**: Explore `helper/` directory
   - Reusable components
   - Widget composition
   - Parameter passing

4. **UX Best Practices**: Study the checkbox guidance system
   - Visual guidance implementation
   - Multi-selection state management
   - User-friendly form design patterns

### For Advanced Developers

**Advanced Concepts:**
1. **State Management Patterns**: Analyze state handling across screens
2. **Performance Optimization**: Review widget rebuild strategies
3. **API Integration**: Study error handling and async patterns
4. **Architecture**: Evaluate code organization and separation of concerns

### Recommended Learning Path

```
Week 1: Basics
├── Day 1-2: Widget basics, StatelessWidget vs StatefulWidget
├── Day 3-4: Layout widgets (Column, Row, Stack, Container)
└── Day 5-7: Navigation and routing

Week 2: Intermediate
├── Day 1-2: Forms and validation
├── Day 3-4: State management with setState
├── Day 5-6: Responsive design
└── Day 7: Custom widgets

Week 3: Advanced
├── Day 1-2: HTTP requests and APIs
├── Day 3-4: Animations and transitions
├── Day 5-6: Advanced layouts
└── Day 7: Project structure and best practices
```

---

## 🛠️ Key Dependencies

| Package | Purpose | Version |
|---------|---------|---------|
| `sizer` | Responsive sizing (sp, h, w units) | ^2.0.15 |
| `google_fonts` | Custom typography | ^6.3.3 |
| `http` | HTTP requests for API calls | ^1.2.0 |
| `webview_flutter` | Embedded web content | ^4.4.2 |
| `url_launcher` | Open external URLs | ^6.2.5 |
| `marquee` | Scrolling text animations | ^2.3.0 |
| `auto_scroll_image` | Auto-scrolling image carousel | ^0.2.9-dev |

---

## 🎨 Design System

### Colors

```dart
ColorManager.white   // #CFD7D7 - Primary text color
ColorManager.orange  // #E1BC69 - Accent color
ColorManager.blue    // #69ABE1 - Primary action color
```

### Typography

- **Font Family**: Albert Sans (via Google Fonts)
- **Responsive Sizing**: Uses `sizer` package
  - Mobile: `10.sp`, `9.sp`, `8.sp`
  - Web: `5.sp`, `4.sp`, `3.5.sp`

### Spacing

- Uses `sizer` package for responsive spacing
- Mobile: `1.h`, `2.w`, `0.5.h`
- Web: `0.6.h`, `0.8.w`, `0.3.h`

---

## 🔍 Code Examples

### Example 1: Responsive Text Field

```dart
Widget _buildTextField({
  required String label,
  required TextEditingController controller,
  bool isMobile = false,
}) {
  return TextFormField(
    controller: controller,
    style: GoogleFonts.albertSans(
      fontSize: isMobile ? 10.sp : 5.sp,
    ),
    decoration: InputDecoration(
      labelText: label,
      fillColor: const Color(0xFF0F1F35).withValues(alpha: 0.55),
      filled: true,
    ),
  );
}
```

### Example 2: Checkbox Selection with Guidance

```dart
Set<String> _selectedFeatures = {};

Container(
  child: Column(
    children: [
      // Guidance tip
      Row(
        children: [
          Icon(Icons.info_outline, color: ColorManager.orange),
          Text('💡 Tip: Select features below instead of typing'),
        ],
      ),
      // Checkbox options
      Wrap(
        children: [
          FilterChip(
            selected: _selectedFeatures.contains('User Authentication'),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  _selectedFeatures.add('User Authentication');
                } else {
                  _selectedFeatures.remove('User Authentication');
                }
              });
            },
            label: Row(
              children: [
                Icon(Icons.person),
                Text('User Authentication'),
              ],
            ),
          ),
          // More chips...
        ],
      ),
    ],
  ),
)
```

### Example 2.5: Country Code Selector

```dart
String _selectedCountryCode = '+1';

Row(
  children: [
    // Country code dropdown
    Container(
      width: 25.w,
      child: DropdownButton<String>(
        value: _selectedCountryCode,
        items: [
          DropdownMenuItem(
            value: '+1',
            child: Row(
              children: [
                Text('🇺🇸'),
                Text('+1'),
              ],
            ),
          ),
          // More countries...
        ],
        onChanged: (value) {
          setState(() {
            _selectedCountryCode = value!;
          });
        },
      ),
    ),
    // Phone number input
    Expanded(
      child: TextFormField(
        controller: _clientPhoneController,
        keyboardType: TextInputType.phone,
      ),
    ),
  ],
)
```

### Example 3: API Call with Error Handling

```dart
Future<void> _submitForm() async {
  try {
    final response = await http.post(
      Uri.parse(_formspreeEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(formData),
    );
    
    if (response.statusCode == 200) {
      _showSuccessDialog();
    } else {
      _showErrorDialog('Failed to submit form');
    }
  } catch (e) {
    _showErrorDialog('Error: ${e.toString()}');
  }
}
```

---

## 🐛 Troubleshooting

### Common Issues

1. **"Package not found"**
   ```bash
   flutter pub get
   flutter clean
   flutter pub get
   ```

2. **Form submission not working**
   - Check Formspree endpoint configuration
   - Verify internet connection
   - Check browser console for errors

3. **Layout issues on web**
   - Clear browser cache
   - Run `flutter clean` and rebuild
   - Check responsive breakpoints

4. **Images not loading**
   - Verify assets in `pubspec.yaml`
   - Run `flutter pub get`
   - Check file paths are correct

---

## 📖 Additional Resources

### Flutter Documentation
- [Flutter Official Docs](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Widget Catalog](https://flutter.dev/docs/development/ui/widgets)

### Learning Resources
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)
- [Flutter YouTube Channel](https://www.youtube.com/flutterdev)
- [Dart Academy](https://dart.academy/)

### Packages Used
- [Sizer Package](https://pub.dev/packages/sizer)
- [Google Fonts](https://pub.dev/packages/google_fonts)
- [HTTP Package](https://pub.dev/packages/http)

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👤 Author

**John Colani**
- Email: johnacolani@gmail.com
- GitHub: [@johnhcolani](https://github.com/johnhcolani)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Package maintainers for their excellent work
- The Flutter community for inspiration and support

---

## 📊 Project Statistics

- **Total Files**: 20+ Dart files
- **Lines of Code**: 2300+
- **Screens**: 8+ screens
- **Custom Widgets**: 15+ reusable widgets
- **Form Sections**: 5 major sections with checkbox guidance
- **Checkbox Options**: 50+ predefined options across all form sections
- **Country Codes**: 30+ supported countries for phone numbers
- **Platforms Supported**: 6 (iOS, Android, Web, Windows, macOS, Linux)

---

<div align="center">

**Made with ❤️ using Flutter**

⭐ Star this repo if you found it helpful!

</div>
