From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: reduce region of cp_rwsem covered in
	f2fs_do_collapse
Date: Thu, 16 Jul 2015 18:18:11 +0800
Message-ID: <018d01d0bfb0$cf828090$6e8781b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZFgFo-0007OS-KT
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Jul 2015 10:19:00 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZFgFm-0006qE-Pu
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Jul 2015 10:19:00 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NRK01A1ZSNFU530@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Jul 2015 19:18:51 +0900 (KST)
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

In f2fs_do_collapse, region cp_rwsem covered is large, since it will be
held until all blocks are left shifted, so if we try to collapse small
area at the beginning of large file, checkpoint who want to grab writer's
lock of cp_rwsem will be delayed for long time.

In order to avoid this condition, altering to lock/unlock cp_rwsem each
shift operation.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 963cee0..852535f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -800,11 +800,11 @@ static int f2fs_do_collapse(struct inode *inode, pgoff_t start, pgoff_t end)
 	pgoff_t nrpages = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
 	int ret = 0;
 
-	f2fs_lock_op(sbi);
-
 	for (; end < nrpages; start++, end++) {
 		block_t new_addr, old_addr;
 
+		f2fs_lock_op(sbi);
+
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		ret = get_dnode_of_data(&dn, end, LOOKUP_NODE_RA);
 		if (ret && ret != -ENOENT) {
@@ -820,13 +820,16 @@ static int f2fs_do_collapse(struct inode *inode, pgoff_t start, pgoff_t end)
 		if (new_addr == NULL_ADDR) {
 			set_new_dnode(&dn, inode, NULL, NULL, 0);
 			ret = get_dnode_of_data(&dn, start, LOOKUP_NODE_RA);
-			if (ret && ret != -ENOENT)
+			if (ret && ret != -ENOENT) {
 				goto out;
-			else if (ret == -ENOENT)
+			} else if (ret == -ENOENT) {
+				f2fs_unlock_op(sbi);
 				continue;
+			}
 
 			if (dn.data_blkaddr == NULL_ADDR) {
 				f2fs_put_dnode(&dn);
+				f2fs_unlock_op(sbi);
 				continue;
 			} else {
 				truncate_data_blocks_range(&dn, 1);
@@ -865,8 +868,9 @@ static int f2fs_do_collapse(struct inode *inode, pgoff_t start, pgoff_t end)
 
 			f2fs_put_dnode(&dn);
 		}
+		f2fs_unlock_op(sbi);
 	}
-	ret = 0;
+	return 0;
 out:
 	f2fs_unlock_op(sbi);
 	return ret;
-- 
2.4.2



------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
