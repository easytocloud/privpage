# privpage

privpage is the privacy filter you always wanted on AWS cli output.

As AWS instructors we show CLI output as part of demonstrations in our classrooms. 
There's always the risk of exposing too much information, certainly in this day and age or remote sessions. 
You can not be sure an attendee is not recoring or screen printing sensitive information.

Hence, you want to always make sure to mask certain sensitive information in your output.

Introducing privpage!

Using the AWS_PAGER environment variable or the pager statement in your .aws/config file streams cli output through the pager, typically less.

By setting AWS_PAGER to privpage it will mask 

- 12 digit (AWS account) numbers
- AIDA
- etc

For testing we add whoiam (who am i or whoami for AWS IAM). When configured correctly, it should not display your full Id and AWS accountnumber.

# Installation

```
brew tap easytocloud/tap
brew install privpage
```

or if not on a Homebrew supported Unix-like environment, clone this repository and install the privpage script somewhere in your path.

# Configuration

In your .aws/credentials file add a profile with masking

```
[masked]
source_profile=default
cli_pager=privpage
```

Now you can use the masked profile to mask output. Alternatively you can set AWS_PAGER to privpage

```
export AWS_PAGER=privpage
```


