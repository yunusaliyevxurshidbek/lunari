import 'package:flutter/material.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';


class VolumeSlider extends StatefulWidget {
  const VolumeSlider({super.key});

  @override
  _VolumeSliderState createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double volume = 0.5;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 10,
                ),
              ),
              child: Slider(
                value: volume,
                onChanged: (newValue) {
                  setState(() {
                    volume = newValue;
                  });
                },
                min: 0,
                max: 1,
                activeColor: context.colors.primary,
                inactiveColor:context.ccolors.dividerLight,
              ),
            ),
          ],
        ),
      );

  }
}
