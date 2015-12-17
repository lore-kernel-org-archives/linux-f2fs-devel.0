From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] defrag.f2fs: eliminate unexpected journal
	entries
Date: Thu, 17 Dec 2015 09:23:02 -0800
Message-ID: <1450372983-84005-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a9cGp-0000gS-Sh
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Dec 2015 17:23:15 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a9cGl-0002UU-8Y for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Dec 2015 17:23:15 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

When moving data or node blocks, it changes current segment information
dynamtically. Meanwhile, its journal entry space is recovered by old
stale data.
This patch makes sure that its journal space is zeroed out.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/defrag.c | 1 +
 fsck/fsck.h   | 1 +
 fsck/mount.c  | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/fsck/defrag.c b/fsck/defrag.c
index 7ca7260..7abc0bf 100644
--- a/fsck/defrag.c
+++ b/fsck/defrag.c
@@ -90,6 +90,7 @@ int f2fs_defragment(struct f2fs_sb_info *sbi, u64 from, u64 len, u64 to, int lef
 
 	/* update curseg info; can update sit->types */
 	move_curseg_info(sbi, to);
+	zero_journal_entries(sbi);
 	write_curseg_info(sbi);
 
 	/* flush dirty sit entries */
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 1464146..3870948 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -135,6 +135,7 @@ extern int f2fs_do_mount(struct f2fs_sb_info *);
 extern void f2fs_do_umount(struct f2fs_sb_info *);
 
 extern void flush_journal_entries(struct f2fs_sb_info *);
+extern void zero_journal_entries(struct f2fs_sb_info *);
 extern void flush_sit_entries(struct f2fs_sb_info *);
 extern void move_curseg_info(struct f2fs_sb_info *, u64);
 extern void write_curseg_info(struct f2fs_sb_info *);
diff --git a/fsck/mount.c b/fsck/mount.c
index 8418dcc..735ed90 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1446,6 +1446,14 @@ void move_curseg_info(struct f2fs_sb_info *sbi, u64 from)
 	}
 }
 
+void zero_journal_entries(struct f2fs_sb_info *sbi)
+{
+	int i;
+
+	for (i = 0; i < NO_CHECK_TYPE; i++)
+		CURSEG_I(sbi, i)->sum_blk->n_nats = 0;
+}
+
 void write_curseg_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
