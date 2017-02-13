module Git::Safe
  macro string(f, *args)
    String.new(C.{{f.id}}({{args.splat}}))
  end

  macro string_or_nil(f, *args)
    result = C.{{f.id}}({{args.splat}})
    result == Pointer(UInt8).null ? nil : String.new(result)
  end

  macro p_to_string_or_nil(p)
    %p = {{p}}
    puts %p
    %p.as(Pointer(Void)) == Pointer(Void).null ? Nil : String.new(%p.as(Pointer(UInt8)))
  end
end
