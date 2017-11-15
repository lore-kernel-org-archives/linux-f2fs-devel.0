From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: expose quota information in debugfs
Date: Wed, 15 Nov 2017 08:24:18 -0800
Message-ID: <20171115162418.GB33528@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171114051214.83458-1-jaegeuk@kernel.org>
 <34e8c6e4-b658-03fc-6370-cabd70d80b12@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <34e8c6e4-b658-03fc-6370-cabd70d80b12@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 11/15, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2017/11/14 13:12, Jaegeuk Kim wrote:
> > This patch shows # of dirty pages and # of hidden quota files.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/debug.c | 11 +++++++++++
> >  fs/f2fs/f2fs.h  | 10 ++++++++--
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> > index f7eec506ceea..ecada8425268 100644
> > --- a/fs/f2fs/debug.c
> > +++ b/fs/f2fs/debug.c
> > @@ -45,9 +45,18 @@ static void update_general_status(struct f2fs_sb_info *sbi)
> >  	si->ndirty_dent = get_pages(sbi, F2FS_DIRTY_DENTS);
> >  	si->ndirty_meta = get_pages(sbi, F2FS_DIRTY_META);
> >  	si->ndirty_data = get_pages(sbi, F2FS_DIRTY_DATA);
> > +	si->ndirty_qdata = get_pages(sbi, F2FS_DIRTY_QDATA);
> >  	si->ndirty_imeta = get_pages(sbi, F2FS_DIRTY_IMETA);
> >  	si->ndirty_dirs = sbi->ndirty_inode[DIR_INODE];
> >  	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
> > +
> > +	si->nquota_files = 0;
> > +	if (f2fs_sb_has_quota_ino(sbi->sb)) {
> > +		for (i = 0; i < MAXQUOTAS; i++) {
> > +			if (f2fs_qf_ino(sbi->sb, i))
> > +				si->nquota_files++;
> > +		}
> > +	}
> >  	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
> >  	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
> >  	si->aw_cnt = atomic_read(&sbi->aw_cnt);
> > @@ -369,6 +378,8 @@ static int stat_show(struct seq_file *s, void *v)
> >  			   si->ndirty_dent, si->ndirty_dirs, si->ndirty_all);
> >  		seq_printf(s, "  - datas: %4d in files:%4d\n",
> >  			   si->ndirty_data, si->ndirty_files);
> > +		seq_printf(s, "  - quota datas: %4d in quota files:%4d\n",
> > +			   si->ndirty_qdata, si->nquota_files);
> >  		seq_printf(s, "  - meta: %4d in %4d\n",
> >  			   si->ndirty_meta, si->meta_pages);
> >  		seq_printf(s, "  - imeta: %4d\n",
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 5c379a8ea075..44f874483ecf 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -865,6 +865,7 @@ struct f2fs_sm_info {
> >  enum count_type {
> >  	F2FS_DIRTY_DENTS,
> >  	F2FS_DIRTY_DATA,
> > +	F2FS_DIRTY_QDATA,
> >  	F2FS_DIRTY_NODES,
> >  	F2FS_DIRTY_META,
> >  	F2FS_INMEM_PAGES,
> > @@ -1642,6 +1643,8 @@ static inline void inode_inc_dirty_pages(struct inode *inode)
> >  	atomic_inc(&F2FS_I(inode)->dirty_pages);
> >  	inc_page_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
> >  				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA);
> > +	if (IS_NOQUOTA(inode))
> 
> If we're trying to get quota sysfile information, how about using sysfile ino
> for distinguishing from normal file?

I'm afraid of needless loop first. And, the goal is to expose hidden sysfile
though, we actually don't need to count it only.

Thanks,

> 
> Thanks,
> 
> > +		inc_page_count(F2FS_I_SB(inode), F2FS_DIRTY_QDATA);
> >  }
> >  
> >  static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
> > @@ -1658,6 +1661,8 @@ static inline void inode_dec_dirty_pages(struct inode *inode)
> >  	atomic_dec(&F2FS_I(inode)->dirty_pages);
> >  	dec_page_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
> >  				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA);
> > +	if (IS_NOQUOTA(inode))
> > +		dec_page_count(F2FS_I_SB(inode), F2FS_DIRTY_QDATA);
> >  }
> >  
> >  static inline s64 get_pages(struct f2fs_sb_info *sbi, int count_type)
> > @@ -2771,9 +2776,10 @@ struct f2fs_stat_info {
> >  	unsigned long long hit_largest, hit_cached, hit_rbtree;
> >  	unsigned long long hit_total, total_ext;
> >  	int ext_tree, zombie_tree, ext_node;
> > -	int ndirty_node, ndirty_dent, ndirty_meta, ndirty_data, ndirty_imeta;
> > +	int ndirty_node, ndirty_dent, ndirty_meta, ndirty_imeta;
> > +	int ndirty_data, ndirty_qdata;
> >  	int inmem_pages;
> > -	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
> > +	unsigned int ndirty_dirs, ndirty_files, nquota_files, ndirty_all;
> >  	int nats, dirty_nats, sits, dirty_sits;
> >  	int free_nids, avail_nids, alloc_nids;
> >  	int total_count, utilization;
> > 
