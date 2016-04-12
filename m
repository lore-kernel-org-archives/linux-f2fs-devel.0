From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] f2fs: unset atomic/volatile flag in
	f2fs_release_file
Date: Tue, 12 Apr 2016 10:42:39 -0700
Message-ID: <1460482960-14227-4-git-send-email-jaegeuk@kernel.org>
References: <1460482960-14227-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aq2LC-0007CH-20
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Apr 2016 17:43:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aq2LB-00051x-Bn
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Apr 2016 17:43:06 +0000
In-Reply-To: <1460482960-14227-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

The atomic/volatile operation should be done in pair of start and commit
ioctl.
For example, if a killed process remains open-ended atomic operation, we should
drop its flag as well as its atomic data. Otherwise, if sqlite initiates another
operation which doesn't require atomic writes, it will lose every data, since
f2fs still treats with them as atomic writes; nobody will trigger its commit.

Reported-by: Miao Xie <miaoxie@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c    | 5 ++---
 fs/f2fs/segment.c | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e10eb61..ed389f6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1266,6 +1266,7 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 	if (f2fs_is_atomic_file(inode))
 		drop_inmem_pages(inode);
 	if (f2fs_is_volatile_file(inode)) {
+		clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
 		set_inode_flag(F2FS_I(inode), FI_DROP_CACHE);
 		filemap_fdatawrite(inode->i_mapping);
 		clear_inode_flag(F2FS_I(inode), FI_DROP_CACHE);
@@ -1449,10 +1450,8 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	if (ret)
 		return ret;
 
-	if (f2fs_is_atomic_file(inode)) {
-		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
+	if (f2fs_is_atomic_file(inode))
 		drop_inmem_pages(inode);
-	}
 	if (f2fs_is_volatile_file(inode)) {
 		clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
 		ret = f2fs_sync_file(filp, 0, LLONG_MAX, 0);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 540669d..299c784 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -239,6 +239,8 @@ void drop_inmem_pages(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
+	clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
+
 	mutex_lock(&fi->inmem_lock);
 	__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
 	mutex_unlock(&fi->inmem_lock);
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
