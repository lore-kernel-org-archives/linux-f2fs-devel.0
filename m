From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: avoid IO split due to mixed
 WB_SYNC_ALL and WB_SYNC_NONE
Date: Thu, 30 Mar 2017 21:18:08 -0700
Message-ID: <20170331041808.GA5675@jaegeuk.local>
References: <20170329204815.9175-1-jaegeuk@kernel.org>
	<20170329204815.9175-2-jaegeuk@kernel.org>
	<bf61ab56-b3be-990d-01c3-ce9273fb47b5@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cto0w-00044H-DS
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Mar 2017 04:18:18 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cto0u-00053a-69
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Mar 2017 04:18:18 +0000
Content-Disposition: inline
In-Reply-To: <bf61ab56-b3be-990d-01c3-ce9273fb47b5@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: heyunlei <heyunlei@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 03/31, heyunlei wrote:
> Hi Jaegeuk,
> 
> Can we split in place update bios into single sbi->f2fs_bio_info for more page
> merged in out place update? This case can be show as below:
> 
> in place update submit a bio with one page
> 	out place update submit a bio with one page
> in place update submit a bio with one page
> 	out place update submit a bio with one page
> ... ...
> 
> just like WB_SYNC_ALL and WB_SYNC_NONE case.

Something like this?

>From d9f00695c5e56c48611ade3ced89432ef2b59a27 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 30 Mar 2017 21:02:46 -0700
Subject: [PATCH] f2fs: submit bio of in-place-update pages

This patch tries to split in-place-update bios from sequential bios.

Suggested-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    | 2 +-
 fs/f2fs/f2fs.h    | 2 +-
 fs/f2fs/segment.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b1cac6d85bcb..1392e7c153bf 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1354,7 +1354,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 			!is_cold_data(page) &&
 			!IS_ATOMIC_WRITTEN_PAGE(page) &&
 			need_inplace_update(inode))) {
-		rewrite_data_page(fio);
+		err = rewrite_data_page(fio);
 		set_inode_flag(inode, FI_UPDATE_WRITE);
 		trace_f2fs_do_write_data_page(page, IPU);
 	} else {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fd39db681226..5a2b8cd13c92 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2207,7 +2207,7 @@ void update_meta_page(struct f2fs_sb_info *sbi, void *src, block_t blk_addr);
 void write_meta_page(struct f2fs_sb_info *sbi, struct page *page);
 void write_node_page(unsigned int nid, struct f2fs_io_info *fio);
 void write_data_page(struct dnode_of_data *dn, struct f2fs_io_info *fio);
-void rewrite_data_page(struct f2fs_io_info *fio);
+int rewrite_data_page(struct f2fs_io_info *fio);
 void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			block_t old_blkaddr, block_t new_blkaddr,
 			bool recover_curseg, bool recover_newaddr);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bff3f3bc7827..eedbed62947f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1973,11 +1973,11 @@ void write_data_page(struct dnode_of_data *dn, struct f2fs_io_info *fio)
 	f2fs_update_data_blkaddr(dn, fio->new_blkaddr);
 }
 
-void rewrite_data_page(struct f2fs_io_info *fio)
+int rewrite_data_page(struct f2fs_io_info *fio)
 {
 	fio->new_blkaddr = fio->old_blkaddr;
 	stat_inc_inplace_blocks(fio->sbi);
-	f2fs_submit_page_mbio(fio);
+	return f2fs_submit_page_bio(fio);
 }
 
 void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
