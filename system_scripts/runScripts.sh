#!/bin/sh

################################
SCRIPTDIR="/etc/cpves"
################################
$SCRIPTDIR/create_mailboxes.pl
$SCRIPTDIR/create_mailfilters.pl
$SCRIPTDIR/create_fetchmail.pl
$SCRIPTDIR/delete_mailbox.pl
