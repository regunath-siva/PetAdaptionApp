import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class PetAdoptDialog extends StatefulWidget {
  final String petName;
  const PetAdoptDialog({super.key, required this.petName});

  @override
  State<PetAdoptDialog> createState() => _PetAdoptDialogState();
}

class _PetAdoptDialogState extends State<PetAdoptDialog> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: true,
          colors: [Colors.blue, Colors.green, Colors.red, Colors.yellow],
          numberOfParticles: 30,
        ),
        AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[850]
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Congratulations!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          content: Text(
            'You’ve now adopted ${widget.petName}!',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black87,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.blueAccent
                      : Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
