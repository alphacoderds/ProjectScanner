import 'package:flutter/material.dart';

class Keterangan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keterangan'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/images/bolder32.png',
                width: 60,
                height: 60,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent],
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                title: Text(
                  'Plan Me',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
