import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lms/models/track_model.dart';
import 'package:lms/modules/courses/course_details_screen.dart';
import 'package:lms/modules/courses/cubit/cubit.dart';
import 'package:lms/modules/courses/cubit/states.dart';
import 'package:lms/modules/user_tracks/cubit/cubit.dart';
import 'package:lms/modules/user_tracks/cubit/states.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/zoomDrawer.dart';
import '../../models/course_model.dart';
import '../../shared/component/constants.dart';

class UserTracksOverViewScreen extends StatelessWidget {

  final Tracks tracksModel;
  const UserTracksOverViewScreen(this.tracksModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrackCubit,AllTracksStates>(
      listener: (context, state) {},
      builder: (context, state){
        var cubit = TrackCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
          ),
          // create two button in bottomNavigationBar
          bottomNavigationBar: Container(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    // object from defaultButton on component.dart file
                    child: defaultButton(
                      onPressed: () {
                        // cubit.enrollCourse(courseId: courseModel.sId);
                        // navigatorAndRemove(context, ZoomDrawerScreen(widget: CoursesDetailsScreen(courseModel),));
                      }, text: 'Enroll Course',),
                  ),
                ),
                Expanded(
                  child: Padding(

                    padding: const EdgeInsets.all(8),

                    // object from defaultButton on component.dart file
                    child: defaultButton(onPressed: () {
                      print("asdasdas");
                      Fluttertoast.showToast(msg: "Added To Your wishlist");
                    }, text: 'Add WatchList', widget: Icon(Icons.favorite_rounded, color: primaryColor,), color: false),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Widget display course image in border radius
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: imageFromNetwork(
                        url: '${tracksModel.imageUrl}', height: 200.h),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // course title
                  Text(
                    '${tracksModel.trackName}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // course description

                  Text(
                    '${tracksModel.description}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // What the course includes

                  // Row Inside tow Column

                  Row(
                    children: [
                      Expanded(

                        // Column inside text, icon, last update
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Last Updated'),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('${tracksModel}')
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        // Column inside text, icon, language

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Language'),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.language,
                                  color: primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                //Text('${courseModel.language}')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // Row Inside tow Column
                  Row(
                    children: [
                      Expanded(
                        // Column inside text, icon, Total Time

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Time'),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.play_circle_outline,
                                  color: primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                               // Text('${courseModel.totalTime}')
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        // Column inside text, icon, Learners number
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Learners'),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.person,
                                  color: primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('700')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Created by ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [

                      // author image in a circular shape
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          '${tracksModel.author}',
                        ),
                        radius: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      // author name
                      //Text('${courseModel.author!.userName}'),
                      const Spacer(),
                      // course rate (title, icon)
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: primaryColor.withOpacity(0.7)),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            // Text(
                            //   '${courseModel.review}',
                            //   style: TextStyle(color: Colors.white),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),


                  const Text(
                    'What you will learn',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'Course Requirements',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'Reviews',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
