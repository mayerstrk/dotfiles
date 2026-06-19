function git-rename
    # Check if a new branch name was provided
    set -l new_name $argv[1]
    if test -z "$new_name"
        echo "Usage: git-rename <new-branch-name>" >&2
        return 1
    end

    # Get the current (old) branch name
    set -l old_name (git rev-parse --abbrev-ref HEAD)

    # Safety Checks
    if [ "$old_name" = main ] or [ "$old_name" = master ]
        echo "Error: You cannot rename the '$old_name' branch." >&2
        return 1
    end
    if [ "$old_name" = "$new_name" ]
        echo "New name is the same as the old name. Nothing to do." >&2
        return 0
    end

    echo "Renaming branch '$old_name' to '$new_name'..."

    # 1. Rename the local branch
    git branch -m "$new_name"
    echo "✅ Renamed local branch."

    # 2. Delete the old remote branch
    # This may show an error if the old branch never existed remotely, which is fine.
    git push origin --delete "$old_name"
    echo "✅ Sent delete command for old remote branch."

    # 3. Push the new branch and set its upstream tracking information
    git push --set-upstream origin "$new_name"
    echo "✅ Pushed new branch and set upstream tracking."
    echo -e "\nAll done! 🚀"
end
