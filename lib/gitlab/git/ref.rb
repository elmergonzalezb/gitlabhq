# Gitaly note: JV: probably no RPC's here (just one interaction with Rugged).

module Gitlab
  module Git
    class Ref
      include Gitlab::EncodingHelper
      include Gitlab::Git::Local::Ref

      # Branch or tag name
      # without "refs/tags|heads" prefix
      attr_reader :name

      # Target sha.
      # Usually it is commit sha but in case
      # when tag reference on other tag it can be tag sha
      attr_reader :target

      # Dereferenced target
      # Commit object to which the Ref points to
      attr_reader :dereferenced_target

      # Extract branch name from full ref path
      #
      # Ex.
      #   Ref.extract_branch_name('refs/heads/master') #=> 'master'
      def self.extract_branch_name(str)
        str.gsub(/\Arefs\/heads\//, '')
      end

      def initialize(repository, name, target, derefenced_target)
        @name = Gitlab::Git.ref_name(name)
        @dereferenced_target = derefenced_target
        @target = if target.respond_to?(:oid)
                    target.oid
                  elsif target.respond_to?(:name)
                    target.name
                  elsif target.is_a? String
                    target
                  else
                    nil
                  end
      end
    end
  end
end
