import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/author_manger_request.dart';
import 'package:lms/models/author_request.dart';
import 'package:lms/models/new/course_requests.dart';
import 'package:lms/models/new/track_requests.dart';
import 'package:lms/modules/manager/bloc/states.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

class ManagerCubit extends Cubit<ManagerStates> {
  ManagerCubit() : super(ManagerRequestAuthorInitialState());

  static ManagerCubit get(context) => BlocProvider.of(context);

  AuthorRequests? authorRequests;

  Future<void> getAuthorRequests() async {
    emit(GetAllAuthorRequestsLoadingState());
    await DioHelper.getData(url: getAuthorRequest, token: userToken)
        .then((value) {
      print(value.data);
      authorRequests = AuthorRequests.fromJson(value.data);
      emit(GetAllAuthorRequestsSuccessState(authorRequests!));
    }).catchError((error) {
      emit(GetAllAuthorRequestsErrorState(error.toString()));
      print(error.toString());
    });
  }


  CourseRequestModel? coursesRequests;
  Future<void> getCoursesRequests() async {
    emit(GetAllCoursesRequestsLoadingState());
    await DioHelper.getData(url: getCourseRequest, token: userToken)
        .then((value) {
      print("asd asd Kareem KAsd ${value.data}");
      coursesRequests = CourseRequestModel.fromJson(value.data);
      emit(GetAllCoursesRequestsSuccessState(coursesRequests!));
    }).catchError((error) {
      emit(GetAllCoursesRequestsErrorState(error.toString()));
      print(error.toString());
    });
  }


  TrackRequestsModel? trackRequestsModel;
  Future<void> getTracksRequests() async {
    emit(GetAllTracksRequestsLoadingState());
    await DioHelper.getData(url: getTrackRequest, token: userToken)
        .then((value) {
      print(value.data);
      trackRequestsModel = TrackRequestsModel.fromJson(value.data);
      emit(GetAllTracksRequestsSuccessState(trackRequestsModel!));
    }).catchError((error) {
      emit(GetAllTracksRequestsErrorState(error.toString()));
      print(error.toString());
    });
  }

  AuthorsManagerRequest? userModel;

  Future<void> getAllUsers() async {
    emit(GetAllUsersLoadingState());
    await DioHelper.getData(url: allUsers, token: userToken)
        .then((value) {
      print(value.data);
      userModel = AuthorsManagerRequest.fromJson(value.data);
      emit(GetAllUsersSuccessState(userModel!));
    }).catchError((error) {
      emit(GetAllUsersErrorState(error.toString()));
      print(error.toString());
    });
  }
  void updateUserProfile({
    required String? userRequestId,
  }) {
    emit(UpdateUserRoleLoadingState());
    DioHelper.putData(
      url: updateUserRoleAuthor,
      token: userToken,
      data: {
        'userRequestId': userRequestId,
      },
    ).then((value) {
      print(value.toString());
      getAuthorRequests();
      //print(model!.profile!.userName);
      emit(UpdateUserRoleSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateUserRoleErrorState(onError.toString()));
    });
  }


  void acceptCourseRequest({
    required String? authorId,
    required String? courseId,
  }) {
    emit(AcceptCourseLoadingState());
    DioHelper.putData(
      url: acceptCourseAuthor,
      token: userToken,
      data: {
        'authorId': authorId,
        'courseId': courseId,
      },
    ).then((value) {
      getCoursesRequests();
      emit(AcceptCourseSuccessState());
    }).catchError((onError) {
      emit(AcceptCourseErrorState(onError.toString()));
    });
  }


  void acceptTrackRequest({
    required String? authorId,
    required String? trackId,
  }) {
    emit(AcceptTrackLoadingState());
    DioHelper.putData(
      url: acceptTrackAuthor,
      token: userToken,
      data: {
        'authorId': authorId,
        'trackId': trackId,
      },
    ).then((value) {
      getTracksRequests();
      emit(AcceptTrackSuccessState());
    }).catchError((onError) {
      emit(AcceptTrackErrorState(onError.toString()));
    });
  }

  void deleteAuthorRequest({required String userRequestId}) {
    emit(DeleteAuthorRequestLoadingState());
    DioHelper.deleteData(url: deleteUserRequest, data: {
      "userRequestId": userRequestId,
    }).then((value) {
      print(value.data);
      getAuthorRequests();
      emit(DeleteAuthorRequestSuccessState());
    }).catchError((error) {
      emit(DeleteAuthorRequestErrorState(error));
    });
  }
  void deleteCourseRequestData({required String courseId}) {
    emit(DeleteCourseRequestLoadingState());
    DioHelper.deleteData(url: deleteCourseRequest, data: {
      "courseId": courseId,
    }).then((value) {
      getCoursesRequests();
      emit(DeleteCourseRequestSuccessState());
    }).catchError((error) {
      emit(DeleteCourseRequestErrorState(error));
    });
  }

  void deleteTrackRequestData({required String trackId}) {
    emit(DeleteTrackRequestLoadingState());
    DioHelper.deleteData(url: deleteTrackRequest, data: {
      "trackId": trackId,
    }).then((value) {
      getTracksRequests();
      emit(DeleteTrackRequestSuccessState());
    }).catchError((error) {
      emit(DeleteTrackRequestErrorState(error));
    });
  }
}
