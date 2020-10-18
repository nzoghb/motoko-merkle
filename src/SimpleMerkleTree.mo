import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Word8 "mo:base/Word8";
import Word64 "mo:base/Word64";

import Sha256 "mo:motoko-sha/SHA256";

import Types "./Types";

module {

  type Iter<S> = Iter.Iter<(S)>;

  type Byte = Types.Byte;
  type ByteArray = Types.ByteArray;
  type Tree = Types.BinaryTree;

  let sha256 = Sha256.sha256;

  public func init(data: ByteArray) : Tree {
    #leaf(sha256(data))
  };

  /// Inserts a new node in the tree's leftmost free branch.
  public func put(t: Tree, data: ByteArray) : Tree {
    let newNode = #leaf(sha256(data));
    switch (t) {
      case (#leaf(hashData)) {
        #node(#leaf(hashData), ?newNode)
      };
      case (#node(l, r)) {
        if (isBalanced(l)) {
          switch (r) {
            case (null) {
              #node(l, ?newNode)
            };
            case (?rightNode) {
              if (isBalanced(rightNode)) {
                #node(t, ?newNode)
              } else {
                #node(l, ?put(rightNode, data))
              }
            };
          }
        } else {
          #node(put(l, data), r)
        }
      };
    }
  };

  public func height(t: Tree) : Nat {
    switch t {
      case (#leaf(_)) { 0 };
      case (#node(l, null)) {
        height(l) + 1
      };
      case (#node(l, ?r)) {
        Nat.max(height(l), height(r)) + 1
      };
    }
  };

  public func size(t: Tree) : Nat {
    switch t {
      case (#leaf(_)) { 0 };
      case (#node(l, null)) {
        size(l) + 1
      };
      case (#node(l, ?r)) {
        size(l) + size(r) + 1
      };
    }
  };

  public func hash(t: Tree) : [Word8] {
    [23]
  };

  public func eq(lhs: Tree, rhs: Tree) : Bool {
    hash(lhs) == hash(rhs)
  };

  func isBalanced(t: Tree) : Bool {
    let x = size(t);
    (x != 0) and ((Word64.fromNat(x) & (Word64.fromNat(x) - Word64.fromNat(1))) == Word64.fromNat(0))
  };

}