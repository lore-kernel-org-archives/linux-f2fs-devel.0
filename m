From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: remove redundant io plug
Date: Tue, 27 Sep 2016 00:09:53 +0800
Message-ID: <1474906193-6487-2-git-send-email-chao@kernel.org>
References: <1474906193-6487-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1boYVn-00086O-AV
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 16:12:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1boYVm-0000KB-LA
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 16:12:11 +0000
In-Reply-To: <1474906193-6487-1-git-send-email-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a655d75..de8693c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -267,7 +267,6 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 				struct writeback_control *wbc)
 {
 	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
-	struct blk_plug plug;
 	long diff, written;
 
 	/* collect a number of dirty meta pages and write together */
@@ -280,9 +279,7 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 	/* if mounting is failed, skip writing node pages */
 	mutex_lock(&sbi->cp_mutex);
 	diff = nr_pages_to_write(sbi, META, wbc);
-	blk_start_plug(&plug);
 	written = sync_meta_pages(sbi, META, wbc->nr_to_write);
-	blk_finish_plug(&plug);
 	mutex_unlock(&sbi->cp_mutex);
 	wbc->nr_to_write = max((long)0, wbc->nr_to_write - written - diff);
 	return 0;
-- 
2.7.2


------------------------------------------------------------------------------
