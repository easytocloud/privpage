# privpage

privpage is the privacy filter you always wanted on AWS cli output.

As AWS instructors we show CLI output as part of demonstrations in our classrooms. 
There's always the risk of exposing too much information, certainly in this day and age of remote sessions. 
You can not be sure an attendee is not recoring or screen printing sensitive information.

Hence, you want to make sure to always mask certain sensitive information in your output.

<em>Introducing privpage!</em>

Using the AWS_PAGER environment variable or the pager statement in your .aws/config file streams cli output through the pager, typically less.

By setting your pager to privpage it will mask 

- 12 digit (AWS account) numbers
- AIDA
- etc

For testing we add whoiam (who am i or whoami for AWS IAM). When configured correctly, it should not display your full Id and AWS accountnumber.

# Installation

```
brew tap easytocloud/tap
brew install privpage
```

or if not on a Homebrew supported Unix-like environment, clone this repository and install the privpage script somewhere in your path. The provided Makefile might work

```
make install
```

# Configuration

There are two ways to make use of privpage. 

Either you set the environment variable AWS_PAGER and it works for all profile,
or you limit it to specific profiles by adding it to the profile's config file ~/.aws/config

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

# Testing

When you run whoiam with privpage installed, sensitive data should be masked in the output.

```
$ whoiam
{
    "UserId": "AIDA*************WTX",
    "Account": "*********194",
    "Arn": "arn:aws:iam::*********194:user/erik""
}
```

