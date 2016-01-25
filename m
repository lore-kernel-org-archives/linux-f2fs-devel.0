From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid multiple node page writes due
 to	inline_data
Date: Mon, 25 Jan 2016 11:17:51 -0800
Message-ID: <20160125191751.GA12233@jaegeuk.gateway>
References: <1453580148-61861-1-git-send-email-jaegeuk@kernel.org>
 <000d01d15754$dca6e6d0$95f4b470$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000d01d15754$dca6e6d0$95f4b470$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Mon, Jan 25, 2016 at 05:42:40PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Sunday, January 24, 2016 4:16 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 1/2] f2fs: avoid multiple node page writes due to inline_data
> > 
> > The sceanrio is:
> > 1. create fully node blocks
> > 2. flush node blocks
> > 3. write inline_data for all the node blocks again
> > 4. flush node blocks redundantly
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 8d0d9ec..011456e 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1622,14 +1622,22 @@ static int f2fs_write_end(struct file *file,
> > 
> >  	trace_f2fs_write_end(inode, pos, len, copied);
> > 
> > -	set_page_dirty(page);
> > -
> >  	if (pos + copied > i_size_read(inode)) {
> >  		i_size_write(inode, pos + copied);
> >  		mark_inode_dirty(inode);
> > -		update_inode_page(inode);
> >  	}
> > 
> > +	if (f2fs_has_inline_data(inode) &&
> > +			is_inode_flag_set(F2FS_I(inode), FI_DATA_EXIST)) {
> > +		int err = f2fs_write_inline_data(inode, page);
> 
> Oh, I'm sure this can fix that issue, but IMO:
> a) this implementation has side-effect, it triggers inline data copying
> between data page and node page whenever user write inline datas, so if
> user updates inline data frequently, write-through approach would cause
> memory copy overhead.

Agreed.

> b) inline storm should be a rare case, as we didn't get any report about
> problem for long time until Dave's, and write_end is a hot path, I think
> it's better to be cautious to change our inline data cache policy for
> fixing a rare issue in hot path.
> 
> What about delaying the merge operation? like:
> 1) as I proposed before, merging inline page into inode page when
> detecting free_sections <= (node_secs + 2 * dent_secs + inline_secs).
> 2) merge inline page into inode page before writeback inode page in
> sync_node_pages.

Okay, I'm thinking more general way where we can get rid of every inlien_data
write when we flush node pages.

I've been testing this patch.

>From ebddf607c64da691fef08cf68a8ecadafd5d896b Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 25 Jan 2016 05:57:05 -0800
Subject: [PATCH] f2fs: avoid multiple node page writes due to inline_data

The sceanrio is:
1. create fully node blocks
2. flush node blocks
3. write inline_data for all the node blocks again
4. flush node blocks redundantly

So, this patch tries to flush inline_data when flushing node blocks.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c   |  1 +
 fs/f2fs/inline.c |  2 ++
 fs/f2fs/node.c   | 35 +++++++++++++++++++++++++++++++++++
 fs/f2fs/node.h   | 15 +++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6925c10..9043ecf 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1464,6 +1464,7 @@ restart:
 		if (pos + len <= MAX_INLINE_DATA) {
 			read_inline_data(page, ipage);
 			set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
+			set_inline_node(ipage);
 			sync_inode_page(&dn);
 		} else {
 			err = f2fs_convert_inline_page(&dn, page);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8df13e5..fc4d298 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -159,6 +159,7 @@ no_update:
 
 	/* clear inline data and flag after data writeback */
 	truncate_inline_inode(dn->inode_page, 0);
+	clear_inline_node(dn->inode_page);
 clear_out:
 	stat_dec_inline_inode(dn->inode);
 	f2fs_clear_inline_inode(dn->inode);
@@ -233,6 +234,7 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
 
 	sync_inode_page(&dn);
+	clear_inline_node(dn.inode_page);
 	f2fs_put_dnode(&dn);
 	return 0;
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 23b800d..1c5023e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1154,6 +1154,33 @@ void sync_inode_page(struct dnode_of_data *dn)
 	dn->node_changed = ret ? true: false;
 }
 
+static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
+{
+	struct inode *inode;
+	struct page *page;
+
+	inode = ilookup(sbi->sb, ino);
+	if (!inode)
+		return;
+
+	page = find_lock_page(inode->i_mapping, 0);
+	if (!page)
+		goto iput_out;
+
+	if (!PageDirty(page))
+		goto put_page_out;
+
+	if (!clear_page_dirty_for_io(page))
+		goto put_page_out;
+
+	if (!f2fs_write_inline_data(inode, page))
+		inode_dec_dirty_pages(inode);
+put_page_out:
+	f2fs_put_page(page, 1);
+iput_out:
+	iput(inode);
+}
+
 int sync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
 					struct writeback_control *wbc)
 {
@@ -1221,6 +1248,14 @@ continue_unlock:
 				goto continue_unlock;
 			}
 
+			/* flush inline_data */
+			if (!ino && is_inline_node(page)) {
+				clear_inline_node(page);
+				unlock_page(page);
+				flush_inline_data(sbi, ino_of_node(page));
+				continue;
+			}
+
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 23bd992..1f4f9d4 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -379,6 +379,21 @@ static inline int is_node(struct page *page, int type)
 #define is_fsync_dnode(page)	is_node(page, FSYNC_BIT_SHIFT)
 #define is_dent_dnode(page)	is_node(page, DENT_BIT_SHIFT)
 
+static inline int is_inline_node(struct page *page)
+{
+	return PageChecked(page);
+}
+
+static inline void set_inline_node(struct page *page)
+{
+	SetPageChecked(page);
+}
+
+static inline void clear_inline_node(struct page *page)
+{
+	ClearPageChecked(page);
+}
+
 static inline void set_cold_node(struct inode *inode, struct page *page)
 {
 	struct f2fs_node *rn = F2FS_NODE(page);
-- 
2.6.3


