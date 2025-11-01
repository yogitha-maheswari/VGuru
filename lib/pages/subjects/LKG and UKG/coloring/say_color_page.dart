import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SayColorPage extends StatefulWidget {
  const SayColorPage({super.key});

  @override
  State<SayColorPage> createState() => _SayColorPageState();
}

class _SayColorPageState extends State<SayColorPage> {
  final FlutterTts flutterTts = FlutterTts();
  final List<String> colors = ["Red", "Blue", "Green", "Yellow", "Orange", "Purple"];
  String selectedColor = "";

  @override
  void initState() {
    super.initState();
    _setupTts();
  }

  Future<void> _setupTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1.0);
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> speak(String text) async {
    await flutterTts.stop();
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text("Say the Color 🎨"),
        backgroundColor: theme.colorScheme.primary,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          children: [
            Text(
              "Tap a color to hear its name!",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: colors.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  crossAxisSpacing: 20, 
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final colorName = colors[index];
                  final color = _getColor(colorName);

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedColor = colorName);
                      speak(colorName);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: selectedColor == colorName
                              ? Colors.white
                              : Colors.transparent,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          colorName,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            if (selectedColor.isNotEmpty)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "You selected: $selectedColor 💬",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Color _getColor(String name) {
    switch (name) {
      case "Red":
        return Colors.red;
      case "Blue":
        return Colors.blue;
      case "Green":
        return Colors.green;
      case "Yellow":
        return Colors.yellow;
      case "Orange":
        return Colors.orange;
      case "Purple":
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
