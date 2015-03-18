From: Dave Chinner <david@fromorbit.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] generic/066: add _require_metadata_replay
Date: Wed, 18 Mar 2015 14:33:53 +1100
Message-ID: <20150318033353.GD10105@dastard>
References: <1425000227-69601-1-git-send-email-jaegeuk@kernel.org>
 <1425000227-69601-2-git-send-email-jaegeuk@kernel.org>
 <alpine.LFD.2.00.1502271056110.2188@localhost.localdomain>
 <CAL3q7H50n+TmUT89sAeGsKeBsrHF4xo56ZRoZ2UZ3gw-15EUAg@mail.gmail.com>
 <alpine.LFD.2.00.1502271351340.2188@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <fstests-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1502271351340.2188@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: Filipe David Manana <fdmanana@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Filipe Manana <fdmanana@suse.com>, Eric Sandeen <sandeen@redhat.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Feb 27, 2015 at 02:10:55PM +0100, Luk=C3=A1=C5=A1 Czerner wrote=
:
> It's interesting, but it really applies only to metadata updates
> since really we normally only journal metadata. We do not
> consider extended attributes to be metadata, do we ?

Just to close the circle here, seeing as I don't think this was
answered: XFS considers all xattrs as metadata.

> > Yes, I'm considering xattrs as metadata (even though they can be se=
en
> > as data as well). This behaviour I'm testing for applies to ext3/4 =
and
> > xfs for example (and apparently intentional, since the test passes =
on
> > these filesystems).
>=20
> Ok, I am confused. Clearly ext4, nor xfs consider xattrs metadata
> which can be tested simply by attaching xattr and crashing the file
> system immediately afterwards - the new xattr will not be there -
> that's expected for data, but unexpected for metadata.

It is expected of metadata if there was no fsync.

> Now the fact that it works might be just a coincidence. Btw in the
> discussion Dave never mentioned xattr, he only talks about inode
> size and extent list changes which makes sense since those are
> metadata and it's expected to be "stabilised" as he very well
> described. I just do not think this applies to this case.

xattrs are part of the journalled inode metadata in XFS, just like
the size and data extent tree.

> Also I think that his wording that fsync on the file implies fsync
> on the directory is unfortunate because it does not.

POSIX does not define how file/directory synchronisation should
work - it allows fsync() to be a complete no-op, so we are really on
our own here. i.e. we define the behaviour ourselves.

> However it
> implies that the directory will actually be stabilised as well due
> to journalling. But the results are the same.

Exactly - what I've described previously is based on the
transactional model that ext4, XFS and btrfs use - they all use a
strongly ordered atomic transaction model. That is, if we commit
transaction N to stable storage, we also commit N-1, N-2, ... and
N-m. i.e. we commit everything from the last synchronisation point
up to the current sync target.

That gives quite clear dependency rules to fsync. e.g:

	create file "X" in dir "Y" (tx N)
	write 1 byte to X	   (tx N+1)
	fsync X			   (force out tx N, N+1)

When fsync completes, we are guaranteeing that the application will
be able to find the byte we wrote to X. That also implies that
directory Y has a dirent that points to X, and that X has a file
size of 1 and and extent that points to the allocated block.

i.e. fsync() implies that all metadata needed to reference the data
that has been synced is present on disk. that means "fsync X" also
implies "fsync Y" because Y is the only way of finding X. However,
if we do this:

	create file "X" in dir "Y" (tx N)
	write 1 byte to X	   (tx N+1)
	add xattr to Y		   (tx N+2)
	fsync X			   (force out tx N, N+1)

the fsync of X is not guaranteed to stabilise "xattr Y" because that
change occurred *after* the dependency between X and Y was created
and is not required to be synced to resolve the dependency between X
and Y...

The devil is in the detail, but we really should see XFS, ext4 and
btrfs all provide the same fsync behaviour w.r.t. metadata and
fsync. Consistency is data integrity behaviour across different
filesystems is a good thing. :)

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
