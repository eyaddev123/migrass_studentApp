import 'package:flutter/material.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/icon_image_manager.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/record_screen/bloc/states_record.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/record_screen/recorder_screen.dart';
import 'package:flutter_sound/flutter_sound.dart';

class RecordDetailsScreen extends StatefulWidget {
  final RecordingData recording;

  const RecordDetailsScreen({super.key, required this.recording});

  @override
  State<RecordDetailsScreen> createState() => _RecordDetailsScreenState();
}

class _RecordDetailsScreenState extends State<RecordDetailsScreen> {
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

  Widget _buildStarRating(int rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          color: index < rating ? Colors.amber : Colors.grey,
          size: 30,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.successBackgroundLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // 🔹 العنوان و زر الرجوع
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      IconImageManager.blackBack,
                      width: 35,
                      height: 35,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Text(
                    "تفاصيل التسجيل",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.black,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // 🔹 كارد التسجيل
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // زر التشغيل
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: ColorManager.successLight,
                                size: 32,
                              ),
                              onPressed: _togglePlay,
                            ),
                          ),
                          const SizedBox(width: 10),
                          // الموجة
                          Expanded(
                            child: WaveformWidget(
                              waveData: widget.recording.waveData,
                            ),
                          ),
                          const SizedBox(width: 10),
                          // الوقت
                          Column(
                            children: const [
                              Text("7:30", style: TextStyle(fontSize: 12)),
                              Text("10:12", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    // 🔹 الكمية
                    const Text(
                      "الكمية :",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.right,
                    ),
                    const Text(
                      "سورة الجن من 1 الى 27",
                      textAlign: TextAlign.right,
                    ),

                    const SizedBox(height: 20),
                    // 🔹 الملاحظات
                    const Text(
                      "الملاحظات :",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Text(
                        "خطأ تشكيل : رسوله \n"
                            "إِنَّهُ كَانَ يَقُولُ سَفِيهُنَا... \n"
                            "سبحان الله ...",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // 🔹 التقييم
                    const Text(
                      "التقييم",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    _buildStarRating(1), // ⭐⭐  (تعديل الرقم حسب التقييم)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
