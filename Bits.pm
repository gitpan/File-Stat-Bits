package File::Stat::Bits;

=head1 NAME

File::Stat::Bits - stat(2) bit mask constants

=head1 SYNOPSIS

 use File::stat;
 use File::Stat::Bits;

 my $st = stat($file) or die "Can't stat $file: $!";

 if ( S_ISCHR($st->mode) ) {
	my ($major, $minor) = dev_split( $st->rdev );

	print "$file is character device $major:$minor\n";
 }

 printf "Permissions are %04o\n", $st->mode & ALLPERMS;


(Too many S_IF* constants to example)


=head1 DESCRIPTION

Lots of Perl modules use the Unix file permissions and type bits directly
in binary form with risk of non-portability for some exotic bits.
Note that the POSIX module does not provides all needed constants
and I can't wait when the POSIX module will be updated.

This separate module provides file type/mode bit and more constants
from sys/stat.ph and sys/sysmacros.ph without pollution caller's namespace
by other unneeded symbols from these headers.
Most of these constants exported by this module are Constant Functions
(see L<perlsub>).

Since some of Perl builds does not include these converted headers,
the build procedure will generate it for itself in the its own lib directory.

This module also should concentrate all portability and compatibility issues.

=cut

use strict;

BEGIN
{
    use Exporter;
    use vars qw($VERSION @ISA @EXPORT);

    $VERSION = do { my @r = (q$Revision: 0.3 $ =~ /\d+/g); sprintf "%d."."%02d" x $#r, @r };

    @ISA = ('Exporter');

    @EXPORT = qw(
	S_IRWXU S_IRUSR S_IWUSR S_IXUSR S_ISUID
	S_IRWXG S_IRGRP S_IWGRP S_IXGRP S_ISGID
	S_IRWXO S_IROTH S_IWOTH S_IXOTH S_ISVTX

	ACCESSPERMS ALLPERMS DEFFILEMODE

	S_IFMT S_IFDIR  S_IFCHR  S_IFBLK  S_IFREG   S_IFIFO  S_IFLNK  S_IFSOCK

	      &S_ISDIR &S_ISCHR &S_ISBLK &S_ISREG &S_ISFIFO &S_ISLNK &S_ISSOCK

	&dev_split &major &minor
    );


    {
	package File::Stat::Bits::dirty;

	use File::Basename;
	use lib dirname(__FILE__) . '/Bits';
	local $^W=0;
	require 'sys/stat.ph';
	require 'sys/sysmacros.ph';
    };


=head1 CONSTANTS

=head2

File type bit masks (for the st_mode field):

 S_IFMT		bitmask for the file type bitfields
 S_IFDIR	directory
 S_IFCHR	character device
 S_IFBLK	block device
 S_IFREG	regular file
 S_IFIFO	fifo (named pipe)
 S_IFLNK	symbolic link
 S_IFSOCK	socket

=cut
    my $s_ifmt   = File::Stat::Bits::dirty::S_IFMT  ();
    my $s_ifdir  = File::Stat::Bits::dirty::S_IFDIR ();
    my $s_ifchr  = File::Stat::Bits::dirty::S_IFCHR ();
    my $s_ifblk  = File::Stat::Bits::dirty::S_IFBLK ();
    my $s_ifreg  = File::Stat::Bits::dirty::S_IFREG ();
    my $s_ififo  = File::Stat::Bits::dirty::S_IFIFO ();
    my $s_iflnk  = File::Stat::Bits::dirty::S_IFLNK ();
    my $s_ifsock = File::Stat::Bits::dirty::S_IFSOCK();

    sub S_IFMT  () { $s_ifmt   }
    sub S_IFDIR () { $s_ifdir  }
    sub S_IFCHR () { $s_ifchr  }
    sub S_IFBLK () { $s_ifblk  }
    sub S_IFREG () { $s_ifreg  }
    sub S_IFIFO () { $s_ififo  }
    sub S_IFLNK () { $s_iflnk  }
    sub S_IFSOCK() { $s_ifsock }


=head2

File access permission bit masks (for the st_mode field):

 S_IRWXU	mask for file owner permissions
 S_IRUSR	owner has read permission
 S_IWUSR	owner has write permission
 S_IXUSR	owner has execute permission
 S_ISUID	set UID bit

 S_IRWXG	mask for group permissions
 S_IRGRP	group has read permission
 S_IWGRP	group has write permission
 S_IXGRP	group has execute permission
 S_ISGID	set GID bit

 S_IRWXO	mask for permissions for others
 S_IROTH	others have read permission
 S_IWOTH	others have write permisson
 S_IXOTH	others have execute permission
 S_ISVTX	sticky bit

Common mode bit masks:

 ACCESSPERMS	 0777
    ALLPERMS	07777
 DEFFILEMODE	 0666

=cut
    my $s_irwxu = File::Stat::Bits::dirty::S_IRWXU();
    my $s_irusr = File::Stat::Bits::dirty::S_IRUSR();
    my $s_iwusr = File::Stat::Bits::dirty::S_IWUSR();
    my $s_ixusr = File::Stat::Bits::dirty::S_IXUSR();
    my $s_isuid = File::Stat::Bits::dirty::S_ISUID();

    my $s_irwxg = File::Stat::Bits::dirty::S_IRWXG();
    my $s_irgrp = File::Stat::Bits::dirty::S_IRGRP();
    my $s_iwgrp = File::Stat::Bits::dirty::S_IWGRP();
    my $s_ixgrp = File::Stat::Bits::dirty::S_IXGRP();
    my $s_isgid = File::Stat::Bits::dirty::S_ISGID();

    my $s_irwxo = File::Stat::Bits::dirty::S_IRWXO();
    my $s_iroth = File::Stat::Bits::dirty::S_IROTH();
    my $s_iwoth = File::Stat::Bits::dirty::S_IWOTH();
    my $s_ixoth = File::Stat::Bits::dirty::S_IXOTH();
    my $s_isvtx = File::Stat::Bits::dirty::S_ISVTX();


    sub S_IRWXU() { $s_irwxu }
    sub S_IRUSR() { $s_irusr }
    sub S_IWUSR() { $s_iwusr }
    sub S_IXUSR() { $s_ixusr }
    sub S_ISUID() { $s_isuid }

    sub S_IRWXG() { $s_irwxg }
    sub S_IRGRP() { $s_irgrp }
    sub S_IWGRP() { $s_iwgrp }
    sub S_IXGRP() { $s_ixgrp }
    sub S_ISGID() { $s_isgid }

    sub S_IRWXO() { $s_irwxo }
    sub S_IROTH() { $s_iroth }
    sub S_IWOTH() { $s_iwoth }
    sub S_IXOTH() { $s_ixoth }
    sub S_ISVTX() { $s_isvtx }


    sub ACCESSPERMS()	{ S_IRWXU|S_IRWXG|S_IRWXO }
    sub    ALLPERMS()	{ S_ISUID|S_ISGID|S_ISVTX|ACCESSPERMS }
    sub DEFFILEMODE()	{ S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH }


=head1 FUNCTIONS

=head2

File type test macros (for the st_mode field):

 S_ISDIR ( mode )	directory?
 S_ISCHR ( mode )	character device?
 S_ISBLK ( mode )	block device?
 S_ISREG ( mode )	regular file?
 S_ISFIFO( mode )	fifo (named pipe)?
 S_ISLNK ( mode )	is it a symbolic link?
 S_ISSOCK( mode )	socket?

All returns boolean value.

=cut
    sub s_istype
    {
	my ($mode, $mask) = @_;
	(($mode & S_IFMT) == ($mask));
    }

    sub S_ISDIR  { my ($mode) = @_; s_istype($mode, S_IFDIR ) }
    sub S_ISCHR  { my ($mode) = @_; s_istype($mode, S_IFCHR ) }
    sub S_ISBLK  { my ($mode) = @_; s_istype($mode, S_IFBLK ) }
    sub S_ISREG  { my ($mode) = @_; s_istype($mode, S_IFREG ) }
    sub S_ISFIFO { my ($mode) = @_; s_istype($mode, S_IFIFO ) }
    sub S_ISLNK  { my ($mode) = @_; s_istype($mode, S_IFLNK ) }
    sub S_ISSOCK { my ($mode) = @_; s_istype($mode, S_IFSOCK) }
}



=head2

$major = major( $st_rdev )

Returns major device number of st_rdev

=cut
sub major
{
    my $dev = shift;
    return File::Stat::Bits::dirty::major($dev);
}


=head2

$minor = minor( $st_rdev )

Returns minor device number of st_rdev

=cut
sub minor
{
    my $dev = shift;
    return File::Stat::Bits::dirty::minor($dev);
}


=head2

($major, $minor) = dev_split( $st_rdev )

Splits st_rdev to major and minor device numbers

=cut
sub dev_split
{
    my $dev = shift;
    return ( major($dev), minor($dev) );
}


# can not use makedev converted by h2ph incorrectly
#
#=head2
#
#$st_rdev = dev_join( $major, $minor )
#
#Makes st_rdev from major and minor device numbers (makedev())
#
#=cut

#sub dev_join
#{
#    my ($major, $minor) = @_;
#    return File::Stat::Bits::dirty::makedev($major, $minor);
#}


=head1 SEE ALSO

L<stat(2)>

L<File::stat(3)>


=head1 AUTHOR

Dmitry Fedorov <fedorov@inp.nsk.su>

=head1 COPYRIGHT

Copyright (c) 2003, Dmitry Fedorov <fedorov@inp.nsk.su>

=head1 LICENCE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License,
or (at your option) any later version.

=head1 DISCLAIMER

The author disclaims any responsibility for any mangling of your system
etc, that this script may cause.

=cut


1;

