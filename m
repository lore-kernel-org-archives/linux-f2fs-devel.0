From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH 2/3] f2fs: fix get stale meta pages when build
	free nids
Date: Mon,  9 Mar 2015 11:00:54 +0800
Message-ID: <1425870055-27694-2-git-send-email-wanpeng.li@linux.intel.com>
References: <1425870055-27694-1-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wanpeng.li@linux.intel.com>) id 1YUoDt-0005rz-QZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 Mar 2015 03:19:17 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YUoDr-0006tM-QV for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 Mar 2015 03:19:17 +0000
In-Reply-To: <1425870055-27694-1-git-send-email-wanpeng.li@linux.intel.com>
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
Cc: Wanpeng Li <wanpeng.li@linux.intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org

The blocks of nat pages to be scanned will be readahead when build free 
nids. The start blkno will be adjusted to 0 when the intended range over 
max_nids, then function ra_meta_pages readahead the right blkno, however, 
function get_current_nat_page which is called in build_free_nids still 
get the meta pages w/ stale blkno, this patch fix it by adjusting the nid 
and the blkno which will be readahead in avdance in order to readahead and 
get the right meta pages.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/checkpoint.c | 3 ---
 fs/f2fs/node.c       | 9 ++++++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 53bc328..aedb441 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -129,9 +129,6 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages, int type
 
 		switch (type) {
 		case META_NAT:
-			if (unlikely(blkno >=
-					NAT_BLOCK_OFFSET(NM_I(sbi)->max_nid)))
-				blkno = 0;
 			/* get nat block addr */
 			fio.blk_addr = current_nat_addr(sbi,
 					blkno * NAT_ENTRY_PER_BLOCK);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1a7e925..8751375 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1509,13 +1509,20 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
 	struct f2fs_summary_block *sum = curseg->sum_blk;
 	int i = 0;
 	nid_t nid = nm_i->next_scan_nid;
+	block_t blkno = NAT_BLOCK_OFFSET(nid);
 
 	/* Enough entries */
 	if (nm_i->fcnt > NAT_ENTRY_PER_BLOCK)
 		return;
 
+	if (unlikely(blkno >=
+			NAT_BLOCK_OFFSET(NM_I(sbi)->max_nid))) {
+		blkno = 0;
+		nid = 0;
+	}
+
 	/* readahead nat pages to be scanned */
-	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES, META_NAT);
+	ra_meta_pages(sbi, blkno, FREE_NID_PAGES, META_NAT);
 
 	while (1) {
 		struct page *page = get_current_nat_page(sbi, nid);
-- 
1.9.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
