import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:myapp/models/task_model.dart';
import 'package:myapp/providers/task_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final input = TextEditingController();

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
    context.read<TaskProvider>().load());
  }



  @override
  Widget build(BuildContext context) {
    final tp = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Image.asset('assets/rdplogo.png', height: 80),
          Text('Daily Planner', style: TextStyle(
            fontFamily: 'Caveat', fontSize: 32, color: Colors.white),
          )
        ],
      )
      ),
      drawer: Drawer(),
      body:
      Column(children: [
        TableCalendar(
          calendarFormat: CalendarFormat.month,
          focusedDay: DateTime.now(),
          firstDay: DateTime(2026),
          lastDay: DateTime(2027)
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: tp.tasks.length,
          itemBuilder: (context, i){
            final task = tp.tasks[i];
            final taskName = task.title;
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
                ),
              tileColor: i.isEven ? Colors.orange : Colors.green,
                leading: Icon(task.completed ? Icons.check_circle : Icons.circle_outlined),
                title: Text('$taskName', style: TextStyle(
                  fontSize: 22,
                  decoration: task.completed ? TextDecoration.lineThrough : null,
                ))
            );
          })
      ],)
    );
  }
}