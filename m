From: Wang Sheng-Hui <shhuiw@gmail.com>
Subject: [f2fs-dev] [PATCH] f2fs-tools: fix the calculation
 raw_node->footer.next_blkaddr for in f2fs_write_root_inode
Date: Fri, 28 Jun 2013 10:41:26 +0800
Message-ID: <51CCF7D6.1080008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shhuiw@gmail.com>) id 1UsOd9-0005dD-90
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Jun 2013 02:41:47 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UsOd7-0000VQ-Hs
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Jun 2013 02:41:47 +0000
Received: by mail-pb0-f47.google.com with SMTP id rr13so1691990pbb.34
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 27 Jun 2013 19:41:39 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk.kim@samsung.com

The raw_node will take 1 blk itself, and its next blk addr should be +1.

Signed-off-by: Wang Sheng-Hui <shhuiw@gmail.com>
---
  mkfs/f2fs_format.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 06771ff..3ab41cc 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -744,7 +744,7 @@ static int f2fs_write_root_inode(void)
  	raw_node->footer.next_blkaddr = cpu_to_le32(
  			le32_to_cpu(super_block.main_blkaddr) +
  			config.cur_seg[CURSEG_HOT_NODE] *
-			config.blks_per_seg + 1);
+			config.blks_per_seg) + 1;

  	raw_node->i.i_mode = cpu_to_le16(0x41ed);
  	raw_node->i.i_links = cpu_to_le32(2);
-- 
1.7.10.4


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
