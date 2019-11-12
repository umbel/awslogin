## awslogin
A small **macOS** utility to simplify AWS MFA logons from the command line. It allows MFA authentication to any main or federated AWS account profile defined in `~/.aws/credentials`. It expects entries in that file to be formatted with 3 additional variables that are not part of the Amazon specs (read more below). Hehe's an example of how that file should be formatted:

<pre><code>
[default]
profile_name = default
username = cooluser
account_number = 987654321010
aws_access_key_id = ABCDEFGHIJKLMNOPQRST
aws_secret_access_key = laisef8;aoweinfasldkjf1348\23bn2o38&a10jn

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
  1. The **default** profile is for the main AWS account where your username is defined
  2. All other profiles are treated as **federated** AWS accounts you may have access to
  3. You **must** defined a valid key pair for your **default** profile
  4. Each profile must have a unique **profile_name** so this utility can identify it
  5. Each federated profile must have a valid **account_number** and **user_role**
  6. The `-c` switch can create a fresh skeleton `~/.aws/credentials` file

**NOTE:** This utility introduces and uses three new special variables (profile_name, account_number, and user_role) without breaking any of the original AWS `~/.aws/credentials` file functionality. If you find that this breaks something, please let me know.

## Installation
~~The preferred installation method is with [Homebrew](https://brew.sh):~~
  ~~1. `brew untap lencap/tools && brew tap lencap/tools` to grab the latest formula~~
  ~~2. `brew install lencap/tools/awslogin` or `brew upgrade lencap/tools/awslogin`~~

**NOTE:** Updated brew installation is TBD. Please follow below steps to compile and install manually.

Alternatively, you can compile and install manually:
  1. Install GoLang (please find out how that's done somewhere else).
  2. Run `make all` if compiling for the first time, or just `make` if it's a subsequent compile.
  3. Install the resulting `awslogin` binary somewhere in your PATH.

## Usage
To logon to one of your accounts run `awslogin stag TOKEN` where **stag** is one of the **profile_name** defined in your `~/.aws/credentials` file, and **TOKEN** is a 6-digit number from your MFA device. If the logon is successful, it will drop you into a **subshell** from where you can run **awscli** commands. To further verify you've logged on, you can run `env | grep AWS` to view the **AWS_SESSION_TOKEN** environment variable that were generated for this specific session.

Once you're done with your work, you can exit this subshell to return to your original shell. Note that **this means you can logon to multiple AWS accounts at the same time, using different shell windows**.

## Config file
Don't forget you also need to populate your `~/.aws/config` file, which usually just contains:
<pre><code>
[default]
region = us-east-1
output = json
</code></pre>

### Usage shell output
<pre><code>
$ awslogin
AWS CLI MFA Logon Utility 1.5.2
awslogin PROFILE TOKEN   Logon to account PROFILE using 6-digit TOKEN
         -l              List all account profiles in ~/.aws/credentials
         -c              Create skeleton ~/.aws/credentials file
         -h              Show additional help information
</code></pre>

## Development notes
Uses AWS SDK for Go (see http://docs.aws.amazon.com/sdk-for-go/api/), and has been successfully compiled and tested with at least Go v1.8.1 on MacOS Sierra 10.12.5.
