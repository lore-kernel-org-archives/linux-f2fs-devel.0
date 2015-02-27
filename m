From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] generic/066: add _require_metadata_replay
Date: Fri, 27 Feb 2015 11:02:37 -0800
Message-ID: <20150227190153.GB71843@jaegeuk-mac02.mot.com>
References: <1425000227-69601-1-git-send-email-jaegeuk@kernel.org>
 <1425000227-69601-2-git-send-email-jaegeuk@kernel.org>
 <alpine.LFD.2.00.1502271056110.2188@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <fstests-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1502271056110.2188@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Filipe Manana <fdmanana@suse.com>, Eric Sandeen <sandeen@redhat.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Lukas,

On Fri, Feb 27, 2015 at 12:34:09PM +0100, Luk=C3=A1=C5=A1 Czerner wrote=
:
> On Thu, 26 Feb 2015, Jaegeuk Kim wrote:
>=20
> > Date: Thu, 26 Feb 2015 17:23:47 -0800
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > To: Dave Chinner <david@fromorbit.com>
> > Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net=
,
> >     Jaegeuk Kim <jaegeuk@kernel.org>, Filipe Manana <fdmanana@suse.=
com>,
> >     Eric Sandeen <sandeen@redhat.com>
> > Subject: [PATCH 2/2] generic/066: add _require_metadata_replay
> >=20
> > This patch adds _require_metadata_replay to detect whether or not f=
ilesystem
> > supports metadata replay.
> >=20
> > This should be used when:
> >=20
> > 1. create file A
> > 2. write file A
> > 3. fsync file A
> >=20
> > 4. write file A
> >=20
> > 5. create file B
> > 6. fsync file B
> > 7. crash!
> >=20
> > In this case, if filesystem supports metadata_replay, file A's data=
 written
> > by #4 should be recovered.
>=20
> What ? No it should not! file A was never fsync after the last
> write, so there is no guarantee that we'll have the new content.
> "Metadata replay" suggests that we only replay metadata, not data
> and that's what file systems usually do with they journals, cows,
> and so on...

I totally wrote this description insanely.
My apologies.

Yes, what I wanted to point out was the coverage of xattr recovery, not=
 data.
1. create file A
2. write file A
3. fsync file A

*4. setxattr file A

5. create file B
6. fsync file B
7. crash!

What I've focussed on actually was the coverage of metadata replay whic=
h depends
on filesystem's design.

In this case, I think the metadata log contains:
=2E..
1. fsync'ed file A
2. changed xattrs on file A
3. fsync'ed file B

Currently, xfs and ext4 recover #2, and btrfs without Filipe's patch do=
es not.
And, I understood that this testcase intends to check #2 is recoverable=
 or not.

IMHO, however, basically filesystem doesn't need to recover #2 at all.
So, I tried to add _require_something to check whether filesystem recov=
ers
written xattrs followed by any fsync'ed file coincidentally.

Thanks,

>
>=20
> But this test is not about writing to a file, it's about changing
> file xattr. And while extended attributes are metadata, they are
> _not_ file system metadata and as such I think it can be very well
> treated as data. Hence explicit fsync is needed to make sure it's
> written to the disk.
>=20
> Now let's look at the test itself:
>=20
>=20
> 	echo "hello world!" >> $SCRATCH_MNT/foobar
> 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foobar
> 	$SETFATTR_PROG -x user.attr1 $SCRATCH_MNT/foobar
> 	ln $SCRATCH_MNT/foobar $SCRATCH_MNT/foobar_link
> 	touch $SCRATCH_MNT/qwerty
> 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/qwerty
>=20
> 	_crash_and_mount
>=20
> 	# Now only the xattr with name user.attr3 should be set in our file.
> 	echo "xattr names and values after second fsync log replay:"
> 	$GETFATTR_PROG --absolute-names --dump $SCRATCH_MNT/foobar |
> 	_filter_scratch
>=20
> No it should not have only attr3 because $SCRATCH_MNT/foobar was
> never fsynced after attr3 removal. If the internal design of the
> file system accidentally synces unrelated xattrs on unrelated fsync,
> than that's fine, but that's not what we need to test for at all
> because it might not be guaranteed by all the file systems. So I
> think this last part of the test is rather pointless. So I think
> this patch is not needed as well.
>=20
> Or am I missing something Filipe ?
>=20
> Thanks!
> -Lukas
>=20
> > Otherwise, file A is recovered to #3.
>=20
>=20
> >=20
> > Cc: Filipe Manana <fdmanana@suse.com>
> > Cc: Eric Sandeen <sandeen@redhat.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  common/rc         | 18 ++++++++++++++++++
> >  tests/generic/066 |  2 +-
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/common/rc b/common/rc
> > index 1ed9df5..e6e8d1f 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2372,6 +2372,24 @@ _require_metadata_journaling()
> >  	esac
> >  }
> > =20
> > +# Does this filesystem support metadata replay?
> > +# Filesystem is able to recover metadata which were not written by=
 fsync
> > +# exlicitly. But another fsync'ed metadata should be followed by t=
hem.
> > +_require_metadata_replay()
> > +{
> > +	_require_metadata_journaling $1
> > +
> > +	case "$FSTYP" in
> > +	f2fs)
> > +		# f2fs supports metadata_journaling, but does not recover any
> > +		# intermediate metadata which was not fsync'ed explicitly.
> > +		_notrun "$FSTYP does not support metadata replay"
> > +		;;
> > +	*)
> > +		;;
> > +	esac
> > +}
> > +
> >  # Does fiemap support?
> >  _require_fiemap()
> >  {
> > diff --git a/tests/generic/066 b/tests/generic/066
> > index cb36506..3fefda4 100755
> > --- a/tests/generic/066
> > +++ b/tests/generic/066
> > @@ -61,7 +61,7 @@ _need_to_be_root
> >  _require_scratch
> >  _require_dm_flakey
> >  _require_attrs
> > -_require_metadata_journaling $SCRATCH_DEV
> > +_require_metadata_replay $SCRATCH_DEV
> > =20
> >  _crash_and_mount()
> >  {
> >=20
