From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: avoid m_flags overlay when allocating more
	data blocks
Date: Thu, 23 Feb 2017 19:55:05 +0800
Message-ID: <088115ed-1cd1-1e3c-f282-0248773e6c1e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cgrzU-0003aJ-Sj
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 11:55:20 +0000
Received: from mail-oi0-f68.google.com ([209.85.218.68])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cgrzU-0006Zw-1c
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 11:55:20 +0000
Received: by mail-oi0-f68.google.com with SMTP id l128so1096070oia.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 23 Feb 2017 03:55:20 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

When more than one data blocks are allocated, the F2FS_MAP_UNWRITTEN/MAPPED
flags will be overlapped by F2FS_MAP_NEW at the later times.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5f3bc98..5618ae8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -867,7 +867,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			}
 			if (err)
 				goto sync_out;
-			map->m_flags = F2FS_MAP_NEW;
+			map->m_flags |= F2FS_MAP_NEW;
 			blkaddr = dn.data_blkaddr;
 		} else {
 			if (flag == F2FS_GET_BLOCK_BMAP) {
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
