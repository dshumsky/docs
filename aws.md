#### AWS
- Install `awscli` <https://docs.aws.amazon.com/cli/latest/userguide/install-linux.html>
- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesConnecting.html
- https://blog.boltops.com/2018/07/13/on-demand-vs-reserved-vs-spot-aws-ec2-pricing-comparison

#### Mount another volume
- <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html>
- `lsblk`, `sudo file -s /dev/xvdb1`, 
- `mkdir /xvdb1`, `sudo mount /dev/xvdb1 /xvdb1`

