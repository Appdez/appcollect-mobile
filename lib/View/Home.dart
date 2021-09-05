import 'package:biospdatabase/Model/Benificiary/Benificiary.dart';
import 'package:biospdatabase/Syncronization/Syncronization.dart';
import 'package:biospdatabase/View/Benificiary/Benificiary.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          primaryColorDark: Colors.deepPurple,
          accentColor: Colors.deepPurple,
        ),
        focusColor: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      title: "Biosp Database",
      home: MainComponent(),
    );
  }
}

class MainComponent extends StatefulWidget {
  const MainComponent({Key? key}) : super(key: key);

  @override
  _MainComponentState createState() => _MainComponentState();
}

class _MainComponentState extends State<MainComponent> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Biosp Database",
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 1,
      ),
      body: ValueListenableBuilder<Box<Benificiary>>(
        valueListenable: Syncronization.getBeneficiaries().listenable(),
        builder: (context, box, _) {
          final benificiaries = box.values.toList().cast<Benificiary>();
          return ListView.builder(
              itemCount: benificiaries.length,
              itemBuilder: (context, int index) {
                return benificiaryCard(
                    context,
                    Benificiary.fromJson(
                        benificiaries.elementAt(index).toJson()));
              });
          //return Text("${benificiaries.length}");
        },
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Benificiarios'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.cloud_off),
            title: Text('Sincronizar'),
            activeColor: Colors.blueAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.print),
            title: Text('Relatórios'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => BenificiaryForm(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget benificiaryCard(BuildContext context, Benificiary benificiary) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amberAccent,
            child: Text(
              benificiary.fullName != ""
                  ? "${benificiary.fullName!.substring(0, 2).toUpperCase()}"
                  : "",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
          title: Text(
            "${benificiary.fullName!.toUpperCase()}",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text("${benificiary.phone}"),
        ),
        elevation: 0.4,
        margin: EdgeInsets.all(0.1),
      ),
      onTap: () {
        showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  contentPadding: EdgeInsets.all(0),
                  title: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xFFFdffdf),
                      ),
                      child: Container(
                        child: Text("${benificiary.fullName!.toUpperCase()}"),
                      )),
                  titlePadding: EdgeInsets.all(0),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.phone,
                            color: Colors.blueGrey,
                          ),
                          onTap: () {
                            launch("tel:${benificiary.phone}");
                          },
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.message,
                            color: Colors.blueGrey,
                          ),
                          onTap: () {
                            launch("sms:${benificiary.phone}");
                          },
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.edit,
                            color: Colors.blueGrey,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    BenificiaryForm(
                                        benificiaryForEdit: benificiary),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.delete_outlined,
                            color: Colors.blueGrey,
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: ListTile(
                                        leading: Icon(
                                          Icons.warning_amber,
                                          color: Colors.amber,
                                        ),
                                        title: Text(
                                            "Deseja apagar esse benificiario"),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text("Não"),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                        TextButton(
                                            child: Text("Sim"),
                                            onPressed: () {
                                              if (Syncronization.addDeleted(
                                                  benificiary)) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                    'Benificiario deletado com sucesso',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  backgroundColor: Colors.green,
                                                ));
                                                Navigator.of(context).pop();
                                              }
                                              Navigator.of(context).pop();
                                            }),
                                      ],
                                    ));
                          },
                        ),
                      ],
                    )
                  ],
                  actionsPadding: EdgeInsets.all(10),
                ));
      },
    );
  }
}
