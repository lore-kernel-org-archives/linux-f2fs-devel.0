From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: handle error in recover_orphan_inode
Date: Mon, 12 Sep 2016 15:32:15 -0700
Message-ID: <20160912223215.40862-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bjZm9-00015b-SD
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Sep 2016 22:32:29 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bjZm8-0001jR-W8
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Sep 2016 22:32:29 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch enhances the error path in recover_orphan_inode.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b80dd37..36073a1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -531,8 +531,9 @@ void remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	struct inode *inode;
+	struct node_info ni;
 
-	inode = f2fs_iget(sbi->sb, ino);
+	inode = f2fs_iget_retry(sbi->sb, ino);
 	if (IS_ERR(inode)) {
 		/*
 		 * there should be a bug that we can't find the entry
@@ -546,6 +547,23 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 
 	/* truncate all the data during iput */
 	iput(inode);
+
+	get_node_info(sbi, ino, &ni);
+
+	/* ENOMEM was fully retried in f2fs_evict_inode. */
+	if (ni.blk_addr != NULL_ADDR) {
+		int err = acquire_orphan_inode(sbi);
+
+		if (err) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_msg(sbi->sb, KERN_WARNING,
+				"%s: orphan failed (ino=%x), run fsck to fix.",
+					__func__, ino);
+			return err;
+		}
+		__add_ino_entry(sbi, ino, ORPHAN_INO);
+		alloc_nid_done(sbi, ino);
+	}
 	return 0;
 }
 
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. http://sdm.link/zohodev2dev
