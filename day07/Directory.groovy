class Directory {

    String name
    int size = 0

    Directory(String name) {
        this.name = name
    }

    @Override
    String toString() {
        return name + ' - ' + size
    }

}
