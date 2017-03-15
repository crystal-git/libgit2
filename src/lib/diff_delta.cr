module Git
  class DiffDelta
    getter safe : Safe::DiffDelta::Type

    def initialize(@safe)
    end

    @old_file : DiffFile?
    def old_file
      @old_file ||= DiffFile.new(Safe::DiffFile.value(@safe.value.old_file))
    end

    @new_file : DiffFile?
    def new_file
      @new_file ||= DiffFile.new(Safe::DiffFile.value(@safe.value.new_file))
    end
  end
end
