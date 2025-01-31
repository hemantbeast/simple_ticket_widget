import 'package:example/horizontal_ticket.dart';
import 'package:example/vertical_ticket.dart';
import 'package:flutter/material.dart';
import 'package:simple_ticket_widget/simple_ticket_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Ticket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Simple Ticket Widget'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            const Text(
              'Simple Horizontal ticket UI',
              style: TextStyle(fontSize: 16),
            ),
            SimpleTicketWidget(
              position: 50,
              arcRadius: 20,
              direction: Axis.horizontal,
              child: Container(
                color: Colors.green,
                height: 200,
                width: 350,
                alignment: Alignment.center,
                child: Text('Ticket Clipper'),
              ),
            ),
            const SizedBox(),
            const Text(
              'Simple Vertical ticket UI',
              style: TextStyle(fontSize: 16),
            ),
            SimpleTicketWidget(
              borderRadius: BorderRadius.circular(10),
              position: 230,
              child: Container(
                color: Colors.green,
                height: 300,
                width: 250,
                alignment: Alignment.center,
                child: Text('Ticket Clipper'),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Horizontal ticket UI',
              style: TextStyle(fontSize: 16),
            ),
            const HorizontalTicket(),
            const SizedBox(),
            const Text(
              'Vertical ticket UI',
              style: TextStyle(fontSize: 16),
            ),
            const VerticalTicket(),
          ],
        ),
      ),
    );
  }
}
