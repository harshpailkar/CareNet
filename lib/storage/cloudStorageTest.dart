import 'package:carenet/Strings.dart';
import 'package:carenet/storage/storageService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CloudStoragePage extends StatefulWidget {
  const CloudStoragePage({Key? key}) : super(key: key);

  @override
  State<CloudStoragePage> createState() => _CloudStoragePageState();
}

class _CloudStoragePageState extends State<CloudStoragePage> {
  @override
  Widget build(BuildContext context) {
    /////
    final Storage storage = Storage();
    String img = "";

    /////
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medical Records Vault',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  final results = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['pdf', 'png', 'jpeg', 'jpg']);

                  if (results == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Row(
                          children: const [
                            Icon(
                              Icons.error,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 7),
                            Text(
                              Strings.uploadFail,
                              style: TextStyle(fontFamily: 'Circular'),
                            ),
                          ],
                        )));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 3),
                        content: Row(
                          children: [
                            Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 7),
                            Text(
                              Strings.uploadSucess,
                              style: TextStyle(fontFamily: 'Circular'),
                            ),
                          ],
                        )));
                  }

                  final path = results?.files.single.path!;
                  final fileName = results!.files.single.name;

                  storage
                      .uploadFile(path!, fileName)
                      .then((value) => print("DONE"));
                },
                child: Text("Upload Medical Record")),
            FutureBuilder(
              future: storage.listFiles(),
              builder: (BuildContext context,
                  AsyncSnapshot<firebase_storage.ListResult> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                img = snapshot.data!.items[index].name;
                              });
                            },
                            child: Text(snapshot.data!.items[index].name),
                          ),
                        );
                      },
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Container();
              },
            ),
            FutureBuilder(
              future: storage.downloadURL(img),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                    width: 300,
                    height: 250,
                    child: Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
