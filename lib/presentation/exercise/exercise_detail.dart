import 'package:fit_fusion/data/repository/user_repo.dart';
import 'package:fit_fusion/presentation/exercise/timer.dart';
import 'package:flutter/material.dart';

List<String> detail = [
  'Begin by standing with your feet shoulder-width apart.',
  'Keep your chest up, shoulders back, and your core engaged. This is your starting position.',
  'Slowly start to lower your body by bending your knees and hips',
  'Keep your back straight and chest up as you lower down.',
  'Continue lowering your body until your thighs are parallel to the ground or as low as your flexibility allows.',
  'Ensure your knees do not go beyond your toes, and your weight is evenly distributed on both feet.',
  'Push through your heels to stand back up to the starting position.',
  'Keep your core engaged and maintain proper posture throughout the movement.',
  'Perform the desired number of repetitions, typically 10 to 15 for beginners.',
  'You can increase the difficulty by holding dumbbells or a barbell across your shoulders.',
];

class ExerxiseDetailPage extends StatelessWidget {
  const ExerxiseDetailPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool audioPref = await UserRepository().getAudioPref();
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TimerPage(audioPref: audioPref)));
        },
        child: const Icon(Icons.play_arrow),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weight Loss',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Fitness Yoga',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color.fromARGB(255, 248, 238, 238)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.play_arrow,
                              size: 30,
                              color: Colors.grey.shade700,
                            ),
                            const Text(
                              '10 Min',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color.fromARGB(255, 234, 239, 240)),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.energy_savings_leaf,
                              size: 30,
                              color: Colors.orange,
                            ),
                            Text(
                              '170 Cal',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Instructions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                  itemCount: detail.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Text(
                      "${index + 1}. ${detail[index]}",
                      style: const TextStyle(color: Colors.black54),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
