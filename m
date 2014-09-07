From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH] f2fs: Avoid node page to be written twice in
	gc_node_segment
Date: Sun,  7 Sep 2014 11:05:20 +0800
Message-ID: <1410059120-9096-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ying.huang@intel.com>) id 1XQSnM-0007uI-G8
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 07 Sep 2014 03:05:40 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XQSnL-0006bN-KR for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 07 Sep 2014 03:05:40 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In gc_node_segment, if node page gc is run concurrently with node page
writeback, and check_valid_map and get_node_page run after page locked
and before cur_valid_map is updated as below, it is possible for the
page to be written twice unnecessarily.

			sync_node_pages
			  try_lock_page
			  ...
check_valid_map		  f2fs_write_node_page
			    ...
			    write_node_page
			      do_write_page
			        allocate_data_block
				  ...
				  refresh_sit_entry /* update cur_valid_map */
				  ...
			    ...
			    unlock_page
get_node_page
...
set_page_dirty
...
f2fs_put_page
  unlock_page

This can be solved via calling check_valid_map after get_node_page again.

Signed-off-by: Huang, Ying <ying.huang@intel.com>
---
 fs/f2fs/gc.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -421,6 +421,12 @@ next_step:
 		if (IS_ERR(node_page))
 			continue;
 
+		/* block may become invalid during get_node_page */
+		if (check_valid_map(sbi, segno, off) == 0) {
+			f2fs_put_page(node_page, 1);
+			continue;
+		}
+
 		/* set page dirty and write it */
 		if (gc_type == FG_GC) {
 			f2fs_wait_on_page_writeback(node_page, NODE);

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
