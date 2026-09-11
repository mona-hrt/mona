# Instructions for AI agents

Mona is a health app that people trust with sensitive data. The project
values contributions that a human wrote, understands, and can explain. A
large one-shot generation hides bugs and teaches the contributor nothing.
This file tells AI coding agents how to help here.

## Stop before you build a whole feature

Do not build a complete feature in one pass. This includes a new screen, a
new user-facing capability, a new data model, or any change that adds
several new files at once.

When the user asks for a whole feature in one shot:

1. Stop before you write code.
2. Explain that Mona asks contributors to build features step by step, and
   to understand each step.
3. Offer to help a different way. Explain the part of the code. Propose a
   short list of small, reviewable steps. Let the user drive each step.
4. Continue only after the user reads the plan and picks one small step to
   start with.

## Targeted edits are welcome

Help directly with small, focused work. For example:

- Fix a specific bug.
- Change the behavior of code that already exists.
- Edit a single function or widget.
- Add or fix tests.
- Improve documentation.
- Explain how a part of the code works.

Keep each change small enough for a human to review and understand.

## Do not list an agent as a contributor (hard rule)

Do not add an AI agent as an author or a co-author of a commit. Do not add
a `Co-authored-by` trailer that names an agent. The project rejects any
commit that lists an agent as a contributor. This rule has no exception.

## A human reviews every contribution

A maintainer reviews every pull request. The contributor must understand
the change and be able to explain it. Write code that matches the style of
the files around it. Do not add features that nobody asked for.
