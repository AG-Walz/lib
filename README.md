## Table of contents
* [Table of contents](#table-of-contents)
* [General purpose](#general-purpose)
* [Generating your own personalized access code](#generating-your-own-personalized-access-code)
* [Create an Renviron file](#create-an-renviron-file)
  * [Mac and Linux](#mac-and-linux)
  * [Windows](#windows)

## General purpose
Since copy-pasting is a **sin**, script stored in the library can be accessed in other scripts easily. 
Before this is possible, you need to make sure that your personalized access token and github email address are stored on your computer in an external file. 
How this is done, can be read below.

## Generating your own personalized access code

1. Generate a new token on [GitHub](https://github.com/settings/tokens/new)
2. Add a note, describing where you are using this token for (example; `GITHUB_PAT`)
3. Fill in the expiration date (example; `90 days` or `No expiration`)
4. Select the following scopes:

    - [x] **repo**
      - [x] repo:status
      - [x] repo_deployment
      - [x] public_repo
      - [x] repo:invite
      - [x] security_events
    - [ ] **workflow**
    - [ ] **write:packages**
      - [ ] read:packages
    - [ ] **delete:packages**
    - [ ] **admin:org**
      - [ ] write:org
      - [ ] read:org
    - [ ] **admin:public_key**
      - [ ] write:public_key
      - [ ] read:public_key
    - [X] **admin:repo_hook**
      - [X] write:repo_hook
      - [X] read:repo_hook
    - [ ] **admin:org_hook**
    - [ ] **gist**
    - [ ] **notifications**
    - [ ] **user**
      - [ ] read:user
      - [ ] user:email
      - [ ] user:follow
    - [X] **delete_repo**
    - [ ] **write:discussion**
      - [ ] read:discussion
    - [ ] **admin:enterprise**
      - [ ] manage_billing:enterprise
      - [ ] read:enterprise
    - [ ] **admin:gpg_key**
      - [ ] write:gpg_key
      - [ ] read:gpg_key

5. Click on `Generate token`
6. Copy-paste the code which is highlighted in the green bar (this is your personalized access code) 

### Problems

If you want to have an overview about with codes are made, or if you want to remove or generate one, then you can go to the [Personalized access tokens] (https://github.com/settings/tokens) overview
Additionally, a detailed overview is provided in the GitHub [documents](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).

## Create an Renviron file

### Mac and Linux
1. Open the terminal (Control + Option + Shift + T / Ctrl+Alt+T) and type `touch $HOME/.Renviron`
2. To open the file you just created in the terminal using `open $HOME/.Renviron`

3. Then write the following information:
```
GITHUB_MAIL=[github email] 
GITHUB_PAT=[personalized access code]
```

4. This will save and store the content in an `.Renviron` file which is located in the Home folder.
5. If you opened RStudio, then reopen this.
6. As a test, run `Sys.getenv('GITHUB_MAIL')` to access the variable in R.

### Windows

1. Press Windows+R to open the Run dialog box, and then type `powershell` in the text box and open this. 
2. Copy this code into powershell

```
Add-Content c:\Users\$env:USERNAME\Documents\.Renviron "GITHUB_MAIL=[github email]"
Add-Content c:\Users\$env:USERNAME\Documents\.Renviron "GITHUB_PAT=[personalized access code]"
```
3. This will save and store the content in an `.Renviron` file in the Documents folder. 
4. If you opened RStudio, then reopen this. 
5. As a test, run `Sys.getenv('GITHUB_MAIL')` to access the variable in R.

### Problems
If you dont see anything when you run `Sys.getenv('GITHUB_MAIL')`, then the first rule when something goes wrong is [RTFM](https://en.wikipedia.org/wiki/RTFM), however you can also try to bribe your favorite bioinformatician (maybe this works).


