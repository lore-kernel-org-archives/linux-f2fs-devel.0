From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] fsck.f2fs: check and fix i_namelen to avoid
 double free
Date: Fri, 15 Dec 2017 14:25:30 +0800
Message-ID: <1513319130-114230-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yunlong.song@huawei.com>) id 1ePjRg-0004Ff-ED
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Dec 2017 06:26:08 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ePjRe-0002XT-1I
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Dec 2017 06:26:08 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: shengyong1@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, miaoxie@huawei.com

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fsck/fsck.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 2212aa3..8ff4e4b 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -643,7 +643,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
 	int ofs = get_extra_isize(node_blk);
 	unsigned char *en;
-	int namelen;
+	int namelen, i_namelen;
 	unsigned int idx = 0;
 	int need_fix = 0;
 	int ret;
@@ -850,8 +850,21 @@ skip_blkcnt_fix:
 	en = malloc(F2FS_NAME_LEN + 1);
 	ASSERT(en);
 
-	namelen = convert_encrypted_name(node_blk->i.i_name,
-					le32_to_cpu(node_blk->i.i_namelen),
+	i_namelen = le32_to_cpu(node_blk->i.i_namelen);
+	namelen = strlen((const char *)node_blk->i.i_name);
+	if (i_namelen > F2FS_NAME_LEN) {
+		ASSERT_MSG("ino: 0x%x has i_namelen: 0x%x, "
+				"but has %d characters for name",
+				nid, i_namelen, namelen);
+		if (c.fix_on) {
+			FIX_MSG("[0x%x] i_namelen=0x%x -> 0x%x", nid, i_namelen,
+				namelen);
+			node_blk->i.i_namelen = cpu_to_le32(namelen);
+			need_fix = 1;
+		}
+		i_namelen = namelen;
+	}
+	namelen = convert_encrypted_name(node_blk->i.i_name, i_namelen,
 					en, file_enc_name(&node_blk->i));
 	en[namelen] = '\0';
 	if (ftype == F2FS_FT_ORPHAN)
-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
