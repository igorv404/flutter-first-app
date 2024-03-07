import 'package:flutter/material.dart';
import 'package:my_project/models/establishment.dart';

class EstablishmentItem extends StatelessWidget {
  final Establishment establishment;

  const EstablishmentItem({required this.establishment, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Image.network(
            establishment.image,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  establishment.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87.withOpacity(0.8),
                  ),
                ),
                Text(
                  establishment.location,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54.withOpacity(0.7),
                  ),
                ),
                Text(
                  'Price level: ${establishment.priceLevel}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black45.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
