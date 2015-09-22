From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: SMR drive test 3: full 8TB partition, mount problems,
 fsck error after delete
Date: Tue, 22 Sep 2015 16:08:50 -0700
Message-ID: <20150922230850.GB31427@jaegeuk-mac02.mot.com>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
	<20150922202202.GA2456@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZeWgH-0007YF-Cb
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 23:09:01 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZeWgF-0003B2-Rx for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 23:09:01 +0000
Content-Disposition: inline
In-Reply-To: <20150922202202.GA2456@schmorp.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Marc Lehmann <schmorp@schmorp.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

Thank you for the test.

On Tue, Sep 22, 2015 at 10:22:02PM +0200, Marc Lehmann wrote:
> Third test, using the full device, on linux 4.2.1
> 
>    mkfs.f2fs -l COLD1 -o1 -a0 -d1 -s128 /dev/mapper/xmnt-cold1

Could you check without -o1, since I merged a patch to calculate the best
overprovision at runtime in f2fs-tools.
Originally, even if you set a specific overprovision ratio, mkfs.f2fs calculates
the real space again.
For example, if you set 1%, we need to reserve 100 sections to do cleaning at
the worse case. That's why you cannot see the reserved area as just 1% over
total space.

>    mount -tf2fs -onoatime,flush_merge,active_logs=2,no_heap /dev/mapper/xmnt-cold1 /cold1
> 
> Unfortunately, mount failed with. The kernel showed that a high order
> allocation could not be satisfied:
> 
>    mount: page allocation failure: order:7, mode:0x40d0
>    ...
>    F2FS-fs (dm-18): Failed to initialize F2FS segment manager
>    (http://data.plan9.de/f2fs-mount-failure.txt)

I think the below patch should resolve this issue.

> 
> I think this memory management is a real problem - the server was booted
> about 20 minutes earlier and had 23GB free ram (used for cache). I was able
> to mount it by dropping the page cache, but clearly this shouldn't be
> neccessary.
> 
> After this, df showed 185GB in use, which is more like 3%, not 1% - again
> overprovisioning seems to be out of bounds.

Actually, 185GB should include FS metadata as well as reserved or overprovision
space. It would be good to check the on-disk layout by fsck.f2fs.

> 
> I started copying files with tar|tar, after 10GB, I restarted, which started
> to overwrite the existing 10GB files.
> 
> Unfortunately, this time the GC kicked in every 10-20 seconds, slowing down
> writing times. I don't know what triggered it this time, but I am quite sure
> at less than 1% utilisation it shouldn't feel the need to gc while the disk
> is busy writing.
> 
> After 90GB were written, I decided to simulate a disk problem by deleting
> the device (to avoid any corruption issues the disk itself might have):
> 
>    echo 1 >/sys/block/sde/device/delete
> 
> After rescanning the device, I used fsck.f2fs on it, and it failed quickly:
> 
>    Info: superblock features = 0 : 
>    Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
>    Info: total FS sectors = 15628050432 (7630884 MB)
>    Info: CKPT version = 2
>    [ASSERT] (restore_node_summary: 688) ret >= 0
>    [Exit 255] 
> 
> Re-running it with -f failed differently, but also quickly:
> 
>    Info: superblock features = 0 : 
>    Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
>    Info: total FS sectors = 15628050432 (7630884 MB)
>    Info: CKPT version = 2
>    [ASSERT] (get_current_sit_page: 803) ret >= 0
>    [Exit 255] 

Actually, this doesn't report f2fs inconsistency.
Instead, these two errors are from lseek64() and read() failures in dev_read():
lib/libf2fs_io.c.

Maybe ENOMEM? Can you check the errno of this function?

Thanks,

> 
> I'll reformat and try without any simulated problems.
> 
> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

>From d495b00a2f04c0ec5e6c6d95c9e66bdba45b174c Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 22 Sep 2015 13:50:47 -0700
Subject: [PATCH] f2fs: use vmalloc to handle -ENOMEM error

This patch introduces f2fs_kvmalloc to avoid -ENOMEM during mount.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    | 11 +++++++++++
 fs/f2fs/segment.c |  9 ++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 79c38ad..553529d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -19,6 +19,7 @@
 #include <linux/magic.h>
 #include <linux/kobject.h>
 #include <linux/sched.h>
+#include <linux/vmalloc.h>
 #include <linux/bio.h>
 
 #ifdef CONFIG_F2FS_CHECK_FS
@@ -1579,6 +1580,16 @@ static inline bool f2fs_may_extent_tree(struct inode *inode)
 	return S_ISREG(mode);
 }
 
+static inline void *f2fs_kvmalloc(size_t size, gfp_t flags)
+{
+	void *ret;
+
+	ret = kmalloc(size, flags | __GFP_NOWARN);
+	if (!ret)
+		ret = __vmalloc(size, flags, PAGE_KERNEL);
+	return ret;
+}
+
 #define get_inode_mode(i) \
 	((is_inode_flag_set(F2FS_I(i), FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 78e6d06..13567ad 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -14,7 +14,6 @@
 #include <linux/blkdev.h>
 #include <linux/prefetch.h>
 #include <linux/kthread.h>
-#include <linux/vmalloc.h>
 #include <linux/swap.h>
 
 #include "f2fs.h"
@@ -2028,12 +2027,12 @@ static int build_free_segmap(struct f2fs_sb_info *sbi)
 	SM_I(sbi)->free_info = free_i;
 
 	bitmap_size = f2fs_bitmap_size(MAIN_SEGS(sbi));
-	free_i->free_segmap = kmalloc(bitmap_size, GFP_KERNEL);
+	free_i->free_segmap = f2fs_kvmalloc(bitmap_size, GFP_KERNEL);
 	if (!free_i->free_segmap)
 		return -ENOMEM;
 
 	sec_bitmap_size = f2fs_bitmap_size(MAIN_SECS(sbi));
-	free_i->free_secmap = kmalloc(sec_bitmap_size, GFP_KERNEL);
+	free_i->free_secmap = f2fs_kvmalloc(sec_bitmap_size, GFP_KERNEL);
 	if (!free_i->free_secmap)
 		return -ENOMEM;
 
@@ -2348,8 +2347,8 @@ static void destroy_free_segmap(struct f2fs_sb_info *sbi)
 	if (!free_i)
 		return;
 	SM_I(sbi)->free_info = NULL;
-	kfree(free_i->free_segmap);
-	kfree(free_i->free_secmap);
+	kvfree(free_i->free_segmap);
+	kvfree(free_i->free_secmap);
 	kfree(free_i);
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
