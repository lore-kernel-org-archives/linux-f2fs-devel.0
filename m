From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: check segment type before recover data
Date: Thu, 4 Jan 2018 09:38:02 +0800
Message-ID: <d392d1e0-87b6-2854-a3ea-48eda239ea2f@huawei.com>
References: <1514619768-134531-1-git-send-email-yunlong.song@huawei.com>
 <c57a26c9-da62-ca5c-b5a3-873d4f1f9ded@huawei.com>
 <83433157-6a26-07f8-0d36-dc16af6a7754@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <83433157-6a26-07f8-0d36-dc16af6a7754@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/1/2 19:02, Yunlong Song wrote:
> 
> 
> On 2018/1/2 14:49, Chao Yu wrote:
>> On 2017/12/30 15:42, Yunlong Song wrote:
>>> In some case, the node blocks has wrong blkaddr whose segment type is
>> You mean *data block* has wrong blkaddr whose segment type is NODE?
> Yes.
>>
>>> NODE, e.g., recover inode has missing xattr flag and the blkaddr is in
>>> the xattr range. Since fsck.f2fs does not check the recovery nodes, this
>>> will cause __f2fs_replace_block change the curseg of node and do the
>>> update_sit_entry(sbi, new_blkaddr, 1) with no next_blkoff refresh, as a
>> Do you mean the root cause is that __f2fs_replace_block didn't update
>> next_blkoff?
> No, it's not the root cause. The root cause may be something like DDR flip.
>>
>>> result, when recovery process write checkpoint and sync nodes, the
>>> next_blkoff of curseg is used in the segment bit map, then it will
>>> cause f2fs_bug_on. So let's check the segment type before recover data,
>>> and stop recover if it is not in DATA segment.
>> Sorry, I can't catch the whole cause and effect from you description, if
>> possible, could you give an example?
> For example, the i_inline flag has F2FS_INLINE_XATTR, and the last 50 
> i_addrs have xattr
> context. But if DDR flips, the i_inline flag may miss F2FS_INLINE_XATTR, 
> and the last 50 i_addrs
> are considered as data block addr. If the xattr context is 0x1234, and 
> 0x1234 happens to be
> a valid block addr, and the block 0x1234 happens to be in a warm node 
> segment. Then do_recover_data
> will call f2fs_replace_block() with dest = 0x1234, which will change 
> curseg of warm node to
> 0x1234's segment, and make update_sit_entry(sbi, 0x1234, 1), the 
> curseg->next_blkoff also
> points to 0x1234's offset in its segment. When recovery process calls 
> write_checkpoint, sync
> nodes will write to 0x1234's offset of curseg warm node. The 
> update_sit_entry will check that
> offset and find the bitmap is already set to 1 and then calls f2fs_bug_on.

Got you, thanks for the explanation. IMO, for better debug, what about
adding f2fs_bug_on here to detect both software and hardware defect in
upstream code? In production, I think you can use your original implementation.

Thanks,

> 
>>
>> Thanks,
>>
>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>> ---
>>>   fs/f2fs/recovery.c | 3 ++-
>>>   fs/f2fs/segment.h  | 3 +++
>>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>> index 7d63faf..e8fee4a 100644
>>> --- a/fs/f2fs/recovery.c
>>> +++ b/fs/f2fs/recovery.c
>>> @@ -478,7 +478,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>>>   		}
>>>   
>>>   		/* dest is valid block, try to recover from src to dest */
>>> -		if (is_valid_blkaddr(sbi, dest, META_POR)) {
>>> +		if (is_valid_blkaddr(sbi, dest, META_POR) &&
>>> +			is_data_blkaddr(sbi, dest)) {
>>>   
>>>   			if (src == NULL_ADDR) {
>>>   				err = reserve_new_block(&dn);
>>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>>> index 71a2aaa..5c5a215 100644
>>> --- a/fs/f2fs/segment.h
>>> +++ b/fs/f2fs/segment.h
>>> @@ -115,6 +115,9 @@
>>>   #define SECTOR_TO_BLOCK(sectors)					\
>>>   	((sectors) >> F2FS_LOG_SECTORS_PER_BLOCK)
>>>   
>>> +#define is_data_blkaddr(sbi, blkaddr)	\
>>> +	(IS_DATASEG(get_seg_entry(sbi, GET_SEGNO(sbi, blkaddr))->type))
>>> +
>>>   /*
>>>    * indicate a block allocation direction: RIGHT and LEFT.
>>>    * RIGHT means allocating new sections towards the end of volume.
>>>
>>
>> .
>>
> 
