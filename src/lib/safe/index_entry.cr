module Git::Safe
  module IndexEntry
    include Safe

    define_safe :index_entry, value: true, free: false
  end
end
