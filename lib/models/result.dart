import './pagination.dart';

class Result<T> {
  String status;
  T data;
  Pagination pagination;
  List<T> items;

  Result({
    this.status,
    this.data,
    this.pagination,
    this.items,
  });

  factory Result.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic> json) convert) {
    T data;
    List<T> items;
    if (json['data'] != null) {
      data = convert(json['data']);
    }
    if (json['items'] != null) {
      try {
        Iterable l = json['items'] as List;
        items = l.map((item) => convert(item)).toList();
      } catch (e) {
        throw e;
      }
    }

    return Result(
      status            : json['status'] != null ? json['status'] : null,
      data              : data,
      pagination        : json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
      items             : items,
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'status'          : status,
      'pagination'      : pagination,
    };
}
