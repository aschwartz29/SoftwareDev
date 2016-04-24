#!/usr/local/bin/perl

use CGI;
$query = new CGI;
print $query->header;
&do_prompt($query);
&do_work($query);
&print_tail;

sub do_prompt {
    my($query) = @_;
    print <<END;
<BODY BACKGROUND="star.gif">
<H1>    Clustering</H1>
Upload a data file to get a rough clustering of the data.  You can have the results emailed to you.
END
    ;

    # Start a multipart form.
    print
    $query->start_multipart_form,
    "<BR>",
    "Enter the file to cluster:",
    $query->filefield(-name=>'filename',
        -size=>30),"<BR>",
    $query->submit(-label=>'Process File'),
    "<BR>",
    "<BR>",

    "Enter your email address to receive the clustered solution:<BR>",
    $query->textarea(-name=>'textentry',
        -rows=>2,-cols=>50),"<P>",
    $query->submit(-label=>'Process File'),
    "<BR>",
    "<BR>",

    "Click here for a demo:<BR>",
    $query->submit(-name=>'demo', -value=> 'Demo'),
    $query->end_form;

}

sub do_work {
    my($query) = @_;

   # Process the form if there is a file name entered
  if ($file = $query->param('filename')) {

    print "<H2>The data in $file will be clustered</H2>\n";

    ####
    ##Should run Python script but not working!!
    open (my $py, "|-", "cd ~Applications/XAMPP/cgi-bin/clusterMethod.py") or die "Python script returned error $!";
    while (<$py>) {
        print clusters;
    }
    close ($py);

    ##DRAW IMAGE BUT DOESN"T WORK#######
    # select(STDOUT); $| = 1;   #unbuffer STDOUT
    # print "Content-type: image/png\n\n";

     #open (IMAGE, '<', 'flowers.jpg');
     #print <IMAGE>;
     #close IMAGE;
    #####

    print "<img src=/image1.eps>";
  }
  if ($email = $query->param('textentry')){
    print "<H2>The result will be sent to $file </H2>\n";
    do `cd ~/Desktop/softwareDev/perl email.pl`;

  }

  ##IF DEMO SELECTED, GIVE RESULT OF CLUSTERING FOR SAMPLE DATA
  if ($demoButton = $query->param('demo')){
    print "<img src=/demo.jpeg width =500 height =500>";
  }
}


sub print_tail {
    print <<END;
<HR>
END
    ;
    print $query->end_html;
}
