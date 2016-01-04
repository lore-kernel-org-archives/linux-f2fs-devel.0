From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH] f2fs: introduce max_file_blocks in sbi
Date: Mon, 04 Jan 2016 13:56:34 +0800
Message-ID: <005b01d146b4$c256c8a0$470459e0$@samsung.com>
References: <011601d14395$95f64d70$c1e2e850$@samsung.com>
 <20160104054316.GA18570@jaegeuk-2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160104054316.GA18570@jaegeuk-2.local>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Monday, January 04, 2016 1:43 PM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] f2fs: introduce max_file_blocks in sbi
> 
> Hi Chao,
> 
> On Thu, Dec 31, 2015 at 02:35:37PM +0800, Chao Yu wrote:
> > Introduce max_file_blocks in sbi to store max block index of file in f2fs,
> > it could be used to avoid unneeded calculation of max block index in
> > runtime.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/data.c  | 2 +-
> >  fs/f2fs/f2fs.h  | 2 +-
> >  fs/f2fs/super.c | 7 ++++---
> >  3 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 5a71017..73b7a8f 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -762,7 +762,7 @@ static int get_data_block_bmap(struct inode *inode, sector_t iblock,
> >  			struct buffer_head *bh_result, int create)
> >  {
> >  	/* Block number less than F2FS MAX BLOCKS */
> > -	if (unlikely(iblock >= max_file_size(0)))
> > +	if (unlikely(iblock >= F2FS_I_SB(inode)->max_file_blocks))
> >  		return -EFBIG;
> >
> >  	return __get_data_block(inode, iblock, bh_result, create,
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 9ba6a09..520d8f2 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -786,6 +786,7 @@ struct f2fs_sb_info {
> >  	unsigned int total_node_count;		/* total node block count */
> >  	unsigned int total_valid_node_count;	/* valid node block count */
> >  	unsigned int total_valid_inode_count;	/* valid inode count */
> > +	unsigned int max_file_blocks;		/* max block index of file */
> 
> I found a overflow bug here and fixed this in my git.
> This should be loff_t, otherwise it goes about 300 MB.

Sorry, it's my bad.
Thanks for fixing this. :)

Thanks,

> 
> Thanks,
> 
> 
> >  	int active_logs;			/* # of active logs */
> >  	int dir_level;				/* directory level */
> >  	int serialized_dio_pages;		/* serialized direct IO pages */
> > @@ -1731,7 +1732,6 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode
> *inode)
> >   * super.c
> >   */
> >  int f2fs_commit_super(struct f2fs_sb_info *, bool);
> > -loff_t max_file_size(unsigned bits);
> >  int f2fs_sync_fs(struct super_block *, int);
> >  extern __printf(3, 4)
> >  void f2fs_msg(struct super_block *, const char *, const char *, ...);
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index f474355..4e5bbd4 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -909,7 +909,7 @@ static const struct export_operations f2fs_export_ops = {
> >  	.get_parent = f2fs_get_parent,
> >  };
> >
> > -loff_t max_file_size(unsigned bits)
> > +static loff_t max_file_blocks(void)
> >  {
> >  	loff_t result = (DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS);
> >  	loff_t leaf_count = ADDRS_PER_BLOCK;
> > @@ -925,7 +925,6 @@ loff_t max_file_size(unsigned bits)
> >  	leaf_count *= NIDS_PER_BLOCK;
> >  	result += leaf_count;
> >
> > -	result <<= bits;
> >  	return result;
> >  }
> >
> > @@ -1281,7 +1280,9 @@ try_onemore:
> >  	if (err)
> >  		goto free_options;
> >
> > -	sb->s_maxbytes = max_file_size(le32_to_cpu(raw_super->log_blocksize));
> > +	sbi->max_file_blocks = max_file_blocks();
> > +	sb->s_maxbytes = sbi->max_file_blocks <<
> > +				le32_to_cpu(raw_super->log_blocksize);
> >  	sb->s_max_links = F2FS_LINK_MAX;
> >  	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
> >
> > --
> > 2.6.3
> >
