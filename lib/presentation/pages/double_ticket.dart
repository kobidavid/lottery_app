import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class DoubleTicket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          child: ListView(children: [
            RaisedButton(
              child: Text('Click'),
              onPressed: () {Navigator.pushNamed(context, '/');}

             /* async {
              var futureValue=await myTimedOutFuture().timeout(Duration(seconds: 8),onTimeout: (){
                print(' this future is timed out');
                return 'this is my timeout value';
              });

                print('Future complete: $futureValue');
                //multipleDonloads();
                /*print('future started- then');
                myFirstFuture().then((value) {
                  print('future finished- then');
                }, onError: (error) {
                  print(error);
                });
                print('Future now here');*/
              },*/
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Image.network(
                      'https://cdn.supercell.com/supercell.com/200929150142/supercell.com/files/games_brawlstars_video_mechamayhem_thumbnail.jpg',
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}


Future<bool> downloadFile(int id, int duration) async {
  await Future.delayed(Duration(seconds: duration));
  print('download completed for $id');
}

Future multipleDonloads ()async{
  var futures=List<Future>();

  for(int i=0;i<10;i++){
    futures.add(downloadFile(i, Random(i).nextInt(10)));
  }
  await Future.wait(futures);
  print('done');
}








Future<String>myTimedOutFuture()async{
await Future.delayed(Duration(seconds: 10));
return ('Future completed');
}