From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH V2 1/2] f2fs: add a new function to support for
 merging contiguous read
Date: Mon, 18 Nov 2013 09:29:20 +0900
Message-ID: <1384734560.26319.10.camel@kjgkr>
References: <000001cee293$3b6e3030$b24a9090$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <000001cee293$3b6e3030$b24a9090$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?UTF-8?Q?=E8=B0=AD=E5=A7=9D?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

2013-11-16 (=ED=86=A0), 14:14 +0800, Chao Yu:
> For better read performance, we add a new function to support for mer=
ging contiguous read as the one for write.

Please consider 80 columns for the description.
I cannot fix this at every time though. :(

>=20
> v1-->v2:
>  o add declarations here as Gu Zheng suggested.
>=20
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> Acked-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> ---
>  fs/f2fs/data.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/f2fs/f2fs.h |    4 ++++
>  2 files changed, 49 insertions(+)
>=20
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index aa3438c..18107cb 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -404,6 +404,51 @@ int f2fs_readpage(struct f2fs_sb_info *sbi, stru=
ct page *page,
>  	return 0;
>  }
> =20
> +void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, int rw)
> +{
> +	down_read(&sbi->bio_sem);

Is there any reason to use down_read()?
It seems that we need to declare sbi->bio_read and sbi->bio_write
instead of sbi->bio_sem.
In addition to that, we need to use down_write(&sbi->bio_read) here.

> +	if (sbi->read_bio) {
> +		submit_bio(rw, sbi->read_bio);
> +		sbi->read_bio =3D NULL;
> +	}
> +	up_read(&sbi->bio_sem);

up_write(&sbi->bio_read);

> +}
> +
> +void submit_read_page(struct f2fs_sb_info *sbi, struct page *page,
> +					block_t blk_addr, int rw)
> +{
> +	struct block_device *bdev =3D sbi->sb->s_bdev;
> +	int bio_blocks;
> +
> +	verify_block_addr(sbi, blk_addr);
> +
> +	down_read(&sbi->bio_sem);

down_write(&sbi->bio_read);

> +
> +	if (sbi->read_bio && sbi->last_read_block !=3D blk_addr - 1) {
> +		submit_bio(rw, sbi->read_bio);
> +		sbi->read_bio =3D NULL;
> +	}
> +
> +alloc_new:
> +	if (sbi->read_bio =3D=3D NULL) {
> +		bio_blocks =3D MAX_BIO_BLOCKS(max_hw_blocks(sbi));
> +		sbi->read_bio =3D f2fs_bio_alloc(bdev, bio_blocks);
> +		sbi->read_bio->bi_sector =3D SECTOR_FROM_BLOCK(sbi, blk_addr);
> +		sbi->read_bio->bi_end_io =3D read_end_io;
> +	}
> +
> +	if (bio_add_page(sbi->read_bio, page, PAGE_CACHE_SIZE, 0) <
> +							PAGE_CACHE_SIZE) {
> +		submit_bio(rw, sbi->read_bio);
> +		sbi->read_bio =3D NULL;
> +		goto alloc_new;
> +	}
> +
> +	sbi->last_read_block =3D blk_addr;
> +
> +	up_read(&sbi->bio_sem);

up_write(&sbi->bio_read);

> +}
> +
>  /*
>   * This function should be used by the data read flow only where it
>   * does not check the "create" flag that indicates block allocation.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 89dc750..bfe9d87 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -359,6 +359,8 @@ struct f2fs_sb_info {
> =20
>  	/* for segment-related operations */
>  	struct f2fs_sm_info *sm_info;		/* segment manager */
> +	struct bio *read_bio;			/* read bios to merge */
> +	sector_t last_read_block;		/* last read block number */
>  	struct bio *bio[NR_PAGE_TYPE];		/* bios to merge */
>  	sector_t last_block_in_bio[NR_PAGE_TYPE];	/* last block number */
>  	struct rw_semaphore bio_sem;		/* IO semaphore */
> @@ -1111,6 +1113,8 @@ struct page *find_data_page(struct inode *, pgo=
ff_t, bool);
>  struct page *get_lock_data_page(struct inode *, pgoff_t);
>  struct page *get_new_data_page(struct inode *, struct page *, pgoff_=
t, bool);
>  int f2fs_readpage(struct f2fs_sb_info *, struct page *, block_t, int=
);
> +void f2fs_submit_read_bio(struct f2fs_sb_info *, int);
> +void submit_read_page(struct f2fs_sb_info *, struct page *, block_t,=
 int);
>  int do_write_data_page(struct page *);
> =20
>  /*

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
