From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 5/8] f2fs: support data flush in checkpoint
Date: Wed, 16 Dec 2015 10:33:10 +0800
Message-ID: <013301d137aa$32cbcc80$98636580$@samsung.com>
References: <00f801d136fa$324a5070$96def150$@samsung.com>
	<20151215215842.GA66113@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a91uq-0002P4-KU
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Dec 2015 02:34:08 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a91un-0002Vk-HD
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Dec 2015 02:34:08 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZF00Y7CJ40QA80@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Dec 2015 11:33:52 +0900 (KST)
In-reply-to: <20151215215842.GA66113@jaegeuk.local>
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
> Sent: Wednesday, December 16, 2015 5:59 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 5/8] f2fs: support data flush in checkpoint
> 
> Hi Chao,
> 
> On Tue, Dec 15, 2015 at 01:33:18PM +0800, Chao Yu wrote:
> > Previously, when finishing a checkpoint, we only keep consistency of all fs
> > meta info including meta inode, node inode, dentry page of directory inode,
> > so, after a sudden power cut, f2fs can recover from last checkpoint with
> > full directory structure.
> >
> > But during checkpoint, we didn't flush dirty pages of regular and symlink
> > inode, so such dirty datas still in memory will be lost in that moment of
> > power off.
> >
> > In order to reduce the chance of lost data, this patch tries to flush user
> > data before starting a checkpoint. So user's data written between two
> > checkpoint which may not be fsynced could be saved.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/checkpoint.c | 11 +++++++++++
> >  fs/f2fs/f2fs.h       |  5 +++++
> >  2 files changed, 16 insertions(+)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index f33c4d7..217571f 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -849,6 +849,17 @@ static int block_operations(struct f2fs_sb_info *sbi)
> >
> >  	blk_start_plug(&plug);
> >
> > +retry_flush_datas:
> > +	/* write all the dirty data pages */
> > +	if (get_pages(sbi, F2FS_DIRTY_DATAS)) {
> > +		sync_dirty_inodes(sbi, FILE_INODE);
> > +		if (unlikely(f2fs_cp_error(sbi))) {
> > +			err = -EIO;
> > +			goto out;
> > +		}
> > +		goto retry_flush_datas;
> > +	}
> > +
> 
> Please don't do like this; our checkpoint should be different from system sync.
> I don't want to increase the checkpoint latency at all even in f2fs_gc as well.

Alright.

Since flushing dirty data definitely increasing our latency of the interface,
so what I thought was that let user take responsibility for risk of potential
longer latency once user choose to mount with data_flush option.

Now, look into this implementation, it seems that adding flushing operation
into checkpoint looks advancing rashly, it spreads random potential long
latency everywhere.

> 
> I think that something like this would be better.

I will follow that currently. :)

> 
> In f2fs_balance_fs_bg(),
> 	if (!avaliable_free_memory() || ...) {
> 		if (test_opt(DATA_FLUSH))
> 			sync_dirty_inodes(FILE_INODE);
> 		f2fs_sync_fs();
> 	}
> 
> Please add its mount option with a disabled one first.

OK, I will do that.

> 
> >  retry_flush_dents:
> >  	f2fs_lock_all(sbi);
> >  	/* write all the dirty dentry pages */
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index d8bef3c..2477b2f5 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -648,6 +648,7 @@ struct f2fs_sm_info {
> >  enum count_type {
> >  	F2FS_WRITEBACK,
> >  	F2FS_DIRTY_DENTS,
> > +	F2FS_DIRTY_DATAS,
> 
> This should be F2FS_DIRTY_DATA.
> 
> And, it'd better to merge this part into your previous patch:
>  "f2fs: record dirty status of regular/symlink inodes"
> 
> I'll do that, so please check it out later from dev-test.

Thanks for doing this, still I will resend the patches for the people
who wants to comment on them.

Thanks,

> 
> >  	F2FS_DIRTY_NODES,
> >  	F2FS_DIRTY_META,
> >  	F2FS_INMEM_PAGES,
> > @@ -1068,6 +1069,8 @@ static inline void inode_inc_dirty_pages(struct inode *inode)
> >  	atomic_inc(&F2FS_I(inode)->dirty_pages);
> >  	if (S_ISDIR(inode->i_mode))
> >  		inc_page_count(F2FS_I_SB(inode), F2FS_DIRTY_DENTS);
> > +	else
> > +		inc_page_count(F2FS_I_SB(inode), F2FS_DIRTY_DATAS);
> 
> ditto.
> 
> >  }
> >
> >  static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
> > @@ -1085,6 +1088,8 @@ static inline void inode_dec_dirty_pages(struct inode *inode)
> >
> >  	if (S_ISDIR(inode->i_mode))
> >  		dec_page_count(F2FS_I_SB(inode), F2FS_DIRTY_DENTS);
> > +	else
> > +		dec_page_count(F2FS_I_SB(inode), F2FS_DIRTY_DATAS);
> 
> ditto.
> 
> >  }
> >
> >  static inline int get_pages(struct f2fs_sb_info *sbi, int count_type)
> > --
> > 2.6.3
> >


------------------------------------------------------------------------------
