 #!/usr/local/bin/perl

 use CGI;

    $to = 'jaliboze@conncoll.edu';
    $from = 'jaliboze@conncoll.edu';
    $subject = 'Test Email';
    $message = 'This is test email sent by Perl Script';
 
    open(MAIL, "|/usr/sbin/sendmail -t");
 
# Email Header
    print MAIL "To: $to\n";
    print MAIL "From: $from\n";
    print MAIL "Subject: $subject\n\n";
# Email Body
    print MAIL $message;

    close(MAIL);
    print "Email Sent Successfully\n";
