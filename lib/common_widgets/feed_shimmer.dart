import 'package:assist/common_widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart' show Shimmer;

class FeedLoading extends StatelessWidget {
  const FeedLoading({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    final size = MediaQuery.of(context).size;

    for (int i = 0; i < 5; i++) {
      widgets.add(
        Column(
          children: [
            SizedBox(height: size.height * 0.05),
            const ContentPlaceholder(
              lineType: ContentLineType.threeLines,
            ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      );
    }

    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: widgets,
          ),
        ));
  }
}
