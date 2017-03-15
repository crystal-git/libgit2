module Git
  class DiffFile
    getter safe : Safe::DiffFile::Type

    def initialize(@safe)
    end

    def path
      String.new(@safe.value.path)
    end
  end
end
