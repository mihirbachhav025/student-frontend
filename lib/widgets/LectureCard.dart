// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class LectureCard extends StatelessWidget {
//   const LectureCard({Key? key, required this.path}) : super(key: key);

//   final String path;

//   @override
//   Widget build(BuildContext context) {
//     DocumentReference lectureRef = FirebaseFirestore.instance.doc(path);
//     final pathComponents = path.split("/");
//     pathComponents[5] = pathComponents[5].split('-')[1];
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         color: Color.fromRGBO(0, 0, 0, 0.688),
//         elevation: 10.0,
//         child: Padding(
//           padding: const EdgeInsets.all(7.0),
//           child: StreamBuilder<DocumentSnapshot>(
//             stream: lectureRef.snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const SizedBox(
//                   height: 16,
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (snapshot.hasError) {
//                 return const Text('Error loading lecture');
//               } else if (!snapshot.hasData) {
//                 return const Text('No data found');
//               } else {
//                 Map<String, dynamic> data =
//                     snapshot.data!.data() as Map<String, dynamic>;
//                 bool status = data['status'] ?? false;
//                 String statusText = status ? 'Present' : 'Absent';
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Professor: ${pathComponents[5]}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       'Lecture name: ${pathComponents[6]}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       'Date: ${pathComponents[4]}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       'Status: $statusText',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LectureCard extends StatelessWidget {
  const LectureCard({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    DocumentReference lectureRef = FirebaseFirestore.instance.doc(path);
    final pathComponents = path.split("/");
    pathComponents[5] = pathComponents[5].split('-')[1];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: StreamBuilder<DocumentSnapshot>(
              stream: lectureRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 16,
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error loading lecture');
                } else if (!snapshot.hasData) {
                  return const Text('No data found');
                } else {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  bool status = data['status'] ?? false;
                  String statusText = status ? 'Present' : 'Absent';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Professor: ${pathComponents[5]}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lecture name: ${pathComponents[6]}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Date: ${pathComponents[4]}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: status ? Colors.green : Colors.red,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 6,
                        ),
                        child: Text(
                          statusText,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
