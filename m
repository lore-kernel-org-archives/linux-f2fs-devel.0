From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: f2fs: BUG_ON() is triggered when mount valid f2fs
	filesystem
Date: Tue, 15 Apr 2014 20:04:24 +0900
Message-ID: <1397559864.7727.5.camel@kjgkr>
References: <52F320FC.50803@ispras.ru> <534BC29B.3020408@ispras.ru>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Wa1CG-0005r1-WB
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Apr 2014 11:06:37 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Wa1CE-0007xx-Hh
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Apr 2014 11:06:36 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N4200L2LK6PEK50@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Apr 2014 20:06:25 +0900 (KST)
In-reply-to: <534BC29B.3020408@ispras.ru>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Andrey Tsyvarev <tsyvarev@ispras.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-f2fs-devel@lists.sourceforge.net

Hi,

Thank you for the report.
I retrieved the fault image and found out that previous garbage data
wreak such the wrong behaviors.
So, I wrote the following patch that fills one zero-block at the
checkpoint procedure.
If the underlying device supports discard, I expect that it mostly
doesn't incur any performance regression significantly.

Could you test this patch?

>From 60588ceb7277aae2a79e7f67f5217d1256720d78 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Tue, 15 Apr 2014 13:57:55 +0900
Subject: [PATCH] f2fs: avoid to conduct roll-forward due to the remained
 garbage blocks

The f2fs always scans the next chain of direct node blocks.
But some garbage blocks are able to be remained due to no discard
support or
SSR triggers.
This occasionally wreaks recovering wrong inodes that were used or
BUG_ONs
due to reallocating node ids as follows.

When mount this f2fs image:
http://linuxtesting.org/downloads/f2fs_fault_image.zip
BUG_ON is triggered in f2fs driver (messages below are generated on
kernel 3.13.2; for other kernels output is similar):

kernel BUG at fs/f2fs/node.c:215!
 Call Trace:
 [<ffffffffa032ebad>] recover_inode_page+0x1fd/0x3e0 [f2fs]
 [<ffffffff811446e7>] ? __lock_page+0x67/0x70
 [<ffffffff81089990>] ? autoremove_wake_function+0x50/0x50
 [<ffffffffa0337788>] recover_fsync_data+0x1398/0x15d0 [f2fs]
 [<ffffffff812b9e5c>] ? selinux_d_instantiate+0x1c/0x20
 [<ffffffff811cb20b>] ? d_instantiate+0x5b/0x80
 [<ffffffffa0321044>] f2fs_fill_super+0xb04/0xbf0 [f2fs]
 [<ffffffff811b861e>] ? mount_bdev+0x7e/0x210
 [<ffffffff811b8769>] mount_bdev+0x1c9/0x210
 [<ffffffffa0320540>] ? validate_superblock+0x210/0x210 [f2fs]
 [<ffffffffa031cf8d>] f2fs_mount+0x1d/0x30 [f2fs]
 [<ffffffff811b9497>] mount_fs+0x47/0x1c0
 [<ffffffff81166e00>] ? __alloc_percpu+0x10/0x20
 [<ffffffff811d4032>] vfs_kern_mount+0x72/0x110
 [<ffffffff811d6763>] do_mount+0x493/0x910
 [<ffffffff811615cb>] ? strndup_user+0x5b/0x80
 [<ffffffff811d6c70>] SyS_mount+0x90/0xe0
 [<ffffffff8166f8d9>] system_call_fastpath+0x16/0x1b

Found by Linux File System Verification project (linuxtesting.org).

Reported-by: Andrey Tsyvarev <tsyvarev@ispras.ru>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c |  6 ++++++
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/segment.c    | 17 +++++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4aa521a..890e23d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -762,6 +762,12 @@ static void do_checkpoint(struct f2fs_sb_info *sbi,
bool is_umount)
 	void *kaddr;
 	int i;
 
+	/*
+	 * This avoids to conduct wrong roll-forward operations and uses
+	 * metapages, so should be called prior to sync_meta_pages below.
+	 */
+	discard_next_dnode(sbi);
+
 	/* Flush all the NAT/SIT pages */
 	while (get_pages(sbi, F2FS_DIRTY_META))
 		sync_meta_pages(sbi, META, LONG_MAX);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2ecac83..2c5a5da 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1179,6 +1179,7 @@ int f2fs_issue_flush(struct f2fs_sb_info *);
 void invalidate_blocks(struct f2fs_sb_info *, block_t);
 void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
 void clear_prefree_segments(struct f2fs_sb_info *);
+void discard_next_dnode(struct f2fs_sb_info *);
 int npages_for_summary_flush(struct f2fs_sb_info *);
 void allocate_new_segments(struct f2fs_sb_info *);
 struct page *get_sum_page(struct f2fs_sb_info *, unsigned int);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1e264e7..9993f94 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -335,13 +335,26 @@ static void locate_dirty_segment(struct
f2fs_sb_info *sbi, unsigned int segno)
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
-static void f2fs_issue_discard(struct f2fs_sb_info *sbi,
+static int f2fs_issue_discard(struct f2fs_sb_info *sbi,
 				block_t blkstart, block_t blklen)
 {
 	sector_t start = SECTOR_FROM_BLOCK(sbi, blkstart);
 	sector_t len = SECTOR_FROM_BLOCK(sbi, blklen);
-	blkdev_issue_discard(sbi->sb->s_bdev, start, len, GFP_NOFS, 0);
 	trace_f2fs_issue_discard(sbi->sb, blkstart, blklen);
+	return blkdev_issue_discard(sbi->sb->s_bdev, start, len, GFP_NOFS, 0);
+}
+
+void discard_next_dnode(struct f2fs_sb_info *sbi)
+{
+	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
+	block_t blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
+
+	if (f2fs_issue_discard(sbi, blkaddr, 1)) {
+		struct page *page = grab_meta_page(sbi, blkaddr);
+		/* zero-filled page */
+		set_page_dirty(page);
+		f2fs_put_page(page, 1);
+	}
 }
 
 static void add_discard_addrs(struct f2fs_sb_info *sbi,
-- 
1.8.4.474.g128a96c

-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
