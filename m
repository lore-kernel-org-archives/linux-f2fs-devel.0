From: Gao Xiang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH RFC] f2fs: add PRE2 to mark segments free to
 one checkpoint but obsolete to the other
Date: Sun, 21 Jan 2018 11:12:26 +0800
Message-ID: <de5a4ef3-623a-9d5d-ae09-1c46b97c5b5a@aol.com>
References: <20180119232903.40922-1-guoweichao@huawei.com>
 <6a06586a-7432-03c5-912a-410e4aa3b129@kernel.org>
 <927e0099-0bad-1a1c-1b03-ac5f935f3df5@kernel.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <hsiangkao@aol.com>) id 1ed63q-0003vo-9Q
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 21 Jan 2018 03:12:46 +0000
Received: from omr-m016e.mx.aol.com ([204.29.186.16])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) id 1ed63o-0003z1-QP
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 21 Jan 2018 03:12:46 +0000
In-Reply-To: <927e0099-0bad-1a1c-1b03-ac5f935f3df5@kernel.org>
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
To: Chao Yu <chao@kernel.org>, guoweichao <guoweichao@huawei.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, heyunlei <heyunlei@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Chao and Weichao,


On 2018/1/21 10:34, Chao Yu wrote:
> Hi Weichao,
>
> On 2018/1/20 23:50, guoweichao wrote:
>> Hi Chao,
>>
>> Yes, it is exactly what I mean.
>> It seems that F2FS has no responsibility to cover hardware problems.
>> However, file systems usually choose redundancy for super block fault to=
lerance.
>> So I think we actually have considered some external errors when designi=
ng a file system.
>> Our dual checkpoint mechanism is mainly designed to keep at least one st=
able
>> CP pack while creating a new one in case of SPO. And it has fault tolera=
nt effects.
>> As CP pack is also very critical to F2FS, why not make checkpoint more r=
obustness
> I think you're trying to change basic design of A/B upgrade system to A/B=
/C one,
> which can keep always two checkpoint valid. There will be no simple modif=
ication
> to implement that one, in where we should cover not only prefree case but=
 also
> SSR case.
*nod*, triple-like-backups would not solve all hardware issues in a even =

worse case,
and in order to make all backups available we need to find more extra =

area to leave all modification among 3 checkpoints.

In my opinion, introducing "snapshot" feature could be something more =

useful for phone (yet it is a big feature :( )
and if fsck found something is unrecoverable
we could roll back to a stable and reliable (via re-checking metadata) =

snapshot (maybe hours ago or days ago,
and remind users when rollback in fsck or somewhere).

Sorry to bother all,

Thanks,
>
> IMO, the biggest problem there is available space, since in checkpoint C,=
 we can
> only use invalid blocks in both checkpoint A and B, so in some cases ther=
e will
> almost be no valid space we can use during allocation, result in frequent=
ly
> checkpoint.
>
> IMO, what we can do is trying to keep last valid checkpoint being integri=
ty as
> possible as we can. One way is that we can add mirror or parity for the
> checkpoint which can help to do recovery once checkpoint is corrupted. At
> least, I hope that with it in debug version we can help hardware staff to=
 fix
> their issue instead of wasting much time to troubleshoot filesystem issue.
>
> Thanks,
>
>> with simple modification in current design and little overhead except fo=
r FG_GC.
>> Of cause, keep unchanged is OK. I just want to discuss this proposal. :)
>>
>> Thanks,
>> *From:*Chao Yu
>> *To:*guoweichao,jaegeuk@kernel.org,
>> *Cc:*linux-f2fs-devel@lists.sourceforge.net,linux-fsdevel@vger.kernel.or=
g,heyunlei,
>> *Date:*2018-01-20 15:43:23
>> *Subject:*Re: [PATCH RFC] f2fs: add PRE2 to mark segments free to one ch=
eckpoint but obsolete to the other
>>
>> Hi Weichao,
>>
>> On 2018/1/20 7:29, Weichao Guo wrote:
>>> Currently, we set prefree segments as free ones after writing
>>> a checkpoint, then believe the segments could be used safely.
>>> However, if a sudden power-off coming and the newer checkpoint
>>> corrupted due to hardware issues at the same time, we will try
>>> to use the old checkpoint and may face an inconsistent file
>>> system status.
>> IIUC, you mean:
>>
>> 1. write nodes into segment x;
>> 2. write checkpoint A;
>> 3. remove nodes in segment x;
>> 4. write checkpoint B;
>> 5. issue discard or write datas into segment x;
>> 6. sudden power-cut
>>
>> But after reboot, we found checkpoint B is corrupted due to hardware, and
>> then start to use checkpoint A, but nodes in segment x recorded as valid
>> data in checkpoint A has been overcovered in step 5), so we will encount=
er
>> inconsistent meta data, right?
>>
>> Thanks,
>>
>>> How about add an PRE2 status for prefree segments, and make
>>> sure the segments could be used safely to both checkpoints?
>>> Or any better solutions? Or this is not a problem?
>>>
>>> Look forward to your comments!
>>>
>>> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
>>> ---
>>>  =A0fs/f2fs/gc.c =A0=A0=A0=A0=A0| 11 +++++++++--
>>>  =A0fs/f2fs/segment.c | 21 ++++++++++++++++++---
>>>  =A0fs/f2fs/segment.h | =A06 ++++++
>>>  =A03 files changed, 33 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index 33e7969..153e3ea 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -1030,7 +1030,12 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>  =A0 =A0* threshold, we can make them free by checkpoint. Then, we
>>>  =A0 =A0* secure free segments which doesn't need fggc any more.
>>>  =A0 =A0*/
>>> - if (prefree_segments(sbi)) {
>>> + if (prefree_segments(sbi) || prefree2_segments(sbi)) {
>>> + ret =3D write_checkpoint(sbi, &cpc);
>>> + if (ret)
>>> + goto stop;
>>> + }
>>> + if (has_not_enough_free_secs(sbi, 0, 0) && prefree2_segments(sbi)) {
>>>  =A0 ret =3D write_checkpoint(sbi, &cpc);
>>>  =A0 if (ret)
>>>  =A0 goto stop;
>>> @@ -1063,8 +1068,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>  =A0 goto gc_more;
>>>  =A0 }
>>>   =

>>> - if (gc_type =3D=3D FG_GC)
>>> + if (gc_type =3D=3D FG_GC) {
>>> + ret =3D write_checkpoint(sbi, &cpc);
>>>  =A0 ret =3D write_checkpoint(sbi, &cpc);
>>> + }
>>>  =A0 }
>>>  =A0stop:
>>>  =A0 SIT_I(sbi)->last_victim[ALLOC_NEXT] =3D 0;
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 2e8e054d..9dec445 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1606,7 +1606,7 @@ static void set_prefree_as_free_segments(struct f=
2fs_sb_info *sbi)
>>>  =A0 unsigned int segno;
>>>   =

>>>  =A0 mutex_lock(&dirty_i->seglist_lock);
>>> - for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], MAIN_SEGS(sbi))
>>> + for_each_set_bit(segno, dirty_i->dirty_segmap[PRE2], MAIN_SEGS(sbi))
>>>  =A0 __set_test_and_free(sbi, segno);
>>>  =A0 mutex_unlock(&dirty_i->seglist_lock);
>>>  =A0}
>>> @@ -1617,13 +1617,17 @@ void clear_prefree_segments(struct f2fs_sb_info=
 *sbi, struct cp_control *cpc)
>>>  =A0 struct list_head *head =3D &dcc->entry_list;
>>>  =A0 struct discard_entry *entry, *this;
>>>  =A0 struct dirty_seglist_info *dirty_i =3D DIRTY_I(sbi);
>>> - unsigned long *prefree_map =3D dirty_i->dirty_segmap[PRE];
>>> + unsigned long *prefree_map;
>>>  =A0 unsigned int start =3D 0, end =3D -1;
>>>  =A0 unsigned int secno, start_segno;
>>>  =A0 bool force =3D (cpc->reason & CP_DISCARD);
>>> + int phase =3D 0;
>>> + enum dirty_type dirty_type =3D PRE2;
>>>   =

>>>  =A0 mutex_lock(&dirty_i->seglist_lock);
>>>   =

>>> +next_step:
>>> + prefree_map =3D dirty_i->dirty_segmap[dirty_type];
>>>  =A0 while (1) {
>>>  =A0 int i;
>>>  =A0 start =3D find_next_bit(prefree_map, MAIN_SEGS(sbi), end + 1);
>>> @@ -1635,7 +1639,7 @@ void clear_prefree_segments(struct f2fs_sb_info *=
sbi, struct cp_control *cpc)
>>>  =A0 for (i =3D start; i < end; i++)
>>>  =A0 clear_bit(i, prefree_map);
>>>   =

>>> - dirty_i->nr_dirty[PRE] -=3D end - start;
>>> + dirty_i->nr_dirty[dirty_type] -=3D end - start;
>>>   =

>>>  =A0 if (!test_opt(sbi, DISCARD))
>>>  =A0 continue;
>>> @@ -1663,6 +1667,16 @@ void clear_prefree_segments(struct f2fs_sb_info =
*sbi, struct cp_control *cpc)
>>>  =A0 else
>>>  =A0 end =3D start - 1;
>>>  =A0 }
>>> + if (phase =3D=3D 0) {
>>> + /* status change: PRE -> PRE2 */
>>> + for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], MAIN_SEGS(sbi))
>>> + if (!test_and_set_bit(segno, prefree_map))
>>> + dirty_i->nr_dirty[PRE2]++;
>>> +
>>> + phase =3D 1;
>>> + dirty_type =3D PRE;
>>> + goto next_step;
>>> + }
>>>  =A0 mutex_unlock(&dirty_i->seglist_lock);
>>>   =

>>>  =A0 /* send small discards */
>>> @@ -2245,6 +2259,7 @@ static void change_curseg(struct f2fs_sb_info *sb=
i, int type)
>>>   =

>>>  =A0 mutex_lock(&dirty_i->seglist_lock);
>>>  =A0 __remove_dirty_segment(sbi, new_segno, PRE);
>>> + __remove_dirty_segment(sbi, new_segno, PRE2);
>>>  =A0 __remove_dirty_segment(sbi, new_segno, DIRTY);
>>>  =A0 mutex_unlock(&dirty_i->seglist_lock);
>>>   =

>>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>>> index 71a2aaa..f702726 100644
>>> --- a/fs/f2fs/segment.h
>>> +++ b/fs/f2fs/segment.h
>>> @@ -263,6 +263,7 @@ enum dirty_type {
>>>  =A0 DIRTY_COLD_NODE, /* dirty segments assigned as cold node logs */
>>>  =A0 DIRTY, /* to count # of dirty segments */
>>>  =A0 PRE, /* to count # of entirely obsolete segments */
>>> + PRE2, /* to count # of the segments free to one checkpoint but obsole=
te to the other checkpoint */
>>>  =A0 NR_DIRTY_TYPE
>>>  =A0};
>>>   =

>>> @@ -477,6 +478,11 @@ static inline unsigned int prefree_segments(struct=
 f2fs_sb_info *sbi)
>>>  =A0 return DIRTY_I(sbi)->nr_dirty[PRE];
>>>  =A0}
>>>   =

>>> +static inline unsigned int prefree2_segments(struct f2fs_sb_info *sbi)
>>> +{
>>> + return DIRTY_I(sbi)->nr_dirty[PRE2];
>>> +}
>>> +
>>>  =A0static inline unsigned int dirty_segments(struct f2fs_sb_info *sbi)
>>>  =A0{
>>>  =A0 return DIRTY_I(sbi)->nr_dirty[DIRTY_HOT_DATA] +
>>>
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
