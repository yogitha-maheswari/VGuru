import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfReportUtil {
  /// Helper: Convert Flutter Color → PdfColor
  static PdfColor _toPdf(Color c, [double opacity = 1]) {
    return PdfColor(
      c.red / 255,
      c.green / 255,
      c.blue / 255,
      opacity.clamp(0, 1),
    );
  }

  /// ----------------------------- MAIN FUNCTION -----------------------------
  static Future<void> generateAndPrintReport({
    required BuildContext context,
    required Map<String, dynamic> results,
    required bool testValid,
    Duration? timeLeft,
  }) async {
    // attach timeLeft safely
    results = Map<String, dynamic>.from(results)..['timeLeft'] = timeLeft;

    try {
      final theme = Theme.of(context);
      final pdf = pw.Document();

      final pdfPrimary = _toPdf(theme.colorScheme.primary, 0.95);
      final pdfSecondary = _toPdf(theme.colorScheme.secondary, 0.85);
      final textDark = PdfColors.black;

      // ------------------------- SAFE RESULT EXTRACTIONS -------------------------
      final int total = results['total'] ?? 0;
      final int correct = results['correct'] ?? 0;
      final List<int> correctList = List<int>.from(results['correctList'] ?? []);
      final List<int> incorrectList = List<int>.from(results['incorrect'] ?? []);
      final List<int> skippedList = List<int>.from(results['skipped'] ?? []);

      final double percentage =
          (results['percentage'] ?? 0).toDouble(); // ✅ FIXED

      // Format time safely
      String formattedTime = "—";
      if (results['timeLeft'] != null && results['timeLeft'] is Duration) {
        final left = results['timeLeft'] as Duration;
        final mm = left.inMinutes.toString().padLeft(2, "0");
        final ss = left.inSeconds.remainder(60).toString().padLeft(2, "0");
        formattedTime = "$mm:$ss left";
      }

      final List<Map<String, String>> improvementAreas =
          (results['improvementAreas'] as List<dynamic>)
              .map((e) => Map<String, String>.from(e))
              .toList();

      // -------------------------- UI COMPONENT BUILDERS --------------------------
      pw.Widget _sectionCard(String title, pw.Widget child) {
        return pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 22),
          padding: const pw.EdgeInsets.all(18),
          decoration: pw.BoxDecoration(
            color: PdfColor(0.98, 0.98, 0.99),
            borderRadius: pw.BorderRadius.circular(14),
            border: pw.Border.all(
              color: PdfColors.grey400,
              width: 0.8,
            ),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: textDark,
                ),
              ),
              pw.SizedBox(height: 10),
              child,
            ],
          ),
        );
      }

      pw.Widget _statCard(String title, String value, PdfColor color) {
        return pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(12),
            color: PdfColor(color.red, color.green, color.blue, 0.14),
            border: pw.Border.all(
              color: PdfColor(color.red, color.green, color.blue, 0.32),
            ),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 11,
                  color: PdfColors.grey700,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Text(
                value,
                style: pw.TextStyle(
                  fontSize: 18,
                  color: textDark,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }

      pw.Widget _legend(PdfColor color, String label) {
        return pw.Row(
          children: [
            pw.Container(width: 12, height: 12, color: color),
            pw.SizedBox(width: 6),
            pw.Text(label,
                style: pw.TextStyle(fontSize: 10, color: PdfColors.grey800)),
          ],
        );
      }

      // ------------------------------- PDF BAR CHART -------------------------------
      pw.Widget _barChart() {
        return pw.Container(
          height: 180,
          child: pw.Chart(
            grid: pw.CartesianGrid(
              xAxis: pw.FixedAxis.fromStrings(
                List.generate(total, (i) => "Q${i + 1}"),
                marginStart: 20,
                marginEnd: 20,
              ),
              yAxis: pw.FixedAxis(
                [0, 0.5, 1.0],
                divisions: true,
              ),
            ),
            datasets: [
              pw.BarDataSet(
                width: 12,
                color: pdfPrimary,
                data: List.generate(
                  total,
                  (i) {
                    double val = 0;

                    if (correctList.contains(i + 1)) {
                      val = 1.0;
                    } else if (incorrectList.contains(i + 1)) {
                      val = 0.7;
                    } else if (skippedList.contains(i + 1)) {
                      val = 0.4;
                    }

                    return pw.PointChartValue(i.toDouble(), val,);
                  },
                ),
              ),
            ],
          ),
        );
      }

      // ------------------------------- BUILD PDF PAGE -------------------------------
      pdf.addPage(
        pw.MultiPage(
          pageTheme: pw.PageTheme(
            margin: const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            theme: pw.ThemeData.withFont(
              base: await PdfGoogleFonts.openSansRegular(),
              bold: await PdfGoogleFonts.openSansBold(),
              italic: await PdfGoogleFonts.openSansItalic(),
            ),
          ),
          build: (ctx) => [
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Text(
                    "Your Test Summary",
                    style: pw.TextStyle(
                      fontSize: 22,
                      fontWeight: pw.FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    "Here’s how you performed in this test.",
                    style:
                        pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 22),

            // ------------------- STAT CARDS -------------------
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                    child:
                        _statCard("Score", "$correct / $total", pdfPrimary)),
                pw.SizedBox(width: 14),
                pw.Expanded(
                    child: _statCard(
                        "Percentage",
                        "${percentage.toStringAsFixed(1)}%",
                        pdfSecondary)),
                pw.SizedBox(width: 14),
                pw.Expanded(
                    child:
                        _statCard("Time", formattedTime, PdfColors.orange800)),
              ],
            ),
            pw.SizedBox(height: 26),

            // ------------------- BAR CHART -------------------
            _sectionCard(
              "Question Overview",
              pw.Column(children: [
                _barChart(),
                pw.SizedBox(height: 12),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    _legend(pdfPrimary, "Correct"),
                    pw.SizedBox(width: 14),
                    _legend(PdfColors.red800, "Incorrect"),
                    pw.SizedBox(width: 14),
                    _legend(PdfColors.orange800, "Skipped"),
                  ],
                )
              ]),
            ),

            // ------------------- PERFORMANCE BREAKDOWN -------------------
            _sectionCard(
              "Performance Breakdown",
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      children: [
                        pw.Text("Correct",
                            style: pw.TextStyle(
                                fontSize: 12, color: textDark)),
                        pw.Text(
                          correctList.isEmpty
                              ? "—"
                              : correctList.join(", "),
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.green800,
                          ),
                        )
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      children: [
                        pw.Text("Incorrect",
                            style: pw.TextStyle(
                                fontSize: 12, color: textDark)),
                        pw.Text(
                          incorrectList.isEmpty
                              ? "—"
                              : incorrectList.join(", "),
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.red800,
                          ),
                        )
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      children: [
                        pw.Text("Skipped",
                            style: pw.TextStyle(
                                fontSize: 12, color: textDark)),
                        pw.Text(
                          skippedList.isEmpty
                              ? "—"
                              : skippedList.join(", "),
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.orange800,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

           // ------------------- IMPROVEMENT AREAS -------------------
            _sectionCard(
              "Areas to Improve",
              pw.Container(
                width: double.infinity, // ✅ makes width same as others
                child: improvementAreas.isEmpty
                    ? pw.Center(
                        child: pw.Text(
                          "No weak areas detected — great work!",
                          style: pw.TextStyle(
                            color: PdfColors.green800,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: improvementAreas.map((a) {
                          return pw.Container(
                            width: double.infinity,
                            padding: const pw.EdgeInsets.all(14),
                            margin: const pw.EdgeInsets.only(bottom: 10),
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(12),
                              color: PdfColor(
                                pdfSecondary.red,
                                pdfSecondary.green,
                                pdfSecondary.blue,
                                0.18,
                              ),
                              border: pw.Border.all(
                                color: PdfColor(
                                  pdfSecondary.red,
                                  pdfSecondary.green,
                                  pdfSecondary.blue,
                                  0.32,
                                ),
                              ),
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  a['topic'] ?? "Unknown Topic",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 12,
                                    color: textDark,
                                  ),
                                ),
                                pw.SizedBox(height: 6),
                                pw.Text(
                                  a['suggestion'] ?? "",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                    color: PdfColors.grey800,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ),


            // ------------------- MALPRACTICE -------------------
            _sectionCard(
              "Malpractice Status",
              pw.Row(
                children: [
                  pw.Text(
                    testValid
                        ? "✅ Valid attempt"
                        : "❌ Invalid — exceeded screen switch limit",
                    style: pw.TextStyle(
                      color:
                          testValid ? PdfColors.green800 : PdfColors.red800,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),

            pw.Center(
              child: pw.Text(
                "“Every result is a new beginning to improve.”",
                style: pw.TextStyle(
                  color: PdfColors.grey700,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      );

      // ------------------------ SAVE / SHARE / OPEN ------------------------
      final bytes = await pdf.save();

      try {
        await Printing.layoutPdf(onLayout: (format) async => bytes);
        return;
      } catch (_) {}

      if (kIsWeb) {
        await Printing.sharePdf(bytes: bytes, filename: "Test_Report.pdf");
        return;
      }

      final dir = await getTemporaryDirectory();
      final file = File("${dir.path}/Test_Report.pdf");
      await file.writeAsBytes(bytes);

      await OpenFile.open(file.path);
    } catch (e, st) {
      print("❌ PDF generation error: $e");
      print(st);
    }
  }
}
