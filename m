From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] fsck.f2fs: sanity check of crc_offset from raw
	checkpoint
Date: Wed, 15 Mar 2017 21:12:10 +0800
Message-ID: <3c4486ea-8bcf-2c9e-0838-4603a75ee163@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1co8j5-00051G-Uu
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Mar 2017 13:12:27 +0000
Received: from mail-it0-f67.google.com ([209.85.214.67])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1co8j3-0000Z2-S9
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Mar 2017 13:12:27 +0000
Received: by mail-it0-f67.google.com with SMTP id u69so3008037ita.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 15 Mar 2017 06:12:25 -0700 (PDT)
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

The crc_offset towards or beyond the end of block is wrong,
sanity check it.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fsck/mount.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index fc4cca8..c54bb95 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -545,7 +545,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 
 	cp = (struct f2fs_checkpoint *)cp_page_1;
 	crc_offset = get_cp(checksum_offset);
-	if (crc_offset >= blk_size)
+	if (crc_offset > (blk_size - sizeof(__le32)))
 		goto invalid_cp1;
 
 	crc = le32_to_cpu(*(__le32 *)((unsigned char *)cp + crc_offset));
@@ -563,7 +563,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 
 	cp = (struct f2fs_checkpoint *)cp_page_2;
 	crc_offset = get_cp(checksum_offset);
-	if (crc_offset >= blk_size)
+	if (crc_offset > (blk_size - sizeof(__le32)))
 		goto invalid_cp2;
 
 	crc = le32_to_cpu(*(__le32 *)((unsigned char *)cp + crc_offset));
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
