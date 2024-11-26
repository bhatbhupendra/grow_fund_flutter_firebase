class FundGroup {
  final String manager;
  final String fg_id;
  final String name;
  final int fund;
  final int maxUsers;
  final int perGap;

  FundGroup({
    required this.fg_id,
    required this.manager,
    required this.name,
    required this.fund,
    required this.maxUsers,
    required this.perGap,
  }); //Requred indicates that a variable has to be set.

  @override
  String toString() {
    return 'FundGroup(name: $name, manager: $manager, id: $fg_id, fund: $fund, max users: $maxUsers, manager: $perGap)';
  }
}
