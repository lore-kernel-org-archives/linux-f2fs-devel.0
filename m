From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/3] f2fs: introduce __f2fs_commit_super
Date: Tue, 15 Dec 2015 17:20:50 +0800
Message-ID: <010601d13719$fb952260$f2bf6720$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a8lnf-0000LD-PV
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 09:21:39 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a8lne-0006Xv-Bm
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 09:21:39 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZE007U27BUKD50@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 18:21:30 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Introduce __f2fs_commit_super to include duplicated codes in
f2fs_commit_super for cleanup.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/super.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2d4fed8..56a160a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1201,14 +1201,13 @@ next:
 	return 0;
 }
 
-int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
+int __f2fs_commit_super(struct f2fs_sb_info *sbi, int block)
 {
 	struct f2fs_super_block *super = F2FS_RAW_SUPER(sbi);
 	struct buffer_head *bh;
 	int err;
 
-	/* write back-up superblock first */
-	bh = sb_getblk(sbi->sb, sbi->valid_super_block ? 0 : 1);
+	bh = sb_getblk(sbi->sb, block);
 	if (!bh)
 		return -EIO;
 
@@ -1222,23 +1221,22 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	err = __sync_dirty_buffer(bh, WRITE_FLUSH_FUA);
 	brelse(bh);
 
+	return err;
+}
+
+int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
+{
+	int err;
+
+	/* write back-up superblock first */
+	err = __f2fs_commit_super(sbi, sbi->valid_super_block ? 0 : 1);
+
 	/* if we are in recovery path, skip writing valid superblock */
 	if (recover || err)
 		return err;
 
-	bh = sb_getblk(sbi->sb, sbi->valid_super_block);
-	if (!bh)
-		return -EIO;
-
 	/* write current valid superblock */
-	lock_buffer(bh);
-	memcpy(bh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
-	set_buffer_uptodate(bh);
-	set_buffer_dirty(bh);
-	unlock_buffer(bh);
-
-	err = __sync_dirty_buffer(bh, WRITE_FLUSH_FUA);
-	brelse(bh);
+	err = __f2fs_commit_super(sbi, sbi->valid_super_block);
 
 	return err;
 }
-- 
2.6.3



------------------------------------------------------------------------------
