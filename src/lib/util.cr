require "./util/*"

module Git::Util
  def self.yield_with(*args)
    yield *args
  end

  def self.null_pstr
    Pointer(UInt8).null
  end

  def self.null_ppstr
    Pointer(Pointer(UInt8)).null
  end
end
