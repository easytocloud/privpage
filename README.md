![release workflow](https://github.com/erikmeinders/privpage/actions/workflows/release.yml/badge.svg)

# privpage

privpage is the privacy filter you always wanted on AWS cli output.

### background
As AWS instructors we often show aws cli output as part of demonstrations in our classrooms. 
There's always the risk of exposing too much information, certainly in this day and age of remote sessions. 
You can not be sure an attendee is not recording or screen-printing sensitive information.

Hence, you want to make sure to always mask certain sensitive information in your output.

<em>Introducing privpage!</em>

Using privpage, the following data will be masked in all aws cli output to your screen 

- 12 digit (AWS account) numbers
- AIDA (IAM User)
- AKIA (Access Key)
- AROA (Role)
- ASIA (STS key)

privpage only shows the last 3 characters of an AWS account number and masks everything between the first four and the last 3 characters of other masked data.

For testing, we add whoiam (who am i or whoami for AWS IAM). When configured correctly, it should not display your full Id and AWS accountnumber.

# Installation
Installation with Homebrew
```
brew tap easytocloud/tap
brew install privpage
```

or if you are not on a Homebrew supported Unix-like environment, 
clone this repository and install the privpage script somewhere in your path. The provided Makefile might work

```
make install
```

# Usage 

Use privpage in much the same way as you would use ```cat``` to see the content of a file, with AWS sensitive information removed. 
Show the content of your ~/.aws/credentials file with enough information to demonstrate the use,
without the stress of leaking your access key!
```
$ privpage ~/.aws/credentials
```

# Configuration as AWS pager

The privpage tool can also be used as an aws cli pager. 
Output of aws cli commands, for as far as it is to stdout, will be processed by privpage before written to the screen. 
The cli pager doesn't affect non-tty output!

There are two ways to configure using privpage (or any other pager) as aws cli pager.

Either you set the environment variable AWS_PAGER and it works for all profiles
or you limit it to a specific profile by adding 'cli_pager' to the profile's config block in the file ~/.aws/config or ~/.aws/credentials.

## Environment

```
export AWS_PAGER=privpage
```

## Profile specific

In your .aws/config add the cli_pager line 

```
[profile masked]
region=eu-west-1
cli_pager=privpage
source_profile=default
```

Now you can use the masked profile to mask output. 

```
export AWS_PROFILE=masked
```

or use our [aws-profile-organizer](https://github.com/easytocloud/aws-profile-organizer#awsprofile) to easily switch between profiles:

```
awsprofile masked
```

# Testing
When you run whoiam (aws sts get-caller-identity) with privpage installed and configured, sensitive data should be masked in the output.

```
$ whoiam
{
    "UserId": "AIDA*************WTX",
    "Account": "*********194",
    "Arn": "arn:aws:iam::*********194:user/erik""
}
```

Should you see non-masked output, please verify you have a recent version of the AWS CLI and check your configuration.

# Pager
The orriginal idea of AWS_PAGER / cli_pager is to page large amounts of output.
Should your output require paging, you can use the environment variable PRIVPAGER to use your favourite pager:
```
export PRIVPAGER=less
```

# CAUTION
As aws cli pagers only kick in when writing to a terminal, be very careful ... 
If you need to page the output, set PRIVPAGER as piping to `more`, `less` or whatever your outpur  will 
not run through the pager! 

IN STEAD OF
```
aws iam list-users | jq ".Users[].Arn". |  more
```
USE
```
aws iam list-users | jq ".Users[].Arn" | privpage
```

OR BETTER YET
```
aws iam list-users --query "Users[].Arn"
```
