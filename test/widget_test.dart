import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:test_utils/test_utils.dart';

import 'package:responsive_safe_area/responsive_safe_area.dart';

void main() {
  MaterialApp materialAppWrapper(Widget widget) =>
      MaterialApp(home: Material(child: widget));
  
  group('Testing widgets for recognition of the status bar', () {
    const double screenWidth = 600, screenHeight = 800;
    const Size screenSize = Size(screenWidth, screenHeight);

    final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

    void setBinding(){
      binding.window.devicePixelRatioTestValue = 1;
      binding.window.physicalSizeTestValue = screenSize;
    }

    testWidgets(
        'Checks that the `LayoutBuilder` does *not* recognize the presence of '
        'the Status Bar', (WidgetTester tester) async {
      setBinding();

      double extractedHeight;

      final MaterialApp layoutBuilderApp = materialAppWrapper(
        SampleScreenWithArtificialStatusBar(
          widget: LayoutBuilder(
            builder: (_, BoxConstraints constraints) {
              extractedHeight = constraints.biggest.height;
              return Container();
            },
          ),
        ),
      );

      await tester.pumpWidget(layoutBuilderApp);

      expect(extractedHeight, screenHeight);
    });

    testWidgets(
        'Checks that the `ResponsiveSafeArea` *does* recognize the presence of '
        'the Status Bar', (WidgetTester tester) async {
      setBinding();

      double extractedHeight;

      final MaterialApp responsiveSafeAreaApp = materialAppWrapper(
        SampleScreenWithArtificialStatusBar(
          widget: ResponsiveSafeArea(
            builder: (_, Size constraints) {
              extractedHeight = constraints.height;
              return Container();
            },
          ),
        ),
      );

      await tester.pumpWidget(responsiveSafeAreaApp);

      const double safeHeight = 
          screenHeight - SampleScreenWithArtificialStatusBar.statusBarHeight;

      expect(extractedHeight, safeHeight);
    });
  });
}

class SampleScreenWithArtificialStatusBar extends StatelessWidget {
  static const double statusBarHeight = 10;

  final Widget widget;

  const SampleScreenWithArtificialStatusBar({
    Key key, 
    @required this.widget,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        padding: EdgeInsets.only(
          top: statusBarHeight,
        ),
      ),
      child: widget,
    );
  }
}
