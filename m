From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: fix to update variable correctly when skip
 a unmapped block
Date: Mon, 14 Dec 2015 15:26:04 +0800
Message-ID: <004f01d13640$ceab8890$6c0299b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1a8NXE-00047r-NF
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 07:27:04 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a8NXC-0006CV-QX
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 07:27:04 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZC01X587CUNL00@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 16:26:54 +0900 (KST)
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

map.m_len should be reduced after skip a block

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/file.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5fac4f2..9949d0f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1759,6 +1759,7 @@ do_map:

                if (!(map.m_flags & F2FS_MAP_FLAGS)) {
                        map.m_lblk++;
+                       map.m_len--;
                        continue;
                }

-- 
1.7.9.5


------------------------------------------------------------------------------
