From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] f2fs: make local functions static
Date: Fri, 5 Jan 2018 09:41:20 +0000
Message-ID: <1515145280-28626-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Fixes the following sparse warnings:

fs/f2fs/segment.c:887:6: warning:
 symbol '__check_sit_bitmap' was not declared. Should it be static?
fs/f2fs/segment.c:1327:6: warning:
 symbol 'f2fs_wait_discard_bio' was not declared. Should it be static?
fs/f2fs/super.c:1661:5: warning:
 symbol 'f2fs_get_projid' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 fs/f2fs/segment.c | 4 ++--
 fs/f2fs/super.c | 2 +-
 2 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b03f65e..36bfd53 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -884,7 +884,7 @@ static void f2fs_submit_discard_endio(struct bio *bio)
 	bio_put(bio);
 }
 
-void __check_sit_bitmap(struct f2fs_sb_info *sbi,
+static void __check_sit_bitmap(struct f2fs_sb_info *sbi,
 				block_t start, block_t end)
 {
 #ifdef CONFIG_F2FS_CHECK_FS
@@ -1324,7 +1324,7 @@ static void __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 }
 
 /* This should be covered by global mutex, &sit_i->sentry_lock */
-void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
+static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_cmd *dc;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f562307..9958fbf 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1658,7 +1658,7 @@ void f2fs_quota_off_umount(struct super_block *sb)
 		f2fs_quota_off(sb, type);
 }
 
-int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
+static int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
 {
 	*projid = F2FS_I(inode)->i_projid;
 	return 0;
