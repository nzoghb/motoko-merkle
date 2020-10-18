import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Nat8 "mo:base/Nat8";
import Word8 "mo:base/Word8";

import Sha256 "mo:motoko-sha/SHA256";

import A "canister:SimpleMerkleTree";

import TestTypes "./Types";

actor {

  type Test = TestTypes.Test;

  type ByteArray = A.ByteArray;
  type Tree = A.Tree;

  let sha256 = Sha256.sha256;
  let testData: ByteArray = [0];
  let testLeaf: Tree = #leaf(
                        Array.map<Word8, Nat8>(
                          sha256([0]),
                          func (x: Word8): Nat8 { Nat8.fromNat(Word8.toNat(x)) }
                        ));

  private func sanityTest() : async () {
    let expectedVal: Tree = #leaf([0]);
    assert await A.eq(await A.get(), expectedVal);
  };

  private func putOneTest() : async () {
    let expectedVal: Tree = #node(testLeaf, null);
    A.put(testData);
    assert await A.eq(await A.get(), expectedVal);
  };

  private func setup() : async () {
    A.reset();
  };

  let tests: [Test] = [
    {name = "sanityTest"; description = ""; body = sanityTest},
    {name = "putOneTest"; description = ""; body = putOneTest},
  ];

  public func run() : async () {
    for (test in tests.vals()) {
      await setup();
      Debug.print("RUNNING " # test.name # "...");
      await test.body();
      Debug.print(test.name # " PASSED");
    };
    Debug.print("ALL TESTS PASSED");
  };

};