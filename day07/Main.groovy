static void main(String[] args) {
    def root = new TreeNode<Directory>(new Directory())
    def node = root
    String fileContents = new File('input.txt').text
    fileContents.eachLine { line ->
        if (line == '$ cd ..') {
            node = node.parent

        } else if (line.startsWith('$ cd ')) {
            def dir = line.substring(5)
            def child = node.children.find {
                it.data.name == dir
            }
            if (child == null) {
                child = node.addChild(new Directory(dir))
            }
            node = child

        } else if (line.startsWith('dir ')) {
            node.addChild(new Directory(line.split()[1]))

        } else if (!line.startsWith('$ ')) {
            node.data.size += line.split()[0] as Integer
        }
    }

    def nodes = nodes(root)
    int solutionOne = nodes.findAll { it <= 100000 }.sum() as int
    print('the sum of the total sizes of those directories is: ' + solutionOne + '\n')

    def requiredSpace = 30000000 - (70000000 - sumUp(root))
    def solutionTwo = nodes.findAll { it > requiredSpace }.min()
    print('the total size of that directory is: ' + solutionTwo + '\n')
}

List nodes(TreeNode<Directory> node) {
    def nodeList = []
    def sum = node.data.size
    for ( el in node.children) {
        sum += sumUp(el)
        nodeList.addAll(nodes(el))
    }
    nodeList.add(sum)
    return nodeList
}

int sumUp(TreeNode<Directory> node) {
    def sum = node.data.size
    for ( el in node.children) {
        sum += sumUp(el)
    }
    return sum
}
