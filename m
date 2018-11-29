From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] fsck.f2fs: check nat_bits separately from
 bug_on
Date: Wed, 28 Nov 2018 18:03:42 -0800
Message-ID: <20181129020342.96045-2-jaegeuk@kernel.org>
References: <20181129020342.96045-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gSBgX-0007uI-4n
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Nov 2018 02:04:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gSBgH-0033A6-4i
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Nov 2018 02:04:09 +0000
In-Reply-To: <20181129020342.96045-1-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

It checks nat_bits separately, and enable it seamlessly.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       | 2 +-
 fsck/mount.c      | 2 +-
 include/f2fs_fs.h | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index bcda781..e089a64 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2676,7 +2676,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	if (force || (c.fix_on && !c.ro)) {
 		struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 
-		if (force || c.bug_on) {
+		if (force || c.bug_on || c.bug_nat_bits) {
 			/* flush nats to write_nit_bits below */
 			flush_journal_entries(sbi);
 			fix_hard_links(sbi);
diff --git a/fsck/mount.c b/fsck/mount.c
index d853fcf..3966525 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1242,7 +1242,7 @@ out:
 	if (!err) {
 		MSG(0, "Info: Checked valid nat_bits in checkpoint\n");
 	} else {
-		c.bug_on = 1;
+		c.bug_nat_bits = 1;
 		MSG(0, "Info: Corrupted valid nat_bits in checkpoint\n");
 	}
 	return err;
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 6eebb3a..a730688 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -372,6 +372,7 @@ struct f2fs_configuration {
 	int force;
 	int defset;
 	int bug_on;
+	int bug_nat_bits;
 	int alloc_failed;
 	int auto_fix;
 	int quota_fix;
-- 
2.19.0.605.g01d371f741-goog
