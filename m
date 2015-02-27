From: Filipe David Manana <fdmanana@gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] generic/066: add _require_metadata_replay
Date: Fri, 27 Feb 2015 11:43:36 +0000
Message-ID: <CAL3q7H50n+TmUT89sAeGsKeBsrHF4xo56ZRoZ2UZ3gw-15EUAg@mail.gmail.com>
References: <1425000227-69601-1-git-send-email-jaegeuk@kernel.org>
	<1425000227-69601-2-git-send-email-jaegeuk@kernel.org>
	<alpine.LFD.2.00.1502271056110.2188@localhost.localdomain>
Reply-To: fdmanana@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <fstests-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1502271056110.2188@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: =?UTF-8?B?THVrw6HFoSBDemVybmVy?= <lczerner@redhat.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Filipe Manana <fdmanana@suse.com>, Eric Sandeen <sandeen@redhat.com>, Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Feb 27, 2015 at 11:34 AM, Luk=C3=A1=C5=A1 Czerner <lczerner@red=
hat.com> wrote:
> On Thu, 26 Feb 2015, Jaegeuk Kim wrote:
>
>> Date: Thu, 26 Feb 2015 17:23:47 -0800
>> From: Jaegeuk Kim <jaegeuk@kernel.org>
>> To: Dave Chinner <david@fromorbit.com>
>> Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
>>     Jaegeuk Kim <jaegeuk@kernel.org>, Filipe Manana <fdmanana@suse.c=
om>,
>>     Eric Sandeen <sandeen@redhat.com>
>> Subject: [PATCH 2/2] generic/066: add _require_metadata_replay
>>
>> This patch adds _require_metadata_replay to detect whether or not fi=
lesystem
>> supports metadata replay.
>>
>> This should be used when:
>>
>> 1. create file A
>> 2. write file A
>> 3. fsync file A
>>
>> 4. write file A
>>
>> 5. create file B
>> 6. fsync file B
>> 7. crash!
>>
>> In this case, if filesystem supports metadata_replay, file A's data =
written
>> by #4 should be recovered.
>
> What ? No it should not! file A was never fsync after the last
> write, so there is no guarantee that we'll have the new content.
> "Metadata replay" suggests that we only replay metadata, not data
> and that's what file systems usually do with they journals, cows,
> and so on...
>
> But this test is not about writing to a file, it's about changing
> file xattr. And while extended attributes are metadata, they are
> _not_ file system metadata and as such I think it can be very well
> treated as data. Hence explicit fsync is needed to make sure it's
> written to the disk.
>
> Now let's look at the test itself:
>
>
>         echo "hello world!" >> $SCRATCH_MNT/foobar
>         $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foobar
>         $SETFATTR_PROG -x user.attr1 $SCRATCH_MNT/foobar
>         ln $SCRATCH_MNT/foobar $SCRATCH_MNT/foobar_link
>         touch $SCRATCH_MNT/qwerty
>         $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/qwerty
>
>         _crash_and_mount
>
>         # Now only the xattr with name user.attr3 should be set in ou=
r file.
>         echo "xattr names and values after second fsync log replay:"
>         $GETFATTR_PROG --absolute-names --dump $SCRATCH_MNT/foobar |
>         _filter_scratch
>
> No it should not have only attr3 because $SCRATCH_MNT/foobar was
> never fsynced after attr3 removal. If the internal design of the
> file system accidentally synces unrelated xattrs on unrelated fsync,
> than that's fine, but that's not what we need to test for at all
> because it might not be guaranteed by all the file systems. So I
> think this last part of the test is rather pointless. So I think
> this patch is not needed as well.
>
> Or am I missing something Filipe ?

So that second part of the test, essentially comes from this ordered
metadata dependency explanation Dave gave me recently on another
thread:

http://www.spinics.net/lists/linux-btrfs/msg42086.html

Yes, I'm considering xattrs as metadata (even though they can be seen
as data as well). This behaviour I'm testing for applies to ext3/4 and
xfs for example (and apparently intentional, since the test passes on
these filesystems).

Thanks

>
> Thanks!
> -Lukas
>
>> Otherwise, file A is recovered to #3.
>
>
>>
>> Cc: Filipe Manana <fdmanana@suse.com>
>> Cc: Eric Sandeen <sandeen@redhat.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>  common/rc         | 18 ++++++++++++++++++
>>  tests/generic/066 |  2 +-
>>  2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 1ed9df5..e6e8d1f 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -2372,6 +2372,24 @@ _require_metadata_journaling()
>>       esac
>>  }
>>
>> +# Does this filesystem support metadata replay?
>> +# Filesystem is able to recover metadata which were not written by =
fsync
>> +# exlicitly. But another fsync'ed metadata should be followed by th=
em.
>> +_require_metadata_replay()
>> +{
>> +     _require_metadata_journaling $1
>> +
>> +     case "$FSTYP" in
>> +     f2fs)
>> +             # f2fs supports metadata_journaling, but does not reco=
ver any
>> +             # intermediate metadata which was not fsync'ed explici=
tly.
>> +             _notrun "$FSTYP does not support metadata replay"
>> +             ;;
>> +     *)
>> +             ;;
>> +     esac
>> +}
>> +
>>  # Does fiemap support?
>>  _require_fiemap()
>>  {
>> diff --git a/tests/generic/066 b/tests/generic/066
>> index cb36506..3fefda4 100755
>> --- a/tests/generic/066
>> +++ b/tests/generic/066
>> @@ -61,7 +61,7 @@ _need_to_be_root
>>  _require_scratch
>>  _require_dm_flakey
>>  _require_attrs
>> -_require_metadata_journaling $SCRATCH_DEV
>> +_require_metadata_replay $SCRATCH_DEV
>>
>>  _crash_and_mount()
>>  {
>>
>
> ---------------------------------------------------------------------=
---------
> Dive into the World of Parallel Programming The Go Parallel Website, =
sponsored
> by Intel and developed in partnership with Slashdot Media, is your hu=
b for all
> things parallel software development, from weekly thought leadership =
blogs to
> news, videos, case studies, tutorials and more. Take a look and join =
the
> conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel



--=20
=46ilipe David Manana,

"Reasonable men adapt themselves to the world.
 Unreasonable men adapt the world to themselves.
 That's why all progress depends on unreasonable men."
