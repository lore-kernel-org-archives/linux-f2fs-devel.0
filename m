From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid writepage lock when many threads
	call fsync
Date: Fri, 11 Mar 2016 16:14:37 -0800
Message-ID: <1457741677-67046-2-git-send-email-jaegeuk@kernel.org>
References: <1457741677-67046-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aeXCh-0004D0-No
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Mar 2016 00:14:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aeXCh-0006uU-39
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Mar 2016 00:14:47 +0000
In-Reply-To: <1457741677-67046-1-git-send-email-jaegeuk@kernel.org>
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

If many threads try to write small number of data and fsync, we should avoid
writepages lock contention.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e5c762b..fb75699 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1400,7 +1400,8 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 
 	diff = nr_pages_to_write(sbi, DATA, wbc);
 
-	if (!S_ISDIR(inode->i_mode) && wbc->sync_mode == WB_SYNC_ALL) {
+	if (!S_ISDIR(inode->i_mode) && wbc->sync_mode == WB_SYNC_ALL &&
+			!is_inode_flag_set(F2FS_I(inode), FI_NEED_IPU)) {
 		mutex_lock(&sbi->writepages);
 		locked = true;
 	}
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140
