import 'package:fit_fusion/presentation/exercise/exercise_detail.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> exercises = [
    'Military press',
    'Biceps Curls',
    "Squats",
    'Push-Ups',
    'Plank'
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              const Text(
                'Exercises',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.separated(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return ExerciseCard(
                      size: size,
                      title: exercises[index],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    super.key,
    required this.size,
    required this.title,
  });

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExerxiseDetailPage(
                      title: title,
                    )));
      },
      child: Container(
        height: size.height * 0.2,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xffFFEEEA),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Fitness Yoga',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black38),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_arrow,
                        size: 30,
                        color: Colors.grey.shade700,
                      ),
                      const Text(
                        '10 Min',
                        style: TextStyle(fontSize: 17, color: Colors.grey),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.energy_savings_leaf,
                        size: 30,
                        color: Colors.orange,
                      ),
                      Text(
                        '170 Cal',
                        style: TextStyle(fontSize: 17, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
