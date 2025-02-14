import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pslab/constants.dart';
import 'package:pslab/providers/oscilloscope_state_provider.dart';

class TimebaseTriggerWidget extends StatefulWidget {
  const TimebaseTriggerWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TimebaseTriggerState();
}

class _TimebaseTriggerState extends State<TimebaseTriggerWidget> {
  @override
  Widget build(BuildContext context) {
    OscilloscopeStateProvider oscilloscopeStateProvider =
        Provider.of<OscilloscopeStateProvider>(context, listen: false);
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
                bottom: -4,
                left: 4,
                right: 0,
                child: Row(
                  children: [
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: const Color(0xFFCE525F),
                      value: oscilloscopeStateProvider.isTriggerSelected,
                      onChanged: (bool? value) {
                        setState(
                          () {
                            oscilloscopeStateProvider.isTriggerSelected =
                                value!;
                          },
                        );
                      },
                    ),
                    const Text(
                      'Trigger',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: DropdownMenu<String>(
                        width: 90,
                        initialSelection: oscilloscopeStateProvider
                                    .triggerChannel ==
                                CHANNEL.ch1.toString()
                            ? 'CH1'
                            : oscilloscopeStateProvider.triggerChannel ==
                                    CHANNEL.ch2.toString()
                                ? 'CH2'
                                : oscilloscopeStateProvider.triggerChannel ==
                                        CHANNEL.ch3.toString()
                                    ? 'CH3'
                                    : 'MIC',
                        dropdownMenuEntries: channelEntries.map(
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
                        textStyle: const TextStyle(
                          fontSize: 15,
                        ),
                        onSelected: (String? value) {
                          switch (value) {
                            case 'CH1':
                              oscilloscopeStateProvider.triggerChannel =
                                  CHANNEL.ch1.toString();
                              break;
                            case 'CH2':
                              oscilloscopeStateProvider.triggerChannel =
                                  CHANNEL.ch2.toString();
                              break;
                            case 'CH3':
                              oscilloscopeStateProvider.triggerChannel =
                                  CHANNEL.ch3.toString();
                              break;
                            case 'MIC':
                              oscilloscopeStateProvider.triggerChannel =
                                  CHANNEL.mic.toString();
                              break;
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: const SliderThemeData(
                          trackHeight: 1,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 6),
                        ),
                        child: Selector<OscilloscopeStateProvider, double>(
                          selector: (context, provider) =>
                              provider.oscillscopeAxesScale.yAxisScale,
                          builder: (context, yAxisScale, _) {
                            return Slider(
                              activeColor: const Color(0xFFCE525F),
                              min: -yAxisScale,
                              max: yAxisScale,
                              value: oscilloscopeStateProvider.trigger
                                  .clamp(-yAxisScale, yAxisScale),
                              onChanged: (double value) {
                                setState(
                                  () {
                                    oscilloscopeStateProvider.trigger = value;
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Text(
                      '${oscilloscopeStateProvider.trigger.toStringAsFixed(1)} V',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: DropdownMenu<String>(
                        width: 150,
                        initialSelection:
                            oscilloscopeStateProvider.triggerMode ==
                                    MODE.rising.toString()
                                ? 'Rising Edge'
                                : oscilloscopeStateProvider.triggerMode ==
                                        MODE.falling.toString()
                                    ? 'Falling Edge'
                                    : 'Dual Edge',
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
                        textStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        onSelected: (String? value) {
                          switch (value) {
                            case 'Rising Edge':
                              oscilloscopeStateProvider.triggerMode =
                                  MODE.rising.toString();
                              break;
                            case 'Falling Edge':
                              oscilloscopeStateProvider.triggerMode =
                                  MODE.falling.toString();
                              break;
                            case 'Dual Edge':
                              oscilloscopeStateProvider.triggerMode =
                                  MODE.dual.toString();
                              break;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -2,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Timebase',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
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
                          max: oscilloscopeStateProvider.timebaseDivisions
                              .toDouble(),
                          divisions:
                              oscilloscopeStateProvider.timebaseDivisions,
                          value: oscilloscopeStateProvider.timebaseSlider.clamp(
                              0,
                              oscilloscopeStateProvider.timebaseDivisions
                                  .toDouble()),
                          onChanged: (double value) {
                            setState(
                              () {
                                oscilloscopeStateProvider.timebaseSlider =
                                    value;
                                oscilloscopeStateProvider.setTimebase(value);
                              },
                            );
                            switch (value) {
                              case 0:
                                oscilloscopeStateProvider.samples = 512;
                                oscilloscopeStateProvider.timeGap =
                                    (2 * oscilloscopeStateProvider.timebase) /
                                        oscilloscopeStateProvider.samples;
                                break;
                              case 1:
                                oscilloscopeStateProvider.samples = 512;
                                oscilloscopeStateProvider.timeGap =
                                    (2 * oscilloscopeStateProvider.timebase) /
                                        oscilloscopeStateProvider.samples;
                                break;
                              case 2:
                                oscilloscopeStateProvider.samples = 512;
                                oscilloscopeStateProvider.timeGap =
                                    (2 * oscilloscopeStateProvider.timebase) /
                                        oscilloscopeStateProvider.samples;
                                break;
                              case 3:
                                oscilloscopeStateProvider.samples = 512;
                                oscilloscopeStateProvider.timeGap =
                                    (2 * oscilloscopeStateProvider.timebase) /
                                        oscilloscopeStateProvider.samples;
                                break;
                              case 4:
                                oscilloscopeStateProvider.samples = 1024;
                                oscilloscopeStateProvider.timeGap =
                                    (2 * oscilloscopeStateProvider.timebase) /
                                        oscilloscopeStateProvider.samples;
                                break;
                              case 5:
                                oscilloscopeStateProvider.samples = 1024;
                                oscilloscopeStateProvider.timeGap =
                                    (2 * oscilloscopeStateProvider.timebase) /
                                        oscilloscopeStateProvider.samples;
                                break;
                              case 6:
                                oscilloscopeStateProvider.samples = 1024;
                                oscilloscopeStateProvider.timeGap =
                                    (2 * oscilloscopeStateProvider.timebase) /
                                        oscilloscopeStateProvider.samples;
                                break;
                              case 7:
                                oscilloscopeStateProvider.samples = 1024;
                                oscilloscopeStateProvider.timeGap =
                                    (2 * oscilloscopeStateProvider.timebase) /
                                        oscilloscopeStateProvider.samples;
                                break;
                              default:
                                oscilloscopeStateProvider.samples = 512;
                                oscilloscopeStateProvider.timeGap =
                                    (2 * oscilloscopeStateProvider.timebase) /
                                        oscilloscopeStateProvider.samples;
                                break;
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Text(
                        oscilloscopeStateProvider.timebase == 875
                            ? '${oscilloscopeStateProvider.timebase.toStringAsFixed(2)} \u00b5s'
                            : '${(oscilloscopeStateProvider.timebase / 1000).toStringAsFixed(2)} ms',
                        style: const TextStyle(
                          fontSize: 14,
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
          left: 0,
          right: 0,
          top: 1,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              decoration: const BoxDecoration(color: Colors.white),
              child: const Text(
                'Timebase & Trigger',
                style: TextStyle(
                  color: Color(0xFFC72C2C),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
