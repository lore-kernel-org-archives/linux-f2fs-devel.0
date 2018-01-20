From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2 v2] f2fs: recover some i_inline flags
Date: Sat, 20 Jan 2018 14:06:16 -0800
Message-ID: <20180120220616.GC28167@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180120042643.20717-1-jaegeuk@kernel.org>
 <20180120042643.20717-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1ed1HL-0001Sk-LK
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 22:06:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ed1HK-00033m-Qz
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 22:06:23 +0000
Content-Disposition: inline
In-Reply-To: <20180120042643.20717-2-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This fixes lost i_inline flags during roll-forward.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

Change log from v1:
 - add a new function to recover the flag
 - fix missing pin_file unset

 fs/f2fs/recovery.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index cbeef73bc4dd..337f3363f48f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -195,6 +195,20 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 	return err;
 }
 
+static void recover_inline_flags(struct inode *inode, struct f2fs_inode *ri)
+{
+	if (ri->i_inline & F2FS_PIN_FILE)
+		set_inode_flag(inode, FI_PIN_FILE);
+	else
+		clear_inode_flag(inode, FI_PIN_FILE);
+	if (ri->i_inline & F2FS_DATA_EXIST)
+		set_inode_flag(inode, FI_DATA_EXIST);
+	else
+		clear_inode_flag(inode, FI_DATA_EXIST);
+	if (!(ri->i_inline & F2FS_INLINE_DOTS))
+		clear_inode_flag(inode, FI_INLINE_DOTS);
+}
+
 static void recover_inode(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode *raw = F2FS_INODE(page);
@@ -211,13 +225,16 @@ static void recover_inode(struct inode *inode, struct page *page)
 
 	F2FS_I(inode)->i_advise = raw->i_advise;
 
+	recover_inline_flags(inode, raw);
+
 	if (file_enc_name(inode))
 		name = "<encrypted>";
 	else
 		name = F2FS_INODE(page)->i_name;
 
-	f2fs_msg(inode->i_sb, KERN_NOTICE, "recover_inode: ino = %x, name = %s",
-			ino_of_node(page), name);
+	f2fs_msg(inode->i_sb, KERN_NOTICE,
+		"recover_inode: ino = %x, name = %s, inline = %x",
+			ino_of_node(page), name, raw->i_inline);
 }
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
