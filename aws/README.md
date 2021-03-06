#### AWS
- Install `awscli` <https://docs.aws.amazon.com/cli/latest/userguide/install-linux.html>
- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesConnecting.html
- https://blog.boltops.com/2018/07/13/on-demand-vs-reserved-vs-spot-aws-ec2-pricing-comparison

#### Mount another volume
- <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html>
- `lsblk`
- `sudo file -s /dev/xvdb1` - to get information about a device
- `sudo fdisk -l /dev/xvdb1`
- `mkdir /xvdb1`, `sudo mount /dev/xvdb1 /xvdb1`

#### CloudFront
- <https://medium.com/@peatiscoding/here-is-how-easy-it-is-to-deploy-an-angular-spa-single-page-app-as-a-static-website-using-s3-and-6aa446db38ef>

#### Extend volume
```bash
# Modify volume in AWS GUI
# Attach to EC2

lsblk
sudo file -s /dev/nvme?n*
sudo file -s /dev/x*
sudo growpart /dev/nvme1n1 1

df -h
apt-get install e2fsprogs
resize2fs /dev/nvme1n1
```
