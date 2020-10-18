module {

  public type Test = {
    name: Text;
    description: Text;
    body: () -> async ();
  };

}