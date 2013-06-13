From: Haicheng Li <haicheng.li@linux.intel.com>
Subject: [f2fs-dev] [PATCH 2/3] f2fs: make locate_dirty_segment() as static
Date: Thu, 13 Jun 2013 16:59:28 +0800
Message-ID: <1371113969-946-3-git-send-email-haicheng.li@linux.intel.com>
References: <1371113969-946-1-git-send-email-haicheng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <haicheng.li@linux.intel.com>) id 1Un3Ok-0005HR-NR
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Jun 2013 09:00:50 +0000
Received: from mga14.intel.com ([143.182.124.37])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Un3Oj-0002C2-Po for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Jun 2013 09:00:50 +0000
In-Reply-To: <1371113969-946-1-git-send-email-haicheng.li@linux.intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: Haicheng Li <haicheng.lee@gmail.com>, linux-kernel@vger.kernel.org

It's used only locally and could be static.

Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
---
 fs/f2fs/f2fs.h    |    1 -
 fs/f2fs/segment.c |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a05aa65..3e7cb33 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -996,7 +996,6 @@ void destroy_node_manager_caches(void);
  */
 void f2fs_balance_fs(struct f2fs_sb_info *);
 void invalidate_blocks(struct f2fs_sb_info *, block_t);
-void locate_dirty_segment(struct f2fs_sb_info *, unsigned int);
 void clear_prefree_segments(struct f2fs_sb_info *);
 int npages_for_summary_flush(struct f2fs_sb_info *);
 void allocate_new_segments(struct f2fs_sb_info *);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 77f31c0..b15debc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -94,7 +94,7 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
  * Adding dirty entry into seglist is not critical operation.
  * If a given segment is one of current working segments, it won't be added.
  */
-void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
+static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	unsigned short valid_blocks;
-- 
1.7.9.5


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
