import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CircleAvatar(
                  radius: 30,
                  child: Text('baek'),
                ),
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'MONDAY 16',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              scrollDirection: Axis.horizontal,
              children: [
                const Text(
                  'TODAY',
                  style: TextStyle(
                    fontSize: 44,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '·',
                  style: TextStyle(
                    fontSize: 44,
                    color: Colors.pink.shade200,
                  ),
                ),
                Text(
                  '17',
                  style: TextStyle(
                    fontSize: 44,
                    color: Colors.pink.shade200,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '18',
                  style: TextStyle(
                    fontSize: 44,
                    color: Colors.pink.shade200,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '19',
                  style: TextStyle(
                    fontSize: 44,
                    color: Colors.pink.shade200,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '20',
                  style: TextStyle(
                    fontSize: 44,
                    color: Colors.pink.shade200,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(5),
              children: const [
                Card(
                  color: Color(0xffFEF754),
                  fromHour: '11',
                  fromMinutes: '30',
                  toHour: '12',
                  toMinutes: '20',
                  contents: 'DESIGN\nMEETING',
                  participants: [
                    'ALEX',
                    'HELENA',
                    'NANA',
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Color(0xff9c6bce),
                  fromHour: '12',
                  fromMinutes: '35',
                  toHour: '14',
                  toMinutes: '10',
                  contents: 'DAILY\nPROJECT',
                  participants: [
                    'ME',
                    'RICHARD',
                    'CIRY',
                    '+4',
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Color(0xffBCEE4B),
                  fromHour: '15',
                  fromMinutes: '00',
                  toHour: '16',
                  toMinutes: '30',
                  contents: 'WEEKLY\nPLANNING',
                  participants: [
                    'DEN',
                    'NANA',
                    'MARK',
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    super.key,
    required this.color,
    required this.fromHour,
    required this.fromMinutes,
    required this.toHour,
    required this.toMinutes,
    required this.contents,
    required this.participants,
  });

  final Color color;
  final String fromHour;
  final String fromMinutes;
  final String toHour;
  final String toMinutes;
  final String contents;
  final List<String> participants;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          50,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              bottom: 20,
              left: 15,
              right: 15,
            ),
            child: Row(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        fromHour,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        fromMinutes,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        '|',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        toHour,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        toMinutes,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  contents,
                  style: const TextStyle(
                    fontSize: 57,
                    height: 1,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 80,
            ),
            child: Row(
              children: [
                for (var name in participants) ...[
                  Text(
                    name,
                    style: TextStyle(
                      color: name == 'ME' ? Colors.black : Colors.black54,
                      fontWeight:
                          name == 'ME' ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
