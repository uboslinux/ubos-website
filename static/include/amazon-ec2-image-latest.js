var thisScript = document.getElementById( 'ubos-amazon-ec2-image-latest' );
var parent     = thisScript.parentElement;
var imageDiv   = document.createElement( 'div' );

imageDiv.id        = 'ubos-amazon-ec2-image-latest';
imageDiv.style     = 'text-align: center';
imageDiv.innerHTML = '<a href="https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:ami=ami-0363a4bb10fa9a766" target="_blank"><img src="https://ubos.net/images/ubos-on-aws-100x95.png" alt="[EC2 image]" style="padding: 10px; border-radius: 5px; border: #a0a0a0 1px solid"/></a>';

parent.replaceChild( imageDiv, thisScript );

