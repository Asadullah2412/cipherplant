import 'package:flutter/material.dart';

class Myplantcard extends StatefulWidget {
  final String MyPlantName;
  final String Location;
  final int water;
  final VoidCallback? onDelete;

  Myplantcard({
    required this.Location,
    required this.MyPlantName,
    required this.water,
    this.onDelete,
  });

  @override
  State<Myplantcard> createState() => _MyplantcardState();
}

class _MyplantcardState extends State<Myplantcard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Delete Plant?"),
              content: Text("Do you want to delete this plant?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (widget.onDelete != null) {
                      widget.onDelete!();
                      Navigator.pop(ctx);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text("Plant deleted 🌿"),
                      //     duration: Duration(seconds: 2),
                      //   ),
                      // );
                    }
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          // color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Plant Image or Icon
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    // color: Colors.green[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.local_florist,
                    size: 40,
                    // color: Colors.green[700],
                  ),
                ),

                SizedBox(width: 20),

                // Plant Info Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.MyPlantName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Location: ${widget.Location}',
                        style: TextStyle(
                          fontSize: 14,
                          // color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Water: ${widget.water} ml',
                        style: TextStyle(
                          fontSize: 14,
                          // color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
