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
INTRODUCTION TEXT GOES HERE
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
    $query->submit(-label=>'Demo'),
    $query->end_form;

}

sub do_work {
    my($query) = @_;

   # Process the form if there is a file name entered
  if ($file = $query->param('filename')) {
    print "<H2>The data in $file will be clustered</H2>\n";
    ###THIS IS WHERE WE WILL CALL THE CLUSTERING METHOD AND PASS THE DATA
  }
  if ($file = $query->param('textentry')){
    print "<H2>The result will be sent to $file </H2>\n";
    ###THIS IS WHERE WE WILL PROCESS THE EMAIL ADDRESS TO SEND SOLUTION TO
  }

  ##IF DEMO SELECTED, GIVE RESULT OF CLUSTERING FOR SAMPLE DATA

}




sub print_tail {
    print <<END;
<HR>
END
    ;
    print $query->end_html;
}
