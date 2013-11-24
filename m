From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH V3 2/2] f2fs: read contiguous sit entry pages by
 merging for mount performance
Date: Sun, 24 Nov 2013 13:26:00 +0900
Message-ID: <1385267160.26319.98.camel@kjgkr>
References: <000301cee71f$b0e54160$12afc420$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <000301cee71f$b0e54160$12afc420$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?UTF-8?Q?=E8=B0=AD=E5=A7=9D?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2013-11-22 (=EA=B8=88), 09:09 +0800, Chao Yu:
> Previously we read sit entries page one by one, this method lost the =
chance=20
> of reading contiguous page together. So we read pages as contiguous a=
s=20
> possible for better mount performance.
>=20
> change log:
>  o merge judgements/use 'Continue' or 'Break' instead of 'Goto' as Gu=
 Zheng=20
>    suggested.
>  o add mark_page_accessed() before release page to delay VM reclaimin=
g.
>  o remove '*order' for simplification of function as Jaegeuk Kim sugg=
ested.
>=20
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/segment.c |  103 +++++++++++++++++++++++++++++++++++++++----=
----------
>  fs/f2fs/segment.h |    2 ++
>  2 files changed, 78 insertions(+), 27 deletions(-)
>=20
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8149eba..998e7d3 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -14,6 +14,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/prefetch.h>
>  #include <linux/vmalloc.h>
> +#include <linux/swap.h>
> =20
>  #include "f2fs.h"
>  #include "segment.h"
> @@ -1488,41 +1489,89 @@ static int build_curseg(struct f2fs_sb_info *=
sbi)
>  	return restore_curseg_summaries(sbi);
>  }
> =20
> +static int ra_sit_pages(struct f2fs_sb_info *sbi, int start, int nrp=
ages)
> +{
> +	struct address_space *mapping =3D sbi->meta_inode->i_mapping;
> +	struct page *page;
> +	block_t blk_addr, prev_blk_addr =3D 0;
> +	int sit_blk_cnt =3D SIT_BLK_CNT(sbi);
> +	int blkno =3D start;
> +
> +	for (; blkno < start + nrpages && blkno < sit_blk_cnt; blkno++) {
> +
> +		blk_addr =3D current_sit_addr(sbi, start * SIT_ENTRY_PER_BLOCK);

Should be:
	blk_addr =3D current_sit_addr(sbi, blkno * SIT_ENTRY_PER_BLOCK);
	                                -------
I'll fix this and merge the patch though.
Thanks,

--=20
Jaegeuk Kim
Samsung
