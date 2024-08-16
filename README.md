# Easy Email Notifications For Failed Services

## Script "Installation"
Create *config.conf* by copying the *template.conf* file and inserting the correct values.

Email can be tested/used with \
`./email.sh -s "Service Name"`

Keep in mind to \
`sudo chmod +x email.sh`

## Install the Notification Service

Edit *notify-email@.service* with correct path to *email.sh*

Then move *notify-email@.service* to */etc/systemd/system/* (or other suitable systemd location) \
`sudo cp notify-email@.service /etc/systemd/system/notify-email@.service`

## Add the Notification Service to a Service

Finally, add this notification to the service under the [Unit] tag (see *dummy.service*) \
`OnFailure=notify-email@%i.service`

And reload the daemon \
`sudo systemctl daemon-reload`
