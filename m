From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: avoid f2fs_gc dead loop
Date: Mon, 25 Dec 2017 18:30:51 +0800
Message-ID: <3ac4d41e-8b06-2c9e-b818-ac03a9a4a413@kernel.org>
References: <1514034550-149813-1-git-send-email-yunlong.song@huawei.com>
 <4202ea25-f40a-a4da-787b-86f5aa9b0311@huawei.com>
 <4ad03dc8-6517-f130-3d9e-6d6d17640ec5@huawei.com>
 <6201b0ce-61bc-aa57-39f3-93cbb52027ef@huawei.com>
 <b44ba3ef-4017-37b5-f9ec-c363f2b7ac54@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1eTQ2A-0007yj-Tr
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Dec 2017 10:31:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eTQ29-0002cW-Q2
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Dec 2017 10:31:02 +0000
In-Reply-To: <b44ba3ef-4017-37b5-f9ec-c363f2b7ac54@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlong Song <yunlong.song@huawei.com>, Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org, yunlong.song@icloud.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, miaoxie@huawei.com

On 2017/12/25 17:56, Yunlong Song wrote:
> In this case, f2fs_gc will skip all the victims and return with no dead l=
oop. The atomic file will
> use SSR to OPU, it=91s OK.

Nope, SSR trigger condition is limited, don't rely on it.

Thanks,

> =

> On 2017/12/25 17:45, Chao Yu wrote:
>> On 2017/12/25 14:15, Yunlong Song wrote:
>>> What if the application starts atomic write but forgets to commit, e.g.
>>> bugs in application or the application
>>> is a malicious software itself?
>> I agree we should consider robustness of f2fs in security aspect, but
>> please consider more scenario of these sqlite customized interface usage,
>> it looks just skipping gc is not enough, for example, if there is one la=
rge
>> size db in our partition, with random write, its data spreads in each
>> segment, once this db has been atomic opened, foreground gc may loop for=
 ever.
>>
>> How about checking opened time of atomic or volatile file in
>> f2fs_balance_fs, if it exceeds threshold, we can restore the file to nor=
mal
>> one to avoid potential security issue.
>>
>> Thanks,
>>
>>> On 2017/12/25 11:44, Chao Yu wrote:
>>>> On 2017/12/23 21:09, Yunlong Song wrote:
>>>>> For some corner case, f2fs_gc selects one target victim but cannot fr=
ee
>>>>> that victim segment due to some reason (e.g. the segment has some blo=
cks
>>>>> of atomic file which is not commited yet), in this case, the victim
>>>> File should not be atomic opened for long time since normally sqlite
>>>> transaction will finish quickly, so we can expect that gc loop could be
>>>> ended up soon, right?
>>>>
>>>> Thanks,
>>>>
>>>>> segment may probably be selected over and over, and then f2fs_gc will
>>>>> go to dead loop. This patch identifies the dead-loop segment, and ski=
ps
>>>>> it in __get_victim next time.
>>>>>
>>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>>> ---
>>>>> =A0=A0 fs/f2fs/f2fs.h=A0 |=A0 8 ++++++++
>>>>> =A0=A0 fs/f2fs/gc.c=A0=A0=A0 | 34 ++++++++++++++++++++++++++++++++++
>>>>> =A0=A0 fs/f2fs/super.c |=A0 3 +++
>>>>> =A0=A0 3 files changed, 45 insertions(+)
>>>>>
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index ca6b0c9..b75851b 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -115,6 +115,13 @@ struct f2fs_mount_info {
>>>>> =A0=A0=A0=A0=A0=A0 unsigned int=A0=A0=A0 opt;
>>>>> =A0=A0 };
>>>>> =A0=A0 +struct gc_loop_info {
>>>>> +=A0=A0=A0 int count;
>>>>> +=A0=A0=A0 unsigned int segno;
>>>>> +=A0=A0=A0 unsigned long *segmap;
>>>>> +};
>>>>> +#define GC_LOOP_MAX 10
>>>>> +
>>>>> =A0=A0 #define F2FS_FEATURE_ENCRYPT=A0=A0=A0=A0=A0=A0=A0 0x0001
>>>>> =A0=A0 #define F2FS_FEATURE_BLKZONED=A0=A0=A0=A0=A0=A0=A0 0x0002
>>>>> =A0=A0 #define F2FS_FEATURE_ATOMIC_WRITE=A0=A0=A0 0x0004
>>>>> @@ -1125,6 +1132,7 @@ struct f2fs_sb_info {
>>>>> =A0=A0 =A0=A0=A0=A0=A0=A0 /* threshold for converting bg victims for =
fg */
>>>>> =A0=A0=A0=A0=A0=A0 u64 fggc_threshold;
>>>>> +=A0=A0=A0 struct gc_loop_info gc_loop;
>>>>> =A0=A0 =A0=A0=A0=A0=A0=A0 /* maximum # of trials to find a victim seg=
ment for SSR and GC */
>>>>> =A0=A0=A0=A0=A0=A0 unsigned int max_victim_search;
>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>> index 5d5bba4..4ee9e1b 100644
>>>>> --- a/fs/f2fs/gc.c
>>>>> +++ b/fs/f2fs/gc.c
>>>>> @@ -229,6 +229,10 @@ static unsigned int check_bg_victims(struct f2fs=
_sb_info *sbi)
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (no_fggc_candidate(sbi, secno))
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
>>>>> =A0=A0 +=A0=A0=A0=A0=A0=A0=A0 if (sbi->gc_loop.segmap &&
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_bit(GET_SEG_FROM_SEC(sbi, sec=
no), sbi->gc_loop.segmap))
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
>>>>> +
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clear_bit(secno, dirty_i->victim_secma=
p);
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return GET_SEG_FROM_SEC(sbi, secno);
>>>>> =A0=A0=A0=A0=A0=A0 }
>>>>> @@ -371,6 +375,9 @@ static int get_victim_by_default(struct f2fs_sb_i=
nfo *sbi,
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (gc_type =3D=3D FG_GC && p.alloc_mo=
de =3D=3D LFS &&
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 no=
_fggc_candidate(sbi, secno))
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto next;
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (gc_type =3D=3D FG_GC && p.alloc_mode =3D=
=3D LFS &&
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sbi->gc_loop.segmap && test_bit(se=
gno, sbi->gc_loop.segmap))
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto next;
>>>>> =A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cost =3D get_gc_cost(sbi, segno=
, &p);
>>>>> =A0=A0 @@ -1042,6 +1049,27 @@ int f2fs_gc(struct f2fs_sb_info *sbi, b=
ool sync,
>>>>> =A0=A0=A0=A0=A0=A0 seg_freed =3D do_garbage_collect(sbi, segno, &gc_l=
ist, gc_type);
>>>>> =A0=A0=A0=A0=A0=A0 if (gc_type =3D=3D FG_GC && seg_freed =3D=3D sbi->=
segs_per_sec)
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sec_freed++;
>>>>> +=A0=A0=A0 else if (gc_type =3D=3D FG_GC && seg_freed =3D=3D 0) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (!sbi->gc_loop.segmap) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sbi->gc_loop.segmap =3D
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kvzalloc(f2fs_bitmap_s=
ize(MAIN_SEGS(sbi)), GFP_KERNEL);
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sbi->gc_loop.count =3D 0;
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sbi->gc_loop.segno =3D NULL_SEGNO;
>>>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (segno =3D=3D sbi->gc_loop.segno) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (sbi->gc_loop.count > GC_LOOP_M=
AX) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f2fs_bug_on(sbi, 1);
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 set_bit(segno, sbi->gc=
_loop.segmap);
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sbi->gc_loop.count =3D=
 0;
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sbi->gc_loop.segno =3D=
 NULL_SEGNO;
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sbi->gc_loop.count++;
>>>>> +=A0=A0=A0=A0=A0=A0=A0 } else {
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sbi->gc_loop.segno =3D segno;
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sbi->gc_loop.count =3D 0;
>>>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>>>> +=A0=A0=A0 }
>>>>> =A0=A0=A0=A0=A0=A0 total_freed +=3D seg_freed;
>>>>> =A0=A0 =A0=A0=A0=A0=A0=A0 if (gc_type =3D=3D FG_GC)
>>>>> @@ -1075,6 +1103,12 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool syn=
c,
>>>>> =A0=A0 =A0=A0=A0=A0=A0=A0 if (sync)
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D sec_freed ? 0 : -EAGAIN;
>>>>> +=A0=A0=A0 if (sbi->gc_loop.segmap) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0 kvfree(sbi->gc_loop.segmap);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 sbi->gc_loop.segmap =3D NULL;
>>>>> +=A0=A0=A0=A0=A0=A0=A0 sbi->gc_loop.count =3D 0;
>>>>> +=A0=A0=A0=A0=A0=A0=A0 sbi->gc_loop.segno =3D NULL_SEGNO;
>>>>> +=A0=A0=A0 }
>>>>> =A0=A0=A0=A0=A0=A0 return ret;
>>>>> =A0=A0 }
>>>>> =A0=A0 diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>> index 031cb26..76f0b72 100644
>>>>> --- a/fs/f2fs/super.c
>>>>> +++ b/fs/f2fs/super.c
>>>>> @@ -2562,6 +2562,9 @@ static int f2fs_fill_super(struct super_block *=
sb, void *data, int silent)
>>>>> =A0=A0=A0=A0=A0=A0 sbi->last_valid_block_count =3D sbi->total_valid_b=
lock_count;
>>>>> =A0=A0=A0=A0=A0=A0 sbi->reserved_blocks =3D 0;
>>>>> =A0=A0=A0=A0=A0=A0 sbi->current_reserved_blocks =3D 0;
>>>>> +=A0=A0=A0 sbi->gc_loop.segmap =3D NULL;
>>>>> +=A0=A0=A0 sbi->gc_loop.count =3D 0;
>>>>> +=A0=A0=A0 sbi->gc_loop.segno =3D NULL_SEGNO;
>>>>> =A0=A0 =A0=A0=A0=A0=A0=A0 for (i =3D 0; i < NR_INODE_TYPE; i++) {
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INIT_LIST_HEAD(&sbi->inode_list[i]);
>>>>>
>>>> .
>>>>
>>
>> .
>>
> =


---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
