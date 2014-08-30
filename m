From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 11/17] fsck.f2fs: remove dentry if its inode
	block is corrupted
Date: Fri, 29 Aug 2014 17:28:58 -0700
Message-ID: <1409358544-54740-11-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWY9-0005S0-Lf
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:49 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWY8-0001ku-Vh for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:49 +0000
In-Reply-To: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
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

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 00f5b27..2a47b4c 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -617,8 +617,21 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 				TYPE_INODE,
 				&blk_cnt);
 
-		if (ret)
-			printf("TODO: delete dentry\n");
+		if (ret && config.fix_cnt) {
+			int j;
+			int slots = (name_len + F2FS_SLOT_LEN - 1) /
+				F2FS_SLOT_LEN;
+			for (j = 0; j < slots; j++)
+				clear_bit(i + j,
+					(unsigned long *)de_blk->dentry_bitmap);
+			FIX_MSG("Unlink [0x%x] - %s len[0x%x], type[0x%x]",
+					le32_to_cpu(de_blk->dentry[i].ino),
+					name, name_len,
+					de_blk->dentry[i].file_type);
+			i += slots;
+			free(name);
+			continue;
+		}
 
 		i += (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN;
 		dentries++;
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
