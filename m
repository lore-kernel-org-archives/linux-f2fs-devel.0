From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] Space leak in f2fs
Date: Wed, 13 May 2015 18:45:39 -0700
Message-ID: <20150514014538.GA69664@jaegeuk-mac02>
References: <5552FA7D.7000704@huawei.com>
 <20150513174417.GA56247@jaegeuk-mac02.mot.com>
 <20150514002417.GC68412@jaegeuk-mac02>
 <5553FD09.9030508@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5553FD09.9030508@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: hujianyang <hujianyang@huawei.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

I'll push the patch into dev branch right now.
Let me know, if there is any problem.

Thanks,

On Thu, May 14, 2015 at 09:40:25AM +0800, hujianyang wrote:
> Hi Jaegeuk,
> 
> I've tested this patch. It's OK now. Seems this problem is fixed.
> 
> I'd like to push this patch to my local tree and run a formal
> stress test next week. Will you push this patch to f2fs-dev branch?
> 
> If you have other modification to this fix, please let me know.
> 
> Thanks very much!
> Hu
> 
> On 2015/5/14 8:24, Jaegeuk Kim wrote:
> > Hi Hu,
> > 
> > Found a bug in the previous patch.
> > Could you check this out?
> > 
> > Thanks,
> > 
> > ---
> >  fs/f2fs/super.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 19438f2..647591b 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -431,8 +431,17 @@ static int f2fs_drop_inode(struct inode *inode)
> >  	 *    - f2fs_gc -> iput -> evict
> >  	 *       - inode_wait_for_writeback(inode)
> >  	 */
> > -	if (!inode_unhashed(inode) && inode->i_state & I_SYNC)
> > +	if (!inode_unhashed(inode) && inode->i_state & I_SYNC) {
> > +		if (!inode->i_nlink && !is_bad_inode(inode)) {
> > +			spin_unlock(&inode->i_lock);
> > +			i_size_write(inode, 0);
> > +
> > +			if (F2FS_HAS_BLOCKS(inode))
> > +				f2fs_truncate(inode);
> > +			spin_lock(&inode->i_lock);
> > +		}
> >  		return 0;
> > +	}
> >  	return generic_drop_inode(inode);
> >  }
> >  
> > 
