From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH] f2fs: skip encrypted inode in ASYNC IPU policy
Date: Fri, 21 Apr 2017 12:41:48 +0000
Message-ID: <20170421124148.103622-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1d1XuP-0004XR-1I
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Apr 2017 12:43:33 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188]
	helo=dggrg02-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d1XuM-0003im-P4
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Apr 2017 12:43:33 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Async request may be throttled in block layer, so page for async may keep WRITE_BACK
for a long time.

For encrytped inode, we need wait on page writeback no matter if the device supports
BDI_CAP_STABLE_WRITES. This may result in a higher waiting page writeback time for 
async encrypted inode page.

This patch skips IPU for encrypted inode's updating write.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/segment.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 4a85035..99e1e21 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -590,7 +590,8 @@ static inline bool need_inplace_update(struct inode *inode,
 	 */
 	if (policy & (0x1 << F2FS_IPU_ASYNC) &&
 			fio && fio->op == REQ_OP_WRITE &&
-			!(fio->op_flags & REQ_SYNC))
+			!(fio->op_flags & REQ_SYNC) &&
+			!f2fs_encrypted_inode(inode))
 		return true;
 
 	/* this is only set during fdatasync */
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
