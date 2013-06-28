From: Wang Sheng-Hui <shhuiw@gmail.com>
Subject: [f2fs-dev] [PATCH v2] f2fs-tools: fix the calculation for
 raw_node->footer.next_blkaddr in f2fs_write_root_inode
Date: Fri, 28 Jun 2013 13:12:32 +0800
Message-ID: <51CD1B40.2080803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shhuiw@gmail.com>) id 1UsQzR-0002yV-5n
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Jun 2013 05:12:57 +0000
Received: from mail-ie0-f178.google.com ([209.85.223.178])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UsQzP-0006o5-9m
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Jun 2013 05:12:57 +0000
Received: by mail-ie0-f178.google.com with SMTP id u16so3130500iet.23
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 27 Jun 2013 22:12:50 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com, linux-f2fs-devel@lists.sourceforge.net

The raw_node will take 1 blk itself, and its next blk addr should be +1.

Signed-off-by: Wang Sheng-Hui <shhuiw@gmail.com>
---
  mkfs/f2fs_format.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 06771ff..f00ba04 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -744,7 +744,7 @@ static int f2fs_write_root_inode(void)
  	raw_node->footer.next_blkaddr = cpu_to_le32(
  			le32_to_cpu(super_block.main_blkaddr) +
  			config.cur_seg[CURSEG_HOT_NODE] *
-			config.blks_per_seg + 1);
+			config.blks_per_seg) + cpu_to_le32(1);

  	raw_node->i.i_mode = cpu_to_le16(0x41ed);
  	raw_node->i.i_links = cpu_to_le32(2);
-- 
1.7.10.4

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
