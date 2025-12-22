import 'package:flutter/material.dart';
import 'package:my_web_site/core/ColorManager.dart';
import 'package:my_web_site/helper/app_background.dart';
import 'package:my_web_site/screens/portfolio_webview_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    
    // Responsive breakpoints
    final bool isMobile = wi < 600;
    final bool isTablet = wi >= 600 && wi < 1024;
    
    // Responsive font sizes
    final double titleFontSize = isMobile ? 28 : (isTablet ? 32 : 36);
    final double sectionTitleSize = isMobile ? 22 : (isTablet ? 24 : 26);
    final double bodyFontSize = isMobile ? 16 : (isTablet ? 17 : 18);
    final double subtitleFontSize = isMobile ? 14 : (isTablet ? 15 : 16);
    
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.amber[100],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff020923),
        title: Text(
          'Portfolio',
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 20 : 22,
          ),
        ),
      ),
      body: Stack(
        children: [
          const AppBackground(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16.0 : (isTablet ? 24.0 : 32.0),
                      vertical: isMobile ? 20.0 : 24.0,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isMobile ? double.infinity : (isTablet ? 700 : 800),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        // Header
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Absolute Stone Design (ASD)',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: he * 0.01),
                              Text(
                                'Multi‑Role Operations Platform',
                                style: TextStyle(
                                  color: ColorManager.orange,
                                  fontSize: bodyFontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: he * 0.02),
                              Container(
                                padding: EdgeInsets.all(isMobile ? 12 : 16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.2),
                                  ),
                                ),
                                child: Text(
                                  'Production‑ready, multi‑role platform built for a real stone fabrication and installation business.\n\n'
                                  'Supports Admins, Sales Representatives, Installers, Schedulers, and Clients — all through a single application.\n\n'
                                  'Owned product end‑to‑end: strategy, UX/UI, design system, AI governance, and cross‑platform delivery.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: bodyFontSize,
                                    height: 1.6,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: he * 0.04),
                        
                        // Problem Statement
                        _buildSection(
                          title: 'Problem Statement',
                          content: 'Stone businesses rely on fragmented tools: phone calls, texts, spreadsheets, and disconnected software.\n\n'
                              'Clients lack transparency. Installers lack clear workflows. Admins lack system‑wide control.\n\n'
                              'The goal was to unify operations into a single scalable product.',
                          fontSize: bodyFontSize,
                          he: he,
                          isMobile: isMobile,
                        ),
                        
                        // Users & Roles
                        _buildSection(
                          title: 'Users & Roles',
                          content: '• Admin — Full system governance, role promotion, content and AI control.\n'
                              '• Sales Representative — Lead management, contracts, and client communication.\n'
                              '• Scheduler — Job scheduling and coordination across teams.\n'
                              '• Installer — Field execution, live location tracking, and job lifecycle.\n'
                              '• Client — Discovery, order tracking, communication, and transparency.',
                          fontSize: bodyFontSize,
                          he: he,
                          isMobile: isMobile,
                        ),
                        
                        // Product Strategy
                        _buildSection(
                          title: 'Product Strategy',
                          content: '• Single authentication flow for all users.\n'
                              '• Dynamic role‑based routing after login.\n'
                              '• Progressive disclosure to reduce cognitive overload.\n'
                              '• Admin as a central command layer.\n'
                              '• AI as a governed feature, not an autonomous black box.',
                          fontSize: bodyFontSize,
                          he: he,
                          isMobile: isMobile,
                        ),
                        
                        // Design System
                        _buildSection(
                          title: 'Design System (v3.0.11)',
                          content: 'Token‑based design system shared across mobile and web.\n\n'
                              'Dark‑first UI optimized for dashboards and field use.\n\n'
                              'Semantic colors, role‑specific palettes, typography scale, spacing, grid, and components.\n\n'
                              'Ensures visual consistency and engineering efficiency.',
                          fontSize: bodyFontSize,
                          he: he,
                          isMobile: isMobile,
                        ),
                        
                        // Key Features
                        _buildSection(
                          title: 'Key Features',
                          content: 'Admin Dashboard: The operational heart of the platform. Admins can promote users into any role without re‑registration. Admins control home screen content, materials, chatrooms, and AI behavior.\n\n'
                              'Role‑Specific Dashboards: Each role receives a dedicated dashboard tailored to their responsibilities.\n\n'
                              'Installer Experience: Installers start a job, triggering automatic client notifications. Live GPS tracking increases client trust and reduces inbound calls.\n\n'
                              'Amy AI Assistant: AI assistant that answers client questions. Admins can test responses in training mode. All conversations are logged and reviewable.\n\n'
                              'Content & Material Management: Admins manage trending, new, and recommended materials. Home content updates do not require app redeployment.',
                          fontSize: bodyFontSize,
                          he: he,
                          isMobile: isMobile,
                        ),
                        
                        // Shipping & Platforms
                        _buildSection(
                          title: 'Shipping & Platforms',
                          content: 'The product is shipped on iOS, Android, and Web.\n\n'
                              'Single design system supports all platforms.\n\n'
                              'QR‑based distribution enables fast onboarding.',
                          fontSize: bodyFontSize,
                          he: he,
                          isMobile: isMobile,
                        ),
                        
                        // Outcomes & Learnings
                        _buildSection(
                          title: 'Outcomes & Learnings',
                          content: '• Unified operations under one platform.\n'
                              '• Improved transparency for clients.\n'
                              '• Reduced operational friction for internal teams.\n'
                              '• Human‑governed AI adoption with real business value.',
                          fontSize: bodyFontSize,
                          he: he,
                          isMobile: isMobile,
                        ),
                        
                        // Next Steps
                        _buildSection(
                          title: 'Next Steps',
                          content: '• Advanced analytics dashboards.\n'
                              '• Expanded installer workflows (QA, signatures, checklists).\n'
                              '• AI feedback loops tied to real performance metrics.\n'
                              '• Further automation in scheduling and operations.',
                          fontSize: bodyFontSize,
                          he: he,
                          isMobile: isMobile,
                        ),
                        
                        SizedBox(height: he * 0.03),
                        
                        // Portfolio Link
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PortfolioWebViewScreen(),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: EdgeInsets.all(isMobile ? 16 : 20),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ColorManager.blue.withValues(alpha: 0.3),
                                    ColorManager.orange.withValues(alpha: 0.3),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: ColorManager.orange.withValues(alpha: 0.5),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'View Full Portfolio',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: sectionTitleSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.open_in_new,
                                        color: ColorManager.orange,
                                        size: sectionTitleSize,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Tap to open in WebView',
                                    style: TextStyle(
                                      color: ColorManager.orange,
                                      fontSize: subtitleFontSize,
                                      decoration: TextDecoration.underline,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: he * 0.02),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required double fontSize,
    required double he,
    required bool isMobile,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: he * 0.03),
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: ColorManager.orange,
              fontSize: fontSize + 4,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: he * 0.015),
          Text(
            content,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
