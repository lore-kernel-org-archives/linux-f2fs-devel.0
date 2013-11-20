From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH V2 1/2 RESEND] f2fs: add a new function to
 support for merging contiguous read
Date: Wed, 20 Nov 2013 14:31:23 +0800
Message-ID: <001b01cee5ba$46651330$d32f3990$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
References: 
In-reply-to: 
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?gb2312?B?zLfmrQ==?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Kim,

No considering 80 columns for the description, :(
I will resend the patches.

> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Wednesday, November 20, 2013 1:55 PM
> To: ??? (jaegeuk.kim@samsung.com)
> Cc: 'linux-fsdevel@vger.kernel.org'; 'linux-kernel@vger.kernel.org'; =
'linux-f2fs-devel@lists.sourceforge.net'; =CC=B7=E6=AD
> (shu.tan@samsung.com)
> Subject: [f2fs-dev] [PATCH V2 1/2 RESEND] f2fs: add a new function to=
 support for merging contiguous read
>=20
> For better read performance, we add a new function to support for mer=
ging contiguous read as the one for write.
>=20
> v1-->v2:
>  o add declarations here as Gu Zheng suggested.
>  o use new structure f2fs_bio_info introduced by Jaegeuk Kim.
>=20
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> Acked-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> ---
>  fs/f2fs/data.c  |   50 +++++++++++++++++++++++++++++++++++++++++++++=
+++++
>  fs/f2fs/f2fs.h  |    3 +++
>  fs/f2fs/super.c |    1 +
>  3 files changed, 54 insertions(+)
>=20
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index b4e4c7e..9cf3f6c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -400,6 +400,56 @@ int f2fs_readpage(struct f2fs_sb_info *sbi, stru=
ct page *page,
>  	return 0;
>  }
>=20
> +void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, int rw)
> +{
> +	struct f2fs_bio_info *io =3D &sbi->read_io;
> +
> +	if (!io->bio)
> +		return;
> +
> +	mutex_lock(&io->io_mutex);
> +	if (io->bio) {
> +		submit_bio(rw, io->bio);
> +		io->bio =3D NULL;
> +	}
> +	mutex_unlock(&io->io_mutex);
> +}
> +
> +void submit_read_page(struct f2fs_sb_info *sbi, struct page *page,
> +					block_t blk_addr, int rw)
> +{
> +	struct block_device *bdev =3D sbi->sb->s_bdev;
> +	struct f2fs_bio_info *io =3D &sbi->read_io;
> +	int bio_blocks;
> +
> +	verify_block_addr(sbi, blk_addr);
> +
> +	mutex_lock(&io->io_mutex);
> +
> +	if (io->bio && io->last_block_in_bio !=3D blk_addr - 1) {
> +		submit_bio(rw, io->bio);
> +		io->bio =3D NULL;
> +	}
> +alloc_new:
> +	if (io->bio =3D=3D NULL) {
> +		bio_blocks =3D MAX_BIO_BLOCKS(max_hw_blocks(sbi));
> +		io->bio =3D f2fs_bio_alloc(bdev, bio_blocks);
> +		io->bio->bi_sector =3D SECTOR_FROM_BLOCK(sbi, blk_addr);
> +		io->bio->bi_end_io =3D read_end_io;
> +	}
> +
> +	if (bio_add_page(io->bio, page, PAGE_CACHE_SIZE, 0) <
> +							PAGE_CACHE_SIZE) {
> +		submit_bio(rw, io->bio);
> +		io->bio =3D NULL;
> +		goto alloc_new;
> +	}
> +
> +	io->last_block_in_bio =3D blk_addr;
> +
> +	mutex_unlock(&io->io_mutex);
> +}
> +
>  /*
>   * This function should be used by the data read flow only where it
>   * does not check the "create" flag that indicates block allocation.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index a54fac2..e2cb920 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -368,6 +368,7 @@ struct f2fs_sb_info {
>  	struct f2fs_sm_info *sm_info;		/* segment manager */
>=20
>  	/* for bio operations */
> +	struct f2fs_bio_info read_io;			/* for read bios */
>  	struct f2fs_bio_info write_io[NR_PAGE_TYPE];	/* for write bios */
>=20
>  	/* for checkpoint */
> @@ -1118,6 +1119,8 @@ struct page *find_data_page(struct inode *, pgo=
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
>=20
>  /*
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 344fb86..6d78fff 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -876,6 +876,7 @@ static int f2fs_fill_super(struct super_block *sb=
, void *data, int silent)
>  	sbi->por_doing =3D false;
>  	spin_lock_init(&sbi->stat_lock);
>=20
> +	mutex_init(&sbi->read_io.io_mutex);
>  	for (i =3D 0; i < NR_PAGE_TYPE; i++)
>  		mutex_init(&sbi->write_io[i].io_mutex);
>=20
> --
> 1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
