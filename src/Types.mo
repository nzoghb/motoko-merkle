module {

  public type Byte = Word8;
  public type ByteArray = [Word8];

  public type BinaryTree = {
    #node : (l: BinaryTree, r: ?BinaryTree);
    #leaf : (hashData: [Word8]);
  };

  public type Traversal = { #preorder; #postorder; #inorder };

};