## Contributing

We'd love to see you contribute your code to make Steroids even more awesome. Contribution is done via GitHub Pull Requests.

### Search for open issues and Pull Requests

Go through our centralized issue tracker at [https://github.com/appgyver/steroids/issues](https://github.com/appgyver/steroids/issues) and see if there are any relevant open or closed issues. Minor changes and improvements can be made without opening a new issue. If you're planning a larger contribution, it's a good idea to open a GitHub issue describing what you're planning so that it can be commented on.

To avoid duplicate work, also go through the Pull Requests of the repo your contributing to ensure there are no open or closed Pull Requests.

### Read the guidelines
To increase the chances of your Pull Request being accepted, consider the following points as you're making your Pull Request.

1. Make your changes in a new git branch, based on the `next` branch.

    ```
    $ git checkout -b my-awesome-fix next
    ```
2. Follow the coding conventions of the project you are contributing to (your code should not stand out or be stylistically different from the existing code).
3. Keep your Pull Request atomic. That means only one feature/bugfix per Pull Request. Fixing a bug and unrelated typos in the same Pull Request is not good conduct – simply make two Pull Requests.
4. Before submitting, rebase your topic branch on the current state of the `next` branch. This keeps the commit history clean and ensures no merge conflicts arise.
5. If possible, add descriptive tests that demonstrate your bugfix/feature. It should be clear when the test succeeds/fails. This includes describing the intended effect, not just informing the user when the callbacks fire.
6. All existing tests should pass/function as before.
7. If the Pull Request requires a specific version of another Steroids component to test, mention this in the Pull Request message.
8. The Pull Request message should be verbose and include a clear changelog of what's introduced: new features, API calls, bugfixes etc. We shouldn't have to look at  Do not make changes to `CHANGELOG.md` directly – the person merging the Pull Request will do that.
9. Reference any relevant GitHub issues in the Pull Request. Note that we use a single issue tracker for all Steroids platform issues at [https://github.com/appgyver/steroids/issues](https://github.com/appgyver/steroids/issues).

### Responding to comments
If we suggest changes, then

1. Make the required updates.
2. Re-run all tests to ensure that everything is functioning correctly.
3. Rebase your branch and force push to your GitHub repository. This will update your Pull Request.


    ```
    git rebase next -i
    git push -f
    ```