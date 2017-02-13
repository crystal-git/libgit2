module Git::Safe
  macro call(f, *args, &block)
    %result = C.{{f.id}}({{args.splat}})
    {% if block %}
      %call = ::Git::Safe::Call.new({{f.id.stringify}}, %result, C.giterr_last)
      ::Git::Util.yield_with(%call) {{block}}
    {% else %}
    (if %result < 0
      raise ::Git::Safe::CallError.new({{f.id.stringify}}, %result, C.giterr_last)
    else
      %result
    end)
    {% end %}
  end
end
