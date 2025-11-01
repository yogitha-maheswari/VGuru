import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/provider/user_provider.dart';
import 'package:vguru/widgets/subject_card.dart';

class Learn extends StatelessWidget {
  const Learn({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 600;
    final userProvider = Provider.of<UserProvider>(context);

    // Get the user class (e.g., "KG", "1", "2", ...)
    final String classGrade = userProvider.classGrade ?? "1";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Responsive Search Bar
          TextField(
            style: TextStyle(
              fontSize: isDesktop ? 16 : 14,
            ),
            decoration: InputDecoration(
              hintText: "Search Topics...",
              hintStyle: TextStyle(
                fontSize: isDesktop ? 16 : 14,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: theme.colorScheme.primary,
                size: isDesktop ? 24 : 20,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: isDesktop ? 14 : 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Section Title
          Text(
            classGrade.toLowerCase() == "lkg" || classGrade.toLowerCase() == "ukg" ? "Activities" : "Subjects",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: isDesktop ? 22 : 18,
            ),
          ),
          const SizedBox(height: 16),

          // Conditional Grid
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth > 800
                    ? 3
                    : constraints.maxWidth > 500
                        ? 2
                        : 1;
                double aspectRatio = constraints.maxWidth > 800 ? 0.9 : 1.2;

                // KG Activities
                if (classGrade.toLowerCase() == "lkg" || classGrade.toLowerCase() == "ukg") {
                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: aspectRatio,
                    padding: const EdgeInsets.only(bottom: 16),
                    children: [
                      SubjectCard(
                        subject: "Coloring",
                        imagePath: "assets/images/coloring.png",
                        route: "/color",
                      ),
                      SubjectCard(
                        subject: "Fun Activities",
                        imagePath: "assets/images/fun.png",
                        route: "/fun$classGrade",
                      ),
                      SubjectCard(
                        subject: "Shapes",
                        imagePath: "assets/images/shapes.png",
                        route: "/shapes$classGrade",
                      ),
                      SubjectCard(
                        subject: "Matching Games",
                        imagePath: "assets/images/matching.png",
                        route: "/trace",
                      ),
                      SubjectCard(
                        subject: "Poems",
                        imagePath: "assets/images/poems.png",
                        route: "/poems$classGrade",
                      ),
                    ],
                  );
                }

                // 1–10 Subjects
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: aspectRatio,
                  padding: const EdgeInsets.only(bottom: 16),
                  children: [
                    SubjectCard(
                      subject: "English",
                      imagePath: "assets/images/english.png",
                      route: "/english$classGrade",
                    ),
                    SubjectCard(
                      subject: "Science",
                      imagePath: "assets/images/science.png",
                      route: "/science",
                    ),
                    SubjectCard(
                      subject: "Mathematics",
                      imagePath: "assets/images/maths.png",
                      route: "/maths$classGrade",
                    ),
                    SubjectCard(
                      subject: "Social Studies",
                      imagePath: "assets/images/social.png",
                      route: "/social",
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
