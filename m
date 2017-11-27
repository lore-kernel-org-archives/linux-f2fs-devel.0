From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: no need to read nat block if
 nat_block_bitmap is set
Date: Sun, 26 Nov 2017 20:27:14 -0800
Message-ID: <20171127042714.GA35661@jaegeuk-macbookpro.roam.corp.google.com>
References: <1510906418-11829-1-git-send-email-heyunlei@huawei.com>
 <1da5b381-ec6b-1f98-8ca6-d4a06cc50f2b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eJB0u-0004aG-5O
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 27 Nov 2017 04:27:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eJB0s-0001xF-Ds
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 27 Nov 2017 04:27:24 +0000
Content-Disposition: inline
In-Reply-To: <1da5b381-ec6b-1f98-8ca6-d4a06cc50f2b@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: ning.jia@huawei.com, Yunlei He <heyunlei@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

On 11/17, Chao Yu wrote:
> On 2017/11/17 16:13, Yunlei He wrote:
> > No need to read nat block if nat_block_bitmap is set.
> > 
> > Signed-off-by: Yunlei He <heyunlei@huawei.com>
> > ---
> >  fs/f2fs/node.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index fe1fc66..104b44c 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1949,9 +1949,6 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
> >  	unsigned int nat_ofs = NAT_BLOCK_OFFSET(start_nid);
> >  	int i;
> >  
> > -	if (test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
> > -		return;
> > -
> >  	__set_bit_le(nat_ofs, nm_i->nat_block_bitmap);
> >  
> >  	i = start_nid % NAT_ENTRY_PER_BLOCK;
> > @@ -2056,11 +2053,16 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
> >  	down_read(&nm_i->nat_tree_lock);
> >  
> >  	while (1) {
> > -		struct page *page = get_current_nat_page(sbi, nid);
> > +		struct page *page;
> >  
> > +		if (test_bit_le(NAT_BLOCK_OFFSET(nid),
> > +					nm_i->nat_block_bitmap)) {
> > +			goto skip;
> > +		}

I modified this to avoid goto statement like:
		if (!test_bit_le()) {
			/* do something */
		}

Thanks,

> Coding style, we don't need brace for a single line, other party looks good
> to me:
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> > +		page = get_current_nat_page(sbi, nid);
> >  		scan_nat_page(sbi, page, nid);
> >  		f2fs_put_page(page, 1);
> > -
> > +skip:
> >  		nid += (NAT_ENTRY_PER_BLOCK - (nid % NAT_ENTRY_PER_BLOCK));
> >  		if (unlikely(nid >= nm_i->max_nid))
> >  			nid = 0;
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
