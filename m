From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3] f2fs: backup raw_super in sbi
Date: Tue, 15 Dec 2015 17:17:20 +0800
Message-ID: <010401d13719$803b6020$80b22060$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a8lkP-0007f5-6K
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 09:18:17 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a8lkJ-0006zB-MI
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 09:18:17 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZE02XO3760ZT60@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 18:18:03 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Yunlei He <heyunlei@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Yunlei He <heyunlei@huawei.com>

f2fs use fields of f2fs_super_block struct directly in a grabbed buffer.

Once the buffer happen to be destroyed (e.g. through dd), it may bring
in unpredictable effect on f2fs.

This patch fixes to allocate additional buffer to store datas of super
block rather than using grabbed block buffer directly.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/super.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 694e092..a6eb79a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -578,6 +578,7 @@ static void f2fs_put_super(struct super_block *sb)
 
 	sb->s_fs_info = NULL;
 	brelse(sbi->raw_super_buf);
+	kfree(sbi->raw_super);
 	kfree(sbi);
 }
 
@@ -1153,6 +1154,9 @@ static int read_raw_super_block(struct super_block *sb,
 	struct f2fs_super_block *super;
 	int err = 0;
 
+	super = kzalloc(sizeof(struct f2fs_super_block), GFP_KERNEL);
+	if (!super)
+		return -ENOMEM;
 retry:
 	buffer = sb_bread(sb, block);
 	if (!buffer) {
@@ -1168,8 +1172,7 @@ retry:
 		}
 	}
 
-	super = (struct f2fs_super_block *)
-		((char *)(buffer)->b_data + F2FS_SUPER_OFFSET);
+	memcpy(super, buffer->b_data + F2FS_SUPER_OFFSET, sizeof(*super));
 
 	/* sanity checking of raw super */
 	if (sanity_check_raw_super(sb, super)) {
@@ -1203,14 +1206,17 @@ retry:
 
 out:
 	/* No valid superblock */
-	if (!*raw_super)
+	if (!*raw_super) {
+		kfree(super);
 		return err;
+	}
 
 	return 0;
 }
 
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 {
+	struct f2fs_super_block *super = F2FS_RAW_SUPER(sbi);
 	struct buffer_head *sbh = sbi->raw_super_buf;
 	struct buffer_head *bh;
 	int err;
@@ -1221,7 +1227,7 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 		return -EIO;
 
 	lock_buffer(bh);
-	memcpy(bh->b_data, sbh->b_data, sbh->b_size);
+	memcpy(bh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
 	WARN_ON(sbh->b_size != F2FS_BLKSIZE);
 	set_buffer_uptodate(bh);
 	set_buffer_dirty(bh);
@@ -1237,6 +1243,10 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 
 	/* write current valid superblock */
 	lock_buffer(sbh);
+	if (memcmp(sbh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super))) {
+		f2fs_msg(sbi->sb, KERN_INFO, "Write modified valid superblock");
+		memcpy(sbh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
+	}
 	set_buffer_dirty(sbh);
 	unlock_buffer(sbh);
 
@@ -1513,6 +1523,7 @@ free_options:
 	kfree(options);
 free_sb_buf:
 	brelse(raw_super_buf);
+	kfree(raw_super);
 free_sbi:
 	kfree(sbi);
 
-- 
2.6.3



------------------------------------------------------------------------------
