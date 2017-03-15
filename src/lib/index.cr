module Git
  class Index
    getter safe : Safe::Index::Type

    def initialize(@safe)
    end

    def count
      C.index_entrycount(@safe)
    end

    def empty?
      count == 0
    end

    def has_conflicts?
      C.index_has_conflicts(@safe) == 1
    end

    def new_conflict_iterator
      Safe.call :index_conflict_iterator_new, out it, @safe
      IndexConflictIterator.new(Safe::IndexConflictIterator.free(it))
    end

    def each_conflict
      new_conflict_iterator.each do |ancestor, our, their|
        yield ancestor, our, their
      end
    end

    def each
      i = 0
      until (p = C.index_get_byindex(@safe, i)).null?
        yield IndexEntry.new(Safe::IndexEntry.pointer(p))
        i += 1
      end
    end

    def write_tree
      Safe.call :index_write_tree, out oid, @safe
      Oid.new(Safe::Oid.value(oid))
    end
  end
end
