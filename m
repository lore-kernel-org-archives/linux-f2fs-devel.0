From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: add a max block count for f2fs_map_blocks
Date: Fri, 25 Dec 2015 16:47:37 +0800
Message-ID: <1451033257-2087-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1aCO2X-000413-Ow
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Dec 2015 08:47:57 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aCO2R-0005zy-98
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Dec 2015 08:47:57 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao2.yu@samsung.com

This patch adds a max block count for f2fs_map_blocks

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
---
 fs/f2fs/data.c | 4 ++++
 fs/f2fs/f2fs.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e34b1bd..2a16c867 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -578,6 +578,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	map->m_len = 0;
 	map->m_flags = 0;
 
+	/* We can handle the block number less than F2FS_MAX_BLOCKS */
+	if (unlikely(map->m_lblk >= F2FS_MAX_BLOCKS))
+		return -EUCLEAN;
+
 	/* it only supports block size == page size */
 	pgofs =	(pgoff_t)map->m_lblk;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 19beabe..911c99b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -331,6 +331,9 @@ enum {
 
 #define F2FS_LINK_MAX	0xffffffff	/* maximum link count per file */
 
+
+#define F2FS_MAX_BLOCKS 0x3F015AFF      /* maximum block count per file */
+
 #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
 
 /* vector size for gang look-up from extent cache that consists of radix tree */
-- 
1.9.1


------------------------------------------------------------------------------
