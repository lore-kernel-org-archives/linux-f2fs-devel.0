From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 04/13] f2fs: clear FI_INC_LINK during the recovery
Date: Tue, 12 Aug 2014 12:49:18 -0700
Message-ID: <1407872967-26423-4-git-send-email-jaegeuk@kernel.org>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XHI4X-0003fE-6C
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:29 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XHI4V-00009C-VX for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:29 +0000
In-Reply-To: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
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

If an inode are fsynced multiple times with fsync & dent marks, this inode will
set FI_INC_LINK at find_fsync_dnodes during the recovery.
But, in recover_inode, recover_dentry doesn't clear that flag when multiple hits
were occurred.

So this patch removes the flag for the further consistency.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index fe1c6d9..cfb2aa9 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -62,8 +62,10 @@ static int recover_dentry(struct page *ipage, struct inode *inode)
 	}
 retry:
 	de = f2fs_find_entry(dir, &name, &page);
-	if (de && inode->i_ino == le32_to_cpu(de->ino))
+	if (de && inode->i_ino == le32_to_cpu(de->ino)) {
+		clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
 		goto out_unmap_put;
+	}
 	if (de) {
 		einode = f2fs_iget(inode->i_sb, le32_to_cpu(de->ino));
 		if (IS_ERR(einode)) {
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
