import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:fit_fusion/data/repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../bloc/quote/quote_bloc.dart';

class TimerPage extends StatefulWidget {
  TimerPage({super.key, required this.audioPref});

  bool audioPref;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final CountdownController _controller = CountdownController(autoStart: true);
  late final ConfettiController _confettiController;
  bool paused = false;
  late final AudioPlayer player;

  @override
  initState() {
    player = AudioPlayer();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    if (widget.audioPref) {
      playOnStart();
    }
    super.initState();
  }

  playOnStart() async {
    player.setReleaseMode(ReleaseMode.loop);
    await player.play(AssetSource('reflected-light-147979.mp3'));
  }

  @override
  dispose() {
    playerDispose();
    super.dispose();
  }

  playerDispose() async {
    player.dispose();
    await player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        _confettiController.play();
      }),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: true,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.audiotrack),
                      Switch(
                          value: widget.audioPref,
                          onChanged: (val) async {
                            setState(() {
                              widget.audioPref = val;
                            });
                            // print(widget.audioPref);
                            if (widget.audioPref) {
                              playOnStart();
                              await UserRepository().saveAudioPref(true);
                            } else {
                              player.stop();
                              await UserRepository().saveAudioPref(false);
                            }
                          }),
                    ],
                  ),
                  BlocBuilder<QuoteBloc, QuoteState>(
                    builder: (context, state) {
                      if (state is QuoteError) {
                        return const Column(
                          children: [
                            Center(
                              child: Text(
                                "Don't Self reject",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "- Someone great",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        );
                      }
                      if (state is QuoteLoaded) {
                        int idx = Random().nextInt(state.quotes.quotes.length);
                        return Column(
                          children: [
                            Center(
                              child: Text(
                                state.quotes.quotes[idx].quote,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "- ${state.quotes.quotes[idx].author}",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        );
                      }
                      return const Column(
                        children: [
                          Center(
                            child: Text(
                              "Don't Self reject",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "- Someone great",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  const Spacer(),
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color.fromARGB(255, 241, 85, 137),
                            Color.fromARGB(255, 243, 210, 161),
                          ],
                        ),
                      ),
                      child: Countdown(
                        controller: _controller,
                        seconds: 100,
                        onFinished: () {
                          setState(() {
                            _confettiController.play();
                            Timer(const Duration(seconds: 10), () {
                              _confettiController.stop();
                              _confettiController.dispose();
                            });
                            paused = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('You have completed')));
                        },
                        build: (context, time) {
                          int hr = (time / 3600.0).floor();
                          int mn = (time / 60.0).floor() - (hr * 60);
                          int sc = (time).floor() - (mn * 60);
                          return Center(
                              child: Text(
                            "$mn : $sc",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ));
                        },
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (paused) {
                        _controller.resume();
                        player.resume();
                        setState(() {
                          paused = false;
                        });
                      } else {
                        _controller.pause();
                        player.stop();
                        setState(() {
                          paused = true;
                        });
                      }
                    },
                    child: Text(paused ? 'Start' : 'Stop'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
