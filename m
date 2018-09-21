From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200871] F2FS experiences data loss (entry is
 completely lost) when an I/O failure occurs.
Date: Fri, 21 Sep 2018 08:50:21 +0000
Message-ID: <bug-200871-202145-O7i4mQTvxa@https.bugzilla.kernel.org/>
References: <bug-200871-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1g3H8u-0005MB-J1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Sep 2018 08:50:28 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g3H8s-003jOH-Ej
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Sep 2018 08:50:28 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 8DDD62DB05
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 21 Sep 2018 08:50:20 +0000 (UTC)
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

--- Comment #10 from Chao Yu (chao@kernel.org) ---
(In reply to Stathis Maneas from comment #7)
> Please find attached the required files to reproduce the error. Start with
> the Makefile to compile and install the module into your kernel.
> 
> Assuming the underlying device is /dev/vdb, please execute the following
> commands to initialize the file system:
> $ dd if=/dev/zero of=/dev/vdb bs=4096
> $ mkfs.f2fs -l F2FS /dev/vdb -d 10 -a 0 -O extra_attr -O inode_checksum
> $ mount -t f2fs /dev/vdb /mnt/f2fs -o background_gc=off
> $ cd /mnt/f2fs
> $ dd if=/dev/urandom of=inline_file bs=3400 count=1
> $ cd; umount /mnt/f2fs
> 
> In order to reproduce the error, we need two pieces of information:
> - The device's number of sectors (invoking fdisk -l should be more than
> sufficient to extract this information). In my case, this number is equal to
> 262,144.
> - The block number (on disk) that will accommodate the newly updated inode
> (after its mode has changed). In my case, this block number is equal to 4609.
> 
> Then, please execute the following commands to reproduce the error:
> $ sudo dmsetup create f2fs_dev --table '0 262144 injector /dev/vdb 0 W4609'
> --readahead none
> $ dmesg -C; dmsetup message f2fs_dev 0 start
> $ sudo mount -t f2fs /dev/mapper/f2fs_dev /mnt/f2fs -o background_gc=off
> $ cd /mnt/f2fs/
> $ /tmp/run_chmod inline_file
> The operation "chmod" returned: 0 (errno: 0)
> 
> (Comment: During the execution of this command, the write operation that is
> related to the newly updated inode (BlockID: 4609) is failed.)

I tried this testcase, but I can't reproduce this bug.

Look into this, the problem here is, f2fs always triggers out-place-update for
meta data including inode block, so any update in inode of inline_file, f2fs
should not write to (BlockID: 4609) directly, so how inline_file becomes
corrupted?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
