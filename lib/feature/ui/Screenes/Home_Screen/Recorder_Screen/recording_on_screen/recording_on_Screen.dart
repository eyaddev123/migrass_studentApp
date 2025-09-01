


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/icon_image_manager.dart';
import 'package:student/core/widgets/green_container.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/record_screen/bloc/states_record.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recorder_details/recorder_details.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/record_screen/recorder_screen.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recording_on_screen/bloc/bloc_on_recordind.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recording_on_screen/bloc/events_on_recordind.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recording_on_screen/bloc/states_on_recordind.dart';

class SendRecordScreen extends StatefulWidget {
  final RecordingData recording;

  const SendRecordScreen({super.key, required this.recording});

  @override
  State<SendRecordScreen> createState() => _SendRecordScreenState();
}

class _SendRecordScreenState extends State<SendRecordScreen> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player.openPlayer();
  }

  @override
  void dispose() {
    _player.closePlayer();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inHours)}:${twoDigits(d.inMinutes % 60)}:${twoDigits(d.inSeconds % 60)}";
  }

  Future<void> _togglePlay() async {
    if (_isPlaying) {
      await _player.stopPlayer();
      setState(() => _isPlaying = false);
    } else {
      await _player.startPlayer(
        fromURI: widget.recording.filePath,
        whenFinished: () {
          setState(() => _isPlaying = false);
        },
      );
      setState(() => _isPlaying = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.successBackgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatDuration(widget.recording.duration),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          height: 80,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: WaveformWidget(waveData: widget.recording.waveData),
                        ),


                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.lightGray,
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.black.withOpacity(0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: ColorManager.successLight,
                      size: 30,
                    ),
                    onPressed: _togglePlay,
                  ),
                ),
                const SizedBox(height: 40),
                defauilButton(
                  background: ColorManager.lightGray,
                  textcolorbutton: ColorManager.black,
                  function: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BlocProvider(
                          create: (context) => SendRecordBloc(),
                          child: SendRecordDialog(
                            filePath: widget.recording.filePath,
                          ),
                        );
                      },
                    );

                  },
                  text: "تم",
                ),
                const SizedBox(height: 30),
                /// زر الملاحظات
                defauilButton(
                  background: ColorManager.lightGray,
                  textcolorbutton: ColorManager.black,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordDetailsScreen(
                          recording: widget.recording, // مرر البيانات
                        ),
                      ),
                    );
                  },
                  text: "الملاحظات ",
                ),

                const SizedBox(height: 40),
              ],
            ),

            /// سهم الرجوع العلوي
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Image.asset(
                  IconImageManager.blackBack,
                  width: 40,
                  height: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SendRecordDialog extends StatelessWidget {
  final String filePath;
  const SendRecordDialog({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendRecordBloc, SendRecordState>(
      listener: (context, state) {
        if (state is SendRecordUploading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("جاري رفع التسجيل...")),
          );
        } else if (state is SendRecordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          Navigator.pop(context);
        } else if (state is SendRecordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("فشل الإرسال: ${state.error}")),
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "هل انت متأكد انك تريد إرسال التسجيل؟",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 15),

              // اختيار السورة
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "اختر اسم السورة"),
                value: state.selectedSurah,
                items: ["الفاتحة", "البقرة", "آل عمران"]
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    context.read<SendRecordBloc>().add(SelectSurah(val));
                  }
                },
              ),
              const SizedBox(height: 10),

              // من آية
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: "من آية"),
                value: state.fromAya,
                items: List.generate(20, (i) => i + 1)
                    .map((num) => DropdownMenuItem(value: num, child: Text("$num")))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    context.read<SendRecordBloc>().add(SelectFromAya(val));
                  }
                },
              ),
              const SizedBox(height: 10),

              // إلى آية
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: "الى آية"),
                value: state.toAya,
                items: List.generate(20, (i) => i + 1)
                    .map((num) => DropdownMenuItem(value: num, child: Text("$num")))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    context.read<SendRecordBloc>().add(SelectToAya(val));
                  }
                },
              ),
            ],
          ),
          actions: [
            Center(
              child: defauilButton(
                background: ColorManager.lightGray,
                textcolorbutton: ColorManager.black,
                function: () {
                  if (state.selectedSurah == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("الرجاء اختيار السورة")),
                    );
                    return;
                  }
                  context.read<SendRecordBloc>().add(
                    UploadRecord(
                      filePath: filePath,
                      surahId: 10, // TODO: ضيفي ID الصح من API
                      fromAya: state.fromAya,
                      toAya: state.toAya,
                    ),
                  );
                },
                text: "تم",
              ),
            ),
          ],
        );
      },
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/icon_image_manager.dart';
import 'package:student/core/widgets/green_container.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/record_screen/bloc/states_record.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/record_screen/recorder_screen.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recorder_details/recorder_details.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recording_on_screen/bloc/bloc_on_recordind.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recording_on_screen/bloc/events_on_recordind.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recording_on_screen/bloc/states_on_recordind.dart';

class SendRecordScreen extends StatefulWidget {
  final RecordingData recording;

  const SendRecordScreen({super.key, required this.recording});

  @override
  State<SendRecordScreen> createState() => _SendRecordScreenState();
}

class _SendRecordScreenState extends State<SendRecordScreen> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player.openPlayer();
  }

  @override
  void dispose() {
    _player.closePlayer();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inHours)}:${twoDigits(d.inMinutes % 60)}:${twoDigits(d.inSeconds % 60)}";
  }

  Future<void> _togglePlay() async {
    if (_isPlaying) {
      await _player.stopPlayer();
      setState(() => _isPlaying = false);
    } else {
      await _player.startPlayer(
        fromURI: widget.recording.filePath,
        whenFinished: () {
          setState(() => _isPlaying = false);
        },
      );
      setState(() => _isPlaying = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.successBackgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatDuration(widget.recording.duration),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          height: 80,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: WaveformWidget(waveData: widget.recording.waveData),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.lightGray,
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.black.withOpacity(0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: ColorManager.successLight,
                      size: 30,
                    ),
                    onPressed: _togglePlay,
                  ),
                ),
                const SizedBox(height: 40),

                /// زر إرسال
                defauilButton(
                  background: ColorManager.lightGray,
                  textcolorbutton: ColorManager.black,
                  function: () {
                    final surah = state.selectedSurah;
                    final fromAya = state.fromAya;
                    final toAya = state.toAya;

                    if (surah == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("الرجاء اختيار السورة")),
                      );
                      return;
                    }

                    // ارسل الحدث
                    context.read<SendRecordBloc>().add(
                      UploadRecord(
                        filePath: "ضع هنا مسار الملف المسجل", // من recording.filePath
                        surahId: 10, // لازم تجيب الـ id الحقيقي للسورة
                        fromAya: fromAya,
                        toAya: toAya,
                      ),
                    );
                  },
                  text: "تم",
                ),

                const SizedBox(height: 30),

                /// زر الملاحظات
                defauilButton(
                  background: ColorManager.lightGray,
                  textcolorbutton: ColorManager.black,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordDetailsScreen(
                          recording: widget.recording,
                        ),
                      ),
                    );
                  },
                  text: "الملاحظات ",
                ),

                const SizedBox(height: 40),
              ],
            ),

            /// سهم الرجوع العلوي
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Image.asset(
                  IconImageManager.blackBack,
                  width: 40,
                  height: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SendRecordDialog extends StatelessWidget {
  const SendRecordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SendRecordBloc(),
      child: BlocBuilder<SendRecordBloc, SendRecordState>(
        builder: (context, state) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "هل انت متأكد انك تريد إرسال التسجيل؟",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 15),

                /// اختيار السورة
                DropdownButtonFormField<String>(
                  value: state.selectedSurah,
                  decoration: const InputDecoration(labelText: "اختر اسم السورة"),
                  items: ["الفاتحة", "البقرة", "آل عمران"]
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      context.read<SendRecordBloc>().add(SelectSurah(val));
                    }
                  },
                ),
                const SizedBox(height: 10),

                /// من آية
                DropdownButtonFormField<int>(
                  value: state.fromAya,
                  decoration: const InputDecoration(labelText: "من آية"),
                  items: List.generate(20, (i) => i + 1)
                      .map((num) => DropdownMenuItem(value: num, child: Text("$num")))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      context.read<SendRecordBloc>().add(SelectFromAya(val));
                    }
                  },
                ),
                const SizedBox(height: 10),

                /// إلى آية
                DropdownButtonFormField<int>(
                  value: state.toAya,
                  decoration: const InputDecoration(labelText: "الى آية"),
                  items: List.generate(20, (i) => i + 1)
                      .map((num) => DropdownMenuItem(value: num, child: Text("$num")))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      context.read<SendRecordBloc>().add(SelectToAya(val));
                    }
                  },
                ),
              ],
            ),
            actions: [
              Center(
                child: defauilButton(
                  background: ColorManager.lightGray,
                  textcolorbutton: ColorManager.black,
                  function: () {
                    final surah = state.selectedSurah;
                    final fromAya = state.fromAya;
                    final toAya = state.toAya;

                    print("تم الإرسال: $surah - من آية $fromAya إلى آية $toAya");

                    Navigator.pop(context);
                  },
                  text: "تم",
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

*/