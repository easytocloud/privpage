# privpage

privpage is the privacy filter you always wanted on AWS cli output.

### background
As AWS instructors we often show aws cli output as part of demonstrations in our classrooms. 
There's always the risk of exposing too much information, certainly in this day and age of remote sessions. 
You can not be sure an attendee is not recording or screen-printing sensitive information.

Hence, you want to make sure to always mask certain sensitive information in your output.

<em>Introducing privpage!</em>

Using privpage, the following data will be masked in aws cli output

- 12 digit (AWS account) numbers
- AIDA (IAM User)
- AKIA (Access Key)
- AROA (Role)
- ASIA (STS key)

privpage only shows the last 3 characters of an AWS account number and masks everything between the first four and the last 3 characters of other masked data.

For testing, we add whoiam (who am i or whoami for AWS IAM). When configured correctly, it should not display your full Id and AWS accountnumber.

# Installation

```
brew tap easytocloud/tap
brew install privpage
```

or if you are not on a Homebrew supported Unix-like environment, 
clone this repository and install the privpage script somewhere in your path. The provided Makefile might work

```
make install
```

# Configuration

The privpage tool is used as an aws cli pager. There are two ways to make use of privpage. 

Either you set the environment variable AWS_PAGER and it works for all profiles
or you limit it to a specific profile by adding 'cli_pager' to the profile's config block in the file ~/.aws/config

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

