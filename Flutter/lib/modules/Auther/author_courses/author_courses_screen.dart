import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/author_courses_published_model.dart';
import 'package:lms/models/course_model.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/cubit.dart';
import 'package:lms/modules/Auther/create_course/create_course_screen.dart';
import 'package:lms/modules/Auther/create_course/update_course_screen.dart';

import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';

import 'author_courses_cubit/status.dart';


class AuthorCourses extends StatelessWidget {
  AuthorCourses({Key? key}) : super(key: key);

  final List<Widget> myTabs = [
    //Tab(text: 'Drafts'),
    Tab(text: 'Pendding'),
    Tab(text: 'Published'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorCoursesCubit, AuthorCoursesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AuthorCoursesCubit.get(context);
        return Layout(
          widget: DefaultTabController(
            length: myTabs.length,
            child: Scaffold(
              appBar: AppBar(),
              body: ConditionalBuilder(
                condition: cubit.authorCoursesTestModel != null,
                builder: (context) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10),
                        child: Row(
                          children: [
                            Text(
                              'My Courses',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                navigator(context, CreateCourseScreen());
                              },
                              child: Text(
                                'New Course',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TabBar(
                        labelColor: primaryColor,
                        indicatorColor: primaryColor,
                        unselectedLabelColor: Colors.black,
                        // isScrollable: true,
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: myTabs,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ConditionalBuilder(
                              condition: cubit.authorCoursesTestModel!.courses!.length != 0,
                              builder: (context) {
                                return penddingCourses(cubit);
                              },
                              fallback: (context) {
                                return emptyPage(
                                    text: "No Tracks Added Yet",
                                    context: context);
                              },
                            ),
                            ConditionalBuilder(
                              condition: cubit.authorCoursesTestModel!.courses!.length != 0,
                              builder: (context) {
                                return publishedCourses(cubit);
                              },
                              fallback: (context) {
                                return emptyPage(
                                    text: "No Tracks Added Yet",
                                    context: context);
                              },
                            ),
                            //draftsCourses(),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                fallback: (context) {
                  return Center(
                    child:  CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  //Published Courses PageView
  Widget publishedCourses(AuthorCoursesCubit cubit,) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return buildAuthorCoursePublish(context, cubit.authorCoursesModel!.courses![index], cubit);
        },
        itemCount: cubit.authorCoursesModel!.courses!.length);
  }

  //Pending Courses PageView
  Widget penddingCourses(AuthorCoursesCubit cubit) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return buildAuthorCourse(context, cubit.authorCoursesTestModel!.courses![index], cubit);
        },
        itemCount: cubit.authorCoursesTestModel!.courses!.length);
  }

  //Course Widget
  Widget buildAuthorCourse(context, Courses course, AuthorCoursesCubit cubit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120.h,
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey[100],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            // Container(
            //   clipBehavior: Clip.antiAliasWithSaveLayer,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(30.0),
            //     color: Colors.white,
            //   ),
            //   child: Image.network(
            //     'https://media.gettyimages.com/vectors/-vector-id960988454',
            //     height: 150.h,
            //     width: 140.w,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: imageFromNetwork(
                //'https://media.gettyimages.com/vectors/-vector-id960988454',
                url: '${course.imageUrl}',
                height: 150.h,
                width: 140.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    child: Text(
                      //'Track Name',
                      '${course.title}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 18.r,
                        child: IconButton(
                          onPressed: () {
                            navigator(context, UpdateCourseScreen(course));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 18.r,
                        child: IconButton(
                          onPressed: () {
                            print(course.sId);
                            cubit.deleteCourse(courseId: course.sId!);
                          },
                          icon: Icon(
                            Icons.delete_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 18.r,
                        child: IconButton(
                          onPressed: () {

                          },
                          icon: Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildAuthorCoursePublish(context, Coursess course, AuthorCoursesCubit cubit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120.h,
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey[100],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            // Container(
            //   clipBehavior: Clip.antiAliasWithSaveLayer,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(30.0),
            //     color: Colors.white,
            //   ),
            //   child: Image.network(
            //     'https://media.gettyimages.com/vectors/-vector-id960988454',
            //     height: 150.h,
            //     width: 140.w,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: imageFromNetwork(
                //'https://media.gettyimages.com/vectors/-vector-id960988454',
                url: '${course.imageUrl}',
                height: 150.h,
                width: 140.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    child: Text(
                      //'Track Name',
                      '${course.title}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 18.r,
                        child: IconButton(
                          onPressed: () {
                            //navigator(context, UpdateCourseScreen(course));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 18.r,
                        child: IconButton(
                          onPressed: () {
                            print(course.sId);
                            cubit.deleteCourse(courseId: course.sId!);
                          },
                          icon: Icon(
                            Icons.delete_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      // CircleAvatar(
                      //   backgroundColor: Colors.greenAccent[400],
                      //   radius: 18.r,
                      //   child: IconButton(
                      //     onPressed: () {},
                      //     icon: Icon(
                      //       Icons.send_rounded,
                      //       color: Colors.white,
                      //       size: 18,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 10.w,
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
