import 'package:flutter/material.dart';

class TraceLettersPage extends StatefulWidget {
  const TraceLettersPage({super.key});

  @override
  State<TraceLettersPage> createState() => _TraceLettersPageState();
}

class _TraceLettersPageState extends State<TraceLettersPage> {
  final List<String> letters = ['A', 'B', 'C'];
  int currentIndex = 0;
  List<Offset> points = [];
  bool isCorrect = false;
  bool isTraced = false;

  void clearDrawing() {
    setState(() {
      points.clear();
      isTraced = false;
      isCorrect = false;
    });
  }

  void checkTraceAccuracy() {
    if (points.length < 80) {
      setState(() {
        isTraced = true;
        isCorrect = false;
      });
      return;
    }

    double minX = points.map((p) => p.dx).reduce((a, b) => a < b ? a : b);
    double maxX = points.map((p) => p.dx).reduce((a, b) => a > b ? a : b);
    double minY = points.map((p) => p.dy).reduce((a, b) => a < b ? a : b);
    double maxY = points.map((p) => p.dy).reduce((a, b) => a > b ? a : b);

    double width = maxX - minX;
    double height = maxY - minY;

    if (width > 150 && height > 150) {
      setState(() {
        isTraced = true;
        isCorrect = true;
      });
    } else {
      setState(() {
        isTraced = true;
        isCorrect = false;
      });
    }
  }

  void goToNextLetter() {
    if (currentIndex < letters.length - 1) {
      setState(() {
        currentIndex++;
        clearDrawing();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("🎉 You’ve traced all the letters!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String currentLetter = letters[currentIndex];

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "Trace the Letter ($currentLetter)",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Follow the pattern and trace the letter carefully 👇",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // 🖋️ Letter tracing area
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.colorScheme.primary, width: 2),
                ),
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GestureDetector(
                        onPanUpdate: (details) {
                          RenderBox box = context.findRenderObject() as RenderBox;
                          Offset localPos =
                              box.globalToLocal(details.globalPosition);
                          if (localPos.dx >= 0 &&
                              localPos.dx <= constraints.maxWidth &&
                              localPos.dy >= 0 &&
                              localPos.dy <= constraints.maxHeight) {
                            setState(() => points.add(localPos));
                          }
                        },
                        onPanEnd: (_) => setState(() => points.add(Offset.zero)),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              painter: LetterGuidePainter(currentLetter),
                              size: Size(constraints.maxWidth, constraints.maxHeight),
                            ),
                            CustomPaint(
                              painter: TracingPainter(points: points),
                              size: Size(constraints.maxWidth, constraints.maxHeight),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ✅ Feedback text
              if (isTraced)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isCorrect
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isCorrect ? "✅ Great Job! Correct Trace!" : "❌ Try Again!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isCorrect ? Colors.green[700] : Colors.red[700],
                    ),
                  ),
                ),

              const SizedBox(height: 25),

              // 🎮 Control Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _actionButton(
                    label: "Clear",
                    color: Colors.orange,
                    onPressed: clearDrawing,
                    theme: theme,
                  ),
                  const SizedBox(width: 16),
                  _actionButton(
                    label: "Check",
                    color: theme.colorScheme.primary,
                    onPressed: checkTraceAccuracy,
                    theme: theme,
                  ),
                  const SizedBox(width: 16),
                  _actionButton(
                    label: "Next ➡️",
                    color: isCorrect ? Colors.green : Colors.grey,
                    onPressed: isCorrect ? goToNextLetter : null,
                    theme: theme,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required Color color,
    required VoidCallback? onPressed,
    required ThemeData theme,
  }) {
    return SizedBox(
      width: 100,
      height: 46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// 🎨 Paints user's trace
class TracingPainter extends CustomPainter {
  final List<Offset> points;
  TracingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pinkAccent
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ✏️ Paints dotted guide (blueprint)
class LetterGuidePainter extends CustomPainter {
  final String letter;
  LetterGuidePainter(this.letter);

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: letter,
        style: TextStyle(
          fontSize: 250,
          fontWeight: FontWeight.bold,
          foreground: Paint()
            ..color = Colors.grey.withOpacity(0.3)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
