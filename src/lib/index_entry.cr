module Git
  class IndexEntry
    getter safe : Safe::IndexEntry::Type

    def initialize(@safe)
    end

    def path
      String.new(@safe.value.path)
    end

    def flags_stage
      C::IndexStageT.new((@safe.value.flags & C::IDXENTRY_STAGEMASK >> C::IDXENTRY_STAGESHIFT).to_i32)
    end

    def flags_name
      @safe.value.flags & C::IDXENTRY_NAMEMASK
    end

    def to_tuple
      {
        path: path,
        file_size: @safe.value.file_size,
        flags: {
          bits: @safe.value.flags,
          stage: flags_stage,
          name: flags_name
        },
        flags_extended: @safe.value.flags_extended,
        id: Oid.new(Safe::Oid.value(@safe.value.id)).string,
        mode: @safe.value.mode,
        uid: @safe.value.uid,
        gid: @safe.value.gid
      }
    end
  end
end


# Git::C::IndexEntry(
#                      @ctime=
#                       Git::C::IndexTime(
#                        @nanoseconds=0,
#                        @seconds=0),
#                      @dev=0,
#                      @file_size=0,
#                      @flags=8198,
#                      @flags_extended=0,
#                      @gid=0,
#                      @id=
#                       Git::C::Oid(
#                        @id=
#                         StaticArray[31,
#                          115,
#                          145,
#                          249,
#                          43,
#                          106,
#                          55,
#                          146,
#                          32,
#                          78,
#                          7,
#                          233,
#                          159,
#                          113,
#                          246,
#                          67,
#                          204,
#                          53,
#                          231,
#                          225]),
#                      @ino=0,
#                      @mode=33188,
#                      @mtime=
#                       Git::C::IndexTime(
#                        @nanoseconds=0,
#                        @seconds=0),
#                      @path=Pointer(UInt8)@0x7fe153700a20,
#                      @uid=0)
