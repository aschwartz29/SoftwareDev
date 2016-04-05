 #!/usr/local/bin/perl


print "Content-type:text/html\
\
";
$to = 'jaliboze@conncoll.edu';
$from = 'jaliboze@conncoll.edu';
print "Message is being sent.";
open (MAIL, "|/usr/sbin/sendmail -t");
print MAIL "To: $to\n";
print MAIL "From: $from\n";

print MAIL "Subject: subject\
\
";
print MAIL "Hello";
print MAIL "\
\
";
$attachment = 'tumblr_nklqqxxae01s1l2r7o2_1280.jpg';
open(FILE, "uuencode $attachment $attachment|");
while( <FILE> ) { print MAIL; };
close(FILE);
close(MAIL);
print "Email Sent Successfully\n";
