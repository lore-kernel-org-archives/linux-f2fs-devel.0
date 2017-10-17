From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: handle error case when adding xattr
 entry
Date: Tue, 17 Oct 2017 09:41:54 -0700
Message-ID: <20171017164154.GA5509@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171016230642.94228-1-jaegeuk@kernel.org>
 <cfca102c-fcd9-4d43-80a7-1684a59f5e95@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cfca102c-fcd9-4d43-80a7-1684a59f5e95@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/17, Chao Yu wrote:
> On 2017/10/17 7:06, Jaegeuk Kim wrote:
> > This patch fixes recovering incomplete xattr entries remaining in inline xattr
> > and xattr block, caused by any kind of errors.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/xattr.c | 48 ++++++++++++++++++++++++++++--------------------
> >  1 file changed, 28 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> > index e74a4d7f744a..5a9c5e6ad714 100644
> > --- a/fs/f2fs/xattr.c
> > +++ b/fs/f2fs/xattr.c
> > @@ -389,10 +389,11 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
> >  {
> >  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >  	size_t inline_size = inline_xattr_size(inode);
> > -	void *xattr_addr;
> > +	struct page *in_page = NULL;
> > +	void *xattr_addr, *inline_addr;
> >  	struct page *xpage;
> >  	nid_t new_nid = 0;
> > -	int err;
> > +	int err = 0;
> >  
> >  	if (hsize > inline_size && !F2FS_I(inode)->i_xattr_nid)
> >  		if (!alloc_nid(sbi, &new_nid))
> > @@ -400,30 +401,30 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
> >  
> >  	/* write to inline xattr */
> >  	if (inline_size) {
> > -		struct page *page = NULL;
> > -		void *inline_addr;
> > -
> >  		if (ipage) {
> >  			inline_addr = inline_xattr_addr(inode, ipage);
> > -			f2fs_wait_on_page_writeback(ipage, NODE, true);
> > -			set_page_dirty(ipage);
> >  		} else {
> > -			page = get_node_page(sbi, inode->i_ino);
> > -			if (IS_ERR(page)) {
> > +			in_page = get_node_page(sbi, inode->i_ino);
> > +			if (IS_ERR(in_page)) {
> >  				alloc_nid_failed(sbi, new_nid);
> > -				return PTR_ERR(page);
> > +				return PTR_ERR(in_page);
> >  			}
> > -			inline_addr = inline_xattr_addr(inode, page);
> > -			f2fs_wait_on_page_writeback(page, NODE, true);
> > +			inline_addr = inline_xattr_addr(inode, in_page);
> >  		}
> > -		memcpy(inline_addr, txattr_addr, inline_size);
> > -		f2fs_put_page(page, 1);
> >  
> > +		f2fs_wait_on_page_writeback(ipage ? ipage : in_page,
> > +							NODE, true);
> >  		/* no need to use xattr node block */
> >  		if (hsize <= inline_size) {
> >  			err = truncate_xattr_node(inode, ipage);
> 
> truncate_xattr_node(inode, ipage ? ipage : in_page);

No, that should be ipage.

Thanks,

> Please add:
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> >  			alloc_nid_failed(sbi, new_nid);
> > -			return err;
> > +			if (err) {
> > +				f2fs_put_page(in_page, 1);
> > +				return err;
> > +			}
> > +			memcpy(inline_addr, txattr_addr, inline_size);
> > +			set_page_dirty(ipage ? ipage : in_page);
> > +			goto in_page_out;
> >  		}
> >  	}
> >  
> > @@ -432,7 +433,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
> >  		xpage = get_node_page(sbi, F2FS_I(inode)->i_xattr_nid);
> >  		if (IS_ERR(xpage)) {
> >  			alloc_nid_failed(sbi, new_nid);
> > -			return PTR_ERR(xpage);
> > +			goto in_page_out;
> >  		}
> >  		f2fs_bug_on(sbi, new_nid);
> >  		f2fs_wait_on_page_writeback(xpage, NODE, true);
> > @@ -442,17 +443,24 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
> >  		xpage = new_node_page(&dn, XATTR_NODE_OFFSET);
> >  		if (IS_ERR(xpage)) {
> >  			alloc_nid_failed(sbi, new_nid);
> > -			return PTR_ERR(xpage);
> > +			goto in_page_out;
> >  		}
> >  		alloc_nid_done(sbi, new_nid);
> >  	}
> > -
> >  	xattr_addr = page_address(xpage);
> > +
> > +	if (inline_size)
> > +		memcpy(inline_addr, txattr_addr, inline_size);
> >  	memcpy(xattr_addr, txattr_addr + inline_size, VALID_XATTR_BLOCK_SIZE);
> > +
> > +	if (inline_size)
> > +		set_page_dirty(ipage ? ipage : in_page);
> >  	set_page_dirty(xpage);
> > -	f2fs_put_page(xpage, 1);
> >  
> > -	return 0;
> > +	f2fs_put_page(xpage, 1);
> > +in_page_out:
> > +	f2fs_put_page(in_page, 1);
> > +	return err;
> >  }
> >  
> >  int f2fs_getxattr(struct inode *inode, int index, const char *name,
> > 
