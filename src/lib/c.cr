require "./c/auto_generated"

module Git
  lib C
    fun giterr_last : GitError*

    struct GitError
      message : LibC::Char*
      klass : LibC::Int
    end

    IDXENTRY_NAMEMASK = 0x0fff
    IDXENTRY_STAGEMASK = 0x3000

    enum IndexStageT
      IndexStageAny = -1
      IndexStageNormal = 0
    	IndexStateAncestor = 1
      IndexStageOurs = 2
      IndexStateTheir = 3
    end
  end
end

Git::C.libgit2_init
