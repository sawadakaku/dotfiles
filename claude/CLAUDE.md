* Never include the message about claude code in the commit message and PR description.
* Use English for commit messages.
* Checkout branch from origin/master or origin/main, not from local master or main.
* Read the files under the worktree, not under the parent repository, when you are working on worktrees.
* Use LSP tool for code navigations (goToDefinition、findReferences、hover) if available, instead of using grep.
* Never send any comments to the PRs.
* Use the Edit tool to modify existing files, not python/sed scripts in Bash. Don't bundle file edits into the same Bash call as commit or push.
* When writing Jira tickets, keep them short:
  * The description states only the problem. No solutions, and no backstory such as "found while doing X" (a link is enough).
  * Put ideas and supporting context in brief ticket comments, links, or collapsed sections.
