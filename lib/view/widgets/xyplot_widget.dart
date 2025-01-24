import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class XYPlotWidget extends StatefulWidget {
  const XYPlotWidget({super.key});

  @override
  State<StatefulWidget> createState() => _XYPlotState();
}

class _XYPlotState extends State<XYPlotWidget> {
  bool? isXYPlotSelected = false;

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
                top: 4.h,
                left: 4.w,
                right: 0.w,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: const Color(0xFFCE525F),
                        value: isXYPlotSelected,
                        onChanged: (bool? value) {
                          setState(
                            () {
                              isXYPlotSelected = value;
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Text(
                        'Enable XY Plot',
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
              Positioned(
                bottom: -6.h,
                left: 14.w,
                right: 14.w,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    DropdownMenu<String>(
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
                    DropdownMenu<String>(
                      width: 95.w,
                      initialSelection: 'CH2',
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
                'XY Plot',
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
