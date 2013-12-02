From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: refactor bio-related operations
Date: Mon, 02 Dec 2013 17:24:12 +0900
Message-ID: <1385972652.2417.111.camel@kjgkr>
References: <1385792739-31405-1-git-send-email-jaegeuk.kim@samsung.com>
 <000101ceef19$ae149b50$0a3dd1f0$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <000101ceef19$ae149b50$0a3dd1f0$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?UTF-8?Q?=E8=B0=AD=E5=A7=9D?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2013-12-02 (=EC=9B=94), 12:47 +0800, Chao Yu:
> Hi,
>=20
> Some comments as following.
>=20
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> > Sent: Saturday, November 30, 2013 2:26 PM
> > Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; li=
nux-f2fs-devel@lists.sourceforge.net
> > Subject: [f2fs-dev] [PATCH] f2fs: refactor bio-related operations
> >=20
>=20
> [snip]
>=20
> > +void f2fs_submit_page_mbio(struct f2fs_sb_info *sbi, struct page *=
page,
> > +			block_t blk_addr, enum page_type type, int rw)
> > +{
> > +	enum page_type btype =3D PAGE_TYPE_OF_BIO(type);
> > +	struct block_device *bdev =3D sbi->sb->s_bdev;
> > +	struct f2fs_bio_info *io;
> > +	int bio_blocks;
> > +
> > +	io =3D is_read_io(rw) ? &sbi->read_io : &sbi->write_io[btype];
> > +
> > +	verify_block_addr(sbi, blk_addr);
> > +
> > +	mutex_lock(&io->io_mutex);
> > +
> > +	if (!is_read_io(rw))
> > +		inc_page_count(sbi, F2FS_WRITEBACK);
> > +
> > +	if (io->bio && io->last_block_in_bio !=3D blk_addr - 1)
> > +		__submit_merged_bio(sbi, io, type, true, rw);
> > +alloc_new:
> > +	if (io->bio =3D=3D NULL) {
> > +		bio_blocks =3D MAX_BIO_BLOCKS(max_hw_blocks(sbi));
> > +		io->bio =3D __bio_alloc(bdev, bio_blocks);
> > +		io->bio->bi_sector =3D SECTOR_FROM_BLOCK(sbi, blk_addr);
> > +		io->bio->bi_end_io =3D is_read_io(rw) ? f2fs_read_end_io :
> > +							f2fs_write_end_io;
> > +		/*
> > +		 * The end_io will be assigned at the sumbission phase.
> > +		 * Until then, let bio_add_page() merge consecutive IOs as much
> > +		 * as possible.
> > +		 */
> > +	}
> > +
> > +	if (bio_add_page(io->bio, page, PAGE_CACHE_SIZE, 0) <
> > +							PAGE_CACHE_SIZE) {
> > +		__submit_merged_bio(sbi, io, type, true, rw);
> > +		io->bio =3D NULL;
>=20
> We should remove the redundant code " io->bio =3D NULL;" here,
> because __submit_merged_bio does the same job.

Agreed.

>=20
> [snip]
>=20
> >  /*
> >   * data.c
> >   */
> > +void f2fs_submit_merged_bio(struct f2fs_sb_info *, enum page_type,=
 bool, int);
> > +int f2fs_submit_page_bio(struct f2fs_sb_info *, struct page *, blo=
ck_t, int);
>=20
> Redundant to the following code.

Ah, agreed.
Thank you for the review. :)

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
