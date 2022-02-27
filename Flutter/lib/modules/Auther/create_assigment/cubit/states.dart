
import '../../../../models/module_model.dart';
import '../../../../models/response_model.dart';

abstract class CreateAssignmentStates {}

class InitCreateAssignmentState extends CreateAssignmentStates {}

class ChangeItemState extends CreateAssignmentStates {}
class ChangeAActivityState extends CreateAssignmentStates {}

class CreateNewAssignmentLoadingState extends CreateAssignmentStates {}

class CreateNewAssignmentSuccssesState extends CreateAssignmentStates {

  final CreateContent createContentModel;
  CreateNewAssignmentSuccssesState(this.createContentModel);
}

class CreateNewAssignmentErrorState extends CreateAssignmentStates {
  final String error;
  CreateNewAssignmentErrorState(this.error);
}
class GetNewAssignmentLoadingState extends CreateAssignmentStates {}

class GetNewAssignmentSuccssesState extends CreateAssignmentStates {

  final CreateContent createContentModel;
  GetNewAssignmentSuccssesState(this.createContentModel);
}

class GetNewAssignmentErrorState extends CreateAssignmentStates {
  final String error;
  GetNewAssignmentErrorState(this.error);
}

class UpdateAssignmentLoadingState extends CreateAssignmentStates {}

class UpdateAssignmentSuccssesState extends CreateAssignmentStates {

  final ResponseModel  responseModel;
  UpdateAssignmentSuccssesState(this.responseModel);
}

class UpdateAssignmentErrorState extends CreateAssignmentStates {
  final String error;
  UpdateAssignmentErrorState(this.error);
}
class DeleteAssignmentLoadingState extends CreateAssignmentStates {}

class DeleteAssignmentSuccssesState extends CreateAssignmentStates {

  final ResponseModel responseModel;
  DeleteAssignmentSuccssesState(this.responseModel);
}

class DeleteAssignmentErrorState extends CreateAssignmentStates {
  final String error;
  DeleteAssignmentErrorState(this.error);
}