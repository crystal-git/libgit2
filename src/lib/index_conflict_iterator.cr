module Git
  class IndexConflictIterator
    getter safe : Safe::IndexConflictIterator::Type

    def initialize(@safe)
    end

    def each
      loop do
        Safe.call :index_conflict_next, out ancestor_unsafe, out our_unsafe, out their_unsafe, @safe do |call|
          if call.success?
            ancestor = if !ancestor_unsafe.null?
              IndexEntry.new(Safe::IndexEntry.pointer(ancestor_unsafe))
            end
            our = if !our_unsafe.null?
              IndexEntry.new(Safe::IndexEntry.pointer(our_unsafe))
            end
            their = if !their_unsafe.null?
              IndexEntry.new(Safe::IndexEntry.pointer(their_unsafe))
            end
            yield ancestor, our, their
          elsif call.result == C::Iterover
            return
          else
            call.raise!
          end
        end
      end
    end
  end
end
