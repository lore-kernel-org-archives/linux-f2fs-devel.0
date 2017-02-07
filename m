From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] mkfs.f2fs: make sure clean all reset dnodes
Date: Tue, 7 Feb 2017 10:43:09 +0800
Message-ID: <7eb4aa73-bf37-5c62-20b7-3b74b7046337@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cavkb-00080h-5i
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Feb 2017 02:43:25 +0000
Received: from mail-it0-f65.google.com ([209.85.214.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cavkY-0003k4-Ut
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Feb 2017 02:43:25 +0000
Received: by mail-it0-f65.google.com with SMTP id 203so11019953ith.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 06 Feb 2017 18:43:22 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

memset(raw_node, 0, F2FS_BLKSIZE) sets the next_blkaddr to zero,
so that, only one reset dnode is cleaned always.

Fixes: ad042d9194f5 "mkfs.f2fs: reset dnode with zeros",
Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 mkfs/f2fs_format.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 3c13026..1b10e4f 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -775,6 +775,8 @@ static int f2fs_write_super_block(void)
 #ifndef WITH_ANDROID
 static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 {
+	u_int64_t next_blkaddr = 0;
+
 	if (c.zoned_mode)
 		return 0;
 	do {
@@ -787,6 +789,7 @@ static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 			return -1;
 		}
 
+		next_blkaddr = le32_to_cpu(raw_node->footer.next_blkaddr);
 		memset(raw_node, 0, F2FS_BLKSIZE);
 
 		DBG(1, "\tDiscard dnode, at offset 0x%08"PRIx64"\n", offset);
@@ -794,7 +797,7 @@ static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 			MSG(1, "\tError: While discarding direct node!!!\n");
 			return -1;
 		}
-		offset = le32_to_cpu(raw_node->footer.next_blkaddr);
+		offset = next_blkaddr;
 	} while (1);
 
 	return 0;
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
