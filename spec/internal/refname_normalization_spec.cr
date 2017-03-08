require "../spec_helper"

module GitInternalSpecs::RefnameNormalization
  macro expect(method, expected, *args)
    it {{args[0].id.stringify}} do
      Git::Ref.{{method.id}}(*{{args}}).should eq {{expected}}
    end
  end

  describe name do
    describe "to_local" do
      expect :to_local, "refs/heads/foo", "refs/remotes/origin/foo"
    end
  end
end
