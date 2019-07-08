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
      currentPage   : int.parse(json['currentPage'].toString()),
      from          : int.parse(json['from'].toString()),
      lastPage      : int.parse(json['lastPage'].toString()),
      perPage       : int.parse(json['perPage'].toString()),
      to            : int.parse(json['to'].toString()),
      total         : int.parse(json['total'].toString()),
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'currentPage'  : currentPage,
      'from'          : from,
      'lastPage'     : lastPage,
      'perPage'      : perPage,
      'to'            : to,
      'total'         : total,
    };
}
