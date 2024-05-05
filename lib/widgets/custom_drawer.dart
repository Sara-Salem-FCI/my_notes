import 'package:flutter/material.dart';
import '../helper/capitalize.dart';
import '../constants/colors.dart';
import '../shared_prefrences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 40),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.7,
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), topRight: Radius.circular(50)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: kActiveColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage('${CacheHelper.getString(key: 'imageUrl')}'),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Text(
                  '${CacheHelper.getString(key: 'firstName')?.capitalize()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${CacheHelper.getString(key: 'secondName')?.capitalize()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30,),
                Row(
                    children: [
                      const Icon(Icons.account_circle_rounded, color: kMidColor, size: 30,),
                      const SizedBox(width: 10,),
                      Text('View Profile', style: TextStyle(color: Colors.grey[300], fontSize: 20),),
                    ]
                ),
                const SizedBox(height: 10,),
                Row(
                    children: [
                      const Icon(Icons.bookmark, color: kMidColor, size: 30,),
                      const SizedBox(width: 10,),
                      Text('Saved Notes', style: TextStyle(color: Colors.grey[300], fontSize: 20),),
                    ]
                ),
                const SizedBox(height: 10,),
                Row(
                    children: [
                      const Icon(Icons.analytics_outlined, color: kMidColor, size: 30,),
                      const SizedBox(width: 10,),
                      Text('Analytics', style: TextStyle(color: Colors.grey[300], fontSize: 20),),
                    ]
                ),
                const SizedBox(height: 50,),
              ]
          ),
        ),
      ),
    );
  }
}
