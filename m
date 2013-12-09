From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 3/3 V2] f2fs: introduce f2fs_cache_node_page()
 to add page into node_inode cache
Date: Mon, 09 Dec 2013 14:19:46 +0900
Message-ID: <1386566386.2101.99.camel@kjgkr>
References: <000501cef263$1c57e710$5507b530$@samsung.com>
 <1386545831.2101.67.camel@kjgkr> <000901cef484$97536b10$c5fa4130$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <000901cef484$97536b10$c5fa4130$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

2013-12-09 (=EC=9B=94), 10:14 +0800, Chao Yu:
> Hi,
>=20
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> > Sent: Monday, December 09, 2013 7:37 AM
> > To: Chao Yu
> > Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; li=
nux-f2fs-devel@lists.sourceforge.net
> > Subject: Re: [f2fs-dev] [PATCH 3/3 V2] f2fs: introduce f2fs_cache_n=
ode_page() to add page into node_inode cache
> >=20
> > 2013-12-06 (=EA=B8=88), 17:10 +0800, Chao Yu:
> > > This patch introduces f2fs_cache_node_page(), in this function, p=
age which is
> > > readed ahead will be copy to node_inode's mapping cache.
> > > It will avoid rereading these node pages.
> > >
> > > change log:
> > >  o check validity of grabbed page suggested by Jaegeuk Kim.
> > >
> > > Suggested-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> > > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > > ---
> > >  fs/f2fs/node.c |   35 +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 35 insertions(+)
> > >
> > > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > > index 099f06f..3ff98fa 100644
> > > --- a/fs/f2fs/node.c
> > > +++ b/fs/f2fs/node.c
> > > @@ -1600,6 +1600,39 @@ static int ra_sum_pages(struct f2fs_sb_inf=
o *sbi, struct list_head *pages,
> > >  	return 0;
> > >  }
> > >
> > > +/*
> > > + * f2fs_cache_node_page() copy updated page data to node_inode c=
ache page.
> > > + */
> > > +void f2fs_cache_node_page(struct f2fs_sb_info *sbi, struct page =
*page,
> > > +						nid_t nid)
> > > +{
> > > +	struct address_space *mapping =3D sbi->node_inode->i_mapping;
> > > +	struct page *npage;
> >=20
> >=20
> > What I meant for the validity was to check the block address to fig=
ure
> > out this node page is up-to-date or not.
> > IOW, something like this.
>=20
> Yes, you're right.
>=20
> So, how about the this one?
> ---
>  fs/f2fs/node.c |   39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 099f06f..3e7a336 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1600,13 +1600,46 @@ static int ra_sum_pages(struct f2fs_sb_info *=
sbi, struct list_head *pages,
>  	return 0;
>  }
> =20
> +/*
> + * f2fs_cache_node_page() check validaty of input page by searching =
NAT.
> + * Then, it will copy updated data of vaild page to node_inode cache=
=2E
> + */
> +void f2fs_cache_node_page(struct f2fs_sb_info *sbi, struct page *pag=
e,
> +						nid_t nid, block_t blkaddr)
> +{
> +	struct address_space *mapping =3D sbi->node_inode->i_mapping;
> +	struct page *npage;
> +	struct node_info ni;
> +
> +	get_node_info(sbi, nid, &ni);
> +
> +	if (ni.blk_addr !=3D blkaddr)
> +		return;
> +
> +	npage =3D grab_cache_page(mapping, nid);
> +	if (!npage)

	if (unlikely(!npage))

Could you submit a v3?
Thanks,

> +		return;
> +
> +	if (PageUptodate(npage)) {
> +		f2fs_put_page(npage, 1);
> +		return;
> +	}
> +
> +	memcpy(page_address(npage), page_address(page), PAGE_CACHE_SIZE);
> +
> +	SetPageUptodate(npage);
> +	f2fs_put_page(npage, 1);
> +
> +	return;
> +}
> +
>  int restore_node_summary(struct f2fs_sb_info *sbi,
>  			unsigned int segno, struct f2fs_summary_block *sum)
>  {
>  	struct f2fs_node *rn;
>  	struct f2fs_summary *sum_entry;
>  	struct page *page, *tmp;
> -	block_t addr;
> +	block_t addr, blkaddr;
>  	int bio_blocks =3D MAX_BIO_BLOCKS(max_hw_blocks(sbi));
>  	int i, last_offset, nrpages, err =3D 0;
>  	LIST_HEAD(page_list);
> @@ -1624,6 +1657,7 @@ int restore_node_summary(struct f2fs_sb_info *s=
bi,
>  		if (err)
>  			return err;
> =20
> +		blkaddr =3D addr;
>  		list_for_each_entry_safe(page, tmp, &page_list, lru) {
> =20
>  			lock_page(page);
> @@ -1633,6 +1667,8 @@ int restore_node_summary(struct f2fs_sb_info *s=
bi,
>  				sum_entry->version =3D 0;
>  				sum_entry->ofs_in_node =3D 0;
>  				sum_entry++;
> +				f2fs_cache_node_page(sbi, page,
> +					le32_to_cpu(rn->footer.nid), blkaddr);
>  			} else {
>  				err =3D -EIO;
>  			}
> @@ -1640,6 +1676,7 @@ int restore_node_summary(struct f2fs_sb_info *s=
bi,
>  			list_del(&page->lru);
>  			unlock_page(page);
>  			__free_pages(page, 0);
> +			blkaddr++;
>  		}
>  	}
>  	return err;

--=20
Jaegeuk Kim
Samsung
