import 'dart:math';
import 'package:flutter/material.dart';
import '../../themes/colors.dart';

class SeatSelector extends StatefulWidget {
  const SeatSelector({Key? key, required this.title, required this.release})
      : super(key: key);

  final String title, release;

  @override
  State<SeatSelector> createState() => _SeatSelectorState();
}

class _SeatSelectorState extends State<SeatSelector> {
  late List<List<Color>> seatColors;
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    seatColors = List.generate(
      8,
      (row) => List.generate(
        10,
        (seat) => _generateRandomColor(row),
      ),
    );
  }

  Color _generateRandomColor(int row) {
    Random random = Random();
    if (row == 7) {
      return kVIP;
    } else {
      List<Color> availableColors = [kUnavailable, kGetTickets];
      return availableColors[random.nextInt(availableColors.length)];
    }
  }

  void updateTotalPrice() {
    int selectedSeatsCount = 0;

    for (int i = 0; i < seatColors.length; i++) {
      for (int j = 0; j < seatColors[0].length; j++) {
        if (seatColors[i][j] == kSelected) {
          selectedSeatsCount++;
        }
      }
    }

    setState(() {
      totalPrice = selectedSeatsCount * 50; // $50 per selected seat
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        foregroundColor: Colors.black,
        backgroundColor: kAppBarBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              this.widget.title,
              style: const TextStyle(fontSize: 12),
            ),
            SizedBox(height: 10),
            Text(
              "In Theaters ${widget.release}",
              style: const TextStyle(color: Colors.blue, fontSize: 12),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Screen',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: kNavBarColor,
            ),
            SizedBox(height: 16),
            Container(
              height: 350,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: seatColors.length * seatColors[0].length,
                itemBuilder: (context, index) {
                  int row = index ~/ seatColors[0].length;
                  int col = index % seatColors[0].length;
                  Color color = seatColors[row][col];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        seatColors[row][col] = kSelected;
                        updateTotalPrice();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${row + 1}-${col + 1}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SeatLegend(color: kSelected, text: 'Selected'),
                  SizedBox(width: 20),
                  SeatLegend(color: kUnavailable, text: "Not Available"),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SeatLegend(color: kVIP, text: 'VIP (150\$)'),
                  SizedBox(width: 20),
                  SeatLegend(color: kGetTickets, text: 'Regular (50\$)'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: kUnavailable),
                  onPressed: () {},
                  child: Text(
                    "4/3 row",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: kUnavailable),
                    onPressed: () {},
                    child: Text(
                      'Total Price: \$${totalPrice.toString()}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: kGetTickets),
                    onPressed: () {},
                    child: const Text(
                      'Proceed to pay',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SeatLegend extends StatelessWidget {
  final Color color;
  final String text;

  const SeatLegend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}