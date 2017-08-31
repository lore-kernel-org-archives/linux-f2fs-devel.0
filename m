From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: avoid race in between atomic_read &
 atomic_inc
Date: Thu, 31 Aug 2017 18:56:05 +0800
Message-ID: <20170831105606.99384-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dnN9e-0008JQ-21
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 Aug 2017 10:56:58 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dnN9c-000775-M6
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 Aug 2017 10:56:57 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously, we will miss merging flush command during fsync due to below
race condition:

Thread A 		Thread B		Thread C
- f2fs_issue_flush
 - atomic_read(&issing_flush)
			- f2fs_issue_flush
			 - atomic_read(&issing_flush)
						- f2fs_issue_flush
						 - atomic_read(&issing_flush)
  - atomic_inc(&issing_flush)
			  - atomic_inc(&issing_flush)
						  - atomic_inc(&issing_flush)
   - submit_flush_wait
			   - submit_flush_wait
						   - submit_flush_wait

It needs to use atomic_inc_return instead to avoid such race.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d6c3f456ea51..1215ca1bd4e2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -536,8 +536,7 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 		return ret;
 	}
 
-	if (!atomic_read(&fcc->issing_flush)) {
-		atomic_inc(&fcc->issing_flush);
+	if (atomic_inc_return(&fcc->issing_flush) == 1) {
 		ret = submit_flush_wait(sbi);
 		atomic_dec(&fcc->issing_flush);
 
@@ -547,7 +546,6 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 
 	init_completion(&cmd.wait);
 
-	atomic_inc(&fcc->issing_flush);
 	llist_add(&cmd.llnode, &fcc->issue_list);
 
 	/* update issue_list before we wake up issue_flush thread */
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
