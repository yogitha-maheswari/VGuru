import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/provider/user_provider.dart';
import 'package:vguru/widgets/subject_card.dart';

class SciencePage extends StatefulWidget {
  const SciencePage({Key? key}) : super(key: key);

  @override
  State<SciencePage> createState() => _SciencePageState();
}

class _SciencePageState extends State<SciencePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 600;
    final userProvider = Provider.of<UserProvider>(context);

    final String classGrade = userProvider.classGrade ?? "1";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
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
              "Science",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: isDesktop ? 22 : 18,
              ),
            ),
            const SizedBox(height: 16),

            // Science Subtopics Grid
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 800
                      ? 3
                      : constraints.maxWidth > 500
                          ? 2
                          : 1;
                  double aspectRatio = constraints.maxWidth > 800 ? 0.9 : 1.2;

                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: aspectRatio,
                    padding: const EdgeInsets.only(bottom: 16),
                    children: [
                      SubjectCard(
                        subject: "Physics",
                        imagePath: "assets/images/physics.png",
                        route: "/physics$classGrade",
                      ),
                      SubjectCard(
                        subject: "Chemistry",
                        imagePath: "assets/images/chemistry.png",
                        route: "/chemistry$classGrade",
                      ),
                      SubjectCard(
                        subject: "Biology",
                        imagePath: "assets/images/biology.png",
                        route: "/biology$classGrade",
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
