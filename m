From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: retry to revoke atomic commit in -ENOMEM case
Date: Thu, 10 Aug 2017 18:14:59 -0700
Message-ID: <20170811011459.GA26485@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170808110908.108562-1-yuchao0@huawei.com>
 <cbab44fc-e3bb-5579-d15d-07fa8af2bad8@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cbab44fc-e3bb-5579-d15d-07fa8af2bad8@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 08/11, Chao Yu wrote:
> Ping,

Sorry, merged. ;)

> 
> On 2017/8/8 19:09, Chao Yu wrote:
> > During atomic committing, if we encounter -ENOMEM in revoke path, it's
> > better to give a chance to retry revoking.
> > 
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> >  fs/f2fs/segment.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 45fb53411032..682ae68b9ef7 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -213,9 +213,15 @@ static int __revoke_inmem_pages(struct inode *inode,
> >  			struct node_info ni;
> >  
> >  			trace_f2fs_commit_inmem_page(page, INMEM_REVOKE);
> > -
> > +retry:
> >  			set_new_dnode(&dn, inode, NULL, NULL, 0);
> > -			if (get_dnode_of_data(&dn, page->index, LOOKUP_NODE)) {
> > +			err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
> > +			if (err) {
> > +				if (err == -ENOMEM) {
> > +					congestion_wait(BLK_RW_ASYNC, HZ/50);
> > +					cond_resched();
> > +					goto retry;
> > +				}
> >  				err = -EAGAIN;
> >  				goto next;
> >  			}
> > 
