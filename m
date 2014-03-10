From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 4/5] f2fs: optimize restore_node_summary slightly
Date: Mon, 10 Mar 2014 13:45:42 +0900
Message-ID: <1394426742.3870.89.camel@kjgkr>
References: <5319A2D8.70409@cn.fujitsu.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <5319A2D8.70409@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Gu,

2014-03-07 (=EA=B8=88), 18:43 +0800, Gu Zheng:
> Previously, we ra_sum_pages to pre-read contiguous pages as more
> as possible, and if we fail to alloc more pages, an ENOMEM error
> will be reported upstream, even though we have alloced some pages
> yet. In fact, we can use the available pages to do the job partly,
> and continue the rest in the following circle. Only reporting ENOMEM
> upstream if we really can not alloc any available page.
>=20
> And another fix is ignoring dealing with the following pages if an
> EIO occurs when reading page from page_list.
>=20
> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> ---
>  fs/f2fs/node.c    |   44 ++++++++++++++++++++-----------------------=
-
>  fs/f2fs/segment.c |    7 +++++--
>  2 files changed, 25 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 8787469..4b7861d 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1588,15 +1588,8 @@ static int ra_sum_pages(struct f2fs_sb_info *s=
bi, struct list_head *pages,
>  	for (; page_idx < start + nrpages; page_idx++) {
>  		/* alloc temporal page for read node summary info*/
>  		page =3D alloc_page(GFP_F2FS_ZERO);
> -		if (!page) {
> -			struct page *tmp;
> -			list_for_each_entry_safe(page, tmp, pages, lru) {
> -				list_del(&page->lru);
> -				unlock_page(page);
> -				__free_pages(page, 0);
> -			}
> -			return -ENOMEM;
> -		}
> +		if (!page)
> +			break;
> =20
>  		lock_page(page);
>  		page->index =3D page_idx;
> @@ -1607,7 +1600,8 @@ static int ra_sum_pages(struct f2fs_sb_info *sb=
i, struct list_head *pages,
>  		f2fs_submit_page_mbio(sbi, page, page->index, &fio);
> =20
>  	f2fs_submit_merged_bio(sbi, META, READ);
> -	return 0;
> +
> +	return page_idx - start;
>  }
> =20
>  int restore_node_summary(struct f2fs_sb_info *sbi,
> @@ -1630,28 +1624,30 @@ int restore_node_summary(struct f2fs_sb_info =
*sbi,
>  		nrpages =3D min(last_offset - i, bio_blocks);
> =20
>  		/* read ahead node pages */
> -		err =3D ra_sum_pages(sbi, &page_list, addr, nrpages);
> -		if (err)
> -			return err;
> +		nrpages =3D ra_sum_pages(sbi, &page_list, addr, nrpages);
> +		if (!nrpages)
> +			return -ENOMEM;
> =20
>  		list_for_each_entry_safe(page, tmp, &page_list, lru) {
> -

Here we can just add:
			if (err)
				goto skip;
			lock_page();
			...
			unlock_page();
		skip:
			list_del();
			__free_pages();

IMO, it's more neat, so if you have any objection, let me know.
Otherwise, I'll handle this by myself. :)
Thanks,

> -			lock_page(page);
> -			if (unlikely(!PageUptodate(page))) {
> -				err =3D -EIO;
> -			} else {
> -				rn =3D F2FS_NODE(page);
> -				sum_entry->nid =3D rn->footer.nid;
> -				sum_entry->version =3D 0;
> -				sum_entry->ofs_in_node =3D 0;
> -				sum_entry++;
> +			if (!err) {
> +				lock_page(page);
> +				if (unlikely(!PageUptodate(page))) {
> +					err =3D -EIO;
> +				} else {
> +					rn =3D F2FS_NODE(page);
> +					sum_entry->nid =3D rn->footer.nid;
> +					sum_entry->version =3D 0;
> +					sum_entry->ofs_in_node =3D 0;
> +					sum_entry++;
> +				}
> +				unlock_page(page);
>  			}
> =20
>  			list_del(&page->lru);
> -			unlock_page(page);
>  			__free_pages(page, 0);
>  		}
>  	}
> +
>  	return err;
>  }
> =20
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 199c964..b3f8431 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1160,9 +1160,12 @@ static int read_normal_summaries(struct f2fs_s=
b_info *sbi, int type)
>  				ns->ofs_in_node =3D 0;
>  			}
>  		} else {
> -			if (restore_node_summary(sbi, segno, sum)) {
> +			int err;
> +
> +			err =3D restore_node_summary(sbi, segno, sum);
> +			if (err) {
>  				f2fs_put_page(new, 1);
> -				return -EINVAL;
> +				return err;
>  			}
>  		}
>  	}

--=20
Jaegeuk Kim
Samsung
