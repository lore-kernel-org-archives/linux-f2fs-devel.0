From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: allow wrong configure dio to buffered
 write
Date: Fri,  6 Jul 2018 14:09:01 -0700
Message-ID: <20180706210903.77887-2-jaegeuk@kernel.org>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fbXye-00011Z-Af
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 21:09:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fbXya-00BetQ-NQ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 21:09:16 +0000
In-Reply-To: <20180706210903.77887-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This fixes to support unaligned dio as buffered writes.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e66379961804..6e8e78bb64a7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2425,7 +2425,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	err = check_direct_IO(inode, iter, offset);
 	if (err)
-		return err;
+		return 0;
 
 	if (f2fs_force_buffered_io(inode, rw))
 		return 0;
-- 
2.17.0.441.gb46fe60e1d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
