import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimebaseTriggerWidget extends StatefulWidget {
  const TimebaseTriggerWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TimebaseTriggerState();
}

class _TimebaseTriggerState extends State<TimebaseTriggerWidget> {
  double _timebaseSlider = 0;
  double triggerValue = 0;
  bool? isTriggerChecked = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 5),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: const Color(0xFFD32F2F)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: -4.h,
                left: 4.w,
                right: 0.w,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: const Color(0xFFCE525F),
                        value: isTriggerChecked,
                        onChanged: (bool? value) {
                          setState(
                            () {
                              isTriggerChecked = value;
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Text(
                        'Trigger',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: DropdownMenu<String>(
                        width: 95.w,
                        initialSelection: 'CH1',
                        dropdownMenuEntries: <String>[
                          'CH1',
                          'CH2',
                          'CH3',
                          'MIC',
                        ].map(
                          (String value) {
                            return DropdownMenuEntry<String>(
                              label: value,
                              value: value,
                            );
                          },
                        ).toList(),
                        inputDecorationTheme: const InputDecorationTheme(
                          border: InputBorder.none,
                        ),
                        textStyle: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: const SliderThemeData(
                          trackHeight: 1,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 6),
                        ),
                        child: Slider(
                          activeColor: const Color(0xFFCE525F),
                          min: -16,
                          max: 16,
                          value: triggerValue,
                          onChanged: (double value) {
                            setState(
                              () {
                                triggerValue = value;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        '${triggerValue.toStringAsFixed(1)} V',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: DropdownMenu<String>(
                        width: 145.w,
                        initialSelection: 'Rising Edge',
                        dropdownMenuEntries: <String>[
                          'Rising Edge',
                          'Falling Edge',
                          'Dual Edge',
                        ].map(
                          (String value) {
                            return DropdownMenuEntry<String>(
                              label: value,
                              value: value,
                            );
                          },
                        ).toList(),
                        inputDecorationTheme: const InputDecorationTheme(
                          border: InputBorder.none,
                        ),
                        textStyle: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0.h,
                left: 16.w,
                right: 24.w,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 40.w),
                      child: Text(
                        'Timebase',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: const SliderThemeData(
                          trackHeight: 1,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 6),
                        ),
                        child: Slider(
                          activeColor: const Color(0xFFCE525F),
                          min: 0,
                          max: 8,
                          divisions: 8,
                          value: _timebaseSlider,
                          onChanged: (double value) {
                            setState(
                              () {
                                _timebaseSlider = value;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.w),
                      child: Text(
                        '${_timebaseSlider.toStringAsFixed(2)} ms',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0.w,
          right: 0.w,
          top: 1.h,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: const BoxDecoration(color: Colors.white),
              child: Text(
                'Timebase & Trigger',
                style: TextStyle(
                  color: const Color(0xFFC72C2C),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
