From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: avoid f2fs_gc dead loop
Date: Mon, 25 Dec 2017 17:56:35 +0800
Message-ID: <b44ba3ef-4017-37b5-f9ec-c363f2b7ac54@huawei.com>
References: <1514034550-149813-1-git-send-email-yunlong.song@huawei.com>
 <4202ea25-f40a-a4da-787b-86f5aa9b0311@huawei.com>
 <4ad03dc8-6517-f130-3d9e-6d6d17640ec5@huawei.com>
 <6201b0ce-61bc-aa57-39f3-93cbb52027ef@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yunlong.song@huawei.com>) id 1eTPW1-00087S-QZ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Dec 2017 09:57:49 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eTPW0-0000ee-5j
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Dec 2017 09:57:49 +0000
In-Reply-To: <6201b0ce-61bc-aa57-39f3-93cbb52027ef@huawei.com>
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
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, miaoxie@huawei.com

In this case, f2fs_gc will skip all the victims and return with no dead =

loop. The atomic file will
use SSR to OPU, it=91s OK.

On 2017/12/25 17:45, Chao Yu wrote:
> On 2017/12/25 14:15, Yunlong Song wrote:
>> What if the application starts atomic write but forgets to commit, e.g.
>> bugs in application or the application
>> is a malicious software itself?
> I agree we should consider robustness of f2fs in security aspect, but
> please consider more scenario of these sqlite customized interface usage,
> it looks just skipping gc is not enough, for example, if there is one lar=
ge
> size db in our partition, with random write, its data spreads in each
> segment, once this db has been atomic opened, foreground gc may loop for =
ever.
>
> How about checking opened time of atomic or volatile file in
> f2fs_balance_fs, if it exceeds threshold, we can restore the file to norm=
al
> one to avoid potential security issue.
>
> Thanks,
>
>> On 2017/12/25 11:44, Chao Yu wrote:
>>> On 2017/12/23 21:09, Yunlong Song wrote:
>>>> For some corner case, f2fs_gc selects one target victim but cannot free
>>>> that victim segment due to some reason (e.g. the segment has some bloc=
ks
>>>> of atomic file which is not commited yet), in this case, the victim
>>> File should not be atomic opened for long time since normally sqlite
>>> transaction will finish quickly, so we can expect that gc loop could be
>>> ended up soon, right?
>>>
>>> Thanks,
>>>
>>>> segment may probably be selected over and over, and then f2fs_gc will
>>>> go to dead loop. This patch identifies the dead-loop segment, and skips
>>>> it in __get_victim next time.
>>>>
>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>> ---
>>>>    fs/f2fs/f2fs.h  |  8 ++++++++
>>>>    fs/f2fs/gc.c    | 34 ++++++++++++++++++++++++++++++++++
>>>>    fs/f2fs/super.c |  3 +++
>>>>    3 files changed, 45 insertions(+)
>>>>
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index ca6b0c9..b75851b 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -115,6 +115,13 @@ struct f2fs_mount_info {
>>>>    	unsigned int	opt;
>>>>    };
>>>>    =

>>>> +struct gc_loop_info {
>>>> +	int count;
>>>> +	unsigned int segno;
>>>> +	unsigned long *segmap;
>>>> +};
>>>> +#define GC_LOOP_MAX 10
>>>> +
>>>>    #define F2FS_FEATURE_ENCRYPT		0x0001
>>>>    #define F2FS_FEATURE_BLKZONED		0x0002
>>>>    #define F2FS_FEATURE_ATOMIC_WRITE	0x0004
>>>> @@ -1125,6 +1132,7 @@ struct f2fs_sb_info {
>>>>    =

>>>>    	/* threshold for converting bg victims for fg */
>>>>    	u64 fggc_threshold;
>>>> +	struct gc_loop_info gc_loop;
>>>>    =

>>>>    	/* maximum # of trials to find a victim segment for SSR and GC */
>>>>    	unsigned int max_victim_search;
>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>> index 5d5bba4..4ee9e1b 100644
>>>> --- a/fs/f2fs/gc.c
>>>> +++ b/fs/f2fs/gc.c
>>>> @@ -229,6 +229,10 @@ static unsigned int check_bg_victims(struct f2fs_=
sb_info *sbi)
>>>>    		if (no_fggc_candidate(sbi, secno))
>>>>    			continue;
>>>>    =

>>>> +		if (sbi->gc_loop.segmap &&
>>>> +			test_bit(GET_SEG_FROM_SEC(sbi, secno), sbi->gc_loop.segmap))
>>>> +			continue;
>>>> +
>>>>    		clear_bit(secno, dirty_i->victim_secmap);
>>>>    		return GET_SEG_FROM_SEC(sbi, secno);
>>>>    	}
>>>> @@ -371,6 +375,9 @@ static int get_victim_by_default(struct f2fs_sb_in=
fo *sbi,
>>>>    		if (gc_type =3D=3D FG_GC && p.alloc_mode =3D=3D LFS &&
>>>>    					no_fggc_candidate(sbi, secno))
>>>>    			goto next;
>>>> +		if (gc_type =3D=3D FG_GC && p.alloc_mode =3D=3D LFS &&
>>>> +			sbi->gc_loop.segmap && test_bit(segno, sbi->gc_loop.segmap))
>>>> +			goto next;
>>>>    =

>>>>    		cost =3D get_gc_cost(sbi, segno, &p);
>>>>    =

>>>> @@ -1042,6 +1049,27 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>>    	seg_freed =3D do_garbage_collect(sbi, segno, &gc_list, gc_type);
>>>>    	if (gc_type =3D=3D FG_GC && seg_freed =3D=3D sbi->segs_per_sec)
>>>>    		sec_freed++;
>>>> +	else if (gc_type =3D=3D FG_GC && seg_freed =3D=3D 0) {
>>>> +		if (!sbi->gc_loop.segmap) {
>>>> +			sbi->gc_loop.segmap =3D
>>>> +				kvzalloc(f2fs_bitmap_size(MAIN_SEGS(sbi)), GFP_KERNEL);
>>>> +			sbi->gc_loop.count =3D 0;
>>>> +			sbi->gc_loop.segno =3D NULL_SEGNO;
>>>> +		}
>>>> +		if (segno =3D=3D sbi->gc_loop.segno) {
>>>> +			if (sbi->gc_loop.count > GC_LOOP_MAX) {
>>>> +				f2fs_bug_on(sbi, 1);
>>>> +				set_bit(segno, sbi->gc_loop.segmap);
>>>> +				sbi->gc_loop.count =3D 0;
>>>> +				sbi->gc_loop.segno =3D NULL_SEGNO;
>>>> +			}
>>>> +			else
>>>> +				sbi->gc_loop.count++;
>>>> +		} else {
>>>> +			sbi->gc_loop.segno =3D segno;
>>>> +			sbi->gc_loop.count =3D 0;
>>>> +		}
>>>> +	}
>>>>    	total_freed +=3D seg_freed;
>>>>    =

>>>>    	if (gc_type =3D=3D FG_GC)
>>>> @@ -1075,6 +1103,12 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>>    =

>>>>    	if (sync)
>>>>    		ret =3D sec_freed ? 0 : -EAGAIN;
>>>> +	if (sbi->gc_loop.segmap) {
>>>> +		kvfree(sbi->gc_loop.segmap);
>>>> +		sbi->gc_loop.segmap =3D NULL;
>>>> +		sbi->gc_loop.count =3D 0;
>>>> +		sbi->gc_loop.segno =3D NULL_SEGNO;
>>>> +	}
>>>>    	return ret;
>>>>    }
>>>>    =

>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>> index 031cb26..76f0b72 100644
>>>> --- a/fs/f2fs/super.c
>>>> +++ b/fs/f2fs/super.c
>>>> @@ -2562,6 +2562,9 @@ static int f2fs_fill_super(struct super_block *s=
b, void *data, int silent)
>>>>    	sbi->last_valid_block_count =3D sbi->total_valid_block_count;
>>>>    	sbi->reserved_blocks =3D 0;
>>>>    	sbi->current_reserved_blocks =3D 0;
>>>> +	sbi->gc_loop.segmap =3D NULL;
>>>> +	sbi->gc_loop.count =3D 0;
>>>> +	sbi->gc_loop.segno =3D NULL_SEGNO;
>>>>    =

>>>>    	for (i =3D 0; i < NR_INODE_TYPE; i++) {
>>>>    		INIT_LIST_HEAD(&sbi->inode_list[i]);
>>>>
>>> .
>>>
>
> .
>

-- =

Thanks,
Yunlong Song



---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
