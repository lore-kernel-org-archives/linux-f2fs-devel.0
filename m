From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] f2fs: count dirty inodes to flush node pages during
 checkpoint
Date: Tue, 22 Nov 2016 17:36:38 -0800
Message-ID: <20161123013637.GA14761@jaegeuk>
References: <20161017215645.435-1-jaegeuk@kernel.org>
 <55c9f7d0-c96f-d0a4-f1d3-edd344f530a8@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55c9f7d0-c96f-d0a4-f1d3-edd344f530a8@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Nov 23, 2016 at 09:27:26AM +0800, Chao Yu wrote:
> On 2016/10/18 5:56, Jaegeuk Kim wrote:
> > If there are a lot of dirty inodes, we need to flush all of them when doing
> > checkpoint. So, we need to count this for enough free space.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/segment.h | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index fecb856..a6efb5c 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -471,11 +471,12 @@ static inline bool need_SSR(struct f2fs_sb_info *sbi)
> >  {
> >  	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
> >  	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
> > +	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
> >  
> >  	if (test_opt(sbi, LFS))
> >  		return false;
> >  
> > -	return free_sections(sbi) <= (node_secs + 2 * dent_secs +
> > +	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
> >  						reserved_sections(sbi) + 1);
> >  }
> >  
> > @@ -484,6 +485,7 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
> >  {
> >  	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
> >  	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
> > +	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
> >  
> >  	node_secs += get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
> 
> This line should be removed if we start to count dirty meta with imeta_secs from
> now on.

Ah, yes.
Fixed.

Thanks,

> 
> Thanks,
> 
> >  
> > @@ -491,7 +493,8 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
> >  		return false;
> >  
> >  	return (free_sections(sbi) + freed) <=
> > -		(node_secs + 2 * dent_secs + reserved_sections(sbi) + needed);
> > +		(node_secs + 2 * dent_secs + imeta_secs +
> > +		reserved_sections(sbi) + needed);
> >  }
> >  
> >  static inline bool excess_prefree_segs(struct f2fs_sb_info *sbi)
> > 
