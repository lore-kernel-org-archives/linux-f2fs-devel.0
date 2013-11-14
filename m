From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: read contiguous sit entry pages
 by merging for mount performance
Date: Thu, 14 Nov 2013 18:31:03 +0800
Message-ID: <5284A667.7020103@cn.fujitsu.com>
References: <000101cedf66$c2e7ea40$48b7bec0$@samsung.com> <5282F470.4020401@cn.fujitsu.com> <000001cee047$e7bebce0$b73c36a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000001cee047$e7bebce0$b73c36a0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: '???' <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?GB2312?B?J8y35q0n?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yu,
On 11/13/2013 04:10 PM, Chao Yu wrote:

> Hi Gu,
>=20
>> -----Original Message-----
>> From: Gu Zheng [mailto:guz.fnst@cn.fujitsu.com]
>> Sent: Wednesday, November 13, 2013 11:39 AM
>> To: Chao Yu
>> Cc: ???; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org=
; linux-f2fs-devel@lists.sourceforge.net; =CC=B7=E6=AD
>> Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: read contiguous sit entry =
pages by merging for mount performance
>>
>> Hi Yu,
>> On 11/12/2013 01:18 PM, Chao Yu wrote:
>>
>>> Previously we read sit entries page one by one, this method lost th=
e chance of reading contiguous page together.
>>> So we read pages as contiguous as possible for better mount perform=
ance.
>>>
>>> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
>>> ---
>>>  fs/f2fs/f2fs.h    |    2 ++
>>>  fs/f2fs/segment.c |   65 +++++++++++++++++++++++++++++++++++++++++=
+++++++++---
>>>  fs/f2fs/segment.h |    2 ++
>>>  3 files changed, 66 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 0afdcec..bfe9d87 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -1113,6 +1113,8 @@ struct page *find_data_page(struct inode *, p=
goff_t, bool);
>>>  struct page *get_lock_data_page(struct inode *, pgoff_t);
>>>  struct page *get_new_data_page(struct inode *, struct page *, pgof=
f_t, bool);
>>>  int f2fs_readpage(struct f2fs_sb_info *, struct page *, block_t, i=
nt);
>>> +void f2fs_submit_read_bio(struct f2fs_sb_info *, int);
>>> +void submit_read_page(struct f2fs_sb_info *, struct page *, block_=
t, int);
>>
>> Better to move these declarations into PATCH 1/2.
>=20
> Okay, I will move it to the right place.
>=20
>>
>>>  int do_write_data_page(struct page *);
>>>
>>>  /*
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 86dc289..414c351 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1474,19 +1474,72 @@ static int build_curseg(struct f2fs_sb_info=
 *sbi)
>>>  	return restore_curseg_summaries(sbi);
>>>  }
>>>
>>> +static int ra_sit_pages(struct f2fs_sb_info *sbi, int start,
>>> +					int nrpages, bool *is_order)
>>> +{
>>> +	struct address_space *mapping =3D sbi->meta_inode->i_mapping;
>>> +	struct sit_info *sit_i =3D SIT_I(sbi);
>>> +	struct page *page;
>>> +	block_t blk_addr;
>>> +	int blkno, readcnt =3D 0;
>>> +	int sit_blk_cnt =3D SIT_BLK_CNT(sbi);
>>> +
>>> +	for (blkno =3D start; blkno < start + nrpages; blkno++) {
>>> +
>>> +		if (blkno >=3D sit_blk_cnt)
>>
>> Merge these two judgements:
>> for (blkno =3D start; blkno < start + nrpages && blkno < sit_blk_cnt=
; blkno++)
>=20
> Right, but the line may over 80 characters, if we split this line, it=
 seems not suitable.
> So how about this?
> 	int blkno =3D start, readcnt =3D 0;
> 	int sit_blk_cnt =3D SIT_BLK_CNT(sbi);
>=20
> 	for (; blkno < start + nrpages && blkno < sit_blk_cnt; blkno++) {

More neat=A3=A1

>=20
>>
>>> +			goto out;
>>
>>> +		if ((!f2fs_test_bit(blkno, sit_i->sit_bitmap) ^ !*is_order)) {
>>> +			*is_order =3D !*is_order;
>>> +			goto out;
>>
>> 'Break' seems more suitable.
>=20
> Yes, you are right.
>=20
>>
>>> +		}
>>> +
>>> +		blk_addr =3D sit_i->sit_base_addr + blkno;
>>> +		if (*is_order)
>>> +			blk_addr +=3D sit_i->sit_blocks;
>>> +repeat:
>>> +		page =3D grab_cache_page(mapping, blk_addr);
>>> +		if (!page) {
>>> +			cond_resched();
>>> +			goto repeat;
>>> +		}
>>> +		if (PageUptodate(page)) {
>>> +			f2fs_put_page(page, 1);
>>> +			readcnt++;
>>> +			goto out;
>>
>> Here may be 'Continue'.
>=20
> 'Out' label could be removed after this modification.
> It seems more neat.

Right.

>=20
>>
>>> +		}
>>> +
>>> +		submit_read_page(sbi, page, blk_addr, READ_SYNC);
>>> +
>>> +		page_cache_release(page);
>>
>> Put page here seems not a good idea, otherwise all your work may be =
in vain.
>=20
> You mean that pages could be reclaimed by VM when out of memory?
> IMO, it is designed more like VM read ahead because we should concern=
=20
> memory state of system, and still we have second chance to read these=
 pages.
>=20

Yes, but we can avoid to read the same page secondly, that's a serious =
waste, if we still
reread the page in get_current_sit_page(), all the improvement will dis=
appear.

> Could we use mark_page_accessed () to delay VM reclaimed them?

IMO, this is the right way.

>=20
>>
>>> +		readcnt++;
>>> +	}
>>> +out:
>>> +	f2fs_submit_read_bio(sbi, READ_SYNC);
>>> +	return readcnt;
>>> +}
>>> +
>>>  static void build_sit_entries(struct f2fs_sb_info *sbi)
>>>  {
>>>  	struct sit_info *sit_i =3D SIT_I(sbi);
>>>  	struct curseg_info *curseg =3D CURSEG_I(sbi, CURSEG_COLD_DATA);
>>>  	struct f2fs_summary_block *sum =3D curseg->sum_blk;
>>> -	unsigned int start;
>>> +	bool is_order =3D f2fs_test_bit(0, sit_i->sit_bitmap) ? true : fa=
lse;
>>> +	int sit_blk_cnt =3D SIT_BLK_CNT(sbi);
>>> +	int bio_blocks =3D MAX_BIO_BLOCKS(max_hw_blocks(sbi));
>>> +	unsigned int i, start, end;
>>> +	unsigned int readed, start_blk =3D 0;
>>>
>>> -	for (start =3D 0; start < TOTAL_SEGS(sbi); start++) {
>>> +next:
>>> +	readed =3D ra_sit_pages(sbi, start_blk, bio_blocks, &is_order);
>>
>> In fact, you know how many blocks that you want to read(SIT_BLK_CNT(=
sbi)),
>> so here sit_blk_cnt is more suitable than a MAX one, and it also can=
 make
>> the logic of ra_sit_pages more simple.
>=20
> Right.
>=20
> BTW, I am considering that maybe we should send dynamical cnt which=20
> depend on memory state of system more than the logic of ra_sit_pages.
> May it's the work of anther patch. How do you think?

Agree. It's the same as the way that I suggested previously, and it can=
 make
the contiguous pages reading api more common.

Regards,
Gu

>=20
>>
>>> +
>>> +	start =3D start_blk * sit_i->sents_per_block;
>>> +	end =3D (start_blk + readed) * sit_i->sents_per_block;
>>> +
>>> +	for (; start < end && start < TOTAL_SEGS(sbi); start++) {
>>>  		struct seg_entry *se =3D &sit_i->sentries[start];
>>>  		struct f2fs_sit_block *sit_blk;
>>>  		struct f2fs_sit_entry sit;
>>>  		struct page *page;
>>> -		int i;
>>>
>>>  		mutex_lock(&curseg->curseg_mutex);
>>>  		for (i =3D 0; i < sits_in_cursum(sum); i++) {
>>> @@ -1497,6 +1550,7 @@ static void build_sit_entries(struct f2fs_sb_=
info *sbi)
>>>  			}
>>>  		}
>>>  		mutex_unlock(&curseg->curseg_mutex);
>>> +
>>>  		page =3D get_current_sit_page(sbi, start);
>>>  		sit_blk =3D (struct f2fs_sit_block *)page_address(page);
>>>  		sit =3D sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
>>> @@ -1509,6 +1563,11 @@ got_it:
>>>  			e->valid_blocks +=3D se->valid_blocks;
>>>  		}
>>>  	}
>>> +
>>> +	start_blk +=3D readed;
>>> +	if (start_blk >=3D sit_blk_cnt)
>>> +		return;
>>> +	goto next;
>>
>> Using do {...} while(start_blk < sit_blk_cnt) rather than the so big=
 upstream goto.
>=20
> Yes, you are right.
>=20
>>
>>>  }
>>>
>>>  static void init_free_segmap(struct f2fs_sb_info *sbi)
>>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>>> index 269f690..ad5b9f1 100644
>>> --- a/fs/f2fs/segment.h
>>> +++ b/fs/f2fs/segment.h
>>> @@ -83,6 +83,8 @@
>>>  	(segno / SIT_ENTRY_PER_BLOCK)
>>>  #define	START_SEGNO(sit_i, segno)		\
>>>  	(SIT_BLOCK_OFFSET(sit_i, segno) * SIT_ENTRY_PER_BLOCK)
>>> +#define SIT_BLK_CNT(sbi)			\
>>> +	((TOTAL_SEGS(sbi) + SIT_ENTRY_PER_BLOCK - 1) / SIT_ENTRY_PER_BLOC=
K)
>>>  #define f2fs_bitmap_size(nr)			\
>>>  	(BITS_TO_LONGS(nr) * sizeof(unsigned long))
>>>  #define TOTAL_SEGS(sbi)	(SM_I(sbi)->main_segments)
>=20
> Thanks!
>=20
> Regards,
> Yu
>=20
>=20
>=20
