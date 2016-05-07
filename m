From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: do not preallocate block unaligned to
	4KB
Date: Sat,  7 May 2016 10:45:19 -0700
Message-ID: <1462643119-96530-2-git-send-email-jaegeuk@kernel.org>
References: <1462643119-96530-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1az6ID-0007tP-Qt
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 May 2016 17:45:29 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1az6ID-0003TO-3s
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 May 2016 17:45:29 +0000
In-Reply-To: <1462643119-96530-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Previously f2fs_preallocate_blocks() tries to allocate unaligned blocks.
In f2fs_write_begin(), however, prepare_write_begin() does not skip its
allocation due to (len != 4KB).
So, it needs locking node page twice unexpectedly.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 96b0353..369d953 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -582,8 +582,8 @@ ssize_t f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 	struct f2fs_map_blocks map;
 	ssize_t ret = 0;
 
-	map.m_lblk = F2FS_BYTES_TO_BLK(iocb->ki_pos);
-	map.m_len = F2FS_BLK_ALIGN(iov_iter_count(from));
+	map.m_lblk = F2FS_BLK_ALIGN(iocb->ki_pos);
+	map.m_len = F2FS_BYTES_TO_BLK(iov_iter_count(from));
 	map.m_next_pgofs = NULL;
 
 	if (f2fs_encrypted_inode(inode))
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
