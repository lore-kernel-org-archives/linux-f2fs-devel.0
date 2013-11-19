From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: split sbi->write_mutex for DATA/NODE/META
 to avoid unnecessary race
Date: Tue, 19 Nov 2013 12:18:16 +0900
Message-ID: <1384831096.26319.25.camel@kjgkr>
References: <001201cee4c8$de450360$9acf0a20$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <001201cee4c8$de450360$9acf0a20$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?UTF-8?Q?=E8=B0=AD=E5=A7=9D?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2013-11-19 (=ED=99=94), 09:43 +0800, Chao Yu:
> All DATA/NODE/META bio buffers in superblock is protected by=20
> 'sbi->write_mutex', but each bio buffer area is independent, So we=20
> should split write_mutex to three for DATA/NODE/META.

Agreed, one comment below though.
Anyway I'll send v2.
Thanks, :)

>=20
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/f2fs.h    |    2 +-
>  fs/f2fs/segment.c |    8 ++++----
>  fs/f2fs/super.c   |    4 +++-
>  3 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 2df1e61..1c67521 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -362,7 +362,7 @@ struct f2fs_sb_info {
>  	struct f2fs_sm_info *sm_info;		/* segment manager */
>  	struct bio *bio[NR_PAGE_TYPE];		/* bios to merge */
>  	sector_t last_block_in_bio[NR_PAGE_TYPE];	/* last block number */
> -	struct mutex write_mutex;		/* mutex for writing IOs */
> +	struct mutex write_mutex[NR_PAGE_TYPE];	/* mutex for writing IOs */
> =20
>  	/* for checkpoint */
>  	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 556965f..a36713ae 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -661,9 +661,9 @@ void f2fs_submit_bio(struct f2fs_sb_info *sbi, en=
um
> page_type type, bool sync)
>  	if (!sbi->bio[btype])
>  		return;
> =20
> -	mutex_lock(&sbi->write_mutex);
> +	mutex_lock(&sbi->write_mutex[type]);

btype instead of type.

>  	do_submit_bio(sbi, type, sync);
> -	mutex_unlock(&sbi->write_mutex);
> +	mutex_unlock(&sbi->write_mutex[type]);
>  }
> =20
>  static void submit_write_page(struct f2fs_sb_info *sbi, struct page =
*page,
> @@ -674,7 +674,7 @@ static void submit_write_page(struct f2fs_sb_info=
 *sbi,
> struct page *page,
> =20
>  	verify_block_addr(sbi, blk_addr);
> =20
> -	mutex_lock(&sbi->write_mutex);
> +	mutex_lock(&sbi->write_mutex[type]);
> =20
>  	inc_page_count(sbi, F2FS_WRITEBACK);
> =20
> @@ -709,7 +709,7 @@ retry:
> =20
>  	sbi->last_block_in_bio[type] =3D blk_addr;
> =20
> -	mutex_unlock(&sbi->write_mutex);
> +	mutex_unlock(&sbi->write_mutex[type]);
>  	trace_f2fs_submit_write_page(page, blk_addr, type);
>  }
> =20
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f56941c..6928c0a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -874,7 +874,9 @@ static int f2fs_fill_super(struct super_block *sb=
, void
> *data, int silent)
>  	mutex_init(&sbi->node_write);
>  	sbi->por_doing =3D false;
>  	spin_lock_init(&sbi->stat_lock);
> -	mutex_init(&sbi->write_mutex);
> +	mutex_init(&sbi->write_mutex[DATA]);
> +	mutex_init(&sbi->write_mutex[NODE]);
> +	mutex_init(&sbi->write_mutex[META]);
>  	init_rwsem(&sbi->cp_rwsem);
>  	init_waitqueue_head(&sbi->cp_wait);
>  	init_sb_info(sbi);

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
