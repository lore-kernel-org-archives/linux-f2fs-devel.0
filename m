From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: large volume support
Date: Wed, 21 May 2014 13:33:11 +0900
Message-ID: <1400646791.12919.4.camel@kjgkr>
References: <1399877976-2643-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-UbicCnF1Ps0vqlbJuhCe"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1399877976-2643-1-git-send-email-cm224.lee@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net


--=-UbicCnF1Ps0vqlbJuhCe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Changman,

2014-05-12 (=EC=9B=94), 15:59 +0900, Changman Lee:
> f2fs's cp has one page which consists of struct f2fs_checkpoint and
> version bitmap of sit and nat. To support lots of segments, we need more
> blocks for sit bitmap. So let's arrange sit bitmap as following:
> +-----------------+------------+
> | f2fs_checkpoint | sit bitmap |
> | + nat bitmap    |            |
> +-----------------+------------+
> 0                 4k        N blocks
>=20
> Signed-off-by: Changman Lee <cm224.lee@samsung.com>
> ---
>  fs/f2fs/checkpoint.c    |   47 +++++++++++++++++++++++++++++++++++++++++=
+++---
>  fs/f2fs/f2fs.h          |   13 +++++++++++--
>  include/linux/f2fs_fs.h |    2 ++
>  3 files changed, 57 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index fe968c7..f418243 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -544,6 +544,32 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
>  	cp_block =3D (struct f2fs_checkpoint *)page_address(cur_page);
>  	memcpy(sbi->ckpt, cp_block, blk_size);
> =20
> +	if (is_set_ckpt_flags(sbi->ckpt, CP_LARGE_VOL_FLAG)) {
> +		int i, cp_blks;
> +		block_t cp_blk_no;
> +
> +		cp_blk_no =3D le32_to_cpu(fsb->cp_blkaddr);
> +		if (cur_page =3D=3D cp2)
> +			cp_blk_no +=3D 1 << le32_to_cpu(fsb->log_blocks_per_seg);
> +
> +		cp_blks =3D 1 + F2FS_BLK_ALIGN(cp_block->sit_ver_bitmap_bytesize);

Should covert le32_to_cpu(cp_block->sit_ver_bitmap_bytesize).

> +
> +		kfree(sbi->ckpt);
> +		sbi->ckpt =3D kzalloc(cp_blks * blk_size, GFP_KERNEL);

Why does it have to reallocate this and not to handle -ENOMEM correctly?

> +
> +		memcpy(sbi->ckpt, cp_block, blk_size);
> +
> +		for (i =3D 1; i < cp_blks; i++) {
> +			void *sit_bitmap_ptr;
> +			unsigned char *ckpt =3D (unsigned char *)sbi->ckpt;
> +
> +			cur_page =3D get_meta_page(sbi, cp_blk_no + i);
> +			sit_bitmap_ptr =3D page_address(cur_page);
> +			memcpy(ckpt + i * blk_size, sit_bitmap_ptr, blk_size);
> +			f2fs_put_page(cur_page, 1);
> +		}
> +	}
> +
>  	f2fs_put_page(cp1, 1);
>  	f2fs_put_page(cp2, 1);
>  	return 0;
> @@ -736,6 +762,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, b=
ool is_umount)
>  	__u32 crc32 =3D 0;
>  	void *kaddr;
>  	int i;
> +	int sit_bitmap_blks =3D 0;
> =20
>  	/*
>  	 * This avoids to conduct wrong roll-forward operations and uses
> @@ -786,16 +813,21 @@ static void do_checkpoint(struct f2fs_sb_info *sbi,=
 bool is_umount)
> =20
>  	orphan_blocks =3D (sbi->n_orphans + F2FS_ORPHANS_PER_BLOCK - 1)
>  					/ F2FS_ORPHANS_PER_BLOCK;
> -	ckpt->cp_pack_start_sum =3D cpu_to_le32(1 + orphan_blocks);
> +	if (is_set_ckpt_flags(ckpt, CP_LARGE_VOL_FLAG))
> +		sit_bitmap_blks =3D F2FS_BLK_ALIGN(ckpt->sit_ver_bitmap_bytesize);
> +	ckpt->cp_pack_start_sum =3D cpu_to_le32(1 + sit_bitmap_blks +
> +			orphan_blocks);
> =20
>  	if (is_umount) {
>  		set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
>  		ckpt->cp_pack_total_block_count =3D cpu_to_le32(2 +
> -			data_sum_blocks + orphan_blocks + NR_CURSEG_NODE_TYPE);
> +				sit_bitmap_blks + data_sum_blocks +
> +				orphan_blocks + NR_CURSEG_NODE_TYPE);
>  	} else {
>  		clear_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
>  		ckpt->cp_pack_total_block_count =3D cpu_to_le32(2 +
> -			data_sum_blocks + orphan_blocks);
> +				sit_bitmap_blks + data_sum_blocks +
> +				orphan_blocks);
>  	}
> =20
>  	if (sbi->n_orphans)
> @@ -821,6 +853,15 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, =
bool is_umount)
>  	set_page_dirty(cp_page);
>  	f2fs_put_page(cp_page, 1);
> =20
> +	for (i =3D 1; i < 1 + sit_bitmap_blks; i++) {
> +		cp_page =3D grab_meta_page(sbi, start_blk++);
> +		kaddr =3D page_address(cp_page);
> +		memcpy(kaddr, (char *)ckpt + i * F2FS_BLKSIZE,
> +				(1 << sbi->log_blocksize));
> +		set_page_dirty(cp_page);
> +		f2fs_put_page(cp_page, 1);
> +	}
> +
>  	if (sbi->n_orphans) {
>  		write_orphan_inodes(sbi, start_blk);
>  		start_blk +=3D orphan_blocks;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 676a2c6..9e147ae 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -764,9 +764,18 @@ static inline unsigned long __bitmap_size(struct f2f=
s_sb_info *sbi, int flag)
>  static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
>  {
>  	struct f2fs_checkpoint *ckpt =3D F2FS_CKPT(sbi);
> -	int offset =3D (flag =3D=3D NAT_BITMAP) ?
> +	int offset;
> +
> +	if (ckpt->ckpt_flags & CP_LARGE_VOL_FLAG) {

Should call is_set_ckpt_flag(ckpt, CP_LARGE_VOL_FLAG) to avoid endian
conversion issue.

Thanks,

> +		if (flag =3D=3D NAT_BITMAP)
> +			return &ckpt->sit_nat_version_bitmap;
> +		else
> +			return ((unsigned char *)ckpt + F2FS_BLKSIZE);
> +	} else {
> +		offset =3D (flag =3D=3D NAT_BITMAP) ?
>  			le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
> -	return &ckpt->sit_nat_version_bitmap + offset;
> +		return &ckpt->sit_nat_version_bitmap + offset;
> +	}
>  }
> =20
>  static inline block_t __start_cp_addr(struct f2fs_sb_info *sbi)
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 8c03f71..0f0b788 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -19,6 +19,7 @@
>  #define F2FS_LOG_SECTORS_PER_BLOCK	3	/* 4KB: F2FS_BLKSIZE */
>  #define F2FS_BLKSIZE			4096	/* support only 4KB block */
>  #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
> +#define F2FS_BLK_ALIGN(x)	(((x) + F2FS_BLKSIZE - 1) / F2FS_BLKSIZE)
> =20
>  #define NULL_ADDR		((block_t)0)	/* used as block_t addresses */
>  #define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
> @@ -80,6 +81,7 @@ struct f2fs_super_block {
>  /*
>   * For checkpoint
>   */
> +#define CP_LARGE_VOL_FLAG	0x00000010
>  #define CP_ERROR_FLAG		0x00000008
>  #define CP_COMPACT_SUM_FLAG	0x00000004
>  #define CP_ORPHAN_PRESENT_FLAG	0x00000002

--=20
Jaegeuk Kim

--=-UbicCnF1Ps0vqlbJuhCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJTfCyHAAoJEEAUqH6CSFDSeKsP/jYZv0OkVLBQKRsFo9pfaBgJ
iNLOJcZQ8wPuLHssrhWststfHML7DNobX4frAvOwuA7hLT02lpUHcH40FwuySw7u
M5yNTThhqpisscHA4kgjqWSmRr9tXmrpnrKSy/s21Q6xFwMCMBz/z0BPjsc+/r6j
GC0bsb/xxsnW6GhE4vrQkTHygvea3TbGhUNyulWWYHhvSfKqBwAPs0LLSxpWGsC6
lCf/RSGSa9SK2Thw6sxEg91ajrzsS4eigRZNgSU3R5InMXRXcFaqBCSidS2ID5wv
ZdAhkwBZ2RGhJIjoh9bHvqSBtQMGyVH8QE6L9J9w/nxjDdRQKvhonTFi0eOi53Ob
cjArSNryqaNbVz9GSZeT26XEbF012RE4kC4n26ki4VkoSEg8HmxcX2K2n3w39phl
9M/GC8mYZEQCKKUcHOkyJ5oporLOV6v3r/ra+iRbQeDnYoNw4GUg93azIfW+uEy+
NEwkRjEI3CvSWn+e3wXZSw685+mv1ZMVe634wyLXQEdH7ox1u4jrSV0wTaXBeran
1339mwwTESwf5mHhF6yuxILR9NozH8/vE3QskcLxrFWnPcs1aPkuGJrG8mXrix12
jdWeNUK5+EfvaFPSNyCSNd4P6MlUAKGBrDRY6ZJ8JZugs1L/kx4++59R0cHIKI5r
kqswk4f6m94YkWxTdYDt
=H9dT
-----END PGP SIGNATURE-----

--=-UbicCnF1Ps0vqlbJuhCe--

