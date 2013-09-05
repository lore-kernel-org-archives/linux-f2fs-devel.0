From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: merge more bios of node block writes
Date: Thu, 05 Sep 2013 11:02:51 +0900
Message-ID: <1378346571-11331-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VHOuf-0006I1-Ja
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Sep 2013 02:03:13 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VHOua-00056l-Gp for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Sep 2013 02:03:13 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MSM00CNLR10CR90@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Sep 2013 11:03:01 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously, we experience bio traces as follows when running simple sequential
write test.

 f2fs_do_submit_bio: type = NODE, io = no sync, sector = 500104928, size = 4K
 f2fs_do_submit_bio: type = NODE, io = no sync, sector = 499922208, size = 368K
 f2fs_do_submit_bio: type = NODE, io = no sync, sector = 499914752, size = 140K

 -> total 512K

The first one is to write an indirect node block, and the others are to write
direct node blocks.

The reason why there are two separate bios for direct node blocks is:
0. initial state
------------------    ------------------
|                |    |xxxxxxxx        |
------------------    ------------------

1. write 368K
------------------    ------------------
|                |    |xxxxxxxxWWWWWWWW|
------------------    ------------------

2. write 140K
------------------    ------------------
|WWWWWWW         |    |xxxxxxxxWWWWWWWW|
------------------    ------------------

This is because f2fs_write_node_pages tries to write just 512K totally, so that
we can lose the chance to merge more bios nicely.

After this patch is applied, we can get the following bio traces.

  f2fs_do_submit_bio: type = NODE, io = no sync, sector = 500103168, size = 8K
  f2fs_do_submit_bio: type = NODE, io = no sync, sector = 500111368, size = 4K
  f2fs_do_submit_bio: type = NODE, io = no sync, sector = 500107272, size = 512K
  f2fs_do_submit_bio: type = NODE, io = no sync, sector = 500108296, size = 512K
  f2fs_do_submit_bio: type = NODE, io = no sync, sector = 500109320, size = 500K

And finally, we can improve the sequential write performance,
    from 458.775 MB/s to 479.945 MB/s on SSD.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/node.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c3c03c9..51ef278 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1191,9 +1191,9 @@ static int f2fs_write_node_page(struct page *page,
 /*
  * It is very important to gather dirty pages and write at once, so that we can
  * submit a big bio without interfering other data writes.
- * Be default, 512 pages (2MB), a segment size, is quite reasonable.
+ * Be default, 512 pages (2MB) * 3 node types, is more reasonable.
  */
-#define COLLECT_DIRTY_NODES	512
+#define COLLECT_DIRTY_NODES	1536
 static int f2fs_write_node_pages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
@@ -1211,9 +1211,10 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 		return 0;
 
 	/* if mounting is failed, skip writing node pages */
-	wbc->nr_to_write = max_hw_blocks(sbi);
+	wbc->nr_to_write = 3 * max_hw_blocks(sbi);
 	sync_node_pages(sbi, 0, wbc);
-	wbc->nr_to_write = nr_to_write - (max_hw_blocks(sbi) - wbc->nr_to_write);
+	wbc->nr_to_write = nr_to_write - (3 * max_hw_blocks(sbi) -
+						wbc->nr_to_write);
 	return 0;
 }
 
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58041391&iu=/4140/ostg.clktrk
