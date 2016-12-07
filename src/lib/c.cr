require "./c/auto_generated"

module Git
  lib C
    fun giterr_last : GitError*

    struct GitError
      message : LibC::Char*
      klass : LibC::Int
    end
  end
end

Git::C.libgit2_init
