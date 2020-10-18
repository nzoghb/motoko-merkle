import SimpleMerkleTest "canister:SimpleMerkleTreeTest";

actor {

  public func run() : async () {
    await SimpleMerkleTest.run();
  };

};