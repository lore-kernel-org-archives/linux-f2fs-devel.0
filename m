From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 3/3 V3] f2fs: introduce f2fs_cache_node_page()
 to add page into node_inode cache
Date: Tue, 10 Dec 2013 09:51:50 +0800
Message-ID: <000c01cef54a$80fef2a0$82fcd7e0$@samsung.com>
References: <000a01cef4a0$9f2d64a0$dd882de0$@samsung.com>
 <1386576057.2101.106.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1386576057.2101.106.camel@kjgkr>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Monday, December 09, 2013 4:01 PM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linu=
x-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 3/3 V3] f2fs: introduce f2fs_cache_nod=
e_page() to add page into node_inode cache
>=20
> Hi,
>=20
> Sorry for the noise.
> Once I tested this patch, I recognized that I made a mistake:
>=20
> f2fs_fill_super()
>  1. build_segment_manager()
>     -> restore_node_summary()
>        -> NULL pointer exception, due to no NAT cache.
>  2. build_node_manager()
>=20
> So, we should not call get_node_info() prior to build_node_manager().
> And, it's not easy to change the order of build_*_manager simply.
>=20
> Let's consider in more details.

Before we call restore_node_summary(), we have read HOT_DATA
Summary. It means already we got the NAT cache in curseg.
Although we could not call get_node_info() directly, we still could use
NAT cache in HOT_DATA curseg.

So how about using this cache to verify validity of page like this?

f2fs_cache_node_page()
	if(!looup_nat_curseg_cache())
		return;
	grab_cache_page();
	memcpy();
	SetPageUptodate();
	f2fs_put_page();

> Thanks,
>=20
> 2013-12-09 (=EC=9B=94), 13:35 +0800, Chao Yu:
> > This patch introduces f2fs_cache_node_page(), in this function, pag=
e which is
> > readed ahead will be copy to node_inode's mapping cache.
> > It will avoid rereading these node pages.
> >
> > change log:
> >  o check validity of page by searching NAT suggested by Jaegeuk Kim=
=2E
> >  o add 'unlikely' for compiler optimization suggested by Jaegeuk Ki=
m.
> >
> > Suggested-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/node.c |   39 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 099f06f..4c6da98 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1600,13 +1600,46 @@ static int ra_sum_pages(struct f2fs_sb_info=
 *sbi, struct list_head *pages,
> >  	return 0;
> >  }
> >
> > +/*
> > + * f2fs_cache_node_page() check validaty of input page by searchin=
g NAT.
> > + * Then, it will copy updated data of vaild page to node_inode cac=
he.
> > + */
> > +void f2fs_cache_node_page(struct f2fs_sb_info *sbi, struct page *p=
age,
> > +						nid_t nid, block_t blkaddr)
> > +{
> > +	struct address_space *mapping =3D sbi->node_inode->i_mapping;
> > +	struct page *npage;
> > +	struct node_info ni;
> > +
> > +	get_node_info(sbi, nid, &ni);
> > +
> > +	if (ni.blk_addr !=3D blkaddr)
> > +		return;
> > +
> > +	npage =3D grab_cache_page(mapping, nid);
> > +	if (unlikely(!npage))
> > +		return;
> > +
> > +	if (PageUptodate(npage)) {
> > +		f2fs_put_page(npage, 1);
> > +		return;
> > +	}
> > +
> > +	memcpy(page_address(npage), page_address(page), PAGE_CACHE_SIZE);
> > +
> > +	SetPageUptodate(npage);
> > +	f2fs_put_page(npage, 1);
> > +
> > +	return;
> > +}
> > +
> >  int restore_node_summary(struct f2fs_sb_info *sbi,
> >  			unsigned int segno, struct f2fs_summary_block *sum)
> >  {
> >  	struct f2fs_node *rn;
> >  	struct f2fs_summary *sum_entry;
> >  	struct page *page, *tmp;
> > -	block_t addr;
> > +	block_t addr, blkaddr;
> >  	int bio_blocks =3D MAX_BIO_BLOCKS(max_hw_blocks(sbi));
> >  	int i, last_offset, nrpages, err =3D 0;
> >  	LIST_HEAD(page_list);
> > @@ -1624,6 +1657,7 @@ int restore_node_summary(struct f2fs_sb_info =
*sbi,
> >  		if (err)
> >  			return err;
> >
> > +		blkaddr =3D addr;
> >  		list_for_each_entry_safe(page, tmp, &page_list, lru) {
> >
> >  			lock_page(page);
> > @@ -1633,6 +1667,8 @@ int restore_node_summary(struct f2fs_sb_info =
*sbi,
> >  				sum_entry->version =3D 0;
> >  				sum_entry->ofs_in_node =3D 0;
> >  				sum_entry++;
> > +				f2fs_cache_node_page(sbi, page,
> > +					le32_to_cpu(rn->footer.nid), blkaddr);
> >  			} else {
> >  				err =3D -EIO;
> >  			}
> > @@ -1640,6 +1676,7 @@ int restore_node_summary(struct f2fs_sb_info =
*sbi,
> >  			list_del(&page->lru);
> >  			unlock_page(page);
> >  			__free_pages(page, 0);
> > +			blkaddr++;
> >  		}
> >  	}
> >  	return err;
>=20
> --
> Jaegeuk Kim
> Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
