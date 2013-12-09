From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH 3/3 V3] f2fs: introduce f2fs_cache_node_page()
 to add page into node_inode cache
Date: Mon, 09 Dec 2013 17:00:57 +0900
Message-ID: <1386576057.2101.106.camel@kjgkr>
References: <000a01cef4a0$9f2d64a0$dd882de0$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <000a01cef4a0$9f2d64a0$dd882de0$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

Sorry for the noise.
Once I tested this patch, I recognized that I made a mistake:

f2fs_fill_super()
 1. build_segment_manager()
    -> restore_node_summary()
       -> NULL pointer exception, due to no NAT cache.
 2. build_node_manager()

So, we should not call get_node_info() prior to build_node_manager().
And, it's not easy to change the order of build_*_manager simply.

Let's consider in more details.
Thanks,

2013-12-09 (=EC=9B=94), 13:35 +0800, Chao Yu:
> This patch introduces f2fs_cache_node_page(), in this function, page =
which is
> readed ahead will be copy to node_inode's mapping cache.
> It will avoid rereading these node pages.
>=20
> change log:
>  o check validity of page by searching NAT suggested by Jaegeuk Kim.
>  o add 'unlikely' for compiler optimization suggested by Jaegeuk Kim.
>=20
> Suggested-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/node.c |   39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 099f06f..4c6da98 100644
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
> +	if (unlikely(!npage))
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

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
