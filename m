From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix data corruption issue with hardware encryption
Date: Wed, 10 Oct 2018 19:15:06 -0700
Message-ID: <20181011021506.GA78526@jaegeuk-macbookpro.roam.corp.google.com>
References: <1539149182-12729-1-git-send-email-stummala@codeaurora.org>
 <20181010213402.GA52406@jaegeuk-macbookpro.roam.corp.google.com>
 <20181011002935.GA24669@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181011002935.GA24669@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/11, Sahitya Tummala wrote:
> On Wed, Oct 10, 2018 at 02:34:02PM -0700, Jaegeuk Kim wrote:
> > On 10/10, Sahitya Tummala wrote:
> > > Direct IO can be used in case of hardware encryption. The following
> > > scenario results into data corruption issue in this path -
> > > 
> > > Thread A -                          Thread B-
> > > -> write file#1 in direct IO
> > >                                     -> GC gets kicked in
> > >                                     -> GC submitted bio on meta mapping
> > > 				       for file#1, but pending completion
> > > -> write file#1 again with new data
> > >    in direct IO
> > >                                     -> GC bio gets completed now
> > >                                     -> GC writes old data to the new
> > >                                        location and thus file#1 is
> > > 				       corrupted.
> > > 
> > > Fix this by submitting and waiting for pending io on meta mapping
> > > for direct IO case in f2fs_map_blocks().
> > > 
> > > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > > ---
> > >  fs/f2fs/data.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 9ef6f1f..7b2fef0 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -1028,6 +1028,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
> > >  		map->m_pblk = ei.blk + pgofs - ei.fofs;
> > >  		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
> > >  		map->m_flags = F2FS_MAP_MAPPED;
> > > +		/* for HW encryption, but to avoid potential issue in future */
> > > +		if (flag == F2FS_GET_BLOCK_DIO) {
> > > +			blkaddr = map->m_pblk;
> > > +			for (; blkaddr < map->m_pblk + map->m_len; blkaddr++)
> > > +				f2fs_wait_on_block_writeback(sbi, blkaddr);
> > 
> > Do we need this? IIRC, DIO would give create=1.
> 
> Yes, we need it. When we are overwriting an existing file, DIO calls
> f2fs_map_blocks() with create=0. From the DIO code, I see that this happens
> because blockdev_direct_IO() passes this dio flag DIO_SKIP_HOLES. And then
> in get_more_blocks(), below code updates create=0, when we are overwriting
> an existing file.
> 
>                 create = dio->op == REQ_OP_WRITE;
>                 if (dio->flags & DIO_SKIP_HOLES) {
>                         if (fs_startblk <= ((i_size_read(dio->inode) - 1) >>
>                                                         i_blkbits))
>                                 create = 0;
>                 }
> 
>                 ret = (*sdio->get_block)(dio->inode, fs_startblk,
>                                                 map_bh, create);
> 

Got it.
How about this?

>From 216037253e6c21530ced716940fa01978d801f0d Mon Sep 17 00:00:00 2001
From: Sahitya Tummala <stummala@codeaurora.org>
Date: Wed, 10 Oct 2018 10:56:22 +0530
Subject: [PATCH] f2fs: fix data corruption issue with hardware encryption

Direct IO can be used in case of hardware encryption. The following
scenario results into data corruption issue in this path -

Thread A -                          Thread B-
-> write file#1 in direct IO
                                    -> GC gets kicked in
                                    -> GC submitted bio on meta mapping
				       for file#1, but pending completion
-> write file#1 again with new data
   in direct IO
                                    -> GC bio gets completed now
                                    -> GC writes old data to the new
                                       location and thus file#1 is
				       corrupted.

Fix this by submitting and waiting for pending io on meta mapping
for direct IO case in f2fs_map_blocks().

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    | 11 +++++++++++
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/segment.c |  7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index be19257d9e36..8952f2d610a6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1030,6 +1030,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		map->m_flags = F2FS_MAP_MAPPED;
 		if (map->m_next_extent)
 			*map->m_next_extent = pgofs + map->m_len;
+
+		/* for hardware encryption, but to avoid potential issue in future */
+		if (flag == F2FS_GET_BLOCK_DIO)
+			f2fs_wait_on_block_writeback_range(inode,
+						map->m_pblk, map->m_len);
 		goto out;
 	}
 
@@ -1188,6 +1193,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	goto next_dnode;
 
 sync_out:
+
+	/* for hardware encryption, but to avoid potential issue in future */
+	if (flag == F2FS_GET_BLOCK_DIO && map->m_flags & F2FS_MAP_MAPPED)
+		f2fs_wait_on_block_writeback_range(inode,
+						map->m_pblk, map->m_len);
+
 	if (flag == F2FS_GET_BLOCK_PRECACHE) {
 		if (map->m_flags & F2FS_MAP_MAPPED) {
 			unsigned int ofs = start_pgofs - map->m_lblk;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7693b1a2072e..4a608a71c360 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2986,6 +2986,8 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 void f2fs_wait_on_page_writeback(struct page *page,
 			enum page_type type, bool ordered);
 void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr);
+void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
+								block_t len);
 void f2fs_write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
 void f2fs_write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
 int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 805c8310d7b0..2a75eb961982 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3301,6 +3301,13 @@ void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr)
 	}
 }
 
+void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
+								block_t len)
+{
+	for (; blkaddr < blkaddr + len; blkaddr++)
+		f2fs_wait_on_block_writeback(inode, blkaddr);
+}
+
 static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-- 
2.19.0.605.g01d371f741-goog
