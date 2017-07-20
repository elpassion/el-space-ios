module Fastlane  
  module Actions
    class MergesPullRequestAction < Action
      def self.run(params)
        branch = GitBranchAction.run(params)

        unless branch == "master"
          return false
        end

        last_git_commit = LastGitCommitAction.run(params)[:message]

        if last_git_commit.match(/Merge pull request #\d+ from .+/)
          true
        else
          false
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Checks whether last commit merges a PR"
      end

      def self.return_value
        "True if merges a PR, false otherwise"
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end 
