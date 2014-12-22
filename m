From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [RFC PATCH] f2fs: add extent cache base on rb-tree
Date: Mon, 22 Dec 2014 17:06:52 +0800
Message-ID: <000401d01dc6$bce92330$36bb6990$@samsung.com>
References: <001f01d01b79$954f0140$bfed03c0$@samsung.com>
 <20141222020317.GB3335@lcm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20141222020317.GB3335@lcm>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Changman Lee' <cm224.lee@samsung.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Changman,

> -----Original Message-----
> From: Changman Lee [mailto:cm224.lee@samsung.com]
> Sent: Monday, December 22, 2014 10:03 AM
> To: Chao Yu
> Cc: Jaegeuk Kim; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH] f2fs: add extent cache base on rb-tree
> 
> Hi Yu,
> 
> Good approach.
> As you know, however, f2fs breaks extent itself due to COW.
> Unlike other filesystem like btrfs, minimum extent of f2fs could have 4KB granularity.
> So we would have lots of extents per inode and it could lead to overhead
> to manage extents.
> 
> Anyway, mount option could be alternative for this patch.
> 
> On Fri, Dec 19, 2014 at 06:49:29PM +0800, Chao Yu wrote:
> > Now f2fs have page-block mapping cache which can cache only one extent mapping
> > between contiguous logical address and physical address.
> > Normally, this design will work well because f2fs will expand coverage area of
> > the mapping extent when we write forward sequentially. But when we write data
> > randomly in Out-Place-Update mode, the extent will be shorten and hardly be
> > expanded for most time as following reasons:
> > 1.The short part of extent will be discarded if we break contiguous mapping in
> > the middle of extent.
> > 2.The new mapping will be added into mapping cache only at head or tail of the
> > extent.
> > 3.We will drop the extent cache when the extent became very fragmented.
> > 4.We will not update the extent with mapping which we get from readpages or
> > readpage.
> >
> > To solve above problems, this patch adds extent cache base on rb-tree like other
> > filesystems (e.g.: ext4/btrfs) in f2fs. By this way, f2fs can support another
> > more effective cache between dnode page cache and disk. It will supply high hit
> > ratio in the cache with fewer memory when dnode page cache are reclaimed in
> > environment of low memory.
> >
> > Todo:
> > *introduce mount option for extent cache.
> > *add shrink ability for extent cache.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>

[snip]

> > +static void __try_merge_extent(struct inode *inode, struct extent_info *ei)
> > +{
> > +	struct rb_root *root = &F2FS_I(inode)->ei_tree.root;
> > +	struct extent_info *pei = NULL;
> > +	struct rb_node *node;
> > +
> > +	node = rb_prev(&ei->rb_node);
> > +	if (node) {
> > +		pei = rb_entry(node, struct extent_info, rb_node);
> > +		if (ei->blk == pei->blk + pei->len) {
> 
> Shouldn't we check below together, too?
> if (ei->fofs == pei->fofs + pei->len)

Yes, you're right.
The following "if (ei->blk + 1 == pei->blk)" has the same problem.
I will fix this issue, thanks for your review!

Regards,
Yu
