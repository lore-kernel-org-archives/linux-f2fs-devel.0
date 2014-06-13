From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: recover fallocated data and its i_size
	together
Date: Fri, 13 Jun 2014 19:17:45 +0900
Message-ID: <1402654666-81383-2-git-send-email-jaegeuk@kernel.org>
References: <1402654666-81383-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1WvOYS-0005qA-Nx
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Jun 2014 10:17:52 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WvOYR-0005H1-0U for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Jun 2014 10:17:52 +0000
In-Reply-To: <1402654666-81383-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch arranges the f2fs_locks to cover the fallocated data and its i_size.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9c49c59..623df73 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -659,13 +659,13 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	off_start = offset & (PAGE_CACHE_SIZE - 1);
 	off_end = (offset + len) & (PAGE_CACHE_SIZE - 1);
 
+	f2fs_lock_op(sbi);
+
 	for (index = pg_start; index <= pg_end; index++) {
 		struct dnode_of_data dn;
 
-		f2fs_lock_op(sbi);
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		ret = f2fs_reserve_block(&dn, index);
-		f2fs_unlock_op(sbi);
 		if (ret)
 			break;
 
@@ -683,8 +683,9 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 		i_size_read(inode) < new_size) {
 		i_size_write(inode, new_size);
 		mark_inode_dirty(inode);
-		f2fs_write_inode(inode, NULL);
+		update_inode_page(inode);
 	}
+	f2fs_unlock_op(sbi);
 
 	return ret;
 }
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
