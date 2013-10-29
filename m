From: Fan Li <fanofcode.li@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: change the method of calculating the
 number summary blocks
Date: Tue, 29 Oct 2013 15:41:27 +0800
Message-ID: <001401ced47a$61fe2fb0$25fa8f10$@samsung.com>
References: <21040538.71861382950468176.JavaMail.weblogic@epv6ml09>
 <1382956476.992.94.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1382956476.992.94.camel@kjgkr>
Content-language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> Hi,
>=20
> 2013-10-28 (=EC=9B=94), 08:54 +0000, Fan Li:
> > "There is a HTML error in the previous email, so I send this one.If=
 you
> already received this before, please ignore it.Sorry for the inconven=
ience"
> >
> > This patch change the method of calculating the number of summary b=
locks
> in function  npages_for_summary_flush.
> > npages_for_summary_flush uses (SUMMARY_SIZE + 1) as the size of a
> f2fs_summary while the actual size is just SUMMARY_SIZE.
> > As a result, occasionally the return value of npages_for_summary_fl=
ush will
> be bigger than the actual number by one, and the checkpoint won't be
> written contiguously  into disk.
> > Besides, struct f2fs_summary can't be split to two pages, so it cou=
ld take
> more space than the sum of its size, the current version seems not to=
 take it
> into account.
> >
>=20
> Again. Please write a description not to exceed 80 columns.
>=20

Sorry, didn't know. here's the short version:
npages_for_summary_flush uses (SUMMARY_SIZE + 1) as the size of a f2fs_=
summary=20
while its actual size is  SUMMARY_SIZE. So the result sometimes is bigg=
er than=20
actual number by one, which causes checkpoint can't be written into dis=
k contiguously,
and sometimes summary blocks can't be compacted like they should.
Besides, when writing summary blocks into pages, if remain space in a p=
age isn't=20
big enough for one f2fs_summary, it will be left unused, current code s=
eems=20
not to take it into account.

Signed-off-by: Fan Li <fanofcode.li@samsung.com>
---
 fs/f2fs/segment.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 487af61..e40cdc4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -279,9 +279,8 @@ static void __add_sum_entry(struct f2fs_sb_info *sb=
i, int type,
  */
 int npages_for_summary_flush(struct f2fs_sb_info *sbi)
 {
-	int total_size_bytes =3D 0;
 	int valid_sum_count =3D 0;
-	int i, sum_space;
+	int i, sum_in_page;
=20
 	for (i =3D CURSEG_HOT_DATA; i <=3D CURSEG_COLD_DATA; i++) {
 		if (sbi->ckpt->alloc_type[i] =3D=3D SSR)
@@ -290,13 +289,12 @@ int npages_for_summary_flush(struct f2fs_sb_info =
*sbi)
 			valid_sum_count +=3D curseg_blkoff(sbi, i);
 	}
=20
-	total_size_bytes =3D valid_sum_count * (SUMMARY_SIZE + 1)
-			+ sizeof(struct nat_journal) + 2
-			+ sizeof(struct sit_journal) + 2;
-	sum_space =3D PAGE_CACHE_SIZE - SUM_FOOTER_SIZE;
-	if (total_size_bytes < sum_space)
+	sum_in_page =3D (PAGE_CACHE_SIZE - 2 * SUM_JOURNAL_SIZE -
+			SUM_FOOTER_SIZE) / SUMMARY_SIZE;
+	if (valid_sum_count <=3D sum_in_page)
 		return 1;
-	else if (total_size_bytes < 2 * sum_space)
+	else if ((valid_sum_count - sum_in_page) <=3D
+		(PAGE_CACHE_SIZE - SUM_FOOTER_SIZE) / SUMMARY_SIZE)
 		return 2;
 	return 3;
 }
--=20
1.7.9.5
