import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fund Table'),
//         ),
//         body: const ScrollableTable(),
//       ),
//     );
//   }
// }

class ScrollableTable extends StatelessWidget {
  const ScrollableTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // User names list
    final List<String> userData = [
      'Sunil Dhami (Manager)',
      'Bhupendra Bhat',
      'Suraj Dhami',
      'Deependra Dhami',
      'Dharmendra Bhat',
      'Anil Dhami',
      'Prek Rawal',
      'Bhuwan Mahar'
    ];

    // Remaining table data (excluding names)
    final List<List<String>> tableData = [
      [
        '¥50,000',
        '¥38,333',
        '¥39,583',
        '¥40,417',
        '¥41,000',
        '¥41,833',
        '¥44,167',
        '¥45,000',
      ],
      [
        '¥50,000',
        '¥38,333',
        '¥39,583',
        '¥40,417',
        '¥41,000',
        '¥41,833',
        '¥44,167',
        '¥45,000',
      ],
      [
        '¥50,000',
        '¥38,333',
        '¥39,583',
        '¥40,417',
        '¥41,000',
        '¥41,833',
        '¥44,167',
        '¥45,000',
      ],
      [
        '¥50,000',
        '¥38,333',
        '¥39,583',
        '¥40,417',
        '¥41,000',
        '¥41,833',
        '¥44,167',
        '¥45,000',
      ],
      [
        '¥50,000',
        '¥38,333',
        '¥39,583',
        '¥40,417',
        '¥41,000',
        '¥41,833',
        '¥44,167',
        '¥45,000',
      ],
      [
        '¥50,000',
        '¥38,333',
        '¥39,583',
        '¥40,417',
        '¥41,000',
        '¥41,833',
        '¥44,167',
        '¥45,000',
      ],
      [
        '¥50,000',
        '¥38,333',
        '¥39,583',
        '¥40,417',
        '¥41,000',
        '¥41,833',
        '¥44,167',
        '¥45,000',
      ],
      [
        '¥50,000',
        '¥38,333',
        '¥39,583',
        '¥40,417',
        '¥41,000',
        '¥41,833',
        '¥44,167',
        '¥45,000',
      ],
    ];

    final fontStyleText = TextStyle(
      fontWeight: FontWeight.w900,
      color: Color.fromARGB(255, 210, 31, 31),
      // fontSize: 15,
    );

    final List<List<String>> totalTable = [
      [
        '¥50,000',
        '¥50,000',
        'Sunil Dhami',
      ],
      [
        '¥50,000',
        '¥50,000',
        'Krishna Paudel',
      ],
      [
        '¥50,000',
        '¥50,000',
        'Bhupendra Bhat',
      ],
      [
        '¥50,000',
        '¥50,000',
        'Anil Dhami',
      ],
      [
        '¥50,000',
        '¥50,000',
        'Ramesh Paudel',
      ],
      [
        '¥50,000',
        '¥50,000',
        'Kamal Lamicheena',
      ],
      [
        '¥50,000',
        '¥50,000',
        'Anil Dhami',
      ],
      [
        '¥50,000',
        '¥50,000',
        'Suraj Shami',
      ],
    ];

    // Column headers
    final List<String> headers = [
      'Sn',
      'Names',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
    ];

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Fund Table'),
      ),
      body: Column(children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(
                  const Color.fromARGB(255, 76, 184, 80)),
              dataRowColor: WidgetStateProperty.resolveWith((Set states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color.fromARGB(
                      255, 127, 172, 76); // Highlight selected rows
                }
                return Colors.white; // Default row color
              }),
              border: TableBorder.all(
                color: const Color.fromARGB(255, 121, 121, 121),
                width: 1, // Inner cell border width
              ),
              columns: headers
                  .map((header) => DataColumn(
                      label: Text(header,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ))))
                  .toList(),
              rows: List.generate(userData.length, (index) {
                    return DataRow(
                      cells: [
                        DataCell(Text((index + 1)
                            .toString())), // First column for user names
                        DataCell(Text(
                            userData[index])), // second column for user names
                        ...tableData[index]
                            .map((data) =>
                                DataCell(Text(data))) // Remaining columns
                            .toList(),
                      ],
                    );
                  }) +
                  List.generate(
                    1,
                    (index) {
                      return DataRow(
                        cells: [
                          DataCell(Text("*",
                              style:
                                  fontStyleText)), // First column for user names
                          DataCell(Text("Maximum Amount",
                              style:
                                  fontStyleText)), // second column for user names
                          ...totalTable
                              .map((data) => DataCell(Text(data[0],
                                  style: fontStyleText))) // Remaining columns
                              .toList(),
                        ],
                      );
                    },
                  ) +
                  List.generate(
                    1,
                    (index) {
                      return DataRow(
                        cells: [
                          DataCell(Text("*",
                              style:
                                  fontStyleText)), // First column for user names
                          DataCell(Text("Picked Amount",
                              style:
                                  fontStyleText)), // second column for user names
                          ...totalTable
                              .map((data) => DataCell(Text(data[1],
                                  style: fontStyleText))) // Remaining columns
                              .toList(),
                        ],
                      );
                    },
                  ) +
                  List.generate(
                    1,
                    (index) {
                      return DataRow(
                        cells: [
                          DataCell(Text("*",
                              style:
                                  fontStyleText)), // First column for user names
                          DataCell(Text("Picked By",
                              style:
                                  fontStyleText)), // second column for user names
                          ...totalTable
                              .map((data) => DataCell(Text(data[2],
                                  style: fontStyleText))) // Remaining columns
                              .toList(),
                        ],
                      );
                    },
                  ),
            ),
          ),
        )
      ]),
    ));
  }
}
