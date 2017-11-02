From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v2 7/9] fsck.f2fs: introduce
 sanity_check_inode
Date: Thu, 2 Nov 2017 11:56:10 +0800
Message-ID: <20171102035612.217263-8-shengyong1@huawei.com>
References: <20171102035612.217263-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <shengyong1@huawei.com>)
 id 1eA6cY-0002ry-Mq
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:56:46 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1eA6cW-00048M-MV
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:56:46 +0000
In-Reply-To: <20171102035612.217263-1-shengyong1@huawei.com>
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

f2fs_iget checks if i_mode is valid. If it is not, the file cannot be
accessed as well as deleted. To make sure such files can be removed,
fsck adds the same check, and removes incorrect inode blocks.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/fsck.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 56a47be..77490d8 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -458,6 +458,25 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 	return 0;
 }
 
+static int sanity_check_inode(struct f2fs_sb_info *sbi, struct f2fs_node *node)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct f2fs_inode *fi = &node->i;
+
+	if (!(le16_to_cpu(fi->i_mode) & S_IFMT)) {
+		ASSERT_MSG("i_mode is not valid. [0x%x]", le16_to_cpu(fi->i_mode));
+		goto remove_node;
+	}
+
+	return 0;
+
+remove_node:
+	f2fs_set_bit(le32_to_cpu(node->footer.ino), fsck->nat_area_bitmap);
+	fsck->chk.valid_blk_cnt--;
+	fsck->chk.valid_node_cnt--;
+	return -EINVAL;
+}
+
 static int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino,
 					u32 x_nid, u32 *blk_cnt)
 {
@@ -500,6 +519,8 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		goto err;
 
 	if (ntype == TYPE_INODE) {
+		if (sanity_check_inode(sbi, node_blk))
+			goto err;
 		fsck_chk_inode_blk(sbi, nid, ftype, node_blk, blk_cnt, &ni);
 	} else {
 		switch (ntype) {
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
