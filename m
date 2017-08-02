From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: update cur_valid_map_mir together with
 cur_valid_map
Date: Wed, 2 Aug 2017 17:00:13 +0800
Message-ID: <4983e1e3-2dea-89c0-8c48-688691e3a0cd@huawei.com>
References: <1501574206-150946-1-git-send-email-yunlong.song@huawei.com>
 <d04ca5c3-f38f-fe48-a073-243e49bc243c@kernel.org>
 <c1935af.77af.15d9ebd35e3.Coremail.sylinux@163.com>
 <8be82ea4-db80-8f87-9029-e63d2926f7d1@huawei.com>
 <7e8346ed-8484-2ab9-85a1-03d232b16865@huawei.com>
 <3cbec840-a4ee-7d93-6b02-8f8f1483b7f6@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3cbec840-a4ee-7d93-6b02-8f8f1483b7f6@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, Yunlong Song <sylinux@163.com>, Chao Yu <chao@kernel.org>
Cc: jaegeuk <jaegeuk@kernel.org>, miaoxie <miaoxie@huawei.com>, "bintian.wang" <bintian.wang@huawei.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Agree, it's safe to bug_on or readonly to protect data. This patch is fine.

On 2017/8/2 16:47, Chao Yu wrote:
> Hi Yunlong,
>
> On 2017/8/2 16:02, Yunlong Song wrote:
>> Hi Chao,
>>       For the memory overflow or cache bit-transition case, when CHECK_FS
>> is on, should f2fs
>> enter panic or just provide WARNing information? I prefer WARNing,
>> because it is not f2fs's
>> fault, f2fs does not need to pay for it, why not use WARN_ON instead?
> Actually, if that happens, I think both original and mirror bitmap datas are not
> trustable, it's harmful to continue to trigger write IOs based on those bitmap
> datas. So IMO, it would be better to trigger bug_on.
>
> At least, if only warning is showed, we'd better to turn f2fs to readonly and
> fail current write IO.
>
> Thanks,
>
>> On 2017/8/2 9:34, Chao Yu wrote:
>>> Hi Yunlong,
>>>
>>> On 2017/8/2 0:59, Yunlong Song wrote:
>>>> Hi Chao,
>>>>       I think there is no need to test mirror bitmap when original bitmap's check
>>>> get passed, it is an instruction waste for "test". By the way, previous patch
>>>> uses WARN to skip trigger panic when the memory is flipped, I think it is proper
>>>> to not trigger panic in this situation, because it is not code bug at all in
>>>> such case.
>>> Original idea is trying to use bitmap mirror to detect bitmap corruption caused
>>> by memory overflow or bit-transition of cache.
>>>
>>> So if we encounter inconsistency in between original bitmap and mirror bitmap,
>>> there may be memory overflow or cache bit-transition, we need to detect that;
>>> another case is that both bitmap is consistent, but we are trying to reuse valid
>>> block address or free invalid block address, indeed that is a bug.
>>>
>>> Below modification can cover above two cases, which make original idea of
>>> introducing mirror bitmap check working correctly.
>>>
>>> Thanks,
>>>
>>>> On 08/01/2017 23:44, Chao Yu <mailto:chao@kernel.org> wrote:
>>>>
>>>>       Hi Yunlong,
>>>>
>>>>       How about checking consistence in between original and mirror bitmap all
>>>>       the time as below?
>>>>
>>>>       ---
>>>>       fs/f2fs/segment.c | 41 +++++++++++++++++++++++++++--------------
>>>>       1 file changed, 27 insertions(+), 14 deletions(-)
>>>>
>>>>       diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>       index a26c24dae70c..f32a19cf486a 100644
>>>>       --- a/fs/f2fs/segment.c
>>>>       +++ b/fs/f2fs/segment.c
>>>>       @@ -1510,6 +1510,7 @@ static void update_sit_entry(struct f2fs_sb_info *sbi,
>>>>       block_t blkaddr, int del)
>>>>          struct seg_entry *se;
>>>>          unsigned int segno, offset;
>>>>          long int new_vblocks;
>>>>       +    bool exist, mir_exist;
>>>>
>>>>          segno = GET_SEGNO(sbi, blkaddr);
>>>>
>>>>       @@ -1526,17 +1527,23 @@ static void update_sit_entry(struct f2fs_sb_info
>>>>       *sbi, block_t blkaddr, int del)
>>>>
>>>>          /* Update valid block bitmap */
>>>>          if (del > 0) {
>>>>       -        if (f2fs_test_and_set_bit(offset, se->cur_valid_map)) {
>>>>       +        exist = f2fs_test_and_set_bit(offset, se->cur_valid_map);
>>>>       #ifdef CONFIG_F2FS_CHECK_FS
>>>>       -            if (f2fs_test_and_set_bit(offset,
>>>>       -                        se->cur_valid_map_mir))
>>>>       -                f2fs_bug_on(sbi, 1);
>>>>       -            else
>>>>       -                WARN_ON(1);
>>>>       -#else
>>>>       +        mir_exist = f2fs_test_and_set_bit(offset,
>>>>       +                        se->cur_valid_map_mir);
>>>>       +        if (exist != mir_exist) {
>>>>       +            f2fs_msg(sbi->sb, KERN_ERR, "Inconsistent error "
>>>>       +                "when setting bitmap, blk:%u, old bit:%d",
>>>>       +                blkaddr, exist);
>>>>                  f2fs_bug_on(sbi, 1);
>>>>       +        }
>>>>       #endif
>>>>       +        if (exist) {
>>>>       +            f2fs_msg(sbi->sb, KERN_ERR,
>>>>       +                "Bitmap was set, blk:%u", blkaddr);
>>>>       +            f2fs_bug_on(sbi, 1);
>>>>              }
>>>>       +
>>>>              if (f2fs_discard_en(sbi) &&
>>>>                  !f2fs_test_and_set_bit(offset, se->discard_map))
>>>>                  sbi->discard_blks--;
>>>>       @@ -1547,17 +1554,23 @@ static void update_sit_entry(struct f2fs_sb_info
>>>>       *sbi, block_t blkaddr, int del)
>>>>                      se->ckpt_valid_blocks++;
>>>>              }
>>>>          } else {
>>>>       -        if (!f2fs_test_and_clear_bit(offset, se->cur_valid_map)) {
>>>>       +        exist = f2fs_test_and_clear_bit(offset, se->cur_valid_map);
>>>>       #ifdef CONFIG_F2FS_CHECK_FS
>>>>       -            if (!f2fs_test_and_clear_bit(offset,
>>>>       -                        se->cur_valid_map_mir))
>>>>       -                f2fs_bug_on(sbi, 1);
>>>>       -            else
>>>>       -                WARN_ON(1);
>>>>       -#else
>>>>       +        mir_exist = f2fs_test_and_clear_bit(offset,
>>>>       +                        se->cur_valid_map_mir);
>>>>       +        if (exist != mir_exist) {
>>>>       +            f2fs_msg(sbi->sb, KERN_ERR, "Inconsistent error "
>>>>       +                "when clearing bitmap, blk:%u, old bit:%d",
>>>>       +                blkaddr, exist);
>>>>                  f2fs_bug_on(sbi, 1);
>>>>       +        }
>>>>       #endif
>>>>       +        if (!exist) {
>>>>       +            f2fs_msg(sbi->sb, KERN_ERR,
>>>>       +                "Bitmap was cleared, blk:%u", blkaddr);
>>>>       +            f2fs_bug_on(sbi, 1);
>>>>              }
>>>>       +
>>>>              if (f2fs_discard_en(sbi) &&
>>>>                  f2fs_test_and_clear_bit(offset, se->discard_map))
>>>>                  sbi->discard_blks++;
>>>>       --
>>>>       2.13.0.90.g1eb437020
>>>>
>>>>       On 2017/8/1 15:56, Yunlong Song wrote:
>>>>       > When cur_valid_map passes the f2fs_test_and_set(,clear)_bit test,
>>>>       > cur_valid_map_mir update is skipped unlikely, so fix it.
>>>>       >
>>>>       > Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>>       > ---
>>>>       >  fs/f2fs/segment.c | 8 ++++++++
>>>>       >  1 file changed, 8 insertions(+)
>>>>       >
>>>>       > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>       > index 151968e..6f7731a 100644
>>>>       > --- a/fs/f2fs/segment.c
>>>>       > +++ b/fs/f2fs/segment.c
>>>>       > @@ -1535,6 +1535,10 @@ static void update_sit_entry(struct f2fs_sb_info
>>>>       *sbi, block_t blkaddr, int del)
>>>>       >              f2fs_bug_on(sbi, 1);
>>>>       >  #endif
>>>>       >          }
>>>>       > +#ifdef CONFIG_F2FS_CHECK_FS
>>>>       > +        else
>>>>       > +            f2fs_set_bit(offset, se->cur_valid_map_mir);
>>>>       > +#endif
>>>>       >          if (f2fs_discard_en(sbi) &&
>>>>       >              !f2fs_test_and_set_bit(offset, se->discard_map))
>>>>       >              sbi->discard_blks--;
>>>>       > @@ -1556,6 +1560,10 @@ static void update_sit_entry(struct f2fs_sb_info
>>>>       *sbi, block_t blkaddr, int del)
>>>>       >              f2fs_bug_on(sbi, 1);
>>>>       >  #endif
>>>>       >          }
>>>>       > +#ifdef CONFIG_F2FS_CHECK_FS
>>>>       > +        else
>>>>       > +            f2fs_clear_bit(offset, se->cur_valid_map_mir);
>>>>       > +#endif
>>>>       >          if (f2fs_discard_en(sbi) &&
>>>>       >              f2fs_test_and_clear_bit(offset, se->discard_map))
>>>>       >              sbi->discard_blks++;
>>>>       >
>>>>
>>> .
>>>
>
> .
>

-- 
Thanks,
Yunlong Song
