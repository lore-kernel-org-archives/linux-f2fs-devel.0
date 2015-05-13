From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] Space leak in f2fs
Date: Wed, 13 May 2015 10:46:04 -0700
Message-ID: <20150513174417.GA56247@jaegeuk-mac02.mot.com>
References: <5552FA7D.7000704@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5552FA7D.7000704@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: hujianyang <hujianyang@huawei.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Hu,

Thank you for the report.

When I tried to reproduce this, it seems that this can occur under somewhat
stressful condition. I could't reach out to this problem.

Nevertheless, I think this is a possible scenario, so I wrote a patch for this.
Could you test this patch?

Thanks,

---
 fs/f2fs/super.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 19438f2..4593cd1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -431,8 +431,26 @@ static int f2fs_drop_inode(struct inode *inode)
 	 *    - f2fs_gc -> iput -> evict
 	 *       - inode_wait_for_writeback(inode)
 	 */
-	if (!inode_unhashed(inode) && inode->i_state & I_SYNC)
+	if (!inode_unhashed(inode) && inode->i_state & I_SYNC) {
+		if (!inode->i_nlink && !is_bad_inode(inode)) {
+			spin_unlock(&inode->i_lock);
+
+			i_size_write(inode, 0);
+
+			if (F2FS_HAS_BLOCKS(inode))
+				f2fs_truncate(inode);
+
+			f2fs_lock_op(F2FS_I_SB(inode));
+			remove_inode_page(inode);
+			f2fs_unlock_op(F2FS_I_SB(inode));
+
+			/* avoid any write_inode call */
+			clear_inode_flag(F2FS_I(inode), FI_DIRTY_INODE);
+
+			spin_lock(&inode->i_lock);
+		}
 		return 0;
+	}
 	return generic_drop_inode(inode);
 }
 
-- 
2.1.1

