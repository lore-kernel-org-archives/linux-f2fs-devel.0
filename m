From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: don't use GFP_ZERO for page caches
Date: Mon, 9 Apr 2018 20:50:22 -0700
Message-ID: <20180410035022.GB47598@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180409190012.21552-1-jaegeuk@kernel.org>
 <fc31dd88-5dbb-1c37-28fe-dfef09cc448c@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fc31dd88-5dbb-1c37-28fe-dfef09cc448c@huawei.com>
Sender: stable-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 04/10, Chao Yu wrote:
> On 2018/4/10 3:00, Jaegeuk Kim wrote:
> > From: Chao Yu <yuchao0@huawei.com>
> > 
> > Related to https://lkml.org/lkml/2018/4/8/661
> > 
> > Sometimes, we need to write meta data to new allocated block address,
> > then we will allocate a zeroed page in inner inode's address space, and
> > fill partial data in it, and leave other place with zero value which means
> > some fields are initial status.
> > 
> > There are two inner inodes (meta inode and node inode) setting __GFP_ZERO,
> > I have just checked them, for both of them, we can avoid using __GFP_ZERO,
> > and do initialization by ourselves to avoid unneeded/redundant zeroing
> > from mm.
> > 
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/inode.c    | 4 ++--
> >  fs/f2fs/node.c     | 6 ++++--
> >  fs/f2fs/node.h     | 7 ++-----
> >  fs/f2fs/recovery.c | 3 +--
> >  4 files changed, 9 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 417c9dcd0269..87535bf63421 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -320,10 +320,10 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> >  make_now:
> >  	if (ino == F2FS_NODE_INO(sbi)) {
> >  		inode->i_mapping->a_ops = &f2fs_node_aops;
> > -		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
> > +		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> >  	} else if (ino == F2FS_META_INO(sbi)) {
> >  		inode->i_mapping->a_ops = &f2fs_meta_aops;
> > -		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
> > +		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> >  	} else if (S_ISREG(inode->i_mode)) {
> >  		inode->i_op = &f2fs_file_inode_operations;
> >  		inode->i_fop = &f2fs_file_operations;
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 9a99243054ba..6fc3311820ec 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1096,7 +1096,8 @@ struct page *new_node_page(struct dnode_of_data *dn, unsigned int ofs)
> >  	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
> >  
> >  	f2fs_wait_on_page_writeback(page, NODE, true);
> > -	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
> > +	memset(F2FS_NODE(page), 0, PAGE_SIZE);
> > +	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs);
> >  	set_cold_node(page, S_ISDIR(dn->inode->i_mode));
> >  	if (!PageUptodate(page))
> >  		SetPageUptodate(page);
> > @@ -2311,7 +2312,8 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
> >  
> >  	if (!PageUptodate(ipage))
> >  		SetPageUptodate(ipage);
> > -	fill_node_footer(ipage, ino, ino, 0, true);
> > +	memset(F2FS_NODE(page), 0, PAGE_SIZE);
> 
> At a glance, should be memset(F2FS_NODE(ipage), 0, PAGE_SIZE);

Actually, we don't need to do this, since fill_node_footer(true) will reset the
page.

> 
> Sorry about that.
> 
> Thanks,
> 
> > +	fill_node_footer(ipage, ino, ino, 0);
> >  	set_cold_node(page, false);
> >  
> >  	src = F2FS_INODE(page);
> > diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> > index b95e49e4a928..42cd081114ab 100644
> > --- a/fs/f2fs/node.h
> > +++ b/fs/f2fs/node.h
> > @@ -263,15 +263,12 @@ static inline block_t next_blkaddr_of_node(struct page *node_page)
> >  }
> >  
> >  static inline void fill_node_footer(struct page *page, nid_t nid,
> > -				nid_t ino, unsigned int ofs, bool reset)
> > +				nid_t ino, unsigned int ofs)
> >  {
> >  	struct f2fs_node *rn = F2FS_NODE(page);
> >  	unsigned int old_flag = 0;
> >  
> > -	if (reset)
> > -		memset(rn, 0, sizeof(*rn));
> > -	else
> > -		old_flag = le32_to_cpu(rn->footer.flag);
> > +	old_flag = le32_to_cpu(rn->footer.flag);
> >  
> >  	rn->footer.nid = cpu_to_le32(nid);
> >  	rn->footer.ino = cpu_to_le32(ino);
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index 1b23d3febe4c..de24f3247aa5 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -540,8 +540,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
> >  	}
> >  
> >  	copy_node_footer(dn.node_page, page);
> > -	fill_node_footer(dn.node_page, dn.nid, ni.ino,
> > -					ofs_of_node(page), false);
> > +	fill_node_footer(dn.node_page, dn.nid, ni.ino, ofs_of_node(page));
> >  	set_page_dirty(dn.node_page);
> >  err:
> >  	f2fs_put_dnode(&dn);
> > 
