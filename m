From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] dump.f2fs: fix incorrect endian conversion
Date: Mon, 10 Dec 2018 11:19:01 +0800
Message-ID: <20181210031901.83823-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gWC6l-0008V9-T5
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Dec 2018 03:19:47 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gWC6j-009Son-Mn
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Dec 2018 03:19:47 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

f2fs_inode.i_mode is variable of __le16 type, during endian converison,
it should to use le16_to_cpu instead of le32_to_cpu, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index d0e3355b726c..07dc2fcdef69 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -409,7 +409,7 @@ static void dump_file(struct f2fs_sb_info *sbi, struct node_info *ni,
 				struct f2fs_node *node_blk, int force)
 {
 	struct f2fs_inode *inode = &node_blk->i;
-	u32 imode = le32_to_cpu(inode->i_mode);
+	u32 imode = le16_to_cpu(inode->i_mode);
 	u32 namelen = le32_to_cpu(inode->i_namelen);
 	char name[F2FS_NAME_LEN + 1] = {0};
 	char path[1024] = {0};
-- 
2.18.0.rc1
