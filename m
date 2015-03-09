From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix to truncate inline data past EOF
Date: Sun, 8 Mar 2015 20:48:55 -0700
Message-ID: <20150309034855.GA4472@jaegeuk-mac02>
References: <00d101d05728$aac41570$004c4050$@samsung.com>
 <20150305213346.GA17190@jaegeuk-mac02.mot.com>
 <004501d05a10$511e4820$f35ad860$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <004501d05a10$511e4820$f35ad860$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,


On Mon, Mar 09, 2015 at 10:24:35AM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Friday, March 06, 2015 5:34 AM
> > To: Chao Yu
> > Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] f2fs: fix to truncate inline data past EOF
> > 
> > Hi Chao,
> > 
> > On Thu, Mar 05, 2015 at 05:41:32PM +0800, Chao Yu wrote:
> > > Previously if inode is with inline data, we will try to invalid partial inline
> > > data in page #0 when we truncate size of inode in truncate_partial_data_page().
> > > And then we set page #0 to dirty, after this we can synchronize inode page with
> > > page #0 at ->writepage().
> > >
> > > But sometimes we will fail to operate page #0 in truncate_partial_data_page()
> > > due to below reason:
> > > a) if offset is zero, we will skip setting page #0 to dirty.
> > > b) if page #0 is not uptodate, we will fail to update it as it has no mapping
> > > data.
> > >
> > > So with following operations, we will meet recent data which should be
> > > truncated.
> > >
> > > 1.write inline data to file
> > > 2.sync first data page to inode page
> > > 3.truncate file size to 0
> > > 4.truncate file size to max_inline_size
> > > 5.echo 1 > /proc/sys/vm/drop_caches
> > > 6.read file --> meet original inline data which is remained in inode page.
> > >
> > > This patch renames truncate_inline_data() to truncate_inline_inode() for code
> > > readability, then intruduces new truncate_inline_data() and use it to truncate
> > > inline data in page #0 and inode page in truncate_partial_data_page() for
> > > fixing.
> > >
> > > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > > ---
> > >  fs/f2fs/f2fs.h   |  1 +
> > >  fs/f2fs/file.c   | 13 ++++++++-----
> > >  fs/f2fs/inline.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
> > >  3 files changed, 61 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index 511d6cd..55dbbe7 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -1754,6 +1754,7 @@ extern struct kmem_cache *inode_entry_slab;
> > >   */
> > >  bool f2fs_may_inline(struct inode *);
> > >  void read_inline_data(struct page *, struct page *);
> > > +int truncate_inline_data(struct inode *, u64 from);
> > >  int f2fs_read_inline_data(struct inode *, struct page *);
> > >  int f2fs_convert_inline_page(struct dnode_of_data *, struct page *);
> > >  int f2fs_convert_inline_inode(struct inode *);
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index f1341c7..6c4443e 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -461,6 +461,9 @@ static int truncate_partial_data_page(struct inode *inode, u64 from)
> > >  	unsigned offset = from & (PAGE_CACHE_SIZE - 1);
> > >  	struct page *page;
> > >
> > > +	if (f2fs_has_inline_data(inode))
> > > +		return 0;
> > > +
> > >  	if (!offset)
> > >  		return 0;
> > >
> > > @@ -497,14 +500,14 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
> > >  	if (lock)
> > >  		f2fs_lock_op(sbi);
> > >
> > > -	ipage = get_node_page(sbi, inode->i_ino);
> > > -	if (IS_ERR(ipage)) {
> > > -		err = PTR_ERR(ipage);
> > > +	if (f2fs_has_inline_data(inode)) {
> > > +		err = truncate_inline_data(inode, from);
> > >  		goto out;
> > >  	}
> > >
> > > -	if (f2fs_has_inline_data(inode)) {
> > > -		f2fs_put_page(ipage, 1);
> > > +	ipage = get_node_page(sbi, inode->i_ino);
> > > +	if (IS_ERR(ipage)) {
> > > +		err = PTR_ERR(ipage);
> > >  		goto out;
> > >  	}
> > >
> > > diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> > > index 4ba9732..a8189c92 100644
> > > --- a/fs/f2fs/inline.c
> > > +++ b/fs/f2fs/inline.c
> > > @@ -50,10 +50,57 @@ void read_inline_data(struct page *page, struct page *ipage)
> > >  	SetPageUptodate(page);
> > >  }
> > >
> > > -static void truncate_inline_data(struct page *ipage)
> > > +static void truncate_inline_inode(struct page *ipage, u64 from)
> > >  {
> > > +	void *addr = inline_data_addr(ipage);
> > > +
> > >  	f2fs_wait_on_page_writeback(ipage, NODE);
> > > -	memset(inline_data_addr(ipage), 0, MAX_INLINE_DATA);
> > > +	memset(addr + from, 0, MAX_INLINE_DATA - from);
> > > +}
> > > +
> > > +int truncate_inline_data(struct inode *inode, u64 from)
> > > +{
> > > +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > > +	struct page *page, *ipage;
> > > +	void *addr;
> > > +	int err = 0;
> > > +
> > > +	/*
> > > +	 * we should never truncate inline data past max inline data size,
> > > +	 * because we always convert inline inode to normal one before
> > > +	 * truncating real data if new size is past max inline data size.
> > > +	 */
> > > +	f2fs_bug_on(sbi, from > MAX_INLINE_DATA);
> > > +
> > > +	if (from == MAX_INLINE_DATA)
> > > +		return 0;
> > > +
> > > +	page = grab_cache_page(inode->i_mapping, 0);
> > > +	if (!page)
> > > +		return -ENOMEM;
> > 
> > Do we need to grab and read #0 page?
> 
> No need to read #0 page, sorry for the mistake.
> 
> > How about checking its cached page after on-disk truncation?
> > 
> > 1. page = get_node_page()
> > 2. check_inline
> > 3. truncate_inline_inode
> > 4. f2fs_put_page(ipage)
> > 
> > 5. truncate_partial_data_page(inode, from, force)
> > 	if (!offset && !force)
> >  		return 0;
> > 
> > > +
> > > +	ipage = get_node_page(sbi, inode->i_ino);
> > > +	if (IS_ERR(ipage)) {
> > > +		err = PTR_ERR(ipage);
> > > +		goto out;
> > > +	}
> > > +
> > > +	if (!f2fs_has_inline_data(inode)) {
> > > +		f2fs_put_page(ipage, 1);
> > > +		goto out;
> > > +	}
> > > +
> > > +	truncate_inline_inode(ipage, from);
> > > +	set_page_dirty(ipage);
> > > +
> > > +	read_inline_data(page, ipage);
> > > +	f2fs_put_page(ipage, 1);
> > > +
> > > +	addr = inline_data_addr(page);
> > > +	memset(addr + from, 0, MAX_INLINE_DATA - from);
> > 
> > It needs to do likewise truncate_partial_data_page.
> 
> Do you mean like this?

I meant this.

Anyway, I also wrote a patch about your testing scenario wrt inline_data.
So, let me submit the patch sooner or later to xfstests mailing list.

Thanks,

---
 fs/f2fs/f2fs.h   |  1 +
 fs/f2fs/file.c   | 10 +++++++---
 fs/f2fs/inline.c | 12 +++++++-----
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 31b440e..b222b3a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1760,6 +1760,7 @@ extern struct kmem_cache *inode_entry_slab;
  */
 bool f2fs_may_inline(struct inode *);
 void read_inline_data(struct page *, struct page *);
+void truncate_inline_inode(struct page *, u64);
 int f2fs_read_inline_data(struct inode *, struct page *);
 int f2fs_convert_inline_page(struct dnode_of_data *, struct page *);
 int f2fs_convert_inline_inode(struct inode *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f1341c7..ab249dd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -456,12 +456,12 @@ void truncate_data_blocks(struct dnode_of_data *dn)
 	truncate_data_blocks_range(dn, ADDRS_PER_BLOCK);
 }
 
-static int truncate_partial_data_page(struct inode *inode, u64 from)
+static int truncate_partial_data_page(struct inode *inode, u64 from, bool force)
 {
 	unsigned offset = from & (PAGE_CACHE_SIZE - 1);
 	struct page *page;
 
-	if (!offset)
+	if (!offset && !force)
 		return 0;
 
 	page = find_data_page(inode, from >> PAGE_CACHE_SHIFT, false);
@@ -489,6 +489,7 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	pgoff_t free_from;
 	int count = 0, err = 0;
 	struct page *ipage;
+	bool truncate_page = false;
 
 	trace_f2fs_truncate_blocks_enter(inode, from);
 
@@ -504,6 +505,9 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	}
 
 	if (f2fs_has_inline_data(inode)) {
+		truncate_inline_inode(ipage, from);
+		set_page_dirty(ipage);
+		truncate_page = true;
 		f2fs_put_page(ipage, 1);
 		goto out;
 	}
@@ -535,7 +539,7 @@ out:
 
 	/* lastly zero out the first data page */
 	if (!err)
-		err = truncate_partial_data_page(inode, from);
+		err = truncate_partial_data_page(inode, from, truncate_page);
 
 	trace_f2fs_truncate_blocks_exit(inode, err);
 	return err;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index ee0984c..b236e30 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -50,10 +50,12 @@ void read_inline_data(struct page *page, struct page *ipage)
 	SetPageUptodate(page);
 }
 
-static void truncate_inline_data(struct page *ipage)
+void truncate_inline_inode(struct page *ipage, u64 from)
 {
+	void *addr = inline_data_addr(ipage);
+
 	f2fs_wait_on_page_writeback(ipage, NODE);
-	memset(inline_data_addr(ipage), 0, MAX_INLINE_DATA);
+	memset(addr + from, 0, MAX_INLINE_DATA - from);
 }
 
 int f2fs_read_inline_data(struct inode *inode, struct page *page)
@@ -131,7 +133,7 @@ no_update:
 	set_inode_flag(F2FS_I(dn->inode), FI_APPEND_WRITE);
 
 	/* clear inline data and flag after data writeback */
-	truncate_inline_data(dn->inode_page);
+	truncate_inline_inode(dn->inode_page, 0);
 clear_out:
 	stat_dec_inline_inode(dn->inode);
 	f2fs_clear_inline_inode(dn->inode);
@@ -245,7 +247,7 @@ process_inline:
 	if (f2fs_has_inline_data(inode)) {
 		ipage = get_node_page(sbi, inode->i_ino);
 		f2fs_bug_on(sbi, IS_ERR(ipage));
-		truncate_inline_data(ipage);
+		truncate_inline_inode(ipage, 0);
 		f2fs_clear_inline_inode(inode);
 		update_inode(inode, ipage);
 		f2fs_put_page(ipage, 1);
@@ -363,7 +365,7 @@ static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
 	set_page_dirty(page);
 
 	/* clear inline dir and flag after data writeback */
-	truncate_inline_data(ipage);
+	truncate_inline_inode(ipage, 0);
 
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(F2FS_I(dir), FI_INLINE_DENTRY);
-- 
2.1.1
