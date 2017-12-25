From: Eric Sandeen <sandeen@sandeen.net>
Subject: Re: xfstests: generic/342 run failed in f2fs
Date: Sun, 24 Dec 2017 21:56:46 -0800
Message-ID: <e367054d-046d-d6e5-943c-7fbe10493029@sandeen.net>
References: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <fstests-owner@vger.kernel.org>
In-Reply-To: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
To: Chen Rong <rongx.a.chen@intel.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: philip.li@intel.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 12/24/17 9:28 PM, Chen Rong wrote:
> Hi, everyone:
> 
> the issue as below:

First we need to look - what does the test do?

# Test that if we rename a file, create a new file that has the old name of the
# other file and is a child of the same parent directory, fsync the new inode,
# power fail and mount the filesystem, we do not lose the first file and that
# file has the name it was renamed to.

Ok, so it is a test of fsync'd file renames/creation over simulated device
failure, and wants to be sure that all files and file contents are as
expected if data integrity syscalls were made before the device failure.

> # ./check generic/342
> FSTYP         -- f2fs
> PLATFORM      -- Linux/x86_64 node01 4.15.0-rc4
> MKFS_OPTIONS  -- /dev/sde1
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/sde1 /tmp/test1
> 
> generic/342      - output mismatch (see /home/ubuntu/git/xfstests-dev/results//generic/342.out.bad)
>     --- tests/generic/342.out   2017-12-13 13:47:20.144000000 -0500
>     +++ /home/ubuntu/git/xfstests-dev/results//generic/342.out.bad 2017-12-25 11:13:12.928000000 -0500
>     @@ -8,8 +8,7 @@
>      48c940ba3b8671d3d6ea74e4ccad8ca3  SCRATCH_MNT/a/bar
>      Directory a/ contents after log replay:
>      SCRATCH_MNT/a:
>     -bar

the test created foo, fsynced it, then renamed it to bar and created a
/new/ file also named foo, then fsynced the new file foo.

Despite that 2nd fsync, the renamed file "bar" is not present in
your case.

However, don't we really need to fsync the directory after
the rename and recreation to ensure persistence?

iows:  does this patch make the test pass on f2fs?  It does
for me, and I think it's the only valid way to run the test:

diff --git a/tests/generic/342 b/tests/generic/342
index ed64e05..6a9e5bd 100755
--- a/tests/generic/342
+++ b/tests/generic/342
@@ -68,6 +68,7 @@ sync
 mv $SCRATCH_MNT/a/foo $SCRATCH_MNT/a/bar
 $XFS_IO_PROG -f -c "pwrite -S 0xba 0 16K" $SCRATCH_MNT/a/foo | _filter_xfs_io
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/a/foo
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/a
 
 echo "File digests before log replay:"
 md5sum $SCRATCH_MNT/a/foo | _filter_scratch

without an fsync of the parent dir, I don't think we can
guarantee that filename changes or additions will persist
on every filesystem.

>      foo
>      File digests after log replay:
>      9e5d56a1f9b2c93589f9d55480f971a1  SCRATCH_MNT/a/foo
>     ...
>     (Run 'diff -u tests/generic/342.out /home/ubuntu/git/xfstests-dev/results//generic/342.out.bad'  to see the entire diff)

Generally best to do that suggested diff command to see if 
there are any more pieces of changed/wrong test output.

> Ran: generic/342
> Failures: generic/342
> Failed 1 of 1 tests
> 
> Is it a problem with my computer or a already known issue with f2fs?

or a problem with the test itself ...

-Eric
 
> thanks!
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
