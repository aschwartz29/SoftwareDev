#!/usr/local/bin/perl
# adapted from code by the cgi guru Lincoln Stein
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
<H1>    File Reflection</H1>
Select the <VAR>browse</VAR> button to choose a text file
to upload.  When you press the submit button, this script
will reflect the file back to your browser view.  (The idea
is that more involved file manipulations, than the identity,
can be built off this in further developments.)
END
    ;

    # Start a multipart form.
    print
	$query->start_multipart_form,
	"Enter the file to process:",
	$query->filefield(-name=>'filename',
			  -size=>30),"<BR>",
	$query->submit(-label=>'Process File'),
	$query->end_form;
}

sub do_work {
    my($query) = @_;

   # Process the form if there is a file name entered
    if ($file = $query->param('filename')) {
	print "<HR>\n";
	print "<H2>File $file has the following text:</H2>\n";
	while (<$file>) {
	    print "$_";
	}
    }
}

sub print_tail {
    print <<END;
<HR>
END
    ;
    print $query->end_html;
}
