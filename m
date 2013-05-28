From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 3/3] f2fs: fix incorrect iputs during the dentry
	recovery
Date: Tue, 28 May 2013 10:19:45 +0900
Message-ID: <1369703985-26284-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1369703985-26284-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Uh8bC-0004IZ-3q
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 May 2013 01:21:14 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uh8bB-0002Pu-3q for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 May 2013 01:21:14 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MNH00H58IEW3DB0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 May 2013 10:21:00 +0900 (KST)
In-reply-to: <1369703985-26284-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

- iget/iput flow in the dentry recovery process

1. *dir* = f2fs_iget
2. set FI_DELAY_IPUT to *dir*
3. add *dir* to the dirty_dir_list
		   - __f2fs_add_link
		     - recover_dentry)
4. iput *dir* by remove_dirty_dir_inode
		   - sync_dirty_dir_inodes
		     - write_chekcpoint

If *dir*'s i_count is not 1 (i.e., root dir), remove_dirty_dir_inode is called
later and then iput is triggered again due to the FI_DELAY_IPUT flag.
So, let's unset the flag properly once iput is triggered.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0d3701d..6f56e57 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -521,8 +521,10 @@ void remove_dirty_dir_inode(struct inode *inode)
 	spin_unlock(&sbi->dir_inode_lock);
 
 	/* Only from the recovery routine */
-	if (is_inode_flag_set(F2FS_I(inode), FI_DELAY_IPUT))
+	if (is_inode_flag_set(F2FS_I(inode), FI_DELAY_IPUT)) {
+		clear_inode_flag(F2FS_I(inode), FI_DELAY_IPUT);
 		iput(inode);
+	}
 }
 
 struct inode *check_dirty_dir_inode(struct f2fs_sb_info *sbi, nid_t ino)
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
