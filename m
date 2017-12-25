From: Eric Sandeen <sandeen@sandeen.net>
Subject: Re: xfstests: generic/342 run failed in f2fs
Date: Sun, 24 Dec 2017 23:47:20 -0800
Message-ID: <d5ff659d-c659-ca47-3999-2f4b16629e42@sandeen.net>
References: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
 <e367054d-046d-d6e5-943c-7fbe10493029@sandeen.net>
 <d20cb58e-6646-a7de-bff1-8b7783a30664@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <fstests-owner@vger.kernel.org>
In-Reply-To: <d20cb58e-6646-a7de-bff1-8b7783a30664@intel.com>
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
To: Chen Rong <rongx.a.chen@intel.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: philip.li@intel.com
List-Id: linux-f2fs-devel.lists.sourceforge.net



On 12/24/17 10:30 PM, Chen Rong wrote:
> 
> 
> On 2017年12月25日 13:56, Eric Sandeen wrote:
>> On 12/24/17 9:28 PM, Chen Rong wrote:
>>> Hi, everyone:
>>>
>>> the issue as below:
>> First we need to look - what does the test do?
>>
>> # Test that if we rename a file, create a new file that has the old name of the
>> # other file and is a child of the same parent directory, fsync the new inode,
>> # power fail and mount the filesystem, we do not lose the first file and that
>> # file has the name it was renamed to.
>>
>> Ok, so it is a test of fsync'd file renames/creation over simulated device
>> failure, and wants to be sure that all files and file contents are as
>> expected if data integrity syscalls were made before the device failure.
>>
>>> # ./check generic/342
>>> FSTYP         -- f2fs
>>> PLATFORM      -- Linux/x86_64 node01 4.15.0-rc4
>>> MKFS_OPTIONS  -- /dev/sde1
>>> MOUNT_OPTIONS -- -o acl,user_xattr /dev/sde1 /tmp/test1
>>>
>>> generic/342      - output mismatch (see /home/ubuntu/git/xfstests-dev/results//generic/342.out.bad)
>>>      --- tests/generic/342.out   2017-12-13 13:47:20.144000000 -0500
>>>      +++ /home/ubuntu/git/xfstests-dev/results//generic/342.out.bad 2017-12-25 11:13:12.928000000 -0500
>>>      @@ -8,8 +8,7 @@
>>>       48c940ba3b8671d3d6ea74e4ccad8ca3  SCRATCH_MNT/a/bar
>>>       Directory a/ contents after log replay:
>>>       SCRATCH_MNT/a:
>>>      -bar
>> the test created foo, fsynced it, then renamed it to bar and created a
>> /new/ file also named foo, then fsynced the new file foo.
>>
>> Despite that 2nd fsync, the renamed file "bar" is not present in
>> your case.
>>
>> However, don't we really need to fsync the directory after
>> the rename and recreation to ensure persistence?
>>
>> iows:  does this patch make the test pass on f2fs?  It does
>> for me, and I think it's the only valid way to run the test:
> the patch works for me. but btrfs could pass the test without it, why so different?

Filesystems are free to do /more/ than the minimum required by posix -
see ext4_sync_parent for example.  Or xfs_finish_rename, for synchronous
mounts:

         * If this is a synchronous mount, make sure that the rename transaction
         * goes to disk before returning to the user.
         */
        if (tp->t_mountp->m_flags & (XFS_MOUNT_WSYNC|XFS_MOUNT_DIRSYNC))
                xfs_trans_set_sync(tp);

so behavior can be fs-dependent, or mount option dependent, etc.

But to be portable, if an app wants directory changes to be persistent
before proceeding, it must fsync the directory after making changes.

I don't know about f2fs's design intent, whether it guarantees more
than posix requires, but to guarantee that this test works on any posix
fs, I think that directory fsync is needed.

-Eric
