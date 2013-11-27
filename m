From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: readahead contiguous pages for
 restore_node_summary
Date: Wed, 27 Nov 2013 14:29:55 +0900
Message-ID: <1385530195.2417.22.camel@kjgkr>
References: <000101cee757$6f3b4790$4db1d6b0$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <000101cee757$6f3b4790$4db1d6b0$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?UTF-8?Q?=E8=B0=AD=E5=A7=9D?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

It seems that we already have a readahed function for node pages,
ra_node_page().
So, we don't make a page list for this, but can use the node_inode's
page cache.

So how about writing ra_node_pages() which use the node_inode's page
cache?

Thanks,

2013-11-22 (=EA=B8=88), 15:48 +0800, Chao Yu:
> If cp has no CP_UMOUNT_FLAG, we will read all pages in whole node seg=
ment=20
> one by one, it makes low performance. So let's merge contiguous pages=
 and=20
> readahead for better performance.
>=20
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/node.c |   89 +++++++++++++++++++++++++++++++++++++++-------=
----------
>  1 file changed, 63 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 4ac4150..81e704a 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1572,47 +1572,84 @@ int recover_inode_page(struct f2fs_sb_info *s=
bi, struct page *page)
>  	return 0;
>  }
> =20
> +/*
> + * ra_sum_pages() merge contiguous pages into one bio and submit.
> + * these pre-readed pages are linked in pages list.
> + */
> +static int ra_sum_pages(struct f2fs_sb_info *sbi, struct list_head *=
pages,
> +				int start, int nrpages)
> +{
> +	struct page *page;
> +	int page_idx =3D start;
> +
> +	for (; page_idx < start + nrpages; page_idx++) {
> +		/* alloc temporal page for read node summary info*/
> +		page =3D alloc_page(GFP_NOFS | __GFP_ZERO);
> +		if (!page) {
> +			struct page *tmp;
> +			list_for_each_entry_safe(page, tmp, pages, lru) {
> +				list_del(&page->lru);
> +				unlock_page(page);
> +				__free_pages(page, 0);
> +			}
> +			return -ENOMEM;
> +		}
> +
> +		lock_page(page);
> +		page->index =3D page_idx;
> +		list_add_tail(&page->lru, pages);
> +	}
> +
> +	list_for_each_entry(page, pages, lru)
> +		submit_read_page(sbi, page, page->index, READ_SYNC);
> +
> +	f2fs_submit_read_bio(sbi, READ_SYNC);
> +	return 0;
> +}
> +
>  int restore_node_summary(struct f2fs_sb_info *sbi,
>  			unsigned int segno, struct f2fs_summary_block *sum)
>  {
>  	struct f2fs_node *rn;
>  	struct f2fs_summary *sum_entry;
> -	struct page *page;
> +	struct page *page, *tmp;
>  	block_t addr;
> -	int i, last_offset;
> -
> -	/* alloc temporal page for read node */
> -	page =3D alloc_page(GFP_NOFS | __GFP_ZERO);
> -	if (!page)
> -		return -ENOMEM;
> -	lock_page(page);
> +	int bio_blocks =3D MAX_BIO_BLOCKS(max_hw_blocks(sbi));
> +	int i, last_offset, nrpages, err =3D 0;
> +	LIST_HEAD(page_list);
> =20
>  	/* scan the node segment */
>  	last_offset =3D sbi->blocks_per_seg;
>  	addr =3D START_BLOCK(sbi, segno);
>  	sum_entry =3D &sum->entries[0];
> =20
> -	for (i =3D 0; i < last_offset; i++, sum_entry++) {
> -		/*
> -		 * In order to read next node page,
> -		 * we must clear PageUptodate flag.
> -		 */
> -		ClearPageUptodate(page);
> +	for (i =3D 0; i < last_offset; i +=3D nrpages, addr +=3D nrpages) {
> =20
> -		if (f2fs_readpage(sbi, page, addr, READ_SYNC))
> -			goto out;
> +		nrpages =3D min(last_offset - i, bio_blocks);
> +		/* read ahead node pages */
> +		err =3D ra_sum_pages(sbi, &page_list, addr, nrpages);
> +		if (err)
> +			return err;
> =20
> -		lock_page(page);
> -		rn =3D F2FS_NODE(page);
> -		sum_entry->nid =3D rn->footer.nid;
> -		sum_entry->version =3D 0;
> -		sum_entry->ofs_in_node =3D 0;
> -		addr++;
> +		list_for_each_entry_safe(page, tmp, &page_list, lru) {
> +
> +			lock_page(page);
> +			if(PageUptodate(page)) {
> +				rn =3D F2FS_NODE(page);
> +				sum_entry->nid =3D rn->footer.nid;
> +				sum_entry->version =3D 0;
> +				sum_entry->ofs_in_node =3D 0;
> +				sum_entry++;
> +			} else {
> +				err =3D -EIO;
> +			}
> +
> +			list_del(&page->lru);
> +			unlock_page(page);
> +			__free_pages(page, 0);
> +		}
>  	}
> -	unlock_page(page);
> -out:
> -	__free_pages(page, 0);
> -	return 0;
> +	return err;
>  }
> =20
>  static bool flush_nats_in_journal(struct f2fs_sb_info *sbi)

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
