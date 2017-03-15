From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: sanity check of crc_offset from raw
	checkpoint
Date: Wed, 15 Mar 2017 21:12:50 +0800
Message-ID: <87563eb3-5db3-05e5-b26c-cf61b0deb7c1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1co8ji-0004MC-TH
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Mar 2017 13:13:06 +0000
Received: from mail-it0-f68.google.com ([209.85.214.68])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1co8jf-0002vc-7i
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Mar 2017 13:13:06 +0000
Received: by mail-it0-f68.google.com with SMTP id u69so3009919ita.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 15 Mar 2017 06:13:03 -0700 (PDT)
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
 fs/f2fs/checkpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index bd75546..f146700 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -678,7 +678,7 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
 	*cp_block = (struct f2fs_checkpoint *)page_address(*cp_page);
 
 	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
-	if (crc_offset >= blk_size) {
+	if (crc_offset > (blk_size - sizeof(__le32))) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
 			"invalid crc_offset: %zu", crc_offset);
 		return -EINVAL;
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
