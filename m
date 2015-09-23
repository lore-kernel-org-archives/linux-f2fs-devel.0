From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH RESEND] f2fs:Fix concurrent access issue in the
	function recover_dentry
Date: Wed, 23 Sep 2015 15:45:50 -0400
Message-ID: <1443037550-3627-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1ZepzM-0002pA-DB
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 19:46:00 +0000
Received: from mail-ig0-f175.google.com ([209.85.213.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZepzL-0005bx-NC
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 19:46:00 +0000
Received: by igbkq10 with SMTP id kq10so126271472igb.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 23 Sep 2015 12:45:54 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This fixes a concurrent access in the function recover_dentry by
locking the superblock representation in memory with f2fs_lock_op
before calling the function __f2fs_add_link and unlocking the
superblock afterwards with f2fs_unlock_op in order to avoid
concurrent access here as neither recover_dentry nor its callers

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 fs/f2fs/recovery.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index faec2ca..6bb03f8 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -70,6 +70,7 @@ static struct fsync_inode_entry *get_fsync_inode(struct list_head *head,
 static int recover_dentry(struct inode *inode, struct page *ipage)
 {
 	struct f2fs_inode *raw_inode = F2FS_INODE(ipage);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	nid_t pino = le32_to_cpu(raw_inode->i_pino);
 	struct f2fs_dir_entry *de;
 	struct qstr name;
@@ -119,9 +120,15 @@ retry:
 		iput(einode);
 		goto retry;
 	}
+
+
+	f2fs_lock_op(sbi);
 	err = __f2fs_add_link(dir, &name, inode, inode->i_ino, inode->i_mode);
-	if (err)
+	if (err) {
+		f2fs_unlock_op(sbi);
 		goto out_err;
+	}
+	f2fs_unlock_op(sbi);
 
 	if (is_inode_flag_set(F2FS_I(dir), FI_DELAY_IPUT)) {
 		iput(dir);
-- 
2.1.4


------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
