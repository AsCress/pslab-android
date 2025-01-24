import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataAnalysisWidget extends StatefulWidget {
  const DataAnalysisWidget({super.key});

  @override
  State<StatefulWidget> createState() => _DataAnalysisState();
}

class _DataAnalysisState extends State<DataAnalysisWidget> {
  bool? isFourierTransformSelected = false;
  double horizontalOffset = 0;
  double verticalOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 5, right: 2.5),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: const Color(0xFFD32F2F)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -2.h,
                      left: 4.w,
                      right: 0.h,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Checkbox(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              activeColor: const Color(0xFFCE525F),
                              value: isFourierTransformSelected,
                              onChanged: (bool? value) {
                                setState(
                                  () {
                                    isFourierTransformSelected = value;
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Text(
                              'Fourier Analysis',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          const Spacer(),
                          DropdownMenu<String>(
                            width: 95.w,
                            initialSelection: 'None',
                            dropdownMenuEntries: <String>[
                              'None',
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
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -6.h,
                      left: 14.w,
                      right: 0.h,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          DropdownMenu<String>(
                            width: 150.w,
                            initialSelection: 'Sine Fit',
                            dropdownMenuEntries: <String>[
                              'Sine Fit',
                              'Square Fit',
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
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: DropdownMenu<String>(
                              width: 95.w,
                              initialSelection: 'None',
                              dropdownMenuEntries: <String>[
                                'None',
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
                      'Data Analysis',
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
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 5, left: 2.5),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: const Color(0xFFD32F2F)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0.h,
                      top: 0.h,
                      left: 12.w,
                      child: Center(
                        child: DropdownMenu<String>(
                          width: 90.w,
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
                    ),
                    Positioned(
                      top: 4.h,
                      right: 8.w,
                      left: 75.w,
                      child: Row(
                        children: [
                          Expanded(
                            child: SliderTheme(
                              data: const SliderThemeData(
                                trackHeight: 1,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 6),
                              ),
                              child: Slider(
                                activeColor: const Color(0xFFCE525F),
                                min: -16,
                                max: 16,
                                value: verticalOffset,
                                onChanged: (double value) {
                                  setState(
                                    () {
                                      verticalOffset = value;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Text(
                            '${verticalOffset.toStringAsFixed(2)} V',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -2.h,
                      right: 8.w,
                      left: 75.w,
                      child: Row(
                        children: [
                          Expanded(
                            child: SliderTheme(
                              data: const SliderThemeData(
                                trackHeight: 1,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 6),
                              ),
                              child: Slider(
                                activeColor: const Color(0xFFCE525F),
                                min: 0,
                                max: 1,
                                value: horizontalOffset,
                                onChanged: (double value) {
                                  setState(
                                    () {
                                      horizontalOffset = value;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Text(
                            '${horizontalOffset.toStringAsFixed(2)} ms',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    )
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
                      'Offsets',
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
          ),
        )
      ],
    );
  }
}
