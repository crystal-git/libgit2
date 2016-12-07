module Git
  {% if flag?(:travis) %}
    @[Link(ldflags: "{{ ENV["CRYSTAL_GIT_LDFLAGS"] }}")]
  {% else %}
    @[Link("git2")]
  {% end %}
  lib C
    PATH_MAX = 4096
    OID_RAWSZ = 20
    OID_MINPREFIXLEN = 4
    REPOSITORY_INIT_OPTIONS_VERSION = 1
    ATTR_CHECK_FILE_THEN_INDEX = 0
    ATTR_CHECK_INDEX_THEN_FILE = 1
    ATTR_CHECK_INDEX_ONLY = 2
    BLAME_OPTIONS_VERSION = 1
    DIFF_OPTIONS_VERSION = 1
    DIFF_FIND_OPTIONS_VERSION = 1
    DIFF_FORMAT_EMAIL_OPTIONS_VERSION = 1
    CHECKOUT_OPTIONS_VERSION = 1
    IDXENTRY_STAGESHIFT = 12
    MERGE_FILE_INPUT_VERSION = 1
    MERGE_FILE_OPTIONS_VERSION = 1
    MERGE_OPTIONS_VERSION = 1
    CHERRYPICK_OPTIONS_VERSION = 1
    REMOTE_CALLBACKS_VERSION = 1
    FETCH_OPTIONS_VERSION = 1
    PUSH_OPTIONS_VERSION = 1
    CLONE_OPTIONS_VERSION = 1
    DESCRIBE_DEFAULT_MAX_CANDIDATES_TAGS = 10
    DESCRIBE_DEFAULT_ABBREVIATED_SIZE = 7
    DESCRIBE_OPTIONS_VERSION = 1
    DESCRIBE_FORMAT_OPTIONS_VERSION = 1
    REBASE_OPTIONS_VERSION = 1
    REVERT_OPTIONS_VERSION = 1
    STASH_APPLY_OPTIONS_VERSION = 1
    STATUS_OPTIONS_VERSION = 1
    SUBMODULE_UPDATE_OPTIONS_VERSION = 1
    fun libgit2_version = git_libgit2_version(major : LibC::Int*, minor : LibC::Int*, rev : LibC::Int*)
    FeatureThreads = 1
    FeatureHttps = 2
    FeatureSsh = 4
    FeatureNsec = 8
    fun libgit2_features = git_libgit2_features : LibC::Int
    OptGetMwindowSize = 0
    OptSetMwindowSize = 1
    OptGetMwindowMappedLimit = 2
    OptSetMwindowMappedLimit = 3
    OptGetSearchPath = 4
    OptSetSearchPath = 5
    OptSetCacheObjectLimit = 6
    OptSetCacheMaxSize = 7
    OptEnableCaching = 8
    OptGetCachedMemory = 9
    OptGetTemplatePath = 10
    OptSetTemplatePath = 11
    OptSetSslCertLocations = 12
    OptSetUserAgent = 13
    OptEnableStrictObjectCreation = 14
    OptSetSslCiphers = 15
    fun libgit2_opts = git_libgit2_opts(option : LibC::Int, ...) : LibC::Int
    ObjAny = -2
    ObjBad = -1
    ObjExt1 = 0
    ObjCommit = 1
    ObjTree = 2
    ObjBlob = 3
    ObjTag = 4
    ObjExt2 = 5
    ObjOfsDelta = 6
    ObjRefDelta = 7
    alias Odb = Void
    alias OdbBackend = Void
    alias OdbObject = Void
    struct OdbStream
      backend : X_OdbBackend
      mode : LibC::UInt
      hash_ctx : Void*
      declared_size : OffT
      received_bytes : OffT
      read : (OdbStream*, LibC::Char*, LibC::SizeT -> LibC::Int)
      write : (OdbStream*, LibC::Char*, LibC::SizeT -> LibC::Int)
      finalize_write : (OdbStream*, Oid* -> LibC::Int)
      free : (OdbStream* -> Void)
    end
    type X_OdbBackend = Void*
    alias Int64T = LibC::LongLong
    alias OffT = Int64T
    struct Oid
      id : UInt8[20]
    end
    struct OdbWritepack
      backend : X_OdbBackend
      append : (OdbWritepack*, Void*, LibC::SizeT, TransferProgress* -> LibC::Int)
      commit : (OdbWritepack*, TransferProgress* -> LibC::Int)
      free : (OdbWritepack* -> Void)
    end
    struct TransferProgress
      total_objects : LibC::UInt
      indexed_objects : LibC::UInt
      received_objects : LibC::UInt
      local_objects : LibC::UInt
      total_deltas : LibC::UInt
      indexed_deltas : LibC::UInt
      received_bytes : LibC::SizeT
    end
    alias Refdb = Void
    alias RefdbBackend = Void
    alias Repository = Void
    alias Object = Void
    alias Revwalk = Void
    alias Tag = Void
    alias Blob = Void
    alias Commit = Void
    alias TreeEntry = Void
    alias Tree = Void
    alias Treebuilder = Void
    alias Index = Void
    alias IndexConflictIterator = Void
    alias Config = Void
    alias ConfigBackend = Void
    alias ReflogEntry = Void
    alias Reflog = Void
    alias Note = Void
    alias Packbuilder = Void
    struct Time
      time : TimeT
      offset : LibC::Int
    end
    alias TimeT = Int64T
    struct Signature
      name : LibC::Char*
      email : LibC::Char*
      when : Time
    end
    alias Reference = Void
    alias ReferenceIterator = Void
    alias Transaction = Void
    alias AnnotatedCommit = Void
    alias MergeResult = Void
    alias StatusList = Void
    alias Rebase = Void
    RefInvalid = 0
    RefOid = 1
    RefSymbolic = 2
    RefListall = 3
    BranchLocal = 1
    BranchRemote = 2
    BranchAll = 3
    FilemodeUnreadable = 0
    FilemodeTree = 16384
    FilemodeBlob = 33188
    FilemodeBlobExecutable = 33261
    FilemodeLink = 40960
    FilemodeCommit = 57344
    alias Refspec = Void
    alias Remote = Void
    alias Transport = Void
    alias Push = Void
    struct RemoteHead
      local : LibC::Int
      oid : Oid
      loid : Oid
      name : LibC::Char*
      symref_target : LibC::Char*
    end
    struct RemoteCallbacks
      version : LibC::UInt
      sideband_progress : TransportMessageCb
      completion : (RemoteCompletionType, Void* -> LibC::Int)
      credentials : CredAcquireCb
      certificate_check : TransportCertificateCheckCb
      transfer_progress : TransferProgressCb
      update_tips : (LibC::Char*, Oid*, Oid*, Void* -> LibC::Int)
      pack_progress : PackbuilderProgress
      push_transfer_progress : PushTransferProgress
      push_update_reference : (LibC::Char*, LibC::Char*, Void* -> LibC::Int)
      push_negotiation : PushNegotiation
      transport : TransportCb
      payload : Void*
    end
    alias TransportMessageCb = (LibC::Char*, LibC::Int, Void* -> LibC::Int)
    enum RemoteCompletionType
      RemoteCompletionDownload = 0
      RemoteCompletionIndexing = 1
      RemoteCompletionError = 2
    end
    struct Cred
      credtype : CredtypeT
      free : (Cred* -> Void)
    end
    alias CredAcquireCb = (Cred**, LibC::Char*, LibC::Char*, LibC::UInt, Void* -> LibC::Int)
    enum CredtypeT
      CredtypeUserpassPlaintext = 1
      CredtypeSshKey = 2
      CredtypeSshCustom = 4
      CredtypeDefault = 8
      CredtypeSshInteractive = 16
      CredtypeUsername = 32
      CredtypeSshMemory = 64
    end
    struct Cert
      cert_type : CertT
    end
    alias TransportCertificateCheckCb = (Cert*, LibC::Int, LibC::Char*, Void* -> LibC::Int)
    enum CertT
      CertNone = 0
      CertX509 = 1
      CertHostkeyLibssh2 = 2
      CertStrarray = 3
    end
    alias TransferProgressCb = (TransferProgress*, Void* -> LibC::Int)
    alias PackbuilderProgress = (LibC::Int, LibC::UInt, LibC::UInt, Void* -> LibC::Int)
    alias PushTransferProgress = (LibC::UInt, LibC::UInt, LibC::SizeT, Void* -> LibC::Int)
    struct PushUpdate
      src_refname : LibC::Char*
      dst_refname : LibC::Char*
      src : Oid
      dst : Oid
    end
    alias PushNegotiation = (PushUpdate**, LibC::SizeT, Void* -> LibC::Int)
    type X_Transport = Void*
    type X_Remote = Void*
    alias TransportCb = (X_Transport*, X_Remote, Void* -> LibC::Int)
    alias Submodule = Void
    SubmoduleUpdateCheckout = 1
    SubmoduleUpdateRebase = 2
    SubmoduleUpdateMerge = 3
    SubmoduleUpdateNone = 4
    SubmoduleUpdateDefault = 0
    SubmoduleIgnoreUnspecified = -1
    SubmoduleIgnoreNone = 1
    SubmoduleIgnoreUntracked = 2
    SubmoduleIgnoreDirty = 3
    SubmoduleIgnoreAll = 4
    SubmoduleRecurseNo = 0
    SubmoduleRecurseYes = 1
    SubmoduleRecurseOndemand = 2
    struct Writestream
      write : (Writestream*, LibC::Char*, LibC::SizeT -> LibC::Int)
      close : (Writestream* -> LibC::Int)
      free : (Writestream* -> Void)
    end
    fun oid_fromstr = git_oid_fromstr(out : Oid*, str : LibC::Char*) : LibC::Int
    fun oid_fromstrp = git_oid_fromstrp(out : Oid*, str : LibC::Char*) : LibC::Int
    fun oid_fromstrn = git_oid_fromstrn(out : Oid*, str : LibC::Char*, length : LibC::SizeT) : LibC::Int
    fun oid_fromraw = git_oid_fromraw(out : Oid*, raw : UInt8*)
    fun oid_fmt = git_oid_fmt(out : LibC::Char*, id : Oid*)
    fun oid_nfmt = git_oid_nfmt(out : LibC::Char*, n : LibC::SizeT, id : Oid*)
    fun oid_pathfmt = git_oid_pathfmt(out : LibC::Char*, id : Oid*)
    fun oid_tostr_s = git_oid_tostr_s(oid : Oid*) : LibC::Char*
    fun oid_tostr = git_oid_tostr(out : LibC::Char*, n : LibC::SizeT, id : Oid*) : LibC::Char*
    fun oid_cpy = git_oid_cpy(out : Oid*, src : Oid*)
    fun oid_cmp = git_oid_cmp(a : Oid*, b : Oid*) : LibC::Int
    fun oid_equal = git_oid_equal(a : Oid*, b : Oid*) : LibC::Int
    fun oid_ncmp = git_oid_ncmp(a : Oid*, b : Oid*, len : LibC::SizeT) : LibC::Int
    fun oid_streq = git_oid_streq(id : Oid*, str : LibC::Char*) : LibC::Int
    fun oid_strcmp = git_oid_strcmp(id : Oid*, str : LibC::Char*) : LibC::Int
    fun oid_iszero = git_oid_iszero(id : Oid*) : LibC::Int
    alias OidShorten = Void
    fun oid_shorten_new = git_oid_shorten_new(min_length : LibC::SizeT) : X_OidShorten
    type X_OidShorten = Void*
    fun oid_shorten_add = git_oid_shorten_add(os : X_OidShorten, text_id : LibC::Char*) : LibC::Int
    fun oid_shorten_free = git_oid_shorten_free(os : X_OidShorten)
    fun buf_free = git_buf_free(buffer : Buf*)
    struct Buf
      ptr : LibC::Char*
      asize : LibC::SizeT
      size : LibC::SizeT
    end
    fun buf_grow = git_buf_grow(buffer : Buf*, target_size : LibC::SizeT) : LibC::Int
    fun buf_set = git_buf_set(buffer : Buf*, data : Void*, datalen : LibC::SizeT) : LibC::Int
    fun buf_is_binary = git_buf_is_binary(buf : Buf*) : LibC::Int
    fun buf_contains_nul = git_buf_contains_nul(buf : Buf*) : LibC::Int
    fun repository_open = git_repository_open(out : X_Repository*, path : LibC::Char*) : LibC::Int
    type X_Repository = Void*
    fun repository_wrap_odb = git_repository_wrap_odb(out : X_Repository*, odb : X_Odb) : LibC::Int
    type X_Odb = Void*
    fun repository_discover = git_repository_discover(out : Buf*, start_path : LibC::Char*, across_fs : LibC::Int, ceiling_dirs : LibC::Char*) : LibC::Int
    RepositoryOpenNoSearch = 1
    RepositoryOpenCrossFs = 2
    RepositoryOpenBare = 4
    fun repository_open_ext = git_repository_open_ext(out : X_Repository*, path : LibC::Char*, flags : LibC::UInt, ceiling_dirs : LibC::Char*) : LibC::Int
    fun repository_open_bare = git_repository_open_bare(out : X_Repository*, bare_path : LibC::Char*) : LibC::Int
    fun repository_free = git_repository_free(repo : X_Repository)
    fun repository_init = git_repository_init(out : X_Repository*, path : LibC::Char*, is_bare : LibC::UInt) : LibC::Int
    RepositoryInitBare = 1
    RepositoryInitNoReinit = 2
    RepositoryInitNoDotgitDir = 4
    RepositoryInitMkdir = 8
    RepositoryInitMkpath = 16
    RepositoryInitExternalTemplate = 32
    RepositoryInitRelativeGitlink = 64
    RepositoryInitSharedUmask = 0
    RepositoryInitSharedGroup = 1533
    RepositoryInitSharedAll = 1535
    fun repository_init_init_options = git_repository_init_init_options(opts : RepositoryInitOptions*, version : LibC::UInt) : LibC::Int
    struct RepositoryInitOptions
      version : LibC::UInt
      flags : Uint32T
      mode : Uint32T
      workdir_path : LibC::Char*
      description : LibC::Char*
      template_path : LibC::Char*
      initial_head : LibC::Char*
      origin_url : LibC::Char*
    end
    alias Uint32T = LibC::UInt
    fun repository_init_ext = git_repository_init_ext(out : X_Repository*, repo_path : LibC::Char*, opts : RepositoryInitOptions*) : LibC::Int
    fun repository_head = git_repository_head(out : X_Reference*, repo : X_Repository) : LibC::Int
    type X_Reference = Void*
    fun repository_head_detached = git_repository_head_detached(repo : X_Repository) : LibC::Int
    fun repository_head_unborn = git_repository_head_unborn(repo : X_Repository) : LibC::Int
    fun repository_is_empty = git_repository_is_empty(repo : X_Repository) : LibC::Int
    fun repository_path = git_repository_path(repo : X_Repository) : LibC::Char*
    fun repository_workdir = git_repository_workdir(repo : X_Repository) : LibC::Char*
    fun repository_set_workdir = git_repository_set_workdir(repo : X_Repository, workdir : LibC::Char*, update_gitlink : LibC::Int) : LibC::Int
    fun repository_is_bare = git_repository_is_bare(repo : X_Repository) : LibC::Int
    fun repository_config = git_repository_config(out : X_Config*, repo : X_Repository) : LibC::Int
    type X_Config = Void*
    fun repository_config_snapshot = git_repository_config_snapshot(out : X_Config*, repo : X_Repository) : LibC::Int
    fun repository_odb = git_repository_odb(out : X_Odb*, repo : X_Repository) : LibC::Int
    fun repository_refdb = git_repository_refdb(out : X_Refdb*, repo : X_Repository) : LibC::Int
    type X_Refdb = Void*
    fun repository_index = git_repository_index(out : X_Index*, repo : X_Repository) : LibC::Int
    type X_Index = Void*
    fun repository_message = git_repository_message(out : Buf*, repo : X_Repository) : LibC::Int
    fun repository_message_remove = git_repository_message_remove(repo : X_Repository) : LibC::Int
    fun repository_state_cleanup = git_repository_state_cleanup(repo : X_Repository) : LibC::Int
    fun repository_fetchhead_foreach = git_repository_fetchhead_foreach(repo : X_Repository, callback : RepositoryFetchheadForeachCb, payload : Void*) : LibC::Int
    alias RepositoryFetchheadForeachCb = (LibC::Char*, LibC::Char*, Oid*, LibC::UInt, Void* -> LibC::Int)
    fun repository_mergehead_foreach = git_repository_mergehead_foreach(repo : X_Repository, callback : RepositoryMergeheadForeachCb, payload : Void*) : LibC::Int
    alias RepositoryMergeheadForeachCb = (Oid*, Void* -> LibC::Int)
    fun repository_hashfile = git_repository_hashfile(out : Oid*, repo : X_Repository, path : LibC::Char*, type : Otype, as_path : LibC::Char*) : LibC::Int
    enum Otype
      ObjAny = -2
      ObjBad = -1
      ObjExt1 = 0
      ObjCommit = 1
      ObjTree = 2
      ObjBlob = 3
      ObjTag = 4
      ObjExt2 = 5
      ObjOfsDelta = 6
      ObjRefDelta = 7
    end
    fun repository_set_head = git_repository_set_head(repo : X_Repository, refname : LibC::Char*) : LibC::Int
    fun repository_set_head_detached = git_repository_set_head_detached(repo : X_Repository, commitish : Oid*) : LibC::Int
    fun repository_set_head_detached_from_annotated = git_repository_set_head_detached_from_annotated(repo : X_Repository, commitish : X_AnnotatedCommit) : LibC::Int
    type X_AnnotatedCommit = Void*
    fun repository_detach_head = git_repository_detach_head(repo : X_Repository) : LibC::Int
    RepositoryStateNone = 0
    RepositoryStateMerge = 1
    RepositoryStateRevert = 2
    RepositoryStateRevertSequence = 3
    RepositoryStateCherrypick = 4
    RepositoryStateCherrypickSequence = 5
    RepositoryStateBisect = 6
    RepositoryStateRebase = 7
    RepositoryStateRebaseInteractive = 8
    RepositoryStateRebaseMerge = 9
    RepositoryStateApplyMailbox = 10
    RepositoryStateApplyMailboxOrRebase = 11
    fun repository_state = git_repository_state(repo : X_Repository) : LibC::Int
    fun repository_set_namespace = git_repository_set_namespace(repo : X_Repository, nmspace : LibC::Char*) : LibC::Int
    fun repository_get_namespace = git_repository_get_namespace(repo : X_Repository) : LibC::Char*
    fun repository_is_shallow = git_repository_is_shallow(repo : X_Repository) : LibC::Int
    fun repository_ident = git_repository_ident(name : LibC::Char**, email : LibC::Char**, repo : X_Repository) : LibC::Int
    fun repository_set_ident = git_repository_set_ident(repo : X_Repository, name : LibC::Char*, email : LibC::Char*) : LibC::Int
    fun annotated_commit_from_ref = git_annotated_commit_from_ref(out : X_AnnotatedCommit*, repo : X_Repository, ref : X_Reference) : LibC::Int
    fun annotated_commit_from_fetchhead = git_annotated_commit_from_fetchhead(out : X_AnnotatedCommit*, repo : X_Repository, branch_name : LibC::Char*, remote_url : LibC::Char*, id : Oid*) : LibC::Int
    fun annotated_commit_lookup = git_annotated_commit_lookup(out : X_AnnotatedCommit*, repo : X_Repository, id : Oid*) : LibC::Int
    fun annotated_commit_from_revspec = git_annotated_commit_from_revspec(out : X_AnnotatedCommit*, repo : X_Repository, revspec : LibC::Char*) : LibC::Int
    fun annotated_commit_id = git_annotated_commit_id(commit : X_AnnotatedCommit) : Oid*
    fun annotated_commit_free = git_annotated_commit_free(commit : X_AnnotatedCommit)
    AttrUnspecifiedT = 0
    AttrTrueT = 1
    AttrFalseT = 2
    AttrValueT = 3
    fun attr_value = git_attr_value(attr : LibC::Char*) : AttrT
    enum AttrT
      AttrUnspecifiedT = 0
      AttrTrueT = 1
      AttrFalseT = 2
      AttrValueT = 3
    end
    fun attr_get = git_attr_get(value_out : LibC::Char**, repo : X_Repository, flags : Uint32T, path : LibC::Char*, name : LibC::Char*) : LibC::Int
    fun attr_get_many = git_attr_get_many(values_out : LibC::Char**, repo : X_Repository, flags : Uint32T, path : LibC::Char*, num_attr : LibC::SizeT, names : LibC::Char**) : LibC::Int
    fun attr_foreach = git_attr_foreach(repo : X_Repository, flags : Uint32T, path : LibC::Char*, callback : AttrForeachCb, payload : Void*) : LibC::Int
    alias AttrForeachCb = (LibC::Char*, LibC::Char*, Void* -> LibC::Int)
    fun attr_cache_flush = git_attr_cache_flush(repo : X_Repository)
    fun attr_add_macro = git_attr_add_macro(repo : X_Repository, name : LibC::Char*, values : LibC::Char*) : LibC::Int
    fun object_lookup = git_object_lookup(object : X_Object*, repo : X_Repository, id : Oid*, type : Otype) : LibC::Int
    type X_Object = Void*
    fun object_lookup_prefix = git_object_lookup_prefix(object_out : X_Object*, repo : X_Repository, id : Oid*, len : LibC::SizeT, type : Otype) : LibC::Int
    fun object_lookup_bypath = git_object_lookup_bypath(out : X_Object*, treeish : X_Object, path : LibC::Char*, type : Otype) : LibC::Int
    fun object_id = git_object_id(obj : X_Object) : Oid*
    fun object_short_id = git_object_short_id(out : Buf*, obj : X_Object) : LibC::Int
    fun object_type = git_object_type(obj : X_Object) : Otype
    fun object_owner = git_object_owner(obj : X_Object) : X_Repository
    fun object_free = git_object_free(object : X_Object)
    fun object_type2string = git_object_type2string(type : Otype) : LibC::Char*
    fun object_string2type = git_object_string2type(str : LibC::Char*) : Otype
    fun object_typeisloose = git_object_typeisloose(type : Otype) : LibC::Int
    fun object__size = git_object__size(type : Otype) : LibC::SizeT
    fun object_peel = git_object_peel(peeled : X_Object*, object : X_Object, target_type : Otype) : LibC::Int
    fun object_dup = git_object_dup(dest : X_Object*, source : X_Object) : LibC::Int
    fun blob_lookup = git_blob_lookup(blob : X_Blob*, repo : X_Repository, id : Oid*) : LibC::Int
    type X_Blob = Void*
    fun blob_lookup_prefix = git_blob_lookup_prefix(blob : X_Blob*, repo : X_Repository, id : Oid*, len : LibC::SizeT) : LibC::Int
    fun blob_free = git_blob_free(blob : X_Blob)
    fun blob_id = git_blob_id(blob : X_Blob) : Oid*
    fun blob_owner = git_blob_owner(blob : X_Blob) : X_Repository
    fun blob_rawcontent = git_blob_rawcontent(blob : X_Blob) : Void*
    fun blob_rawsize = git_blob_rawsize(blob : X_Blob) : OffT
    fun blob_filtered_content = git_blob_filtered_content(out : Buf*, blob : X_Blob, as_path : LibC::Char*, check_for_binary_data : LibC::Int) : LibC::Int
    fun blob_create_fromworkdir = git_blob_create_fromworkdir(id : Oid*, repo : X_Repository, relative_path : LibC::Char*) : LibC::Int
    fun blob_create_fromdisk = git_blob_create_fromdisk(id : Oid*, repo : X_Repository, path : LibC::Char*) : LibC::Int
    fun blob_create_fromchunks = git_blob_create_fromchunks(id : Oid*, repo : X_Repository, hintpath : LibC::Char*, callback : BlobChunkCb, payload : Void*) : LibC::Int
    alias BlobChunkCb = (LibC::Char*, LibC::SizeT, Void* -> LibC::Int)
    fun blob_create_frombuffer = git_blob_create_frombuffer(id : Oid*, repo : X_Repository, buffer : Void*, len : LibC::SizeT) : LibC::Int
    fun blob_is_binary = git_blob_is_binary(blob : X_Blob) : LibC::Int
    BlameNormal = 0
    BlameTrackCopiesSameFile = 1
    BlameTrackCopiesSameCommitMoves = 2
    BlameTrackCopiesSameCommitCopies = 4
    BlameTrackCopiesAnyCommitCopies = 8
    BlameFirstParent = 16
    struct BlameOptions
      version : LibC::UInt
      flags : Uint32T
      min_match_characters : Uint16T
      newest_commit : Oid
      oldest_commit : Oid
      min_line : LibC::SizeT
      max_line : LibC::SizeT
    end
    alias Uint16T = LibC::UShort
    fun blame_init_options = git_blame_init_options(opts : BlameOptions*, version : LibC::UInt) : LibC::Int
    struct BlameHunk
      lines_in_hunk : LibC::SizeT
      final_commit_id : Oid
      final_start_line_number : LibC::SizeT
      final_signature : Signature*
      orig_commit_id : Oid
      orig_path : LibC::Char*
      orig_start_line_number : LibC::SizeT
      orig_signature : Signature*
      boundary : LibC::Char
    end
    alias Blame = Void
    fun blame_get_hunk_count = git_blame_get_hunk_count(blame : X_Blame) : Uint32T
    type X_Blame = Void*
    fun blame_get_hunk_byindex = git_blame_get_hunk_byindex(blame : X_Blame, index : Uint32T) : BlameHunk*
    fun blame_get_hunk_byline = git_blame_get_hunk_byline(blame : X_Blame, lineno : LibC::SizeT) : BlameHunk*
    fun blame_file = git_blame_file(out : X_Blame*, repo : X_Repository, path : LibC::Char*, options : BlameOptions*) : LibC::Int
    fun blame_buffer = git_blame_buffer(out : X_Blame*, reference : X_Blame, buffer : LibC::Char*, buffer_len : LibC::SizeT) : LibC::Int
    fun blame_free = git_blame_free(blame : X_Blame)
    fun branch_create = git_branch_create(out : X_Reference*, repo : X_Repository, branch_name : LibC::Char*, target : X_Commit, force : LibC::Int) : LibC::Int
    type X_Commit = Void*
    fun branch_create_from_annotated = git_branch_create_from_annotated(ref_out : X_Reference*, repository : X_Repository, branch_name : LibC::Char*, commit : X_AnnotatedCommit, force : LibC::Int) : LibC::Int
    fun branch_delete = git_branch_delete(branch : X_Reference) : LibC::Int
    alias BranchIterator = Void
    fun branch_iterator_new = git_branch_iterator_new(out : X_BranchIterator*, repo : X_Repository, list_flags : BranchT) : LibC::Int
    type X_BranchIterator = Void*
    enum BranchT
      BranchLocal = 1
      BranchRemote = 2
      BranchAll = 3
    end
    fun branch_next = git_branch_next(out : X_Reference*, out_type : BranchT*, iter : X_BranchIterator) : LibC::Int
    fun branch_iterator_free = git_branch_iterator_free(iter : X_BranchIterator)
    fun branch_move = git_branch_move(out : X_Reference*, branch : X_Reference, new_branch_name : LibC::Char*, force : LibC::Int) : LibC::Int
    fun branch_lookup = git_branch_lookup(out : X_Reference*, repo : X_Repository, branch_name : LibC::Char*, branch_type : BranchT) : LibC::Int
    fun branch_name = git_branch_name(out : LibC::Char**, ref : X_Reference) : LibC::Int
    fun branch_upstream = git_branch_upstream(out : X_Reference*, branch : X_Reference) : LibC::Int
    fun branch_set_upstream = git_branch_set_upstream(branch : X_Reference, upstream_name : LibC::Char*) : LibC::Int
    fun branch_upstream_name = git_branch_upstream_name(out : Buf*, repo : X_Repository, refname : LibC::Char*) : LibC::Int
    fun branch_is_head = git_branch_is_head(branch : X_Reference) : LibC::Int
    fun branch_remote_name = git_branch_remote_name(out : Buf*, repo : X_Repository, canonical_branch_name : LibC::Char*) : LibC::Int
    fun branch_upstream_remote = git_branch_upstream_remote(buf : Buf*, repo : X_Repository, refname : LibC::Char*) : LibC::Int
    fun tree_lookup = git_tree_lookup(out : X_Tree*, repo : X_Repository, id : Oid*) : LibC::Int
    type X_Tree = Void*
    fun tree_lookup_prefix = git_tree_lookup_prefix(out : X_Tree*, repo : X_Repository, id : Oid*, len : LibC::SizeT) : LibC::Int
    fun tree_free = git_tree_free(tree : X_Tree)
    fun tree_id = git_tree_id(tree : X_Tree) : Oid*
    fun tree_owner = git_tree_owner(tree : X_Tree) : X_Repository
    fun tree_entrycount = git_tree_entrycount(tree : X_Tree) : LibC::SizeT
    fun tree_entry_byname = git_tree_entry_byname(tree : X_Tree, filename : LibC::Char*) : X_TreeEntry
    type X_TreeEntry = Void*
    fun tree_entry_byindex = git_tree_entry_byindex(tree : X_Tree, idx : LibC::SizeT) : X_TreeEntry
    fun tree_entry_byid = git_tree_entry_byid(tree : X_Tree, id : Oid*) : X_TreeEntry
    fun tree_entry_bypath = git_tree_entry_bypath(out : X_TreeEntry*, root : X_Tree, path : LibC::Char*) : LibC::Int
    fun tree_entry_dup = git_tree_entry_dup(dest : X_TreeEntry*, source : X_TreeEntry) : LibC::Int
    fun tree_entry_free = git_tree_entry_free(entry : X_TreeEntry)
    fun tree_entry_name = git_tree_entry_name(entry : X_TreeEntry) : LibC::Char*
    fun tree_entry_id = git_tree_entry_id(entry : X_TreeEntry) : Oid*
    fun tree_entry_type = git_tree_entry_type(entry : X_TreeEntry) : Otype
    fun tree_entry_filemode = git_tree_entry_filemode(entry : X_TreeEntry) : FilemodeT
    enum FilemodeT
      FilemodeUnreadable = 0
      FilemodeTree = 16384
      FilemodeBlob = 33188
      FilemodeBlobExecutable = 33261
      FilemodeLink = 40960
      FilemodeCommit = 57344
    end
    fun tree_entry_filemode_raw = git_tree_entry_filemode_raw(entry : X_TreeEntry) : FilemodeT
    fun tree_entry_cmp = git_tree_entry_cmp(e1 : X_TreeEntry, e2 : X_TreeEntry) : LibC::Int
    fun tree_entry_to_object = git_tree_entry_to_object(object_out : X_Object*, repo : X_Repository, entry : X_TreeEntry) : LibC::Int
    fun treebuilder_new = git_treebuilder_new(out : X_Treebuilder*, repo : X_Repository, source : X_Tree) : LibC::Int
    type X_Treebuilder = Void*
    fun treebuilder_clear = git_treebuilder_clear(bld : X_Treebuilder)
    fun treebuilder_entrycount = git_treebuilder_entrycount(bld : X_Treebuilder) : LibC::UInt
    fun treebuilder_free = git_treebuilder_free(bld : X_Treebuilder)
    fun treebuilder_get = git_treebuilder_get(bld : X_Treebuilder, filename : LibC::Char*) : X_TreeEntry
    fun treebuilder_insert = git_treebuilder_insert(out : X_TreeEntry*, bld : X_Treebuilder, filename : LibC::Char*, id : Oid*, filemode : FilemodeT) : LibC::Int
    fun treebuilder_remove = git_treebuilder_remove(bld : X_Treebuilder, filename : LibC::Char*) : LibC::Int
    fun treebuilder_filter = git_treebuilder_filter(bld : X_Treebuilder, filter : TreebuilderFilterCb, payload : Void*)
    alias TreebuilderFilterCb = (X_TreeEntry, Void* -> LibC::Int)
    fun treebuilder_write = git_treebuilder_write(id : Oid*, bld : X_Treebuilder) : LibC::Int
    TreewalkPre = 0
    TreewalkPost = 1
    fun tree_walk = git_tree_walk(tree : X_Tree, mode : TreewalkMode, callback : TreewalkCb, payload : Void*) : LibC::Int
    enum TreewalkMode
      TreewalkPre = 0
      TreewalkPost = 1
    end
    alias TreewalkCb = (LibC::Char*, X_TreeEntry, Void* -> LibC::Int)
    struct Strarray
      strings : LibC::Char**
      count : LibC::SizeT
    end
    fun strarray_free = git_strarray_free(array : Strarray*)
    fun strarray_copy = git_strarray_copy(tgt : Strarray*, src : Strarray*) : LibC::Int
    fun reference_lookup = git_reference_lookup(out : X_Reference*, repo : X_Repository, name : LibC::Char*) : LibC::Int
    fun reference_name_to_id = git_reference_name_to_id(out : Oid*, repo : X_Repository, name : LibC::Char*) : LibC::Int
    fun reference_dwim = git_reference_dwim(out : X_Reference*, repo : X_Repository, shorthand : LibC::Char*) : LibC::Int
    fun reference_symbolic_create_matching = git_reference_symbolic_create_matching(out : X_Reference*, repo : X_Repository, name : LibC::Char*, target : LibC::Char*, force : LibC::Int, current_value : LibC::Char*, log_message : LibC::Char*) : LibC::Int
    fun reference_symbolic_create = git_reference_symbolic_create(out : X_Reference*, repo : X_Repository, name : LibC::Char*, target : LibC::Char*, force : LibC::Int, log_message : LibC::Char*) : LibC::Int
    fun reference_create = git_reference_create(out : X_Reference*, repo : X_Repository, name : LibC::Char*, id : Oid*, force : LibC::Int, log_message : LibC::Char*) : LibC::Int
    fun reference_create_matching = git_reference_create_matching(out : X_Reference*, repo : X_Repository, name : LibC::Char*, id : Oid*, force : LibC::Int, current_id : Oid*, log_message : LibC::Char*) : LibC::Int
    fun reference_target = git_reference_target(ref : X_Reference) : Oid*
    fun reference_target_peel = git_reference_target_peel(ref : X_Reference) : Oid*
    fun reference_symbolic_target = git_reference_symbolic_target(ref : X_Reference) : LibC::Char*
    fun reference_type = git_reference_type(ref : X_Reference) : RefT
    enum RefT
      RefInvalid = 0
      RefOid = 1
      RefSymbolic = 2
      RefListall = 3
    end
    fun reference_name = git_reference_name(ref : X_Reference) : LibC::Char*
    fun reference_resolve = git_reference_resolve(out : X_Reference*, ref : X_Reference) : LibC::Int
    fun reference_owner = git_reference_owner(ref : X_Reference) : X_Repository
    fun reference_symbolic_set_target = git_reference_symbolic_set_target(out : X_Reference*, ref : X_Reference, target : LibC::Char*, log_message : LibC::Char*) : LibC::Int
    fun reference_set_target = git_reference_set_target(out : X_Reference*, ref : X_Reference, id : Oid*, log_message : LibC::Char*) : LibC::Int
    fun reference_rename = git_reference_rename(new_ref : X_Reference*, ref : X_Reference, new_name : LibC::Char*, force : LibC::Int, log_message : LibC::Char*) : LibC::Int
    fun reference_delete = git_reference_delete(ref : X_Reference) : LibC::Int
    fun reference_remove = git_reference_remove(repo : X_Repository, name : LibC::Char*) : LibC::Int
    fun reference_list = git_reference_list(array : Strarray*, repo : X_Repository) : LibC::Int
    fun reference_foreach = git_reference_foreach(repo : X_Repository, callback : ReferenceForeachCb, payload : Void*) : LibC::Int
    alias ReferenceForeachCb = (X_Reference, Void* -> LibC::Int)
    fun reference_foreach_name = git_reference_foreach_name(repo : X_Repository, callback : ReferenceForeachNameCb, payload : Void*) : LibC::Int
    alias ReferenceForeachNameCb = (LibC::Char*, Void* -> LibC::Int)
    fun reference_free = git_reference_free(ref : X_Reference)
    fun reference_cmp = git_reference_cmp(ref1 : X_Reference, ref2 : X_Reference) : LibC::Int
    fun reference_iterator_new = git_reference_iterator_new(out : X_ReferenceIterator*, repo : X_Repository) : LibC::Int
    type X_ReferenceIterator = Void*
    fun reference_iterator_glob_new = git_reference_iterator_glob_new(out : X_ReferenceIterator*, repo : X_Repository, glob : LibC::Char*) : LibC::Int
    fun reference_next = git_reference_next(out : X_Reference*, iter : X_ReferenceIterator) : LibC::Int
    fun reference_next_name = git_reference_next_name(out : LibC::Char**, iter : X_ReferenceIterator) : LibC::Int
    fun reference_iterator_free = git_reference_iterator_free(iter : X_ReferenceIterator)
    fun reference_foreach_glob = git_reference_foreach_glob(repo : X_Repository, glob : LibC::Char*, callback : ReferenceForeachNameCb, payload : Void*) : LibC::Int
    fun reference_has_log = git_reference_has_log(repo : X_Repository, refname : LibC::Char*) : LibC::Int
    fun reference_ensure_log = git_reference_ensure_log(repo : X_Repository, refname : LibC::Char*) : LibC::Int
    fun reference_is_branch = git_reference_is_branch(ref : X_Reference) : LibC::Int
    fun reference_is_remote = git_reference_is_remote(ref : X_Reference) : LibC::Int
    fun reference_is_tag = git_reference_is_tag(ref : X_Reference) : LibC::Int
    fun reference_is_note = git_reference_is_note(ref : X_Reference) : LibC::Int
    RefFormatNormal = 0
    RefFormatAllowOnelevel = 1
    RefFormatRefspecPattern = 2
    RefFormatRefspecShorthand = 4
    fun reference_normalize_name = git_reference_normalize_name(buffer_out : LibC::Char*, buffer_size : LibC::SizeT, name : LibC::Char*, flags : LibC::UInt) : LibC::Int
    fun reference_peel = git_reference_peel(out : X_Object*, ref : X_Reference, type : Otype) : LibC::Int
    fun reference_is_valid_name = git_reference_is_valid_name(refname : LibC::Char*) : LibC::Int
    fun reference_shorthand = git_reference_shorthand(ref : X_Reference) : LibC::Char*
    DiffNormal = 0
    DiffReverse = 1
    DiffIncludeIgnored = 2
    DiffRecurseIgnoredDirs = 4
    DiffIncludeUntracked = 8
    DiffRecurseUntrackedDirs = 16
    DiffIncludeUnmodified = 32
    DiffIncludeTypechange = 64
    DiffIncludeTypechangeTrees = 128
    DiffIgnoreFilemode = 256
    DiffIgnoreSubmodules = 512
    DiffIgnoreCase = 1024
    DiffIncludeCasechange = 2048
    DiffDisablePathspecMatch = 4096
    DiffSkipBinaryCheck = 8192
    DiffEnableFastUntrackedDirs = 16384
    DiffUpdateIndex = 32768
    DiffIncludeUnreadable = 65536
    DiffIncludeUnreadableAsUntracked = 131072
    DiffForceText = 1048576
    DiffForceBinary = 2097152
    DiffIgnoreWhitespace = 4194304
    DiffIgnoreWhitespaceChange = 8388608
    DiffIgnoreWhitespaceEol = 16777216
    DiffShowUntrackedContent = 33554432
    DiffShowUnmodified = 67108864
    DiffPatience = 268435456
    DiffMinimal = 536870912
    DiffShowBinary = 1073741824
    alias Diff = Void
    DiffFlagBinary = 1
    DiffFlagNotBinary = 2
    DiffFlagValidId = 4
    DiffFlagExists = 8
    DeltaUnmodified = 0
    DeltaAdded = 1
    DeltaDeleted = 2
    DeltaModified = 3
    DeltaRenamed = 4
    DeltaCopied = 5
    DeltaIgnored = 6
    DeltaUntracked = 7
    DeltaTypechange = 8
    DeltaUnreadable = 9
    DeltaConflicted = 10
    fun diff_init_options = git_diff_init_options(opts : DiffOptions*, version : LibC::UInt) : LibC::Int
    struct DiffOptions
      version : LibC::UInt
      flags : Uint32T
      ignore_submodules : SubmoduleIgnoreT
      pathspec : Strarray
      notify_cb : DiffNotifyCb
      progress_cb : DiffProgressCb
      payload : Void*
      context_lines : Uint32T
      interhunk_lines : Uint32T
      id_abbrev : Uint16T
      max_size : OffT
      old_prefix : LibC::Char*
      new_prefix : LibC::Char*
    end
    enum SubmoduleIgnoreT
      SubmoduleIgnoreUnspecified = -1
      SubmoduleIgnoreNone = 1
      SubmoduleIgnoreUntracked = 2
      SubmoduleIgnoreDirty = 3
      SubmoduleIgnoreAll = 4
    end
    type X_Diff = Void*
    struct DiffDelta
      status : DeltaT
      flags : Uint32T
      similarity : Uint16T
      nfiles : Uint16T
      old_file : DiffFile
      new_file : DiffFile
    end
    alias DiffNotifyCb = (X_Diff, DiffDelta*, LibC::Char*, Void* -> LibC::Int)
    enum DeltaT
      DeltaUnmodified = 0
      DeltaAdded = 1
      DeltaDeleted = 2
      DeltaModified = 3
      DeltaRenamed = 4
      DeltaCopied = 5
      DeltaIgnored = 6
      DeltaUntracked = 7
      DeltaTypechange = 8
      DeltaUnreadable = 9
      DeltaConflicted = 10
    end
    struct DiffFile
      id : Oid
      path : LibC::Char*
      size : OffT
      flags : Uint32T
      mode : Uint16T
    end
    alias DiffProgressCb = (X_Diff, LibC::Char*, LibC::Char*, Void* -> LibC::Int)
    DiffBinaryNone = 0
    DiffBinaryLiteral = 1
    DiffBinaryDelta = 2
    DiffLineContext = 32
    DiffLineAddition = 43
    DiffLineDeletion = 45
    DiffLineContextEofnl = 61
    DiffLineAddEofnl = 62
    DiffLineDelEofnl = 60
    DiffLineFileHdr = 70
    DiffLineHunkHdr = 72
    DiffLineBinary = 66
    DiffFindByConfig = 0
    DiffFindRenames = 1
    DiffFindRenamesFromRewrites = 2
    DiffFindCopies = 4
    DiffFindCopiesFromUnmodified = 8
    DiffFindRewrites = 16
    DiffBreakRewrites = 32
    DiffFindAndBreakRewrites = 48
    DiffFindForUntracked = 64
    DiffFindAll = 255
    DiffFindIgnoreLeadingWhitespace = 0
    DiffFindIgnoreWhitespace = 4096
    DiffFindDontIgnoreWhitespace = 8192
    DiffFindExactMatchOnly = 16384
    DiffBreakRewritesForRenamesOnly = 32768
    DiffFindRemoveUnmodified = 65536
    fun diff_find_init_options = git_diff_find_init_options(opts : DiffFindOptions*, version : LibC::UInt) : LibC::Int
    struct DiffFindOptions
      version : LibC::UInt
      flags : Uint32T
      rename_threshold : Uint16T
      rename_from_rewrite_threshold : Uint16T
      copy_threshold : Uint16T
      break_rewrite_threshold : Uint16T
      rename_limit : LibC::SizeT
      metric : DiffSimilarityMetric*
    end
    struct DiffSimilarityMetric
      file_signature : (Void**, DiffFile*, LibC::Char*, Void* -> LibC::Int)
      buffer_signature : (Void**, DiffFile*, LibC::Char*, LibC::SizeT, Void* -> LibC::Int)
      free_signature : (Void*, Void* -> Void)
      similarity : (LibC::Int*, Void*, Void*, Void* -> LibC::Int)
      payload : Void*
    end
    fun diff_free = git_diff_free(diff : X_Diff)
    fun diff_tree_to_tree = git_diff_tree_to_tree(diff : X_Diff*, repo : X_Repository, old_tree : X_Tree, new_tree : X_Tree, opts : DiffOptions*) : LibC::Int
    fun diff_tree_to_index = git_diff_tree_to_index(diff : X_Diff*, repo : X_Repository, old_tree : X_Tree, index : X_Index, opts : DiffOptions*) : LibC::Int
    fun diff_index_to_workdir = git_diff_index_to_workdir(diff : X_Diff*, repo : X_Repository, index : X_Index, opts : DiffOptions*) : LibC::Int
    fun diff_tree_to_workdir = git_diff_tree_to_workdir(diff : X_Diff*, repo : X_Repository, old_tree : X_Tree, opts : DiffOptions*) : LibC::Int
    fun diff_tree_to_workdir_with_index = git_diff_tree_to_workdir_with_index(diff : X_Diff*, repo : X_Repository, old_tree : X_Tree, opts : DiffOptions*) : LibC::Int
    fun diff_index_to_index = git_diff_index_to_index(diff : X_Diff*, repo : X_Repository, old_index : X_Index, new_index : X_Index, opts : DiffOptions*) : LibC::Int
    fun diff_merge = git_diff_merge(onto : X_Diff, from : X_Diff) : LibC::Int
    fun diff_find_similar = git_diff_find_similar(diff : X_Diff, options : DiffFindOptions*) : LibC::Int
    fun diff_num_deltas = git_diff_num_deltas(diff : X_Diff) : LibC::SizeT
    fun diff_num_deltas_of_type = git_diff_num_deltas_of_type(diff : X_Diff, type : DeltaT) : LibC::SizeT
    fun diff_get_delta = git_diff_get_delta(diff : X_Diff, idx : LibC::SizeT) : DiffDelta*
    fun diff_is_sorted_icase = git_diff_is_sorted_icase(diff : X_Diff) : LibC::Int
    fun diff_foreach = git_diff_foreach(diff : X_Diff, file_cb : DiffFileCb, binary_cb : DiffBinaryCb, hunk_cb : DiffHunkCb, line_cb : DiffLineCb, payload : Void*) : LibC::Int
    alias DiffFileCb = (DiffDelta*, LibC::Float, Void* -> LibC::Int)
    struct DiffBinary
      old_file : DiffBinaryFile
      new_file : DiffBinaryFile
    end
    alias DiffBinaryCb = (DiffDelta*, DiffBinary*, Void* -> LibC::Int)
    struct DiffBinaryFile
      type : DiffBinaryT
      data : LibC::Char*
      datalen : LibC::SizeT
      inflatedlen : LibC::SizeT
    end
    enum DiffBinaryT
      DiffBinaryNone = 0
      DiffBinaryLiteral = 1
      DiffBinaryDelta = 2
    end
    struct DiffHunk
      old_start : LibC::Int
      old_lines : LibC::Int
      new_start : LibC::Int
      new_lines : LibC::Int
      header_len : LibC::SizeT
      header : LibC::Char[128]
    end
    alias DiffHunkCb = (DiffDelta*, DiffHunk*, Void* -> LibC::Int)
    struct DiffLine
      origin : LibC::Char
      old_lineno : LibC::Int
      new_lineno : LibC::Int
      num_lines : LibC::Int
      content_len : LibC::SizeT
      content_offset : OffT
      content : LibC::Char*
    end
    alias DiffLineCb = (DiffDelta*, DiffHunk*, DiffLine*, Void* -> LibC::Int)
    fun diff_status_char = git_diff_status_char(status : DeltaT) : LibC::Char
    DiffFormatPatch = 1
    DiffFormatPatchHeader = 2
    DiffFormatRaw = 3
    DiffFormatNameOnly = 4
    DiffFormatNameStatus = 5
    fun diff_print = git_diff_print(diff : X_Diff, format : DiffFormatT, print_cb : DiffLineCb, payload : Void*) : LibC::Int
    enum DiffFormatT
      DiffFormatPatch = 1
      DiffFormatPatchHeader = 2
      DiffFormatRaw = 3
      DiffFormatNameOnly = 4
      DiffFormatNameStatus = 5
    end
    fun diff_blobs = git_diff_blobs(old_blob : X_Blob, old_as_path : LibC::Char*, new_blob : X_Blob, new_as_path : LibC::Char*, options : DiffOptions*, file_cb : DiffFileCb, binary_cb : DiffBinaryCb, hunk_cb : DiffHunkCb, line_cb : DiffLineCb, payload : Void*) : LibC::Int
    fun diff_blob_to_buffer = git_diff_blob_to_buffer(old_blob : X_Blob, old_as_path : LibC::Char*, buffer : LibC::Char*, buffer_len : LibC::SizeT, buffer_as_path : LibC::Char*, options : DiffOptions*, file_cb : DiffFileCb, binary_cb : DiffBinaryCb, hunk_cb : DiffHunkCb, line_cb : DiffLineCb, payload : Void*) : LibC::Int
    fun diff_buffers = git_diff_buffers(old_buffer : Void*, old_len : LibC::SizeT, old_as_path : LibC::Char*, new_buffer : Void*, new_len : LibC::SizeT, new_as_path : LibC::Char*, options : DiffOptions*, file_cb : DiffFileCb, binary_cb : DiffBinaryCb, hunk_cb : DiffHunkCb, line_cb : DiffLineCb, payload : Void*) : LibC::Int
    alias DiffStats = Void
    DiffStatsNone = 0
    DiffStatsFull = 1
    DiffStatsShort = 2
    DiffStatsNumber = 4
    DiffStatsIncludeSummary = 8
    fun diff_get_stats = git_diff_get_stats(out : X_DiffStats*, diff : X_Diff) : LibC::Int
    type X_DiffStats = Void*
    fun diff_stats_files_changed = git_diff_stats_files_changed(stats : X_DiffStats) : LibC::SizeT
    fun diff_stats_insertions = git_diff_stats_insertions(stats : X_DiffStats) : LibC::SizeT
    fun diff_stats_deletions = git_diff_stats_deletions(stats : X_DiffStats) : LibC::SizeT
    fun diff_stats_to_buf = git_diff_stats_to_buf(out : Buf*, stats : X_DiffStats, format : DiffStatsFormatT, width : LibC::SizeT) : LibC::Int
    enum DiffStatsFormatT
      DiffStatsNone = 0
      DiffStatsFull = 1
      DiffStatsShort = 2
      DiffStatsNumber = 4
      DiffStatsIncludeSummary = 8
    end
    fun diff_stats_free = git_diff_stats_free(stats : X_DiffStats)
    DiffFormatEmailNone = 0
    DiffFormatEmailExcludeSubjectPatchMarker = 1
    fun diff_format_email = git_diff_format_email(out : Buf*, diff : X_Diff, opts : DiffFormatEmailOptions*) : LibC::Int
    struct DiffFormatEmailOptions
      version : LibC::UInt
      flags : DiffFormatEmailFlagsT
      patch_no : LibC::SizeT
      total_patches : LibC::SizeT
      id : Oid*
      summary : LibC::Char*
      body : LibC::Char*
      author : Signature*
    end
    enum DiffFormatEmailFlagsT
      DiffFormatEmailNone = 0
      DiffFormatEmailExcludeSubjectPatchMarker = 1
    end
    fun diff_commit_as_email = git_diff_commit_as_email(out : Buf*, repo : X_Repository, commit : X_Commit, patch_no : LibC::SizeT, total_patches : LibC::SizeT, flags : DiffFormatEmailFlagsT, diff_opts : DiffOptions*) : LibC::Int
    fun diff_format_email_init_options = git_diff_format_email_init_options(opts : DiffFormatEmailOptions*, version : LibC::UInt) : LibC::Int
    CheckoutNone = 0
    CheckoutSafe = 1
    CheckoutForce = 2
    CheckoutRecreateMissing = 4
    CheckoutAllowConflicts = 16
    CheckoutRemoveUntracked = 32
    CheckoutRemoveIgnored = 64
    CheckoutUpdateOnly = 128
    CheckoutDontUpdateIndex = 256
    CheckoutNoRefresh = 512
    CheckoutSkipUnmerged = 1024
    CheckoutUseOurs = 2048
    CheckoutUseTheirs = 4096
    CheckoutDisablePathspecMatch = 8192
    CheckoutSkipLockedDirectories = 262144
    CheckoutDontOverwriteIgnored = 524288
    CheckoutConflictStyleMerge = 1048576
    CheckoutConflictStyleDiff3 = 2097152
    CheckoutDontRemoveExisting = 4194304
    CheckoutDontWriteIndex = 8388608
    CheckoutUpdateSubmodules = 65536
    CheckoutUpdateSubmodulesIfChanged = 131072
    CheckoutNotifyNone = 0
    CheckoutNotifyConflict = 1
    CheckoutNotifyDirty = 2
    CheckoutNotifyUpdated = 4
    CheckoutNotifyUntracked = 8
    CheckoutNotifyIgnored = 16
    CheckoutNotifyAll = 65535
    struct CheckoutOptions
      version : LibC::UInt
      checkout_strategy : LibC::UInt
      disable_filters : LibC::Int
      dir_mode : LibC::UInt
      file_mode : LibC::UInt
      file_open_flags : LibC::Int
      notify_flags : LibC::UInt
      notify_cb : CheckoutNotifyCb
      notify_payload : Void*
      progress_cb : CheckoutProgressCb
      progress_payload : Void*
      paths : Strarray
      baseline : X_Tree
      baseline_index : X_Index
      target_directory : LibC::Char*
      ancestor_label : LibC::Char*
      our_label : LibC::Char*
      their_label : LibC::Char*
      perfdata_cb : CheckoutPerfdataCb
      perfdata_payload : Void*
    end
    enum CheckoutNotifyT
      CheckoutNotifyNone = 0
      CheckoutNotifyConflict = 1
      CheckoutNotifyDirty = 2
      CheckoutNotifyUpdated = 4
      CheckoutNotifyUntracked = 8
      CheckoutNotifyIgnored = 16
      CheckoutNotifyAll = 65535
    end
    alias CheckoutNotifyCb = (CheckoutNotifyT, LibC::Char*, DiffFile*, DiffFile*, DiffFile*, Void* -> LibC::Int)
    alias CheckoutProgressCb = (LibC::Char*, LibC::SizeT, LibC::SizeT, Void* -> Void)
    struct CheckoutPerfdata
      mkdir_calls : LibC::SizeT
      stat_calls : LibC::SizeT
      chmod_calls : LibC::SizeT
    end
    alias CheckoutPerfdataCb = (CheckoutPerfdata*, Void* -> Void)
    fun checkout_init_options = git_checkout_init_options(opts : CheckoutOptions*, version : LibC::UInt) : LibC::Int
    fun checkout_head = git_checkout_head(repo : X_Repository, opts : CheckoutOptions*) : LibC::Int
    fun checkout_index = git_checkout_index(repo : X_Repository, index : X_Index, opts : CheckoutOptions*) : LibC::Int
    fun checkout_tree = git_checkout_tree(repo : X_Repository, treeish : X_Object, opts : CheckoutOptions*) : LibC::Int
    struct Oidarray
      ids : Oid*
      count : LibC::SizeT
    end
    fun oidarray_free = git_oidarray_free(array : Oidarray*)
    alias Indexer = Void
    fun indexer_new = git_indexer_new(out : X_Indexer*, path : LibC::Char*, mode : LibC::UInt, odb : X_Odb, progress_cb : TransferProgressCb, progress_cb_payload : Void*) : LibC::Int
    type X_Indexer = Void*
    fun indexer_append = git_indexer_append(idx : X_Indexer, data : Void*, size : LibC::SizeT, stats : TransferProgress*) : LibC::Int
    fun indexer_commit = git_indexer_commit(idx : X_Indexer, stats : TransferProgress*) : LibC::Int
    fun indexer_hash = git_indexer_hash(idx : X_Indexer) : Oid*
    fun indexer_free = git_indexer_free(idx : X_Indexer)
    struct IndexEntry
      ctime : IndexTime
      mtime : IndexTime
      dev : Uint32T
      ino : Uint32T
      mode : Uint32T
      uid : Uint32T
      gid : Uint32T
      file_size : Uint32T
      id : Oid
      flags : Uint16T
      flags_extended : Uint16T
      path : LibC::Char*
    end
    struct IndexTime
      seconds : Int32T
      nanoseconds : Uint32T
    end
    alias Int32T = LibC::Int
    IdxentryExtended = 16384
    IdxentryValid = 32768
    IdxentryIntentToAdd = 8192
    IdxentrySkipWorktree = 16384
    IdxentryExtended2 = 32768
    IdxentryExtendedFlags = 24576
    IdxentryUpdate = 1
    IdxentryRemove = 2
    IdxentryUptodate = 4
    IdxentryAdded = 8
    IdxentryHashed = 16
    IdxentryUnhashed = 32
    IdxentryWtRemove = 64
    IdxentryConflicted = 128
    IdxentryUnpacked = 256
    IdxentryNewSkipWorktree = 512
    IndexcapIgnoreCase = 1
    IndexcapNoFilemode = 2
    IndexcapNoSymlinks = 4
    IndexcapFromOwner = -1
    IndexAddDefault = 0
    IndexAddForce = 1
    IndexAddDisablePathspecMatch = 2
    IndexAddCheckPathspec = 4
    IndexStageAny = -1
    IndexStageNormal = 0
    IndexStageAncestor = 1
    IndexStageOurs = 2
    IndexStageTheirs = 3
    fun index_open = git_index_open(out : X_Index*, index_path : LibC::Char*) : LibC::Int
    fun index_new = git_index_new(out : X_Index*) : LibC::Int
    fun index_free = git_index_free(index : X_Index)
    fun index_owner = git_index_owner(index : X_Index) : X_Repository
    fun index_caps = git_index_caps(index : X_Index) : LibC::Int
    fun index_set_caps = git_index_set_caps(index : X_Index, caps : LibC::Int) : LibC::Int
    fun index_read = git_index_read(index : X_Index, force : LibC::Int) : LibC::Int
    fun index_write = git_index_write(index : X_Index) : LibC::Int
    fun index_path = git_index_path(index : X_Index) : LibC::Char*
    fun index_checksum = git_index_checksum(index : X_Index) : Oid*
    fun index_read_tree = git_index_read_tree(index : X_Index, tree : X_Tree) : LibC::Int
    fun index_write_tree = git_index_write_tree(out : Oid*, index : X_Index) : LibC::Int
    fun index_write_tree_to = git_index_write_tree_to(out : Oid*, index : X_Index, repo : X_Repository) : LibC::Int
    fun index_entrycount = git_index_entrycount(index : X_Index) : LibC::SizeT
    fun index_clear = git_index_clear(index : X_Index) : LibC::Int
    fun index_get_byindex = git_index_get_byindex(index : X_Index, n : LibC::SizeT) : IndexEntry*
    fun index_get_bypath = git_index_get_bypath(index : X_Index, path : LibC::Char*, stage : LibC::Int) : IndexEntry*
    fun index_remove = git_index_remove(index : X_Index, path : LibC::Char*, stage : LibC::Int) : LibC::Int
    fun index_remove_directory = git_index_remove_directory(index : X_Index, dir : LibC::Char*, stage : LibC::Int) : LibC::Int
    fun index_add = git_index_add(index : X_Index, source_entry : IndexEntry*) : LibC::Int
    fun index_entry_stage = git_index_entry_stage(entry : IndexEntry*) : LibC::Int
    fun index_entry_is_conflict = git_index_entry_is_conflict(entry : IndexEntry*) : LibC::Int
    fun index_add_bypath = git_index_add_bypath(index : X_Index, path : LibC::Char*) : LibC::Int
    fun index_add_frombuffer = git_index_add_frombuffer(index : X_Index, entry : IndexEntry*, buffer : Void*, len : LibC::SizeT) : LibC::Int
    fun index_remove_bypath = git_index_remove_bypath(index : X_Index, path : LibC::Char*) : LibC::Int
    fun index_add_all = git_index_add_all(index : X_Index, pathspec : Strarray*, flags : LibC::UInt, callback : IndexMatchedPathCb, payload : Void*) : LibC::Int
    alias IndexMatchedPathCb = (LibC::Char*, LibC::Char*, Void* -> LibC::Int)
    fun index_remove_all = git_index_remove_all(index : X_Index, pathspec : Strarray*, callback : IndexMatchedPathCb, payload : Void*) : LibC::Int
    fun index_update_all = git_index_update_all(index : X_Index, pathspec : Strarray*, callback : IndexMatchedPathCb, payload : Void*) : LibC::Int
    fun index_find = git_index_find(at_pos : LibC::SizeT*, index : X_Index, path : LibC::Char*) : LibC::Int
    fun index_find_prefix = git_index_find_prefix(at_pos : LibC::SizeT*, index : X_Index, prefix : LibC::Char*) : LibC::Int
    fun index_conflict_add = git_index_conflict_add(index : X_Index, ancestor_entry : IndexEntry*, our_entry : IndexEntry*, their_entry : IndexEntry*) : LibC::Int
    fun index_conflict_get = git_index_conflict_get(ancestor_out : IndexEntry**, our_out : IndexEntry**, their_out : IndexEntry**, index : X_Index, path : LibC::Char*) : LibC::Int
    fun index_conflict_remove = git_index_conflict_remove(index : X_Index, path : LibC::Char*) : LibC::Int
    fun index_conflict_cleanup = git_index_conflict_cleanup(index : X_Index) : LibC::Int
    fun index_has_conflicts = git_index_has_conflicts(index : X_Index) : LibC::Int
    fun index_conflict_iterator_new = git_index_conflict_iterator_new(iterator_out : X_IndexConflictIterator*, index : X_Index) : LibC::Int
    type X_IndexConflictIterator = Void*
    fun index_conflict_next = git_index_conflict_next(ancestor_out : IndexEntry**, our_out : IndexEntry**, their_out : IndexEntry**, iterator : X_IndexConflictIterator) : LibC::Int
    fun index_conflict_iterator_free = git_index_conflict_iterator_free(iterator : X_IndexConflictIterator)
    fun merge_file_init_input = git_merge_file_init_input(opts : MergeFileInput*, version : LibC::UInt) : LibC::Int
    struct MergeFileInput
      version : LibC::UInt
      ptr : LibC::Char*
      size : LibC::SizeT
      path : LibC::Char*
      mode : LibC::UInt
    end
    MergeFindRenames = 1
    MergeFailOnConflict = 2
    MergeSkipReuc = 4
    MergeNoRecursive = 8
    MergeFileFavorNormal = 0
    MergeFileFavorOurs = 1
    MergeFileFavorTheirs = 2
    MergeFileFavorUnion = 3
    MergeFileDefault = 0
    MergeFileStyleMerge = 1
    MergeFileStyleDiff3 = 2
    MergeFileSimplifyAlnum = 4
    MergeFileIgnoreWhitespace = 8
    MergeFileIgnoreWhitespaceChange = 16
    MergeFileIgnoreWhitespaceEol = 32
    MergeFileDiffPatience = 64
    MergeFileDiffMinimal = 128
    fun merge_file_init_options = git_merge_file_init_options(opts : MergeFileOptions*, version : LibC::UInt) : LibC::Int
    struct MergeFileOptions
      version : LibC::UInt
      ancestor_label : LibC::Char*
      our_label : LibC::Char*
      their_label : LibC::Char*
      favor : MergeFileFavorT
      flags : MergeFileFlagT
    end
    enum MergeFileFavorT
      MergeFileFavorNormal = 0
      MergeFileFavorOurs = 1
      MergeFileFavorTheirs = 2
      MergeFileFavorUnion = 3
    end
    enum MergeFileFlagT
      MergeFileDefault = 0
      MergeFileStyleMerge = 1
      MergeFileStyleDiff3 = 2
      MergeFileSimplifyAlnum = 4
      MergeFileIgnoreWhitespace = 8
      MergeFileIgnoreWhitespaceChange = 16
      MergeFileIgnoreWhitespaceEol = 32
      MergeFileDiffPatience = 64
      MergeFileDiffMinimal = 128
    end
    fun merge_init_options = git_merge_init_options(opts : MergeOptions*, version : LibC::UInt) : LibC::Int
    struct MergeOptions
      version : LibC::UInt
      flags : MergeFlagT
      rename_threshold : LibC::UInt
      target_limit : LibC::UInt
      metric : DiffSimilarityMetric*
      recursion_limit : LibC::UInt
      file_favor : MergeFileFavorT
      file_flags : MergeFileFlagT
    end
    enum MergeFlagT
      MergeFindRenames = 1
      MergeFailOnConflict = 2
      MergeSkipReuc = 4
      MergeNoRecursive = 8
    end
    MergeAnalysisNone = 0
    MergeAnalysisNormal = 1
    MergeAnalysisUpToDate = 2
    MergeAnalysisFastforward = 4
    MergeAnalysisUnborn = 8
    MergePreferenceNone = 0
    MergePreferenceNoFastforward = 1
    MergePreferenceFastforwardOnly = 2
    fun merge_analysis = git_merge_analysis(analysis_out : MergeAnalysisT*, preference_out : MergePreferenceT*, repo : X_Repository, their_heads : X_AnnotatedCommit*, their_heads_len : LibC::SizeT) : LibC::Int
    enum MergeAnalysisT
      MergeAnalysisNone = 0
      MergeAnalysisNormal = 1
      MergeAnalysisUpToDate = 2
      MergeAnalysisFastforward = 4
      MergeAnalysisUnborn = 8
    end
    enum MergePreferenceT
      MergePreferenceNone = 0
      MergePreferenceNoFastforward = 1
      MergePreferenceFastforwardOnly = 2
    end
    fun merge_base = git_merge_base(out : Oid*, repo : X_Repository, one : Oid*, two : Oid*) : LibC::Int
    fun merge_bases = git_merge_bases(out : Oidarray*, repo : X_Repository, one : Oid*, two : Oid*) : LibC::Int
    fun merge_base_many = git_merge_base_many(out : Oid*, repo : X_Repository, length : LibC::SizeT, input_array : Oid*) : LibC::Int
    fun merge_bases_many = git_merge_bases_many(out : Oidarray*, repo : X_Repository, length : LibC::SizeT, input_array : Oid*) : LibC::Int
    fun merge_base_octopus = git_merge_base_octopus(out : Oid*, repo : X_Repository, length : LibC::SizeT, input_array : Oid*) : LibC::Int
    fun merge_file = git_merge_file(out : MergeFileResult*, ancestor : MergeFileInput*, ours : MergeFileInput*, theirs : MergeFileInput*, opts : MergeFileOptions*) : LibC::Int
    struct MergeFileResult
      automergeable : LibC::UInt
      path : LibC::Char*
      mode : LibC::UInt
      ptr : LibC::Char*
      len : LibC::SizeT
    end
    fun merge_file_from_index = git_merge_file_from_index(out : MergeFileResult*, repo : X_Repository, ancestor : IndexEntry*, ours : IndexEntry*, theirs : IndexEntry*, opts : MergeFileOptions*) : LibC::Int
    fun merge_file_result_free = git_merge_file_result_free(result : MergeFileResult*)
    fun merge_trees = git_merge_trees(out : X_Index*, repo : X_Repository, ancestor_tree : X_Tree, our_tree : X_Tree, their_tree : X_Tree, opts : MergeOptions*) : LibC::Int
    fun merge_commits = git_merge_commits(out : X_Index*, repo : X_Repository, our_commit : X_Commit, their_commit : X_Commit, opts : MergeOptions*) : LibC::Int
    fun merge = git_merge(repo : X_Repository, their_heads : X_AnnotatedCommit*, their_heads_len : LibC::SizeT, merge_opts : MergeOptions*, checkout_opts : CheckoutOptions*) : LibC::Int
    fun cherrypick_init_options = git_cherrypick_init_options(opts : CherrypickOptions*, version : LibC::UInt) : LibC::Int
    struct CherrypickOptions
      version : LibC::UInt
      mainline : LibC::UInt
      merge_opts : MergeOptions
      checkout_opts : CheckoutOptions
    end
    fun cherrypick_commit = git_cherrypick_commit(out : X_Index*, repo : X_Repository, cherrypick_commit : X_Commit, our_commit : X_Commit, mainline : LibC::UInt, merge_options : MergeOptions*) : LibC::Int
    fun cherrypick = git_cherrypick(repo : X_Repository, commit : X_Commit, cherrypick_options : CherrypickOptions*) : LibC::Int
    DirectionFetch = 0
    DirectionPush = 1
    fun refspec_src = git_refspec_src(refspec : X_Refspec) : LibC::Char*
    type X_Refspec = Void*
    fun refspec_dst = git_refspec_dst(refspec : X_Refspec) : LibC::Char*
    fun refspec_string = git_refspec_string(refspec : X_Refspec) : LibC::Char*
    fun refspec_force = git_refspec_force(refspec : X_Refspec) : LibC::Int
    fun refspec_direction = git_refspec_direction(spec : X_Refspec) : Direction
    enum Direction
      DirectionFetch = 0
      DirectionPush = 1
    end
    fun refspec_src_matches = git_refspec_src_matches(refspec : X_Refspec, refname : LibC::Char*) : LibC::Int
    fun refspec_dst_matches = git_refspec_dst_matches(refspec : X_Refspec, refname : LibC::Char*) : LibC::Int
    fun refspec_transform = git_refspec_transform(out : Buf*, spec : X_Refspec, name : LibC::Char*) : LibC::Int
    fun refspec_rtransform = git_refspec_rtransform(out : Buf*, spec : X_Refspec, name : LibC::Char*) : LibC::Int
    CertSshMd5 = 1
    CertSshSha1 = 2
    CredtypeUserpassPlaintext = 1
    CredtypeSshKey = 2
    CredtypeSshCustom = 4
    CredtypeDefault = 8
    CredtypeSshInteractive = 16
    CredtypeUsername = 32
    CredtypeSshMemory = 64
    struct CredSshKey
      parent : Cred
      username : LibC::Char*
      publickey : LibC::Char*
      privatekey : LibC::Char*
      passphrase : LibC::Char*
    end
    struct CredSshInteractive
      parent : Cred
      username : LibC::Char*
      prompt_callback : CredSshInteractiveCallback
      payload : Void*
    end
    type Libssh2UserauthKbdintPrompt = Void*
    type Libssh2UserauthKbdintResponse = Void*
    alias CredSshInteractiveCallback = (LibC::Char*, LibC::Int, LibC::Char*, LibC::Int, LibC::Int, Libssh2UserauthKbdintPrompt, Libssh2UserauthKbdintResponse, Void** -> Void)
    struct CredSshCustom
      parent : Cred
      username : LibC::Char*
      publickey : LibC::Char*
      publickey_len : LibC::SizeT
      sign_callback : CredSignCallback
      payload : Void*
    end
    type Libssh2Session = Void*
    alias CredSignCallback = (Libssh2Session, UInt8**, LibC::SizeT*, UInt8*, LibC::SizeT, Void** -> LibC::Int)
    struct CredUsername
      parent : Cred
      username : LibC::Char[1]
    end
    fun cred_has_username = git_cred_has_username(cred : Cred*) : LibC::Int
    fun cred_userpass_plaintext_new = git_cred_userpass_plaintext_new(out : Cred**, username : LibC::Char*, password : LibC::Char*) : LibC::Int
    fun cred_ssh_key_new = git_cred_ssh_key_new(out : Cred**, username : LibC::Char*, publickey : LibC::Char*, privatekey : LibC::Char*, passphrase : LibC::Char*) : LibC::Int
    fun cred_ssh_interactive_new = git_cred_ssh_interactive_new(out : Cred**, username : LibC::Char*, prompt_callback : CredSshInteractiveCallback, payload : Void*) : LibC::Int
    fun cred_ssh_key_from_agent = git_cred_ssh_key_from_agent(out : Cred**, username : LibC::Char*) : LibC::Int
    fun cred_ssh_custom_new = git_cred_ssh_custom_new(out : Cred**, username : LibC::Char*, publickey : LibC::Char*, publickey_len : LibC::SizeT, sign_callback : CredSignCallback, payload : Void*) : LibC::Int
    fun cred_default_new = git_cred_default_new(out : Cred**) : LibC::Int
    fun cred_username_new = git_cred_username_new(cred : Cred**, username : LibC::Char*) : LibC::Int
    fun cred_ssh_key_memory_new = git_cred_ssh_key_memory_new(out : Cred**, username : LibC::Char*, publickey : LibC::Char*, privatekey : LibC::Char*, passphrase : LibC::Char*) : LibC::Int
    fun cred_free = git_cred_free(cred : Cred*)
    PackbuilderAddingObjects = 0
    PackbuilderDeltafication = 1
    fun packbuilder_new = git_packbuilder_new(out : X_Packbuilder*, repo : X_Repository) : LibC::Int
    type X_Packbuilder = Void*
    fun packbuilder_set_threads = git_packbuilder_set_threads(pb : X_Packbuilder, n : LibC::UInt) : LibC::UInt
    fun packbuilder_insert = git_packbuilder_insert(pb : X_Packbuilder, id : Oid*, name : LibC::Char*) : LibC::Int
    fun packbuilder_insert_tree = git_packbuilder_insert_tree(pb : X_Packbuilder, id : Oid*) : LibC::Int
    fun packbuilder_insert_commit = git_packbuilder_insert_commit(pb : X_Packbuilder, id : Oid*) : LibC::Int
    fun packbuilder_insert_walk = git_packbuilder_insert_walk(pb : X_Packbuilder, walk : X_Revwalk) : LibC::Int
    type X_Revwalk = Void*
    fun packbuilder_insert_recur = git_packbuilder_insert_recur(pb : X_Packbuilder, id : Oid*, name : LibC::Char*) : LibC::Int
    fun packbuilder_write_buf = git_packbuilder_write_buf(buf : Buf*, pb : X_Packbuilder) : LibC::Int
    fun packbuilder_write = git_packbuilder_write(pb : X_Packbuilder, path : LibC::Char*, mode : LibC::UInt, progress_cb : TransferProgressCb, progress_cb_payload : Void*) : LibC::Int
    fun packbuilder_hash = git_packbuilder_hash(pb : X_Packbuilder) : Oid*
    fun packbuilder_foreach = git_packbuilder_foreach(pb : X_Packbuilder, cb : PackbuilderForeachCb, payload : Void*) : LibC::Int
    alias PackbuilderForeachCb = (Void*, LibC::SizeT, Void* -> LibC::Int)
    fun packbuilder_object_count = git_packbuilder_object_count(pb : X_Packbuilder) : Uint32T
    fun packbuilder_written = git_packbuilder_written(pb : X_Packbuilder) : Uint32T
    fun packbuilder_set_callbacks = git_packbuilder_set_callbacks(pb : X_Packbuilder, progress_cb : PackbuilderProgress, progress_cb_payload : Void*) : LibC::Int
    fun packbuilder_free = git_packbuilder_free(pb : X_Packbuilder)
    fun remote_create = git_remote_create(out : X_Remote*, repo : X_Repository, name : LibC::Char*, url : LibC::Char*) : LibC::Int
    fun remote_create_with_fetchspec = git_remote_create_with_fetchspec(out : X_Remote*, repo : X_Repository, name : LibC::Char*, url : LibC::Char*, fetch : LibC::Char*) : LibC::Int
    fun remote_create_anonymous = git_remote_create_anonymous(out : X_Remote*, repo : X_Repository, url : LibC::Char*) : LibC::Int
    fun remote_lookup = git_remote_lookup(out : X_Remote*, repo : X_Repository, name : LibC::Char*) : LibC::Int
    fun remote_dup = git_remote_dup(dest : X_Remote*, source : X_Remote) : LibC::Int
    fun remote_owner = git_remote_owner(remote : X_Remote) : X_Repository
    fun remote_name = git_remote_name(remote : X_Remote) : LibC::Char*
    fun remote_url = git_remote_url(remote : X_Remote) : LibC::Char*
    fun remote_pushurl = git_remote_pushurl(remote : X_Remote) : LibC::Char*
    fun remote_set_url = git_remote_set_url(repo : X_Repository, remote : LibC::Char*, url : LibC::Char*) : LibC::Int
    fun remote_set_pushurl = git_remote_set_pushurl(repo : X_Repository, remote : LibC::Char*, url : LibC::Char*) : LibC::Int
    fun remote_add_fetch = git_remote_add_fetch(repo : X_Repository, remote : LibC::Char*, refspec : LibC::Char*) : LibC::Int
    fun remote_get_fetch_refspecs = git_remote_get_fetch_refspecs(array : Strarray*, remote : X_Remote) : LibC::Int
    fun remote_add_push = git_remote_add_push(repo : X_Repository, remote : LibC::Char*, refspec : LibC::Char*) : LibC::Int
    fun remote_get_push_refspecs = git_remote_get_push_refspecs(array : Strarray*, remote : X_Remote) : LibC::Int
    fun remote_refspec_count = git_remote_refspec_count(remote : X_Remote) : LibC::SizeT
    fun remote_get_refspec = git_remote_get_refspec(remote : X_Remote, n : LibC::SizeT) : X_Refspec
    fun remote_connect = git_remote_connect(remote : X_Remote, direction : Direction, callbacks : RemoteCallbacks*, custom_headers : Strarray*) : LibC::Int
    fun remote_ls = git_remote_ls(out : RemoteHead***, size : LibC::SizeT*, remote : X_Remote) : LibC::Int
    fun remote_connected = git_remote_connected(remote : X_Remote) : LibC::Int
    fun remote_stop = git_remote_stop(remote : X_Remote)
    fun remote_disconnect = git_remote_disconnect(remote : X_Remote)
    fun remote_free = git_remote_free(remote : X_Remote)
    fun remote_list = git_remote_list(out : Strarray*, repo : X_Repository) : LibC::Int
    fun remote_init_callbacks = git_remote_init_callbacks(opts : RemoteCallbacks*, version : LibC::UInt) : LibC::Int
    FetchPruneUnspecified = 0
    FetchPrune = 1
    FetchNoPrune = 2
    RemoteDownloadTagsUnspecified = 0
    RemoteDownloadTagsAuto = 1
    RemoteDownloadTagsNone = 2
    RemoteDownloadTagsAll = 3
    fun fetch_init_options = git_fetch_init_options(opts : FetchOptions*, version : LibC::UInt) : LibC::Int
    struct FetchOptions
      version : LibC::Int
      callbacks : RemoteCallbacks
      prune : FetchPruneT
      update_fetchhead : LibC::Int
      download_tags : RemoteAutotagOptionT
      custom_headers : Strarray
    end
    enum FetchPruneT
      FetchPruneUnspecified = 0
      FetchPrune = 1
      FetchNoPrune = 2
    end
    enum RemoteAutotagOptionT
      RemoteDownloadTagsUnspecified = 0
      RemoteDownloadTagsAuto = 1
      RemoteDownloadTagsNone = 2
      RemoteDownloadTagsAll = 3
    end
    fun push_init_options = git_push_init_options(opts : PushOptions*, version : LibC::UInt) : LibC::Int
    struct PushOptions
      version : LibC::UInt
      pb_parallelism : LibC::UInt
      callbacks : RemoteCallbacks
      custom_headers : Strarray
    end
    fun remote_download = git_remote_download(remote : X_Remote, refspecs : Strarray*, opts : FetchOptions*) : LibC::Int
    fun remote_upload = git_remote_upload(remote : X_Remote, refspecs : Strarray*, opts : PushOptions*) : LibC::Int
    fun remote_update_tips = git_remote_update_tips(remote : X_Remote, callbacks : RemoteCallbacks*, update_fetchhead : LibC::Int, download_tags : RemoteAutotagOptionT, reflog_message : LibC::Char*) : LibC::Int
    fun remote_fetch = git_remote_fetch(remote : X_Remote, refspecs : Strarray*, opts : FetchOptions*, reflog_message : LibC::Char*) : LibC::Int
    fun remote_prune = git_remote_prune(remote : X_Remote, callbacks : RemoteCallbacks*) : LibC::Int
    fun remote_push = git_remote_push(remote : X_Remote, refspecs : Strarray*, opts : PushOptions*) : LibC::Int
    fun remote_stats = git_remote_stats(remote : X_Remote) : TransferProgress*
    fun remote_autotag = git_remote_autotag(remote : X_Remote) : RemoteAutotagOptionT
    fun remote_set_autotag = git_remote_set_autotag(repo : X_Repository, remote : LibC::Char*, value : RemoteAutotagOptionT) : LibC::Int
    fun remote_prune_refs = git_remote_prune_refs(remote : X_Remote) : LibC::Int
    fun remote_rename = git_remote_rename(problems : Strarray*, repo : X_Repository, name : LibC::Char*, new_name : LibC::Char*) : LibC::Int
    fun remote_is_valid_name = git_remote_is_valid_name(remote_name : LibC::Char*) : LibC::Int
    fun remote_delete = git_remote_delete(repo : X_Repository, name : LibC::Char*) : LibC::Int
    fun remote_default_branch = git_remote_default_branch(out : Buf*, remote : X_Remote) : LibC::Int
    CloneLocalAuto = 0
    CloneLocal = 1
    CloneNoLocal = 2
    CloneLocalNoLinks = 3
    struct CloneOptions
      version : LibC::UInt
      checkout_opts : CheckoutOptions
      fetch_opts : FetchOptions
      bare : LibC::Int
      local : CloneLocalT
      checkout_branch : LibC::Char*
      repository_cb : RepositoryCreateCb
      repository_cb_payload : Void*
      remote_cb : RemoteCreateCb
      remote_cb_payload : Void*
    end
    enum CloneLocalT
      CloneLocalAuto = 0
      CloneLocal = 1
      CloneNoLocal = 2
      CloneLocalNoLinks = 3
    end
    alias RepositoryCreateCb = (X_Repository*, LibC::Char*, LibC::Int, Void* -> LibC::Int)
    alias RemoteCreateCb = (X_Remote*, X_Repository, LibC::Char*, LibC::Char*, Void* -> LibC::Int)
    fun clone_init_options = git_clone_init_options(opts : CloneOptions*, version : LibC::UInt) : LibC::Int
    fun clone = git_clone(out : X_Repository*, url : LibC::Char*, local_path : LibC::Char*, options : CloneOptions*) : LibC::Int
    fun commit_lookup = git_commit_lookup(commit : X_Commit*, repo : X_Repository, id : Oid*) : LibC::Int
    fun commit_lookup_prefix = git_commit_lookup_prefix(commit : X_Commit*, repo : X_Repository, id : Oid*, len : LibC::SizeT) : LibC::Int
    fun commit_free = git_commit_free(commit : X_Commit)
    fun commit_id = git_commit_id(commit : X_Commit) : Oid*
    fun commit_owner = git_commit_owner(commit : X_Commit) : X_Repository
    fun commit_message_encoding = git_commit_message_encoding(commit : X_Commit) : LibC::Char*
    fun commit_message = git_commit_message(commit : X_Commit) : LibC::Char*
    fun commit_message_raw = git_commit_message_raw(commit : X_Commit) : LibC::Char*
    fun commit_summary = git_commit_summary(commit : X_Commit) : LibC::Char*
    fun commit_body = git_commit_body(commit : X_Commit) : LibC::Char*
    fun commit_time = git_commit_time(commit : X_Commit) : TimeT
    fun commit_time_offset = git_commit_time_offset(commit : X_Commit) : LibC::Int
    fun commit_committer = git_commit_committer(commit : X_Commit) : Signature*
    fun commit_author = git_commit_author(commit : X_Commit) : Signature*
    fun commit_raw_header = git_commit_raw_header(commit : X_Commit) : LibC::Char*
    fun commit_tree = git_commit_tree(tree_out : X_Tree*, commit : X_Commit) : LibC::Int
    fun commit_tree_id = git_commit_tree_id(commit : X_Commit) : Oid*
    fun commit_parentcount = git_commit_parentcount(commit : X_Commit) : LibC::UInt
    fun commit_parent = git_commit_parent(out : X_Commit*, commit : X_Commit, n : LibC::UInt) : LibC::Int
    fun commit_parent_id = git_commit_parent_id(commit : X_Commit, n : LibC::UInt) : Oid*
    fun commit_nth_gen_ancestor = git_commit_nth_gen_ancestor(ancestor : X_Commit*, commit : X_Commit, n : LibC::UInt) : LibC::Int
    fun commit_header_field = git_commit_header_field(out : Buf*, commit : X_Commit, field : LibC::Char*) : LibC::Int
    fun commit_extract_signature = git_commit_extract_signature(signature : Buf*, signed_data : Buf*, repo : X_Repository, commit_id : Oid*, field : LibC::Char*) : LibC::Int
    fun commit_create = git_commit_create(id : Oid*, repo : X_Repository, update_ref : LibC::Char*, author : Signature*, committer : Signature*, message_encoding : LibC::Char*, message : LibC::Char*, tree : X_Tree, parent_count : LibC::SizeT, parents : X_Commit*) : LibC::Int
    fun commit_create_v = git_commit_create_v(id : Oid*, repo : X_Repository, update_ref : LibC::Char*, author : Signature*, committer : Signature*, message_encoding : LibC::Char*, message : LibC::Char*, tree : X_Tree, parent_count : LibC::SizeT, ...) : LibC::Int
    fun commit_amend = git_commit_amend(id : Oid*, commit_to_amend : X_Commit, update_ref : LibC::Char*, author : Signature*, committer : Signature*, message_encoding : LibC::Char*, message : LibC::Char*, tree : X_Tree) : LibC::Int
    ConfigLevelProgramdata = 1
    ConfigLevelSystem = 2
    ConfigLevelXdg = 3
    ConfigLevelGlobal = 4
    ConfigLevelLocal = 5
    ConfigLevelApp = 6
    ConfigHighestLevel = -1
    struct ConfigEntry
      name : LibC::Char*
      value : LibC::Char*
      level : ConfigLevelT
      free : (ConfigEntry* -> Void)
      payload : Void*
    end
    enum ConfigLevelT
      ConfigLevelProgramdata = 1
      ConfigLevelSystem = 2
      ConfigLevelXdg = 3
      ConfigLevelGlobal = 4
      ConfigLevelLocal = 5
      ConfigLevelApp = 6
      ConfigHighestLevel = -1
    end
    fun config_entry_free = git_config_entry_free(x0 : ConfigEntry*)
    alias ConfigIterator = Void
    CvarFalse = 0
    CvarTrue = 1
    CvarInt32 = 2
    CvarString = 3
    fun config_find_global = git_config_find_global(out : Buf*) : LibC::Int
    fun config_find_xdg = git_config_find_xdg(out : Buf*) : LibC::Int
    fun config_find_system = git_config_find_system(out : Buf*) : LibC::Int
    fun config_find_programdata = git_config_find_programdata(out : Buf*) : LibC::Int
    fun config_open_default = git_config_open_default(out : X_Config*) : LibC::Int
    fun config_new = git_config_new(out : X_Config*) : LibC::Int
    fun config_add_file_ondisk = git_config_add_file_ondisk(cfg : X_Config, path : LibC::Char*, level : ConfigLevelT, force : LibC::Int) : LibC::Int
    fun config_open_ondisk = git_config_open_ondisk(out : X_Config*, path : LibC::Char*) : LibC::Int
    fun config_open_level = git_config_open_level(out : X_Config*, parent : X_Config, level : ConfigLevelT) : LibC::Int
    fun config_open_global = git_config_open_global(out : X_Config*, config : X_Config) : LibC::Int
    fun config_snapshot = git_config_snapshot(out : X_Config*, config : X_Config) : LibC::Int
    fun config_free = git_config_free(cfg : X_Config)
    fun config_get_entry = git_config_get_entry(out : ConfigEntry**, cfg : X_Config, name : LibC::Char*) : LibC::Int
    fun config_get_int32 = git_config_get_int32(out : Int32T*, cfg : X_Config, name : LibC::Char*) : LibC::Int
    fun config_get_int64 = git_config_get_int64(out : Int64T*, cfg : X_Config, name : LibC::Char*) : LibC::Int
    fun config_get_bool = git_config_get_bool(out : LibC::Int*, cfg : X_Config, name : LibC::Char*) : LibC::Int
    fun config_get_path = git_config_get_path(out : Buf*, cfg : X_Config, name : LibC::Char*) : LibC::Int
    fun config_get_string = git_config_get_string(out : LibC::Char**, cfg : X_Config, name : LibC::Char*) : LibC::Int
    fun config_get_string_buf = git_config_get_string_buf(out : Buf*, cfg : X_Config, name : LibC::Char*) : LibC::Int
    fun config_get_multivar_foreach = git_config_get_multivar_foreach(cfg : X_Config, name : LibC::Char*, regexp : LibC::Char*, callback : ConfigForeachCb, payload : Void*) : LibC::Int
    alias ConfigForeachCb = (ConfigEntry*, Void* -> LibC::Int)
    fun config_multivar_iterator_new = git_config_multivar_iterator_new(out : X_ConfigIterator*, cfg : X_Config, name : LibC::Char*, regexp : LibC::Char*) : LibC::Int
    type X_ConfigIterator = Void*
    fun config_next = git_config_next(entry : ConfigEntry**, iter : X_ConfigIterator) : LibC::Int
    fun config_iterator_free = git_config_iterator_free(iter : X_ConfigIterator)
    fun config_set_int32 = git_config_set_int32(cfg : X_Config, name : LibC::Char*, value : Int32T) : LibC::Int
    fun config_set_int64 = git_config_set_int64(cfg : X_Config, name : LibC::Char*, value : Int64T) : LibC::Int
    fun config_set_bool = git_config_set_bool(cfg : X_Config, name : LibC::Char*, value : LibC::Int) : LibC::Int
    fun config_set_string = git_config_set_string(cfg : X_Config, name : LibC::Char*, value : LibC::Char*) : LibC::Int
    fun config_set_multivar = git_config_set_multivar(cfg : X_Config, name : LibC::Char*, regexp : LibC::Char*, value : LibC::Char*) : LibC::Int
    fun config_delete_entry = git_config_delete_entry(cfg : X_Config, name : LibC::Char*) : LibC::Int
    fun config_delete_multivar = git_config_delete_multivar(cfg : X_Config, name : LibC::Char*, regexp : LibC::Char*) : LibC::Int
    fun config_foreach = git_config_foreach(cfg : X_Config, callback : ConfigForeachCb, payload : Void*) : LibC::Int
    fun config_iterator_new = git_config_iterator_new(out : X_ConfigIterator*, cfg : X_Config) : LibC::Int
    fun config_iterator_glob_new = git_config_iterator_glob_new(out : X_ConfigIterator*, cfg : X_Config, regexp : LibC::Char*) : LibC::Int
    fun config_foreach_match = git_config_foreach_match(cfg : X_Config, regexp : LibC::Char*, callback : ConfigForeachCb, payload : Void*) : LibC::Int
    fun config_get_mapped = git_config_get_mapped(out : LibC::Int*, cfg : X_Config, name : LibC::Char*, maps : CvarMap*, map_n : LibC::SizeT) : LibC::Int
    struct CvarMap
      cvar_type : CvarT
      str_match : LibC::Char*
      map_value : LibC::Int
    end
    enum CvarT
      CvarFalse = 0
      CvarTrue = 1
      CvarInt32 = 2
      CvarString = 3
    end
    fun config_lookup_map_value = git_config_lookup_map_value(out : LibC::Int*, maps : CvarMap*, map_n : LibC::SizeT, value : LibC::Char*) : LibC::Int
    fun config_parse_bool = git_config_parse_bool(out : LibC::Int*, value : LibC::Char*) : LibC::Int
    fun config_parse_int32 = git_config_parse_int32(out : Int32T*, value : LibC::Char*) : LibC::Int
    fun config_parse_int64 = git_config_parse_int64(out : Int64T*, value : LibC::Char*) : LibC::Int
    fun config_parse_path = git_config_parse_path(out : Buf*, value : LibC::Char*) : LibC::Int
    fun config_backend_foreach_match = git_config_backend_foreach_match(backend : X_ConfigBackend, regexp : LibC::Char*, callback : ConfigForeachCb, payload : Void*) : LibC::Int
    type X_ConfigBackend = Void*
    fun config_lock = git_config_lock(tx : X_Transaction*, cfg : X_Config) : LibC::Int
    type X_Transaction = Void*
    DescribeDefault = 0
    DescribeTags = 1
    DescribeAll = 2
    struct DescribeOptions
      version : LibC::UInt
      max_candidates_tags : LibC::UInt
      describe_strategy : LibC::UInt
      pattern : LibC::Char*
      only_follow_first_parent : LibC::Int
      show_commit_oid_as_fallback : LibC::Int
    end
    fun describe_init_options = git_describe_init_options(opts : DescribeOptions*, version : LibC::UInt) : LibC::Int
    fun describe_init_format_options = git_describe_init_format_options(opts : DescribeFormatOptions*, version : LibC::UInt) : LibC::Int
    struct DescribeFormatOptions
      version : LibC::UInt
      abbreviated_size : LibC::UInt
      always_use_long_format : LibC::Int
      dirty_suffix : LibC::Char*
    end
    alias DescribeResult = Void
    fun describe_commit = git_describe_commit(result : X_DescribeResult*, committish : X_Object, opts : DescribeOptions*) : LibC::Int
    type X_DescribeResult = Void*
    fun describe_workdir = git_describe_workdir(out : X_DescribeResult*, repo : X_Repository, opts : DescribeOptions*) : LibC::Int
    fun describe_format = git_describe_format(out : Buf*, result : X_DescribeResult, opts : DescribeFormatOptions*) : LibC::Int
    fun describe_result_free = git_describe_result_free(result : X_DescribeResult)
    Ok = 0
    Error = -1
    Enotfound = -3
    Eexists = -4
    Eambiguous = -5
    Ebufs = -6
    Euser = -7
    Ebarerepo = -8
    Eunbornbranch = -9
    Eunmerged = -10
    Enonfastforward = -11
    Einvalidspec = -12
    Econflict = -13
    Elocked = -14
    Emodified = -15
    Eauth = -16
    Ecertificate = -17
    Eapplied = -18
    Epeel = -19
    Eeof = -20
    Einvalid = -21
    Euncommitted = -22
    Edirectory = -23
    Emergeconflict = -24
    Passthrough = -30
    Iterover = -31
    FilterToWorktree = 0
    FilterSmudge = 0
    FilterToOdb = 1
    FilterClean = 1
    FilterDefault = 0
    FilterAllowUnsafe = 1
    alias Filter = Void
    alias FilterList = Void
    fun filter_list_load = git_filter_list_load(filters : X_FilterList*, repo : X_Repository, blob : X_Blob, path : LibC::Char*, mode : FilterModeT, flags : Uint32T) : LibC::Int
    type X_FilterList = Void*
    enum FilterModeT
      FilterToWorktree = 0
      FilterSmudge = 0
      FilterToOdb = 1
      FilterClean = 1
    end
    fun filter_list_contains = git_filter_list_contains(filters : X_FilterList, name : LibC::Char*) : LibC::Int
    fun filter_list_apply_to_data = git_filter_list_apply_to_data(out : Buf*, filters : X_FilterList, in : Buf*) : LibC::Int
    fun filter_list_apply_to_file = git_filter_list_apply_to_file(out : Buf*, filters : X_FilterList, repo : X_Repository, path : LibC::Char*) : LibC::Int
    fun filter_list_apply_to_blob = git_filter_list_apply_to_blob(out : Buf*, filters : X_FilterList, blob : X_Blob) : LibC::Int
    fun filter_list_stream_data = git_filter_list_stream_data(filters : X_FilterList, data : Buf*, target : Writestream*) : LibC::Int
    fun filter_list_stream_file = git_filter_list_stream_file(filters : X_FilterList, repo : X_Repository, path : LibC::Char*, target : Writestream*) : LibC::Int
    fun filter_list_stream_blob = git_filter_list_stream_blob(filters : X_FilterList, blob : X_Blob, target : Writestream*) : LibC::Int
    fun filter_list_free = git_filter_list_free(filters : X_FilterList)
    fun libgit2_init = git_libgit2_init : LibC::Int
    fun libgit2_shutdown = git_libgit2_shutdown : LibC::Int
    fun graph_ahead_behind = git_graph_ahead_behind(ahead : LibC::SizeT*, behind : LibC::SizeT*, repo : X_Repository, local : Oid*, upstream : Oid*) : LibC::Int
    fun graph_descendant_of = git_graph_descendant_of(repo : X_Repository, commit : Oid*, ancestor : Oid*) : LibC::Int
    fun ignore_add_rule = git_ignore_add_rule(repo : X_Repository, rules : LibC::Char*) : LibC::Int
    fun ignore_clear_internal_rules = git_ignore_clear_internal_rules(repo : X_Repository) : LibC::Int
    fun ignore_path_is_ignored = git_ignore_path_is_ignored(ignored : LibC::Int*, repo : X_Repository, path : LibC::Char*) : LibC::Int
    fun message_prettify = git_message_prettify(out : Buf*, message : LibC::Char*, strip_comments : LibC::Int, comment_char : LibC::Char) : LibC::Int
    alias Iterator = Void
    fun note_iterator_new = git_note_iterator_new(out : X_NoteIterator*, repo : X_Repository, notes_ref : LibC::Char*) : LibC::Int
    type X_NoteIterator = Void*
    fun note_iterator_free = git_note_iterator_free(it : X_NoteIterator)
    fun note_next = git_note_next(note_id : Oid*, annotated_id : Oid*, it : X_NoteIterator) : LibC::Int
    fun note_read = git_note_read(out : X_Note*, repo : X_Repository, notes_ref : LibC::Char*, oid : Oid*) : LibC::Int
    type X_Note = Void*
    fun note_author = git_note_author(note : X_Note) : Signature*
    fun note_committer = git_note_committer(note : X_Note) : Signature*
    fun note_message = git_note_message(note : X_Note) : LibC::Char*
    fun note_id = git_note_id(note : X_Note) : Oid*
    fun note_create = git_note_create(out : Oid*, repo : X_Repository, notes_ref : LibC::Char*, author : Signature*, committer : Signature*, oid : Oid*, note : LibC::Char*, force : LibC::Int) : LibC::Int
    fun note_remove = git_note_remove(repo : X_Repository, notes_ref : LibC::Char*, author : Signature*, committer : Signature*, oid : Oid*) : LibC::Int
    fun note_free = git_note_free(note : X_Note)
    fun note_default_ref = git_note_default_ref(out : Buf*, repo : X_Repository) : LibC::Int
    fun note_foreach = git_note_foreach(repo : X_Repository, notes_ref : LibC::Char*, note_cb : NoteForeachCb, payload : Void*) : LibC::Int
    alias NoteForeachCb = (Oid*, Oid*, Void* -> LibC::Int)
    fun odb_new = git_odb_new(out : X_Odb*) : LibC::Int
    fun odb_open = git_odb_open(out : X_Odb*, objects_dir : LibC::Char*) : LibC::Int
    fun odb_add_disk_alternate = git_odb_add_disk_alternate(odb : X_Odb, path : LibC::Char*) : LibC::Int
    fun odb_free = git_odb_free(db : X_Odb)
    fun odb_read = git_odb_read(out : X_OdbObject*, db : X_Odb, id : Oid*) : LibC::Int
    type X_OdbObject = Void*
    fun odb_read_prefix = git_odb_read_prefix(out : X_OdbObject*, db : X_Odb, short_id : Oid*, len : LibC::SizeT) : LibC::Int
    fun odb_read_header = git_odb_read_header(len_out : LibC::SizeT*, type_out : Otype*, db : X_Odb, id : Oid*) : LibC::Int
    fun odb_exists = git_odb_exists(db : X_Odb, id : Oid*) : LibC::Int
    fun odb_exists_prefix = git_odb_exists_prefix(out : Oid*, db : X_Odb, short_id : Oid*, len : LibC::SizeT) : LibC::Int
    fun odb_refresh = git_odb_refresh(db : Odb*) : LibC::Int
    fun odb_foreach = git_odb_foreach(db : X_Odb, cb : OdbForeachCb, payload : Void*) : LibC::Int
    alias OdbForeachCb = (Oid*, Void* -> LibC::Int)
    fun odb_write = git_odb_write(out : Oid*, odb : X_Odb, data : Void*, len : LibC::SizeT, type : Otype) : LibC::Int
    fun odb_open_wstream = git_odb_open_wstream(out : OdbStream**, db : X_Odb, size : OffT, type : Otype) : LibC::Int
    fun odb_stream_write = git_odb_stream_write(stream : OdbStream*, buffer : LibC::Char*, len : LibC::SizeT) : LibC::Int
    fun odb_stream_finalize_write = git_odb_stream_finalize_write(out : Oid*, stream : OdbStream*) : LibC::Int
    fun odb_stream_read = git_odb_stream_read(stream : OdbStream*, buffer : LibC::Char*, len : LibC::SizeT) : LibC::Int
    fun odb_stream_free = git_odb_stream_free(stream : OdbStream*)
    fun odb_open_rstream = git_odb_open_rstream(out : OdbStream**, db : X_Odb, oid : Oid*) : LibC::Int
    fun odb_write_pack = git_odb_write_pack(out : OdbWritepack**, db : X_Odb, progress_cb : TransferProgressCb, progress_payload : Void*) : LibC::Int
    fun odb_hash = git_odb_hash(out : Oid*, data : Void*, len : LibC::SizeT, type : Otype) : LibC::Int
    fun odb_hashfile = git_odb_hashfile(out : Oid*, path : LibC::Char*, type : Otype) : LibC::Int
    fun odb_object_dup = git_odb_object_dup(dest : X_OdbObject*, source : X_OdbObject) : LibC::Int
    fun odb_object_free = git_odb_object_free(object : X_OdbObject)
    fun odb_object_id = git_odb_object_id(object : X_OdbObject) : Oid*
    fun odb_object_data = git_odb_object_data(object : X_OdbObject) : Void*
    fun odb_object_size = git_odb_object_size(object : X_OdbObject) : LibC::SizeT
    fun odb_object_type = git_odb_object_type(object : X_OdbObject) : Otype
    fun odb_add_backend = git_odb_add_backend(odb : X_Odb, backend : X_OdbBackend, priority : LibC::Int) : LibC::Int
    fun odb_add_alternate = git_odb_add_alternate(odb : X_Odb, backend : X_OdbBackend, priority : LibC::Int) : LibC::Int
    fun odb_num_backends = git_odb_num_backends(odb : X_Odb) : LibC::SizeT
    fun odb_get_backend = git_odb_get_backend(out : X_OdbBackend*, odb : X_Odb, pos : LibC::SizeT) : LibC::Int
    fun odb_backend_pack = git_odb_backend_pack(out : X_OdbBackend*, objects_dir : LibC::Char*) : LibC::Int
    fun odb_backend_loose = git_odb_backend_loose(out : X_OdbBackend*, objects_dir : LibC::Char*, compression_level : LibC::Int, do_fsync : LibC::Int, dir_mode : LibC::UInt, file_mode : LibC::UInt) : LibC::Int
    fun odb_backend_one_pack = git_odb_backend_one_pack(out : X_OdbBackend*, index_file : LibC::Char*) : LibC::Int
    StreamRdonly = 2
    StreamWronly = 4
    StreamRw = 6
    alias Patch = Void
    fun patch_from_diff = git_patch_from_diff(out : X_Patch*, diff : X_Diff, idx : LibC::SizeT) : LibC::Int
    type X_Patch = Void*
    fun patch_from_blobs = git_patch_from_blobs(out : X_Patch*, old_blob : X_Blob, old_as_path : LibC::Char*, new_blob : X_Blob, new_as_path : LibC::Char*, opts : DiffOptions*) : LibC::Int
    fun patch_from_blob_and_buffer = git_patch_from_blob_and_buffer(out : X_Patch*, old_blob : X_Blob, old_as_path : LibC::Char*, buffer : LibC::Char*, buffer_len : LibC::SizeT, buffer_as_path : LibC::Char*, opts : DiffOptions*) : LibC::Int
    fun patch_from_buffers = git_patch_from_buffers(out : X_Patch*, old_buffer : Void*, old_len : LibC::SizeT, old_as_path : LibC::Char*, new_buffer : LibC::Char*, new_len : LibC::SizeT, new_as_path : LibC::Char*, opts : DiffOptions*) : LibC::Int
    fun patch_free = git_patch_free(patch : X_Patch)
    fun patch_get_delta = git_patch_get_delta(patch : X_Patch) : DiffDelta*
    fun patch_num_hunks = git_patch_num_hunks(patch : X_Patch) : LibC::SizeT
    fun patch_line_stats = git_patch_line_stats(total_context : LibC::SizeT*, total_additions : LibC::SizeT*, total_deletions : LibC::SizeT*, patch : X_Patch) : LibC::Int
    fun patch_get_hunk = git_patch_get_hunk(out : DiffHunk**, lines_in_hunk : LibC::SizeT*, patch : X_Patch, hunk_idx : LibC::SizeT) : LibC::Int
    fun patch_num_lines_in_hunk = git_patch_num_lines_in_hunk(patch : X_Patch, hunk_idx : LibC::SizeT) : LibC::Int
    fun patch_get_line_in_hunk = git_patch_get_line_in_hunk(out : DiffLine**, patch : X_Patch, hunk_idx : LibC::SizeT, line_of_hunk : LibC::SizeT) : LibC::Int
    fun patch_size = git_patch_size(patch : X_Patch, include_context : LibC::Int, include_hunk_headers : LibC::Int, include_file_headers : LibC::Int) : LibC::SizeT
    fun patch_print = git_patch_print(patch : X_Patch, print_cb : DiffLineCb, payload : Void*) : LibC::Int
    fun patch_to_buf = git_patch_to_buf(out : Buf*, patch : X_Patch) : LibC::Int
    alias Pathspec = Void
    alias PathspecMatchList = Void
    PathspecDefault = 0
    PathspecIgnoreCase = 1
    PathspecUseCase = 2
    PathspecNoGlob = 4
    PathspecNoMatchError = 8
    PathspecFindFailures = 16
    PathspecFailuresOnly = 32
    fun pathspec_new = git_pathspec_new(out : X_Pathspec*, pathspec : Strarray*) : LibC::Int
    type X_Pathspec = Void*
    fun pathspec_free = git_pathspec_free(ps : X_Pathspec)
    fun pathspec_matches_path = git_pathspec_matches_path(ps : X_Pathspec, flags : Uint32T, path : LibC::Char*) : LibC::Int
    fun pathspec_match_workdir = git_pathspec_match_workdir(out : X_PathspecMatchList*, repo : X_Repository, flags : Uint32T, ps : X_Pathspec) : LibC::Int
    type X_PathspecMatchList = Void*
    fun pathspec_match_index = git_pathspec_match_index(out : X_PathspecMatchList*, index : X_Index, flags : Uint32T, ps : X_Pathspec) : LibC::Int
    fun pathspec_match_tree = git_pathspec_match_tree(out : X_PathspecMatchList*, tree : X_Tree, flags : Uint32T, ps : X_Pathspec) : LibC::Int
    fun pathspec_match_diff = git_pathspec_match_diff(out : X_PathspecMatchList*, diff : X_Diff, flags : Uint32T, ps : X_Pathspec) : LibC::Int
    fun pathspec_match_list_free = git_pathspec_match_list_free(m : X_PathspecMatchList)
    fun pathspec_match_list_entrycount = git_pathspec_match_list_entrycount(m : X_PathspecMatchList) : LibC::SizeT
    fun pathspec_match_list_entry = git_pathspec_match_list_entry(m : X_PathspecMatchList, pos : LibC::SizeT) : LibC::Char*
    fun pathspec_match_list_diff_entry = git_pathspec_match_list_diff_entry(m : X_PathspecMatchList, pos : LibC::SizeT) : DiffDelta*
    fun pathspec_match_list_failed_entrycount = git_pathspec_match_list_failed_entrycount(m : X_PathspecMatchList) : LibC::SizeT
    fun pathspec_match_list_failed_entry = git_pathspec_match_list_failed_entry(m : X_PathspecMatchList, pos : LibC::SizeT) : LibC::Char*
    RebaseOperationPick = 0
    RebaseOperationReword = 1
    RebaseOperationEdit = 2
    RebaseOperationSquash = 3
    RebaseOperationFixup = 4
    RebaseOperationExec = 5
    fun rebase_init_options = git_rebase_init_options(opts : RebaseOptions*, version : LibC::UInt) : LibC::Int
    struct RebaseOptions
      version : LibC::UInt
      quiet : LibC::Int
      inmemory : LibC::Int
      rewrite_notes_ref : LibC::Char*
      merge_options : MergeOptions
      checkout_options : CheckoutOptions
    end
    fun rebase_init = git_rebase_init(out : X_Rebase*, repo : X_Repository, branch : X_AnnotatedCommit, upstream : X_AnnotatedCommit, onto : X_AnnotatedCommit, opts : RebaseOptions*) : LibC::Int
    type X_Rebase = Void*
    fun rebase_open = git_rebase_open(out : X_Rebase*, repo : X_Repository, opts : RebaseOptions*) : LibC::Int
    fun rebase_operation_entrycount = git_rebase_operation_entrycount(rebase : X_Rebase) : LibC::SizeT
    fun rebase_operation_current = git_rebase_operation_current(rebase : X_Rebase) : LibC::SizeT
    fun rebase_operation_byindex = git_rebase_operation_byindex(rebase : X_Rebase, idx : LibC::SizeT) : RebaseOperation*
    struct RebaseOperation
      type : RebaseOperationT
      id : Oid
      exec : LibC::Char*
    end
    enum RebaseOperationT
      RebaseOperationPick = 0
      RebaseOperationReword = 1
      RebaseOperationEdit = 2
      RebaseOperationSquash = 3
      RebaseOperationFixup = 4
      RebaseOperationExec = 5
    end
    fun rebase_next = git_rebase_next(operation : RebaseOperation**, rebase : X_Rebase) : LibC::Int
    fun rebase_inmemory_index = git_rebase_inmemory_index(index : X_Index*, rebase : X_Rebase) : LibC::Int
    fun rebase_commit = git_rebase_commit(id : Oid*, rebase : X_Rebase, author : Signature*, committer : Signature*, message_encoding : LibC::Char*, message : LibC::Char*) : LibC::Int
    fun rebase_abort = git_rebase_abort(rebase : X_Rebase) : LibC::Int
    fun rebase_finish = git_rebase_finish(rebase : X_Rebase, signature : Signature*) : LibC::Int
    fun rebase_free = git_rebase_free(rebase : X_Rebase)
    fun refdb_new = git_refdb_new(out : X_Refdb*, repo : X_Repository) : LibC::Int
    fun refdb_open = git_refdb_open(out : X_Refdb*, repo : X_Repository) : LibC::Int
    fun refdb_compress = git_refdb_compress(refdb : X_Refdb) : LibC::Int
    fun refdb_free = git_refdb_free(refdb : X_Refdb)
    fun reflog_read = git_reflog_read(out : X_Reflog*, repo : X_Repository, name : LibC::Char*) : LibC::Int
    type X_Reflog = Void*
    fun reflog_write = git_reflog_write(reflog : X_Reflog) : LibC::Int
    fun reflog_append = git_reflog_append(reflog : X_Reflog, id : Oid*, committer : Signature*, msg : LibC::Char*) : LibC::Int
    fun reflog_rename = git_reflog_rename(repo : X_Repository, old_name : LibC::Char*, name : LibC::Char*) : LibC::Int
    fun reflog_delete = git_reflog_delete(repo : X_Repository, name : LibC::Char*) : LibC::Int
    fun reflog_entrycount = git_reflog_entrycount(reflog : X_Reflog) : LibC::SizeT
    fun reflog_entry_byindex = git_reflog_entry_byindex(reflog : X_Reflog, idx : LibC::SizeT) : X_ReflogEntry
    type X_ReflogEntry = Void*
    fun reflog_drop = git_reflog_drop(reflog : X_Reflog, idx : LibC::SizeT, rewrite_previous_entry : LibC::Int) : LibC::Int
    fun reflog_entry_id_old = git_reflog_entry_id_old(entry : X_ReflogEntry) : Oid*
    fun reflog_entry_id_new = git_reflog_entry_id_new(entry : X_ReflogEntry) : Oid*
    fun reflog_entry_committer = git_reflog_entry_committer(entry : X_ReflogEntry) : Signature*
    fun reflog_entry_message = git_reflog_entry_message(entry : X_ReflogEntry) : LibC::Char*
    fun reflog_free = git_reflog_free(reflog : X_Reflog)
    ResetSoft = 1
    ResetMixed = 2
    ResetHard = 3
    fun reset = git_reset(repo : X_Repository, target : X_Object, reset_type : ResetT, checkout_opts : CheckoutOptions*) : LibC::Int
    enum ResetT
      ResetSoft = 1
      ResetMixed = 2
      ResetHard = 3
    end
    fun reset_from_annotated = git_reset_from_annotated(repo : X_Repository, commit : X_AnnotatedCommit, reset_type : ResetT, checkout_opts : CheckoutOptions*) : LibC::Int
    fun reset_default = git_reset_default(repo : X_Repository, target : X_Object, pathspecs : Strarray*) : LibC::Int
    fun revert_init_options = git_revert_init_options(opts : RevertOptions*, version : LibC::UInt) : LibC::Int
    struct RevertOptions
      version : LibC::UInt
      mainline : LibC::UInt
      merge_opts : MergeOptions
      checkout_opts : CheckoutOptions
    end
    fun revert_commit = git_revert_commit(out : X_Index*, repo : X_Repository, revert_commit : X_Commit, our_commit : X_Commit, mainline : LibC::UInt, merge_options : MergeOptions*) : LibC::Int
    fun revert = git_revert(repo : X_Repository, commit : X_Commit, given_opts : RevertOptions*) : LibC::Int
    fun revparse_single = git_revparse_single(out : X_Object*, repo : X_Repository, spec : LibC::Char*) : LibC::Int
    fun revparse_ext = git_revparse_ext(object_out : X_Object*, reference_out : X_Reference*, repo : X_Repository, spec : LibC::Char*) : LibC::Int
    RevparseSingle = 1
    RevparseRange = 2
    RevparseMergeBase = 4
    fun revparse = git_revparse(revspec : Revspec*, repo : X_Repository, spec : LibC::Char*) : LibC::Int
    struct Revspec
      from : X_Object
      to : X_Object
      flags : LibC::UInt
    end
    SortNone = 0
    SortTopological = 1
    SortTime = 2
    SortReverse = 4
    fun revwalk_new = git_revwalk_new(out : X_Revwalk*, repo : X_Repository) : LibC::Int
    fun revwalk_reset = git_revwalk_reset(walker : X_Revwalk)
    fun revwalk_push = git_revwalk_push(walk : X_Revwalk, id : Oid*) : LibC::Int
    fun revwalk_push_glob = git_revwalk_push_glob(walk : X_Revwalk, glob : LibC::Char*) : LibC::Int
    fun revwalk_push_head = git_revwalk_push_head(walk : X_Revwalk) : LibC::Int
    fun revwalk_hide = git_revwalk_hide(walk : X_Revwalk, commit_id : Oid*) : LibC::Int
    fun revwalk_hide_glob = git_revwalk_hide_glob(walk : X_Revwalk, glob : LibC::Char*) : LibC::Int
    fun revwalk_hide_head = git_revwalk_hide_head(walk : X_Revwalk) : LibC::Int
    fun revwalk_push_ref = git_revwalk_push_ref(walk : X_Revwalk, refname : LibC::Char*) : LibC::Int
    fun revwalk_hide_ref = git_revwalk_hide_ref(walk : X_Revwalk, refname : LibC::Char*) : LibC::Int
    fun revwalk_next = git_revwalk_next(out : Oid*, walk : X_Revwalk) : LibC::Int
    fun revwalk_sorting = git_revwalk_sorting(walk : X_Revwalk, sort_mode : LibC::UInt)
    fun revwalk_push_range = git_revwalk_push_range(walk : X_Revwalk, range : LibC::Char*) : LibC::Int
    fun revwalk_simplify_first_parent = git_revwalk_simplify_first_parent(walk : X_Revwalk)
    fun revwalk_free = git_revwalk_free(walk : X_Revwalk)
    fun revwalk_repository = git_revwalk_repository(walk : X_Revwalk) : X_Repository
    fun revwalk_add_hide_cb = git_revwalk_add_hide_cb(walk : X_Revwalk, hide_cb : RevwalkHideCb, payload : Void*) : LibC::Int
    alias RevwalkHideCb = (Oid*, Void* -> LibC::Int)
    fun signature_new = git_signature_new(out : Signature**, name : LibC::Char*, email : LibC::Char*, time : TimeT, offset : LibC::Int) : LibC::Int
    fun signature_now = git_signature_now(out : Signature**, name : LibC::Char*, email : LibC::Char*) : LibC::Int
    fun signature_default = git_signature_default(out : Signature**, repo : X_Repository) : LibC::Int
    fun signature_dup = git_signature_dup(dest : Signature**, sig : Signature*) : LibC::Int
    fun signature_free = git_signature_free(sig : Signature*)
    StashDefault = 0
    StashKeepIndex = 1
    StashIncludeUntracked = 2
    StashIncludeIgnored = 4
    fun stash_save = git_stash_save(out : Oid*, repo : X_Repository, stasher : Signature*, message : LibC::Char*, flags : Uint32T) : LibC::Int
    StashApplyDefault = 0
    StashApplyReinstateIndex = 1
    StashApplyProgressNone = 0
    StashApplyProgressLoadingStash = 1
    StashApplyProgressAnalyzeIndex = 2
    StashApplyProgressAnalyzeModified = 3
    StashApplyProgressAnalyzeUntracked = 4
    StashApplyProgressCheckoutUntracked = 5
    StashApplyProgressCheckoutModified = 6
    StashApplyProgressDone = 7
    struct StashApplyOptions
      version : LibC::UInt
      flags : StashApplyFlags
      checkout_options : CheckoutOptions
      progress_cb : StashApplyProgressCb
      progress_payload : Void*
    end
    enum StashApplyFlags
      StashApplyDefault = 0
      StashApplyReinstateIndex = 1
    end
    enum StashApplyProgressT
      StashApplyProgressNone = 0
      StashApplyProgressLoadingStash = 1
      StashApplyProgressAnalyzeIndex = 2
      StashApplyProgressAnalyzeModified = 3
      StashApplyProgressAnalyzeUntracked = 4
      StashApplyProgressCheckoutUntracked = 5
      StashApplyProgressCheckoutModified = 6
      StashApplyProgressDone = 7
    end
    alias StashApplyProgressCb = (StashApplyProgressT, Void* -> LibC::Int)
    fun stash_apply_init_options = git_stash_apply_init_options(opts : StashApplyOptions*, version : LibC::UInt) : LibC::Int
    fun stash_apply = git_stash_apply(repo : X_Repository, index : LibC::SizeT, options : StashApplyOptions*) : LibC::Int
    fun stash_foreach = git_stash_foreach(repo : X_Repository, callback : StashCb, payload : Void*) : LibC::Int
    alias StashCb = (LibC::SizeT, LibC::Char*, Oid*, Void* -> LibC::Int)
    fun stash_drop = git_stash_drop(repo : X_Repository, index : LibC::SizeT) : LibC::Int
    fun stash_pop = git_stash_pop(repo : X_Repository, index : LibC::SizeT, options : StashApplyOptions*) : LibC::Int
    StatusCurrent = 0
    StatusIndexNew = 1
    StatusIndexModified = 2
    StatusIndexDeleted = 4
    StatusIndexRenamed = 8
    StatusIndexTypechange = 16
    StatusWtNew = 128
    StatusWtModified = 256
    StatusWtDeleted = 512
    StatusWtTypechange = 1024
    StatusWtRenamed = 2048
    StatusWtUnreadable = 4096
    StatusIgnored = 16384
    StatusConflicted = 32768
    StatusShowIndexAndWorkdir = 0
    StatusShowIndexOnly = 1
    StatusShowWorkdirOnly = 2
    StatusOptIncludeUntracked = 1
    StatusOptIncludeIgnored = 2
    StatusOptIncludeUnmodified = 4
    StatusOptExcludeSubmodules = 8
    StatusOptRecurseUntrackedDirs = 16
    StatusOptDisablePathspecMatch = 32
    StatusOptRecurseIgnoredDirs = 64
    StatusOptRenamesHeadToIndex = 128
    StatusOptRenamesIndexToWorkdir = 256
    StatusOptSortCaseSensitively = 512
    StatusOptSortCaseInsensitively = 1024
    StatusOptRenamesFromRewrites = 2048
    StatusOptNoRefresh = 4096
    StatusOptUpdateIndex = 8192
    StatusOptIncludeUnreadable = 16384
    StatusOptIncludeUnreadableAsUntracked = 32768
    fun status_init_options = git_status_init_options(opts : StatusOptions*, version : LibC::UInt) : LibC::Int
    struct StatusOptions
      version : LibC::UInt
      show : StatusShowT
      flags : LibC::UInt
      pathspec : Strarray
    end
    enum StatusShowT
      StatusShowIndexAndWorkdir = 0
      StatusShowIndexOnly = 1
      StatusShowWorkdirOnly = 2
    end
    fun status_foreach = git_status_foreach(repo : X_Repository, callback : StatusCb, payload : Void*) : LibC::Int
    alias StatusCb = (LibC::Char*, LibC::UInt, Void* -> LibC::Int)
    fun status_foreach_ext = git_status_foreach_ext(repo : X_Repository, opts : StatusOptions*, callback : StatusCb, payload : Void*) : LibC::Int
    fun status_file = git_status_file(status_flags : LibC::UInt*, repo : X_Repository, path : LibC::Char*) : LibC::Int
    fun status_list_new = git_status_list_new(out : X_StatusList*, repo : X_Repository, opts : StatusOptions*) : LibC::Int
    type X_StatusList = Void*
    fun status_list_entrycount = git_status_list_entrycount(statuslist : X_StatusList) : LibC::SizeT
    fun status_byindex = git_status_byindex(statuslist : X_StatusList, idx : LibC::SizeT) : StatusEntry*
    struct StatusEntry
      status : StatusT
      head_to_index : DiffDelta*
      index_to_workdir : DiffDelta*
    end
    enum StatusT
      StatusCurrent = 0
      StatusIndexNew = 1
      StatusIndexModified = 2
      StatusIndexDeleted = 4
      StatusIndexRenamed = 8
      StatusIndexTypechange = 16
      StatusWtNew = 128
      StatusWtModified = 256
      StatusWtDeleted = 512
      StatusWtTypechange = 1024
      StatusWtRenamed = 2048
      StatusWtUnreadable = 4096
      StatusIgnored = 16384
      StatusConflicted = 32768
    end
    fun status_list_free = git_status_list_free(statuslist : X_StatusList)
    fun status_should_ignore = git_status_should_ignore(ignored : LibC::Int*, repo : X_Repository, path : LibC::Char*) : LibC::Int
    SubmoduleStatusInHead = 1
    SubmoduleStatusInIndex = 2
    SubmoduleStatusInConfig = 4
    SubmoduleStatusInWd = 8
    SubmoduleStatusIndexAdded = 16
    SubmoduleStatusIndexDeleted = 32
    SubmoduleStatusIndexModified = 64
    SubmoduleStatusWdUninitialized = 128
    SubmoduleStatusWdAdded = 256
    SubmoduleStatusWdDeleted = 512
    SubmoduleStatusWdModified = 1024
    SubmoduleStatusWdIndexModified = 2048
    SubmoduleStatusWdWdModified = 4096
    SubmoduleStatusWdUntracked = 8192
    struct SubmoduleUpdateOptions
      version : LibC::UInt
      checkout_opts : CheckoutOptions
      fetch_opts : FetchOptions
      clone_checkout_strategy : LibC::UInt
    end
    fun submodule_update_init_options = git_submodule_update_init_options(opts : SubmoduleUpdateOptions*, version : LibC::UInt) : LibC::Int
    fun submodule_update = git_submodule_update(submodule : X_Submodule, init : LibC::Int, options : SubmoduleUpdateOptions*) : LibC::Int
    type X_Submodule = Void*
    fun submodule_lookup = git_submodule_lookup(out : X_Submodule*, repo : X_Repository, name : LibC::Char*) : LibC::Int
    fun submodule_free = git_submodule_free(submodule : X_Submodule)
    fun submodule_foreach = git_submodule_foreach(repo : X_Repository, callback : SubmoduleCb, payload : Void*) : LibC::Int
    alias SubmoduleCb = (X_Submodule, LibC::Char*, Void* -> LibC::Int)
    fun submodule_add_setup = git_submodule_add_setup(out : X_Submodule*, repo : X_Repository, url : LibC::Char*, path : LibC::Char*, use_gitlink : LibC::Int) : LibC::Int
    fun submodule_add_finalize = git_submodule_add_finalize(submodule : X_Submodule) : LibC::Int
    fun submodule_add_to_index = git_submodule_add_to_index(submodule : X_Submodule, write_index : LibC::Int) : LibC::Int
    fun submodule_owner = git_submodule_owner(submodule : X_Submodule) : X_Repository
    fun submodule_name = git_submodule_name(submodule : X_Submodule) : LibC::Char*
    fun submodule_path = git_submodule_path(submodule : X_Submodule) : LibC::Char*
    fun submodule_url = git_submodule_url(submodule : X_Submodule) : LibC::Char*
    fun submodule_resolve_url = git_submodule_resolve_url(out : Buf*, repo : X_Repository, url : LibC::Char*) : LibC::Int
    fun submodule_branch = git_submodule_branch(submodule : X_Submodule) : LibC::Char*
    fun submodule_set_branch = git_submodule_set_branch(repo : X_Repository, name : LibC::Char*, branch : LibC::Char*) : LibC::Int
    fun submodule_set_url = git_submodule_set_url(repo : X_Repository, name : LibC::Char*, url : LibC::Char*) : LibC::Int
    fun submodule_index_id = git_submodule_index_id(submodule : X_Submodule) : Oid*
    fun submodule_head_id = git_submodule_head_id(submodule : X_Submodule) : Oid*
    fun submodule_wd_id = git_submodule_wd_id(submodule : X_Submodule) : Oid*
    fun submodule_ignore = git_submodule_ignore(submodule : X_Submodule) : SubmoduleIgnoreT
    fun submodule_set_ignore = git_submodule_set_ignore(repo : X_Repository, name : LibC::Char*, ignore : SubmoduleIgnoreT) : LibC::Int
    fun submodule_update_strategy = git_submodule_update_strategy(submodule : X_Submodule) : SubmoduleUpdateT
    enum SubmoduleUpdateT
      SubmoduleUpdateCheckout = 1
      SubmoduleUpdateRebase = 2
      SubmoduleUpdateMerge = 3
      SubmoduleUpdateNone = 4
      SubmoduleUpdateDefault = 0
    end
    fun submodule_set_update = git_submodule_set_update(repo : X_Repository, name : LibC::Char*, update : SubmoduleUpdateT) : LibC::Int
    fun submodule_fetch_recurse_submodules = git_submodule_fetch_recurse_submodules(submodule : X_Submodule) : SubmoduleRecurseT
    enum SubmoduleRecurseT
      SubmoduleRecurseNo = 0
      SubmoduleRecurseYes = 1
      SubmoduleRecurseOndemand = 2
    end
    fun submodule_set_fetch_recurse_submodules = git_submodule_set_fetch_recurse_submodules(repo : X_Repository, name : LibC::Char*, fetch_recurse_submodules : SubmoduleRecurseT) : LibC::Int
    fun submodule_init = git_submodule_init(submodule : X_Submodule, overwrite : LibC::Int) : LibC::Int
    fun submodule_repo_init = git_submodule_repo_init(out : X_Repository*, sm : X_Submodule, use_gitlink : LibC::Int) : LibC::Int
    fun submodule_sync = git_submodule_sync(submodule : X_Submodule) : LibC::Int
    fun submodule_open = git_submodule_open(repo : X_Repository*, submodule : X_Submodule) : LibC::Int
    fun submodule_reload = git_submodule_reload(submodule : X_Submodule, force : LibC::Int) : LibC::Int
    fun submodule_status = git_submodule_status(status : LibC::UInt*, repo : X_Repository, name : LibC::Char*, ignore : SubmoduleIgnoreT) : LibC::Int
    fun submodule_location = git_submodule_location(location_status : LibC::UInt*, submodule : X_Submodule) : LibC::Int
    fun tag_lookup = git_tag_lookup(out : X_Tag*, repo : X_Repository, id : Oid*) : LibC::Int
    type X_Tag = Void*
    fun tag_lookup_prefix = git_tag_lookup_prefix(out : X_Tag*, repo : X_Repository, id : Oid*, len : LibC::SizeT) : LibC::Int
    fun tag_free = git_tag_free(tag : X_Tag)
    fun tag_id = git_tag_id(tag : X_Tag) : Oid*
    fun tag_owner = git_tag_owner(tag : X_Tag) : X_Repository
    fun tag_target = git_tag_target(target_out : X_Object*, tag : X_Tag) : LibC::Int
    fun tag_target_id = git_tag_target_id(tag : X_Tag) : Oid*
    fun tag_target_type = git_tag_target_type(tag : X_Tag) : Otype
    fun tag_name = git_tag_name(tag : X_Tag) : LibC::Char*
    fun tag_tagger = git_tag_tagger(tag : X_Tag) : Signature*
    fun tag_message = git_tag_message(tag : X_Tag) : LibC::Char*
    fun tag_create = git_tag_create(oid : Oid*, repo : X_Repository, tag_name : LibC::Char*, target : X_Object, tagger : Signature*, message : LibC::Char*, force : LibC::Int) : LibC::Int
    fun tag_annotation_create = git_tag_annotation_create(oid : Oid*, repo : X_Repository, tag_name : LibC::Char*, target : X_Object, tagger : Signature*, message : LibC::Char*) : LibC::Int
    fun tag_create_frombuffer = git_tag_create_frombuffer(oid : Oid*, repo : X_Repository, buffer : LibC::Char*, force : LibC::Int) : LibC::Int
    fun tag_create_lightweight = git_tag_create_lightweight(oid : Oid*, repo : X_Repository, tag_name : LibC::Char*, target : X_Object, force : LibC::Int) : LibC::Int
    fun tag_delete = git_tag_delete(repo : X_Repository, tag_name : LibC::Char*) : LibC::Int
    fun tag_list = git_tag_list(tag_names : Strarray*, repo : X_Repository) : LibC::Int
    fun tag_list_match = git_tag_list_match(tag_names : Strarray*, pattern : LibC::Char*, repo : X_Repository) : LibC::Int
    fun tag_foreach = git_tag_foreach(repo : X_Repository, callback : TagForeachCb, payload : Void*) : LibC::Int
    alias TagForeachCb = (LibC::Char*, Oid*, Void* -> LibC::Int)
    fun tag_peel = git_tag_peel(tag_target_out : X_Object*, tag : X_Tag) : LibC::Int
    fun transaction_new = git_transaction_new(out : X_Transaction*, repo : X_Repository) : LibC::Int
    fun transaction_lock_ref = git_transaction_lock_ref(tx : X_Transaction, refname : LibC::Char*) : LibC::Int
    fun transaction_set_target = git_transaction_set_target(tx : X_Transaction, refname : LibC::Char*, target : Oid*, sig : Signature*, msg : LibC::Char*) : LibC::Int
    fun transaction_set_symbolic_target = git_transaction_set_symbolic_target(tx : X_Transaction, refname : LibC::Char*, target : LibC::Char*, sig : Signature*, msg : LibC::Char*) : LibC::Int
    fun transaction_set_reflog = git_transaction_set_reflog(tx : X_Transaction, refname : LibC::Char*, reflog : X_Reflog) : LibC::Int
    fun transaction_remove = git_transaction_remove(tx : X_Transaction, refname : LibC::Char*) : LibC::Int
    fun transaction_commit = git_transaction_commit(tx : X_Transaction) : LibC::Int
    fun transaction_free = git_transaction_free(tx : X_Transaction)
  end
end