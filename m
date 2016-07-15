From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH trivial 2/7] f2fs.fsck: fix endianess
Date: Fri, 15 Jul 2016 20:01:20 +0800
Message-ID: <1468584085-29090-2-git-send-email-shengyong1@huawei.com>
References: <1468584085-29090-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1bO1tG-0003y1-VO
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jul 2016 12:06:46 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bO1tB-0007vi-Rp
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jul 2016 12:06:46 +0000
In-Reply-To: <1468584085-29090-1-git-send-email-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/fsck.c  | 2 +-
 fsck/mount.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index c24eb58..8a6373b 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -383,7 +383,7 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 				le32_to_cpu(node_blk->footer.ino));
 		return -EINVAL;
 	}
-	if (ni->ino != node_blk->footer.ino) {
+	if (ni->ino != le32_to_cpu(node_blk->footer.ino)) {
 		ASSERT_MSG("nid[0x%x] nat_entry->ino[0x%x] footer.ino[0x%x]",
 				nid, ni->ino, le32_to_cpu(node_blk->footer.ino));
 		return -EINVAL;
diff --git a/fsck/mount.c b/fsck/mount.c
index 3e3d176..f3b47fd 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -79,9 +79,9 @@ void print_inode_info(struct f2fs_inode *inode, int name)
 	}
 
 	printf("i_ext: fofs:%x blkaddr:%x len:%x\n",
-			inode->i_ext.fofs,
-			inode->i_ext.blk_addr,
-			inode->i_ext.len);
+			le32_to_cpu(inode->i_ext.fofs),
+			le32_to_cpu(inode->i_ext.blk_addr),
+			le32_to_cpu(inode->i_ext.len));
 
 	DISP_u32(inode, i_addr[0]);	/* Pointers to data blocks */
 	DISP_u32(inode, i_addr[1]);	/* Pointers to data blocks */
@@ -91,7 +91,7 @@ void print_inode_info(struct f2fs_inode *inode, int name)
 	for (i = 4; i < ADDRS_PER_INODE(inode); i++) {
 		if (inode->i_addr[i] != 0x0) {
 			printf("i_addr[0x%x] points data block\r\t\t[0x%4x]\n",
-					i, inode->i_addr[i]);
+					i, le32_to_cpu(inode->i_addr[i]));
 			break;
 		}
 	}
-- 
2.7.1


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
