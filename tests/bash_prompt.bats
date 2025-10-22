#!/usr/bin/env bats

setup() {
  export DOTFILES_PROMPT_AUTOLOAD=0
  source "${BATS_TEST_DIRNAME}/../.bash_prompt"
  export GIT_AUTHOR_NAME="Prompt Tester"
  export GIT_AUTHOR_EMAIL="prompt.tester@example.com"
  export GIT_COMMITTER_NAME="Prompt Tester"
  export GIT_COMMITTER_EMAIL="prompt.tester@example.com"
}

teardown() {
  unset DOTFILES_PROMPT_AUTOLOAD
}

setup_repo() {
  REPO_DIR="$(mktemp -d "${BATS_TEST_TMPDIR}/repo.XXXXXX")"
  cd "${REPO_DIR}"
  git init --quiet
  git config user.name "${GIT_AUTHOR_NAME}"
  git config user.email "${GIT_AUTHOR_EMAIL}"
  echo "initial" > README.md
  git add README.md
  git commit --quiet -m "initial"
  CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
}

@test "git segment is empty outside git repo" {
  local tmp
  tmp="$(mktemp -d "${BATS_TEST_TMPDIR}/plain.XXXXXX")"
  cd "${tmp}"
  segment="$(dotfiles_prompt_git_segment '' '')"
  [ -z "${segment}" ]
}

@test "git segment shows branch name for clean repo" {
  setup_repo
  segment="$(dotfiles_prompt_git_segment '' '')"
  [ "${segment}" = "${CURRENT_BRANCH}" ]
}

@test "git segment flags staged changes" {
  setup_repo
  echo "update" >> README.md
  git add README.md
  segment="$(dotfiles_prompt_git_segment '' '')"
  [ "${segment}" = "${CURRENT_BRANCH} [+]" ]
}

@test "git segment flags unstaged changes" {
  setup_repo
  echo "update" >> README.md
  segment="$(dotfiles_prompt_git_segment '' '')"
  [ "${segment}" = "${CURRENT_BRANCH} [!]" ]
}

@test "git segment flags untracked files" {
  setup_repo
  echo "temp" > scratch.txt
  segment="$(dotfiles_prompt_git_segment '' '')"
  [ "${segment}" = "${CURRENT_BRANCH} [?]" ]
}

@test "git segment flags stash entries" {
  setup_repo
  echo "stash" >> README.md
  git stash push --quiet
  segment="$(dotfiles_prompt_git_segment '' '')"
  [ "${segment}" = "${CURRENT_BRANCH} [$]" ]
}

@test "git segment combines status flags" {
  setup_repo
  echo "stash" >> README.md
  git stash push --quiet
  git stash apply --quiet
  echo "staged" > staged.txt
  git add staged.txt
  echo "changed" >> README.md
  echo "untracked" > untracked.txt
  segment="$(dotfiles_prompt_git_segment '' '')"
  [ "${segment}" = "${CURRENT_BRANCH} [+!?$]" ]
}

@test "git segment marks chromium repos with star" {
  setup_repo
  git remote add origin https://chromium.googlesource.com/chromium/src.git
  segment="$(dotfiles_prompt_git_segment '' '')"
  [ "${segment}" = "${CURRENT_BRANCH} [*]" ]
}

@test "PS1 uses normal user and host styles" {
  local tmp
  tmp="$(mktemp -d "${BATS_TEST_TMPDIR}/prompt.XXXXXX")"
  cd "${tmp}"
  bold='<b>'
  reset='</b>'
  white='WHITE'
  green='GREEN'
  yellow='YELLOW'
  violet='VIOLET'
  blue='BLUE'
  orange='ORANGE'
  red='RED'
  USER='kevin'
  unset SSH_TTY
  ps1="$(dotfiles_prompt_build_ps1)"
  [[ "${ps1}" == *'\$(dotfiles_prompt_git_segment'* ]]
  [[ "${ps1}" == *"\[ORANGE\]\\u"* ]]
  [[ "${ps1}" == *"\[YELLOW\]\\h"* ]]
  [[ "${ps1}" == *"\[GREEN\]\\w"* ]]
}

@test "PS1 highlights root and SSH sessions" {
  local tmp
  tmp="$(mktemp -d "${BATS_TEST_TMPDIR}/prompt-root.XXXXXX")"
  cd "${tmp}"
  bold='<b>'
  reset='</b>'
  white='WHITE'
  green='GREEN'
  yellow='YELLOW'
  violet='VIOLET'
  blue='BLUE'
  orange='ORANGE'
  red='RED'
  USER='root'
  SSH_TTY='/tmp/ssh-tty'
  ps1="$(dotfiles_prompt_build_ps1)"
  [[ "${ps1}" == *"\[<b>RED\]\\h"* ]]
  [[ "${ps1}" == *"\[RED\]\\u"* ]]
}
