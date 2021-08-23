import 'package:ws_app_flutter/models/mine/common_question_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/list_controller.dart';

class CommonQuController extends ListController<SingleQuestion> {
  @override
  Future<List<SingleQuestion>?> loadData() async {
    CommonQuModel model = await DioManager()
        .request<CommonQuModel>(DioManager.POST, Api.normalQuestionUrl);
    model.list?.forEach((SingleQuestion question) {
      if (model.filePath != null) {
        question.filePath = model.filePath![question.fileId];
      }
    });
    return model.list;
  }
}
