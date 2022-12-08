class TreeNode<T> {

    T data
    TreeNode<T> parent
    List<TreeNode<T>> children

    TreeNode(T data) {
        this.data = data
        this.children = new LinkedList<TreeNode<T>>()
    }

    TreeNode<T> addChild(T child) {
        TreeNode<T> childNode = new TreeNode<T>(child)
        childNode.parent = this
        this.children.add(childNode)
        return childNode
    }

    @Override
    String toString() {
        return data.toString()
    }

}