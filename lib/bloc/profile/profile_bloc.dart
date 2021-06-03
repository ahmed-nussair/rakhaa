import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/response/profile_update_response.dart';
import '../../model/response/password_update_response.dart';
import '../../model/chopper/profile_service.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    yield ProfileInitial();

    if (event is UpdatingProfile) {
      yield UpdatingProfileState();

      var service = ProfileService.create();
      var response;
      if (event.image != null && event.image.isNotEmpty) {
        response = await service.updateProfile(
            event.name, event.email, event.phone, event.token,
            image: event.image);
      } else {
        response = await service.updateProfile(
            event.name, event.email, event.phone, event.token);
      }

      if (response.isSuccessful) {
        var profileUpdateResponse = response.body;

        if (profileUpdateResponse.result)
          yield ProfileUpdatedState(profileUpdateResponse);
        else
          yield ErrorUpdatingProfileState('خطأ في تحميل الصورة');
      } else {
        yield ErrorUpdatingProfileState('فشل في تحديث البيانات');
      }
    } else if (event is UpdatingPassword) {
      yield UpdatingPasswordState();
      var service = ProfileService.create();
      var response = await service.updatePassword({
        'token': event.token,
        'oldPassword': event.oldPassword,
        'newPassword': event.newPassword,
      });

      if (response.isSuccessful) {
        var passwordUpdateResponse = response.body;

        if (passwordUpdateResponse.result) {
          yield PasswordUpdatedState(passwordUpdateResponse);
        } else {
          yield ErrorUpdatingPasswordState('فشل في تحديث كلمة المرور');
        }
      } else {
        yield ErrorUpdatingPasswordState(
            'حدث خطأ أثناء محاولة تحديث كلمة المرور');
      }
    }
  }
}
