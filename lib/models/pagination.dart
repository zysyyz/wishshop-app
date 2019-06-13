class Pagination {
  int currentPage;
  int from;
  int lastPage;
  int perPage;
  int to;
  int total;

  Pagination({
    this.currentPage,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage   : int.parse(json['current_page'].toString()),
      from          : int.parse(json['from'].toString()),
      lastPage      : int.parse(json['last_page'].toString()),
      perPage       : int.parse(json['per_page'].toString()),
      to            : int.parse(json['to'].toString()),
      total         : int.parse(json['total'].toString()),
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'current_page'  : currentPage,
      'from'          : from,
      'last_page'     : lastPage,
      'per_page'      : perPage,
      'to'            : to,
      'total'         : total,
    };
}
