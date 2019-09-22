#!/usr/bin/perl

open(INF, "question_paper");

@ary = <INF>;
close(INF);

foreach $line (@ary) {
	chomp($line);
	if (length $line == 0) { }
	elsif (length $line == 1) {
		$correct_answer[$q_no] = $line;
		}
	elsif ($line=~/o\)/) {
		$number_answer++;
		$answer[$q_no][$number_answer]=$line;
		}
	else {
		$q_no++;
		$number_answer =0;
		$question[$q_no]=$line;
		}
#	print "$line\n";
	}

#-------Printing the original data----------------
#for ($i=$q_no; $i>=1; $i--) {
#	print "$question[$i]\n";
#	for ($j=1; $j<=4; $j++) {
#		print "$answer[$i][$j]\n";
#	}
#	print "$correct_answer[$i]\n";
#}
#--------End of printing original data-------------
#--------Initialization of some variable----------
$number_script=55;
$course="M.Sc. Sem-II";
$Year = 2019;
$FullMarks = 10;
#---------Printing the headers for rtf file----------
	print "\{\\rtf1\\ansi\\deff0\{\\fonttbl\n";
	print "\{\\f0 Times New Roman;\}\n";
	print "\{\\f1 Symbol;\}\n";
	print "\}\n";
	print "\\paperw11908\\paperh16833\n";
	print "\\margl720\\margt720\\margr720\\margb720\n";
	print "\\tx720\\tx720\n";
for ($script=1; $script <=$number_script; $script++) {

#--------Starting randomization of question numbers---
	for ($i=1; $i<=$q_no; $i++) {
		$q[$i]=$i;
	}
	for ($p=$q_no; $p>=1; $p--) {
		$target_q = 1 + int($p*rand());
		$temp=$q[$p];
		$q[$p]=$q[$target_q];
		$q[$target_q]=$temp;
	}
#for ($i=1; $i<=$q_no; $i++) {
#	print "$q[$i]\n";
#	}
#---------End of initialization----------------------
#---------Printing the necessary headers-------------
	print "\\page\\pard\\qc Script Number - $script\/$Year\\line ";
	print "(Do not write or mark anything on this page)\\par\n";
#---------End of the Header--------------------------
	for ($i=1; $i<=$q_no; $i++) {
		print "\\pard\\ql $i\) $question[$q[$i]]\\line\n";
	
		for ($k=4; $k>=1; --$k) {
			$choice = 1 + int ($k*rand());
			if ($choice !=$k) {
				$temp = $answer[$q[$i]][$k];
				$answer[$q[$i]][$k]=$answer[$q[$i]][$choice];
				$answer[$q[$i]][$choice]=$temp;
				if ($correct_answer[$q[$i]]==$k) {
					$correct_answer[$q[$i]]=$choice;
				}
				elsif ($correct_answer[$q[$i]]==$choice) {
					$correct_answer[$q[$i]]=$k;
				}
			}
		}
#---------Make a copy of the randomized answer for printing ---
		for ($j=1; $j<=4; $j++) {
			$rand_answer[$j]=$answer[$q[$i]][$j];
		}
		for ($j=1; $j<=4; $j++) {
			if ($j==1) {
				$rand_answer[$j]=~s/o\)/a\)/;
				print "\\tab\\tab $rand_answer[$j]\\line\n";
			}
			if ($j==2) {
				$rand_answer[$j]=~s/o\)/b\)/;
				print "\\tab\\tab $rand_answer[$j]\\line\n";
			}
			if ($j==3) {
				$rand_answer[$j]=~s/o\)/c\)/;
				print "\\tab\\tab $rand_answer[$j]\\line\n";
			}
			if ($j==4) {
				$rand_answer[$j]=~s/o\)/d\)/;
				print "\\tab\\tab $rand_answer[$j]\\par\n";
			}
		}
#----------Memorizing the correct answer in a 2Darray page----
		if ($correct_answer[$q[$i]]==1) { $page[$script][$i]="a"; }
		if ($correct_answer[$q[$i]]==2) { $page[$script][$i]="b"; }
		if ($correct_answer[$q[$i]]==3) { $page[$script][$i]="c"; }
		if ($correct_answer[$q[$i]]==4) { $page[$script][$i]="d"; }
#--------------print "$correct_answer[$q[$i]]\n";
#print "$i    $page[$script][$i]\n";
#		print "Script $script ";
#		for ($l=1; $l<=$q_no; $l++) {
#			print "$l $page[$script][$l]  ";
#			print "\n";
#		}
	}
}

#----------Confidential portion-----------------------------
print "\\page\\pard Answer of the $number_script script(s) of $course $Year\\line\n";
for ($script=1; $script <= $number_script; $script++) {
	print "\\line Script-$script:  ";
	for ($l=1; $l<=$q_no; $l++) {
		print "$l$page[$script][$l]  ";
	}
	print "\\line\n";
}
print "\}\n";
