From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200871] F2FS experiences data loss (entry is
 completely lost) when an I/O failure occurs.
Date: Wed, 05 Sep 2018 21:40:50 +0000
Message-ID: <bug-200871-202145-kpJwqgA3Pl@https.bugzilla.kernel.org/>
References: <bug-200871-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fxfXo-0003O9-9F
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Sep 2018 21:41:00 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fxfXm-00AttU-BO
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Sep 2018 21:41:00 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C35882AB1C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Sep 2018 21:40:50 +0000 (UTC)
In-Reply-To: <bug-200871-202145@https.bugzilla.kernel.org/>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

https://bugzilla.kernel.org/show_bug.cgi?id=200871

--- Comment #7 from Stathis Maneas (smaneas@cs.toronto.edu) ---
Please find attached the required files to reproduce the error. Start with the
Makefile to compile and install the module into your kernel.

Assuming the underlying device is /dev/vdb, please execute the following
commands to initialize the file system:
$ dd if=/dev/zero of=/dev/vdb bs=4096
$ mkfs.f2fs -l F2FS /dev/vdb -d 10 -a 0 -O extra_attr -O inode_checksum
$ mount -t f2fs /dev/vdb /mnt/f2fs -o background_gc=off
$ cd /mnt/f2fs
$ dd if=/dev/urandom of=inline_file bs=3400 count=1
$ cd; umount /mnt/f2fs

In order to reproduce the error, we need two pieces of information:
- The device's number of sectors (invoking fdisk -l should be more than
sufficient to extract this information). In my case, this number is equal to
262,144.
- The block number (on disk) that will accommodate the newly updated inode
(after its mode has changed). In my case, this block number is equal to 4609.

Then, please execute the following commands to reproduce the error:
$ sudo dmsetup create f2fs_dev --table '0 262144 injector /dev/vdb 0 W4609'
--readahead none
$ dmesg -C; dmsetup message f2fs_dev 0 start
$ sudo mount -t f2fs /dev/mapper/f2fs_dev /mnt/f2fs -o background_gc=off
$ cd /mnt/f2fs/
$ /tmp/run_chmod inline_file
The operation "chmod" returned: 0 (errno: 0)

(Comment: During the execution of this command, the write operation that is
related to the newly updated inode (BlockID: 4609) is failed.)

$ cd; umount /mnt/f2fs

If everything is executed as expected, then dmesg should contain an entry
similar to the following:
Injecting (W) error for sec: 36872 and block: 4609

At this point, if we re-mount the file system, the file cannot be accessed
since its inode was never persisted on disk:
$ mount -t f2fs /dev/vdb /mnt/f2fs -o background_gc=off
$ cd /mnt/f2fs
$ ls -alR
.:
ls: cannot access inline_file: Invalid argument
total 8
drwxr-xr-x 2 root root 4096 Aug 20 17:04 .
drwxr-xr-x 3 root root 4096 Jun  5 14:50 ..
-????????? ? ?    ?       ?            ? inline_file
$ dmesg
...
[3247.026533] F2FS-fs (vdb): inconsistent node block, nid:4,
node_footer[nid:0,ino:0,ofs:0,cpver:0,blkaddr:0]
...
$ cd; umount /mnt/f2fs

After invoking f2fs.fsck and answering 'yes' to all questions, we end up with a
consistent file system image, but now, the entry has disappeared:
$ mount -t f2fs /dev/vdb /mnt/f2fs -o background_gc=off
$ cd /mnt/f2fs
$ ls -alR
.:
total 8
drwxr-xr-x 2 root root 4096 Aug 20 17:04 .
drwxr-xr-x 3 root root 4096 Jun  5 14:50 ..
$ cd; umount /mnt/f2fs

Please let me know if you run into any issues while trying to reproduce the
error.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
