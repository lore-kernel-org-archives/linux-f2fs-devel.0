From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: change the method of calculating the
 number summary blocks
Date: Mon, 28 Oct 2013 19:34:36 +0900
Message-ID: <1382956476.992.94.camel@kjgkr>
References: <21040538.71861382950468176.JavaMail.weblogic@epv6ml09>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <21040538.71861382950468176.JavaMail.weblogic@epv6ml09>
Sender: linux-fsdevel-owner@vger.kernel.org
To: fanofcode.li@samsung.com
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2013-10-28 (=EC=9B=94), 08:54 +0000, Fan Li:
> "There is a HTML error in the previous email, so I send this one.If y=
ou already received this before, please ignore it.Sorry for the inconve=
nience"
>=20
> This patch change the method of calculating the number of summary blo=
cks in function  npages_for_summary_flush.
> npages_for_summary_flush uses (SUMMARY_SIZE + 1) as the size of a f2f=
s_summary while the actual size is just SUMMARY_SIZE.
> As a result, occasionally the return value of npages_for_summary_flus=
h will be bigger than the actual number by one, and the checkpoint won'=
t be written contiguously  into disk.
> Besides, struct f2fs_summary can't be split to two pages, so it could=
 take more space than the sum of its size, the current version seems no=
t to take it into account.
>=20

Again. Please write a description not to exceed 80 columns.

> Signed-off-by: Fan Li <fanofcode.li@samsung.com>
> ---
>  fs/f2fs/segment.c |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c index 487af61..ba2=
930f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -279,9 +279,8 @@ static void __add_sum_entry(struct f2fs_sb_info *=
sbi, int type,
>   */
>  int npages_for_summary_flush(struct f2fs_sb_info *sbi)  {
> -	int total_size_bytes =3D 0;
>  	int valid_sum_count =3D 0;
> -	int i, sum_space;
> +	int i, sum_in_page;
> =20
>  	for (i =3D CURSEG_HOT_DATA; i <=3D CURSEG_COLD_DATA; i++) {
>  		if (sbi->ckpt->alloc_type[i] =3D=3D SSR)
> @@ -290,13 +289,12 @@ int npages_for_summary_flush(struct f2fs_sb_inf=
o *sbi)
>  			valid_sum_count +=3D curseg_blkoff(sbi, i);
>  	}
> =20
> -	total_size_bytes =3D valid_sum_count * (SUMMARY_SIZE + 1)
> -			+ sizeof(struct nat_journal) + 2
> -			+ sizeof(struct sit_journal) + 2;
> -	sum_space =3D PAGE_CACHE_SIZE - SUM_FOOTER_SIZE;
> -	if (total_size_bytes < sum_space)
> +	sum_in_page =3D (PAGE_CACHE_SIZE - 2*SUM_JOURNAL_SIZE - SUM_FOOTER_=
SIZE)/

	sum_in_page =3D (PAGE_CACHE_SIZE - 2 * SUM_JOURNAL_SIZE -
SUM_FOOTER_SIZE) / SUMMARY_SIZE;

Coding style.

> +			SUMMARY_SIZE;
> +	if (valid_sum_count <=3D sum_in_page)
>  		return 1;
> -	else if (total_size_bytes < 2 * sum_space)
> +	else if (valid_sum_count-sum_in_page <=3D
> +			(PAGE_CACHE_SIZE-SUM_FOOTER_SIZE)/SUMMARY_SIZE)

ditto.

>  		return 2;
>  	return 3;
>  }
> --
> 1.7.9.5

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
