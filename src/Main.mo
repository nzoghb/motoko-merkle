import Word8 "mo:base/Word8";

import SimpleMerkleTree "./SimpleMerkleTree";
import Types "./Types";

actor {

    type Byte = Types.Byte;
    public type ByteArray = Types.ByteArray;
    public type Tree = Types.BinaryTree;

    let initialState = SimpleMerkleTree.init([0]);
    var t = initialState;

    public query func get() : async (Tree) {
        t
    };

    public func put(data: ByteArray) {
        t := SimpleMerkleTree.put(t, data);
    };

    public query func eq(lhs: Tree, rhs: Tree) : async (Bool) {
        SimpleMerkleTree.eq(lhs, rhs)
    };

    public func reset() {
        t := initialState;
    };

};