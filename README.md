## awslogin
This utility simplifies AWS MFA logons from the command line.

This utilility allows CLI MFA authentication to any main or federated AWS account profile defined in `~/.aws/credentials`. It expects that file to be formatted using 3 additional variables (read more below). Below is an example of how the `~/.aws/credentials` file should be formatted:

<pre><code>
[default]
aws_access_key_id = AKERNEIDUFENICUQ3NDO
aws_secret_access_key = ilsjkasdUEwlwDUgvD1b7234Fn/lepi0ACmk8upFy

[stag]
profile_name = stag
account_number = 466692114123
user_role = PowerUser

[prod]
profile_name = prod
account_number = 544492114123
user_role = PowerUser

[accountN]
profile_name = accountN
account_number = 012345114123
user_role = Administrator
</code></pre>

Note that you can also read above and below information by running `awslogin -h`.

In short, the formatting means that:
  1. The **default** profile is for your main AWS account
  2. All other profiles are treated as **federated** AWS accounts that your main AWS account credentials may have access to
  3. You **must** defined a valid key pair for your **default** profile
  4. Each profile must have a unique **profile_name** so this utility can identify it
  5. Each federated profile must have a valid **account_number** and **user_role**
  6. The `-c` switch can create a fresh skeleton `~/.aws/credentials` file

**NOTE:** This utility introduces and uses three new special variables (profile_name, account_number, and user_role) without breaking any of the original AWS `~/.aws/credentials` file functionality. If you find that this breaks something, please let me know.

## Installation
Note that this has only been tested on macOS:
  1. Please first check if your team has an already compiled `awslogin` macOS binary file somewhere.
  2. Alternative, you can compile it yourself below:
  3. Install GoLang (please find out how that's done somewhere else).
  4. Run `make all` for the first time or just `make` for subsequent changes. 
  5. Install the resulting `awslogin` binary anywhere in your PATH.

## Usage
To logon to one of your accounts run `awslogin stag TOKEN` where **stag** is one of the **profile_name** defined in your `~/.aws/credentials` file, and **TOKEN** is a 6-digit number from your MFA device. If the logon is successful, it will drop you into a **subshell** from where you can run **awscli** commands. To further verify you've logged on, you can run `env | grep AWS` to view the **AWS_SESSION_TOKEN** environment variable that were generated for this specific session.

Once you're done with your work, you can exit this subshell to return to your original shell. **This means you can logon to multiple AWS accounts at the same time, using different shell windows.**
  
### Usage shell output
<pre><code>
$ awslogin
AWS CLI MFA Logon Utility 1.5.1
awslogin PROFILE TOKEN   Logon to account PROFILE using 6-digit TOKEN
         -l              List all account profiles in ~/.aws/credentials
         -c              Create skeleton ~/.aws/credentials file
         -h              Show additional help information
</code></pre>

## Development notes
Uses AWS SDK for Go (see http://docs.aws.amazon.com/sdk-for-go/api/). And has been successfully compiled and tested with Go v1.8.1 on MacOS Sierra 10.12.5
