// classify of response of data sources to ui
class ResponseClassify<T> {
  Status status;
  T? data;
  String? error;

  ResponseClassify.loading() : status = Status.loading;

  ResponseClassify.completed(this.data) : status = Status.completed;

  ResponseClassify.error(this.error) : status = Status.error;

  @override
  String toString() {
    return "Status : $status \n Message :  \n Data : $data Error : $error";
  }
}

enum Status { loading, completed, error }
