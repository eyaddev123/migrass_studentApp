

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/image_manager.dart';
import 'package:student/core/widgets/green_container.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/record_screen/bloc/bloc_record.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/record_screen/bloc/events_record.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/record_screen/bloc/states_record.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recording_on_screen/recording_on_Screen.dart';

class RecordingScreen extends StatelessWidget {
  const RecordingScreen({super.key});

  Future<bool?> _confirmDelete(BuildContext context, int index) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: const Text("هل أنت متأكد أنك تريد حذف التسجيل؟",
            textAlign: TextAlign.center),
        actions: [
          defauilButton(
            background: ColorManager.lightGray,
            textcolorbutton: ColorManager.black,
            function: () => Navigator.pop(ctx, false),
            text: "لا",
          ),
          defauilButton(
            background: ColorManager.lightGray,
            textcolorbutton: ColorManager.black,
            function: () => Navigator.pop(ctx, true),
            text: "نعم",
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecordingBloc()..add(InitRecorder()),
      child: BlocBuilder<RecordingBloc, RecordingState>(
        builder: (context, state) {
          final bloc = context.read<RecordingBloc>();
          return Scaffold(
            backgroundColor: ColorManager.successBackgroundLight,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.isRecording)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 12, right: 8),
                        padding: const EdgeInsets.all(8),
                        height: 60,
                        width: 300,
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: WaveformWidget(waveData: state.waveData),
                      ),
                      FloatingActionButton(
                        heroTag: "sendBtn",
                        backgroundColor: ColorManager.accentGreen,
                        shape: const CircleBorder(),
                        onPressed: () => bloc.add(StopRecording()),
                        child:
                        const Icon(Icons.send, size: 28, color: ColorManager.white),
                      ),
                    ],
                  ),
                FloatingActionButton(
                  heroTag: "recordBtn",
                  backgroundColor: state.isRecording
                      ? ColorManager.accentGreen
                      : ColorManager.successLight,
                  shape: const CircleBorder(),
                  onPressed: () {
                    if (!state.isRecording) {
                      bloc.add(StartRecording());
                    } else if (state.isPaused) {
                      bloc.add(ResumeRecording());
                    } else {
                      bloc.add(PauseRecording());
                    }
                  },
                  child: Icon(
                    !state.isRecording
                        ? Icons.add
                        : (state.isPaused ? Icons.play_arrow : Icons.pause),
                    size: 28,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        ImageManager().branch,
                        height: 300,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 50, right: 80),
                        child: Text("تسجيلاتي",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.black)),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: state.recordings.isEmpty
                            ? const Center(child: Text("لا يوجد تسجيلات بعد"))
                            : ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: state.recordings.length,
                          itemBuilder: (context, index) {
                            final rec = state.recordings[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        bloc.add(PlayRecording(rec.filePath,    rec.isLocal ? '' : (rec.remoteUrl ?? ''),
                                        )),
                                    child: Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                            Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 23,
                                          height: 23,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: ColorManager.gray,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              state.isPlaying &&
                                                  state.currentPlayingPath ==
                                                      rec.filePath
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              size: 18,
                                              color: ColorManager.accentGreen,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(16),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                SendRecordScreen(recording: rec),
                                          ),
                                        );
                                      },
                                      child:
                                      WaveformWidget(waveData: rec.waveData),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: ColorManager.gray),
                                    onPressed: () async {
                                      final confirm =
                                      await _confirmDelete(context, index);
                                      if (confirm == true) {
                                        bloc.add(DeleteRecording(index));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class WaveformWidget extends StatelessWidget {
  final List<double> waveData;
  const WaveformWidget({super.key, required this.waveData});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WaveformPainter(waveData),
      size: const Size(double.infinity, 50),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final List<double> waveData;
  WaveformPainter(this.waveData);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorManager.successText
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final centerY = size.height / 2;
    final spacing = size.width / (waveData.isEmpty ? 1 : waveData.length);

    for (int i = 0; i < waveData.length; i++) {
      final x = i * spacing;
      final y = waveData[i] * size.height / 2;
      canvas.drawLine(Offset(x, centerY - y), Offset(x, centerY + y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) =>
      oldDelegate.waveData != waveData;
}
