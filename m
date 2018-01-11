From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 1/3] fsck.f2fs: show encoded name when unlinking
 corrupted dentry
Date: Thu, 11 Jan 2018 10:17:19 +0800
Message-ID: <20180111021721.210437-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1eZSRG-0004ye-Pb
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Jan 2018 02:17:54 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eZSRF-0005r9-KZ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Jan 2018 02:17:54 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: shengyong1@huawei.com, linux-f2fs-devel@lists.sourceforge.net

For dentry name, we should check if parent directory is encrypted. If it
is, show digest-encoded name instead of cipher text when unlink corrupted
dir entries.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/fsck.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index bcb478a..1211729 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -766,7 +766,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 					blkaddr,
 					&child, (i_blocks == *blk_cnt),
 					ftype, nid, idx, ni->version,
-					file_enc_name(&node_blk->i));
+					file_is_encrypt(&node_blk->i));
 			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
 			} else if (c.fix_on) {
@@ -974,7 +974,7 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			blkaddr, child,
 			le64_to_cpu(inode->i_blocks) == *blk_cnt, ftype,
 			nid, idx, ni->version,
-			file_enc_name(inode));
+			file_is_encrypt(inode));
 		if (!ret) {
 			*blk_cnt = *blk_cnt + 1;
 		} else if (c.fix_on) {
@@ -1434,7 +1434,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 				test_and_clear_bit_le(i + j, bitmap);
 			FIX_MSG("Unlink [0x%x] - %s len[0x%x], type[0x%x]",
 					le32_to_cpu(dentry[i].ino),
-					name, name_len,
+					en, name_len,
 					dentry[i].file_type);
 			fixed = 1;
 		} else if (ret == 0) {
@@ -1466,7 +1466,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
 	fsck->dentry_depth++;
 	dentries = __chk_dentries(sbi, child,
 			d.bitmap, d.dentry, d.filename, d.max, 1,
-			file_enc_name(&node_blk->i));
+			file_is_encrypt(&node_blk->i));
 	if (dentries < 0) {
 		DBG(1, "[%3d] Inline Dentry Block Fixed hash_codes\n\n",
 			fsck->dentry_depth);
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
