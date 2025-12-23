// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

String? createWebIframe(String url) {
  try {
    // Create a unique view ID for the iframe
    final iframeViewId = 'portfolio-iframe-${DateTime.now().millisecondsSinceEpoch}';
    
    // Create iframe element
    final iframe = html.IFrameElement()
      ..src = url
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allowFullscreen = true;
    
    // Register the iframe with Flutter's platform view registry
    ui_web.platformViewRegistry.registerViewFactory(
      iframeViewId,
      (int viewId) => iframe,
    );
    
    return iframeViewId;
  } catch (e) {
    return null;
  }
}

