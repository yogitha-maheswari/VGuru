import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Chapters extends StatefulWidget {
  final String subjectName;
  final List<Map<String, dynamic>> chapters;

  const Chapters({
    super.key,
    required this.subjectName,
    required this.chapters,
  });

  @override
  State<Chapters> createState() => _ChaptersState();
}

class _ChaptersState extends State<Chapters> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ------------------ Title ------------------
                  Text(
                    "Chapters",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ------------------ Chapters ------------------
                  ...List.generate(widget.chapters.length, (index) {
                    final chapter = widget.chapters[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _ChapterDropdown(
                        title: chapter['title'],
                        topics: List<String>.from(chapter['topics']),
                        accentColor: theme.colorScheme.primary,
                      ),
                    );
                  }),

                  const SizedBox(height: 24),

                  // ------------------ Mock Test Section ------------------
                  Text(
                    "Mock Tests",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ...List.generate(5, (i) => _buildMockTestCard(context, i + 1, theme.colorScheme.primary)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMockTestCard(BuildContext context, int testNumber, Color accentColor) {
    final theme = Theme.of(context);
    const double baseSpacing = 12;

    return LayoutBuilder(builder: (context, outerConstraints) {
      // adjust action height for small screens
      final bool isNarrowCard = outerConstraints.maxWidth < 520;
      final double actionHeight = isNarrowCard ? 40 : 48;
      final double statsIconSize = isNarrowCard ? 14 : 18;
      final double statsFontSize = isNarrowCard ? 13 : 15;
      final double statsSpacing = isNarrowCard ? 8 : baseSpacing;

      return Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accentColor.withOpacity(0.25)),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onSurface.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: LayoutBuilder(
            builder: (context, constraints) {
              // title + details widget
              final Widget titleDetailsWidget = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Test $testNumber",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _iconInfo(Icons.access_time, "30 mins", theme, theme.colorScheme.secondary, statsFontSize, statsIconSize),
                      SizedBox(width: statsSpacing),
                      _iconInfo(FontAwesomeIcons.star, "50 Marks", theme, theme.colorScheme.secondary, statsFontSize, statsIconSize),
                      SizedBox(width: statsSpacing),
                      _iconInfo(Icons.help_outline, "50 Qs", theme, theme.colorScheme.secondary, statsFontSize, statsIconSize),
                    ],
                  ),
                ],
              );

              // Stats row (fixed height boxes)
              final Widget statsRow = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildStatBox(FontAwesomeIcons.trophy, "1", const Color.fromARGB(255, 226, 179, 10), actionHeight, statsIconSize, statsFontSize),
                  SizedBox(width: statsSpacing),
                  _buildStatBox(FontAwesomeIcons.coins, "100", Colors.amber.shade700, actionHeight, statsIconSize, statsFontSize),
                  SizedBox(width: statsSpacing),
                  _buildStatBox(FontAwesomeIcons.fire, "5", const Color.fromARGB(255, 232, 100, 18), actionHeight, statsIconSize, statsFontSize),
                ],
              );

              // Start button (height matches stats boxes)
              final Widget startButton = SizedBox(
                height: actionHeight,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: start test
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(72, 0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 10),
                      Icon(FontAwesomeIcons.play, size: isNarrowCard ? 12 : 14, color: Colors.white),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          isNarrowCard ? "START" : "START TEST",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: isNarrowCard ? 12 : 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              );

              // Narrow/mobile layout: title stacked, actions in a single scaled row (no wrap)
              if (constraints.maxWidth < 520) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    titleDetailsWidget,
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          statsRow,
                          SizedBox(width: statsSpacing),
                          startButton,
                        ],
                      ),
                    ),
                  ],
                );
              }
              
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title consumes available space
                  Expanded(child: titleDetailsWidget),

                  const SizedBox(width: 12),

                  // Flexible container that scales the right group to prevent overflow on tablet
                  Flexible(
                    fit: FlexFit.loose,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FittedBox(
                        alignment: Alignment.centerRight,
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            statsRow,
                            SizedBox(width: statsSpacing),
                            startButton,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }

  Widget _iconInfo(IconData icon, String text, ThemeData theme, Color color, double fontSize, double iconSize) {
    return Row(
      children: [
        Icon(icon, size: iconSize, color: color),
        const SizedBox(width: 6),
        Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.8),
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }

  Widget _buildStatBox(IconData icon, String value, Color color, double height, double iconSize, double fontSize) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: iconSize),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------ CHAPTER DROPDOWN ------------------ //

class _ChapterDropdown extends StatefulWidget {
  final String title;
  final List<String> topics;
  final Color accentColor;

  const _ChapterDropdown({
    required this.title,
    required this.topics,
    required this.accentColor,
  });

  @override
  State<_ChapterDropdown> createState() => _ChapterDropdownState();
}

class _ChapterDropdownState extends State<_ChapterDropdown> {
  String? selectedTopic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasSelection = selectedTopic != null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      constraints: const BoxConstraints(minHeight: 140),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: widget.accentColor.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<String>(
            value: selectedTopic,
            decoration: InputDecoration(
              labelText: widget.title,
              labelStyle: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
                fontSize: 16,
              ),
              filled: true,
              fillColor: theme.colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: widget.accentColor.withOpacity(0.5)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: widget.accentColor.withOpacity(0.3)),
              ),
            ),
            dropdownColor: theme.colorScheme.surface,
            icon: Icon(Icons.arrow_drop_down, color: widget.accentColor, size: 28),
            items: widget.topics
                .map((t) => DropdownMenuItem(
                      value: t,
                      child: Text(
                        t,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) => setState(() => selectedTopic = value),
          ),

          if (hasSelection) const SizedBox(height: 16),

          // Adaptive Buttons Row
          if (hasSelection)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final subject = context.findAncestorWidgetOfExactType<Chapters>()?.subjectName ?? 'English';
                      Navigator.pushNamed(
                        context,
                        '/video',
                        arguments: {
                          'subject': subject,
                          'topic': selectedTopic!,
                        },
                      );
                    },
                    icon: Icon(FontAwesomeIcons.playCircle, color: theme.colorScheme.secondary, size: 16),
                    label: Text(
                      "Video",
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.surface,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: widget.accentColor.withOpacity(0.4)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final subject = context.findAncestorWidgetOfExactType<Chapters>()?.subjectName ?? 'English';
                      Navigator.pushNamed(
                        context,
                        '/notes',
                        arguments: {
                          'subject': subject,
                          'topic': selectedTopic!,
                          'unit': widget.title, // <-- pass selected unit (chapter) name
                        },
                      );
                    },
                    icon: Icon(FontAwesomeIcons.book, color: theme.colorScheme.secondary, size: 16),
                    label: Text(
                      "Notes",
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.surface,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: widget.accentColor.withOpacity(0.4)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final subject = context.findAncestorWidgetOfExactType<Chapters>()?.subjectName ?? 'English';
                      Navigator.pushNamed(
                        context,
                        '/quiz',
                        arguments: {
                          'subject': subject,
                          'topic': selectedTopic!,
                        },
                      );
                    },
                    icon: Icon(FontAwesomeIcons.circleQuestion, color: theme.colorScheme.secondary, size: 16),
                    label: Text(
                      "Quiz",
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.surface,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: widget.accentColor.withOpacity(0.4)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
