enum ROLE { admin, staff, customer }

abstract class Coll {
  const Coll();
  Map<String, dynamic> toMap();
}
