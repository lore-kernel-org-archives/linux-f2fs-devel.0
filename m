From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 3/5] f2fs: add key function to handle inline
	dir
Date: Tue, 26 Aug 2014 14:39:03 +0800
Message-ID: <008501cfc0f8$87f31170$97d93450$@samsung.com>
References: <00c101cfb37c$79a58140$6cf083c0$@samsung.com>
	<20140821204517.GB85961@jaegeuk-mac02.mot-mobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XMAQA-0002YF-02
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Aug 2014 06:39:58 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XMAQ7-0001R9-Oy
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Aug 2014 06:39:57 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NAW00LXIIIC4PB0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Aug 2014 15:39:48 +0900 (KST)
In-reply-to: <20140821204517.GB85961@jaegeuk-mac02.mot-mobility.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, August 22, 2014 4:45 AM
> To: Chao Yu
> Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [f2fs-dev][PATCH 3/5] f2fs: add key function to handle inline dir
> 
> Hi Chao,
> 
> On Sat, Aug 09, 2014 at 10:48:20AM +0800, Chao Yu wrote:
> > Adds Functions to implement inline dir init/lookup/insert/delete/convert ops.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/f2fs.h   |   9 ++
> >  fs/f2fs/inline.c | 388 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 397 insertions(+)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 58c1a49..436a498 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1450,4 +1450,13 @@ int f2fs_convert_inline_data(struct inode *, pgoff_t);
> >  int f2fs_write_inline_data(struct inode *, struct page *, unsigned int);
> >  void truncate_inline_data(struct inode *, u64);
> >  int recover_inline_data(struct inode *, struct page *);
> > +struct f2fs_dir_entry *find_in_inline_dir(struct inode *, struct qstr *,
> > +							struct page **);
> > +struct f2fs_dir_entry *f2fs_parent_inline_dir(struct inode *, struct page **);
> > +int make_empty_inline_dir(struct inode *inode, struct inode *, struct page *);
> > +int f2fs_add_inline_entry(struct inode *, const struct qstr *, struct inode *);
> > +void f2fs_delete_inline_entry(struct f2fs_dir_entry *, struct page *,
> > +						struct inode *, struct inode *);
> > +bool f2fs_empty_inline_dir(struct inode *);
> > +int f2fs_read_inline_dir(struct file *, struct dir_context *);
> >  #endif
> > diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> > index 5beecce..58d2623 100644
> > --- a/fs/f2fs/inline.c
> > +++ b/fs/f2fs/inline.c
> > @@ -249,3 +249,391 @@ process_inline:
> >  	}
> >  	return 0;
> >  }
> > +
> > +struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
> > +				struct qstr *name, struct page **res_page)
> > +{
> > +	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
> > +	struct page *ipage;
> > +	struct f2fs_dir_entry *de;
> > +	f2fs_hash_t namehash;
> > +	unsigned long bit_pos = 0;
> > +	struct f2fs_inline_dentry *dentry_blk;
> > +	const void *dentry_bits;
> > +
> > +	ipage = get_node_page(sbi, dir->i_ino);
> > +	if (IS_ERR(ipage))
> > +		return NULL;
> > +
> > +	namehash = f2fs_dentry_hash(name);
> > +
> > +	kmap(ipage);
> 
> Don't need kmap for ipage.

Will delete all 'kmap/kunmap' for ipage.

> 
> > +	dentry_blk = inline_data_addr(ipage);
> > +	dentry_bits = &dentry_blk->dentry_bitmap;
> > +
> > +	while (bit_pos < NR_INLINE_DENTRY) {
> > +		if (!test_bit_le(bit_pos, dentry_bits)) {
> > +			bit_pos++;
> > +			continue;
> > +		}
> > +		de = &dentry_blk->dentry[bit_pos];
> > +		if (early_match_name(name->len, namehash, de)) {
> > +			if (!memcmp(dentry_blk->filename[bit_pos],
> > +							name->name,
> > +							name->len)) {
> > +				*res_page = ipage;
> > +				goto found;
> > +			}
> > +		}
> > +
> > +		/*
> > +		 * For the most part, it should be a bug when name_len is zero.
> > +		 * We stop here for figuring out where the bugs are occurred.
> > +		 */
> > +		f2fs_bug_on(!de->name_len);
> > +
> > +		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
> > +	}
> > +
> > +	de = NULL;
> > +	kunmap(ipage);
> 
> Ditto.
> 
> > +found:
> > +	unlock_page(ipage);
> > +	return de;
> > +}
> > +
> > +struct f2fs_dir_entry *f2fs_parent_inline_dir(struct inode *dir,
> > +							struct page **p)
> > +{
> > +	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
> > +	struct page *ipage;
> > +	struct f2fs_dir_entry *de;
> > +	struct f2fs_inline_dentry *dentry_blk;
> > +
> > +	ipage = get_node_page(sbi, dir->i_ino);
> > +	if (IS_ERR(ipage))
> > +		return NULL;
> > +
> > +	kmap(ipage);
> 
> Ditto.
> 
> > +	dentry_blk = inline_data_addr(ipage);
> > +	de = &dentry_blk->dentry[1];
> > +	*p = ipage;
> > +	unlock_page(ipage);
> > +	return de;
> > +}
> > +

[snip]

> > +int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
> > +				struct f2fs_inline_dentry *inline_dentry)
> > +{
> > +	struct page *page;
> > +	struct dnode_of_data dn;
> > +	block_t new_blk_addr;
> > +	struct f2fs_dentry_block *dentry_blk;
> > +	struct f2fs_io_info fio = {
> > +		.type = DATA,
> > +		.rw = WRITE_SYNC | REQ_PRIO,
> > +	};
> > +	int err;
> > +
> > +	page = grab_cache_page(dir->i_mapping, 0);
> > +	if (!page)
> > +		return -ENOMEM;
> > +
> > +	set_new_dnode(&dn, dir, ipage, NULL, 0);
> > +	err = f2fs_reserve_block(&dn, 0);
> > +	if (err)
> > +		goto out;
> 
> At a glance, we don't need to care about dentry blocks to sync, since checkpoint
> handles that.

Yeah, agreed. Thanks for reminding me the issue! I got the reason why
convert_inline_data should sync dentry blocks, but convert_inline_dir
do not need to care about it from the scenario given from you to
Huajun Li.

> It needs to consider about checkpoint and f2fs_sync_file.

If this directory inode is being fsynced, do_checkpoint will be invoked for
data consistent, is there any special case convert_inline_dir will encounter?

> 
> The addition and deletion stuffs are almost same as the existing codes.
> Can we reuse those to avoid potential bugs?

Yes, it could be, and I tried before, it seems not very clean to me when
I implement f2fs_{add,delete}_inline_entry inside f2fs_{add,delete}_dentry.

I think it's better to introduce inner function including the same part
of code between f2fs_add_entry and f2fs_add_inline_entry or between
f2fs_inline_entry and f2fs_delete_inline_entry.

How do you think?

> 
> And it'd be better to add inline_dentry mount option separately for now.

OK.

Thanks,
Yu

> 
> Thanks,
> 
> > +
> > +	f2fs_wait_on_page_writeback(page, DATA);
> > +	zero_user_segment(page, 0, PAGE_CACHE_SIZE);
> > +
> > +	dentry_blk = kmap(page);
> > +
> > +	/* copy data from inline dentry block to new dentry block */
> > +	memcpy(dentry_blk->dentry_bitmap, inline_dentry->dentry_bitmap,
> > +					INLINE_DENTRY_BITMAP_SIZE);
> > +	memcpy(dentry_blk->reserved, inline_dentry->reserved,
> > +					INLINE_RESERVED_SIZE);
> > +	memcpy(dentry_blk->dentry, inline_dentry->dentry,
> > +			sizeof(struct f2fs_dir_entry) * NR_INLINE_DENTRY);
> > +	memcpy(dentry_blk->filename, inline_dentry->filename,
> > +					NR_INLINE_DENTRY * F2FS_SLOT_LEN);
> > +
> > +	kunmap(page);
> > +	SetPageUptodate(page);
> > +
> > +	/* writeback dentry page to make data consistent */
> > +	set_page_writeback(page);
> > +	write_data_page(page, &dn, &new_blk_addr, &fio);
> > +	update_extent_cache(new_blk_addr, &dn);
> > +	f2fs_wait_on_page_writeback(page, DATA);
> > +
> > +	/* clear inline dir and flag after data writeback */
> > +	zero_user_segment(ipage, INLINE_DATA_OFFSET,
> > +				 INLINE_DATA_OFFSET + MAX_INLINE_DATA);
> > +	clear_inode_flag(F2FS_I(dir), FI_INLINE_DATA);
> > +	stat_dec_inline_inode(dir);
> > +
> > +	if (i_size_read(dir) < PAGE_CACHE_SIZE) {
> > +		i_size_write(dir, PAGE_CACHE_SIZE);
> > +		set_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
> > +	}
> > +
> > +	sync_inode_page(&dn);
> > +out:
> > +
> > +	f2fs_put_page(page, 1);
> > +	return err;
> > +}
> > +

[snip]



------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
