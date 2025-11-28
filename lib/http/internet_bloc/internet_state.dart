enum InternetStatus {loading,connected,disconnected}

class InternetInitialState extends InternetState{}

class InternetState{
  InternetStatus internetstatus;
  InternetState({this.internetstatus = InternetStatus.loading});

  InternetState copywith({InternetStatus? internetstatus}) {
    return InternetState(internetstatus: internetstatus ?? this.internetstatus);
  }
}