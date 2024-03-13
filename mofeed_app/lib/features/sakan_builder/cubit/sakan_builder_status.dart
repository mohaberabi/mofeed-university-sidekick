enum SakanBuilderStatus {
  initial,
  loading,
  added,
  deleted,
  error;

  bool get isInitial => this == SakanBuilderStatus.initial;

  bool get isLoading => this == SakanBuilderStatus.loading;

  bool get isAdded => this == SakanBuilderStatus.added;

  bool get isDeleted => this == SakanBuilderStatus.deleted;

  bool get isError => this == SakanBuilderStatus.error;
}
