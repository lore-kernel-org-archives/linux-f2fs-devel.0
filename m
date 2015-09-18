From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/3] f2fs: use correct flag in f2fs_map_blocks()
Date: Fri, 18 Sep 2015 16:54:16 +0800
Message-ID: <00cc01d0f1ef$b19f9dd0$14ded970$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZcrRi-00005e-8W
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Sep 2015 08:55:06 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZcrRg-0003aV-I4
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Sep 2015 08:55:06 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NUV01B7D7F1J150@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Sep 2015 17:54:57 +0900 (KST)
Content-language: zh-cn
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We introduce F2FS_GET_BLOCK_READ in commit e2b4e2bc8865 ("f2fs: fix
incorrect mapping for bmap"), but forget to use this flag in the right
place, fix it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 78b3161..96fc613 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -908,7 +908,8 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 			map.m_lblk = block_in_file;
 			map.m_len = last_block - block_in_file;
 
-			if (f2fs_map_blocks(inode, &map, 0, false))
+			if (f2fs_map_blocks(inode, &map, 0,
+							F2FS_GET_BLOCK_READ))
 				goto set_error_page;
 		}
 got_it:
-- 
2.5.2



------------------------------------------------------------------------------
