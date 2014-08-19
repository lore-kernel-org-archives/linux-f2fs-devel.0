From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] fsck.f2fs: show inode numbers
Date: Tue, 19 Aug 2014 15:21:12 -0700
Message-ID: <1408486872-78010-2-git-send-email-jaegeuk@kernel.org>
References: <1408486872-78010-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XJrmc-0006XD-M0
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Aug 2014 22:21:38 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XJrmb-0002Y1-L8 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Aug 2014 22:21:38 +0000
In-Reply-To: <1408486872-78010-1-git-send-email-jaegeuk@kernel.org>
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

fsck.f2fs -d 1 [dev]
 : shows inode informations
fsck.f2fs -d -1 [dev]
 : shows directory tree with inode number

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 0f48918..2d8dffb 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -506,7 +506,8 @@ static void print_dentry(__u32 depth, __u8 *name,
 
 	for (i = 1; i < depth; i++)
 		printf("%c   ", tree_mark[i]);
-	printf("%c-- %s\n", last_de ? '`' : '|', name);
+	printf("%c-- %s 0x%x\n", last_de ? '`' : '|',
+				name, le32_to_cpu(de_blk->dentry[idx].ino));
 }
 
 int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi,
@@ -561,7 +562,7 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi,
 			}
 		}
 
-		DBG(2, "[%3u] - no[0x%x] name[%s] len[0x%x] ino[0x%x] type[0x%x]\n",
+		DBG(1, "[%3u] - no[0x%x] name[%s] len[0x%x] ino[0x%x] type[0x%x]\n",
 				fsck->dentry_depth, i, name, name_len,
 				le32_to_cpu(de_blk->dentry[i].ino),
 				de_blk->dentry[i].file_type);
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
