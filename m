From: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: use crc ^ cp_ver instead of crc | cp_ver
 for recovery
Date: Thu, 1 Feb 2018 22:06:33 +0800
Message-ID: <b4337b94-3f9c-9e18-3fff-76d230db576c@huawei.com>
References: <9047C53C18267742AB12E43B65C7F9F70BCE5C21@dggemi505-mbx.china.huawei.com>
 <c3444561-9c65-97ce-4bf6-c7f16270d96a@kernel.org>
 <d93d629f-f24c-2e8d-51c0-5c7860d517c2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <d93d629f-f24c-2e8d-51c0-5c7860d517c2@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, heyunlei <heyunlei@huawei.com>, Gao Xiang <hsiangkao@aol.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net



On 2018/2/1 21:57, Gao Xiang wrote:
> Hi Chao,
> 
> On 2018/2/1 21:27, Chao Yu wrote:
>> Hi Xiang,
>>
>> On 2018/2/1 0:16, Gaoxiang (OS) wrote:
>>> This patch add a flag CP_CRC_RECOVERY_XOR_FLAG to use XORed crc ^ cp_ver
>>> since crc | cp_ver is more likely to get a collision or become 
>>> 11..1111 | cp_ver.
>>
>> FYI, we have discussed about this before:
>>
>> https://patchwork.kernel.org/patch/9342639/
>>
>> At that time, cp_ver will always be initialized with 1, so there is 
>> almost a
>> little chance to use high 32 bits, result in less collision, so I 
>> think it
>> will be OK.
>>
>> But now, cp_ver will be initialized with a random 64 bits value, then the
>> collision will be increased, I agree that xor method will be better, 
>> but I'm
>> not sure we should use this, since layout change makes complicated 
>> handling
>> in codes for back compatibility.
>>
>> And do you encounter any incorrect recovery, or is there any following 
>> feature
>> rely on this?
> 



> No... I just looked at node_footer because of another work and saw this 
> part of code by chance.
> I think XOR-ed calculation is much better in mathematics, and typical 
> method for mixing two values (eg. XOR encryption) is also XOR-ed 
> calculation rather than OR-ed...
> 
> Thanks,
> 

BTW,
"The crc is already random enough, but has 32bits only.
The cp_ver is not easy to use over 32bits, so we don't need to keep the 
other
32bits untouched in most of life."

I observe cp_ver(if the high 32 bits are 0) ^ crc == cp_ver | crc, but
if cp_ver is over 32bits, ...

...hmmm...

Thanks,

>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>> ---
>>>   fs/f2fs/checkpoint.c    |  4 ++--
>>>   fs/f2fs/node.h          | 16 +++++++++++-----
>>>   fs/f2fs/segment.c       |  3 ++-
>>>   include/linux/f2fs_fs.h |  1 +
>>>   4 files changed, 16 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index 8b0945b..9e7e63b 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -1157,8 +1157,8 @@ static void update_ckpt_flags(struct 
>>> f2fs_sb_info *sbi, struct cp_control *cpc)
>>>       if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
>>>           __set_ckpt_flags(ckpt, CP_FSCK_FLAG);
>>> -    /* set this flag to activate crc|cp_ver for recovery */
>>> -    __set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG);
>>> +    /* set this flag to activate crc^cp_ver for recovery */
>>> +    __set_ckpt_flags(ckpt, CP_CRC_RECOVERY_XOR_FLAG);
>>>       __clear_ckpt_flags(ckpt, CP_NOCRC_RECOVERY_FLAG);
>>>       spin_unlock_irqrestore(&sbi->cp_lock, flags);
>>> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
>>> index 081ef0d..7b9489f 100644
>>> --- a/fs/f2fs/node.h
>>> +++ b/fs/f2fs/node.h
>>> @@ -293,8 +293,11 @@ static inline void 
>>> fill_node_footer_blkaddr(struct page *page, block_t blkaddr)
>>>       struct f2fs_node *rn = F2FS_NODE(page);
>>>       __u64 cp_ver = cur_cp_version(ckpt);
>>> -    if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
>>> -        cp_ver |= (cur_cp_crc(ckpt) << 32);
>>> +    if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_XOR_FLAG))
>>> +        cp_ver ^= cur_cp_crc(ckpt) << 32;
>>> +    /* for backward compatibility */
>>> +    else if (unlikely(__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG)))
>>> +        cp_ver |= cur_cp_crc(ckpt) << 32;
>>>       rn->footer.cp_ver = cpu_to_le64(cp_ver);
>>>       rn->footer.next_blkaddr = cpu_to_le32(blkaddr);
>>> @@ -307,10 +310,13 @@ static inline bool is_recoverable_dnode(struct 
>>> page *page)
>>>       /* Don't care crc part, if fsck.f2fs sets it. */
>>>       if (__is_set_ckpt_flags(ckpt, CP_NOCRC_RECOVERY_FLAG))
>>> -        return (cp_ver << 32) == (cpver_of_node(page) << 32);
>>> +        return (__u32)cp_ver == (__u32)cpver_of_node(page);
>>> -    if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
>>> -        cp_ver |= (cur_cp_crc(ckpt) << 32);
>>> +    if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_XOR_FLAG))
>>> +        cp_ver ^= cur_cp_crc(ckpt) << 32;
>>> +    /* for backward compatibility */
>>> +    else if (unlikely(__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG)))
>>> +        cp_ver |= cur_cp_crc(ckpt) << 32;
>>>       return cp_ver == cpver_of_node(page);
>>>   }
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 205b0d9..64d0c1f 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -2316,7 +2316,8 @@ static void allocate_segment_by_default(struct 
>>> f2fs_sb_info *sbi,
>>>       if (force)
>>>           new_curseg(sbi, type, true);
>>> -    else if (!is_set_ckpt_flags(sbi, CP_CRC_RECOVERY_FLAG) &&
>>> +    else if (!(is_set_ckpt_flags(sbi, CP_CRC_RECOVERY_FLAG) ||
>>> +        is_set_ckpt_flags(sbi, CP_CRC_RECOVERY_XOR_FLAG)) &&
>>>                       type == CURSEG_WARM_NODE)
>>>           new_curseg(sbi, type, false);
>>>       else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, 
>>> type))
>>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>>> index f7f0990..07ddf4b 100644
>>> --- a/include/linux/f2fs_fs.h
>>> +++ b/include/linux/f2fs_fs.h
>>> @@ -117,6 +117,7 @@ struct f2fs_super_block {
>>>   /*
>>>    * For checkpoint
>>>    */
>>> +#define CP_CRC_RECOVERY_XOR_FLAG    0x00000800
>>>   #define CP_LARGE_NAT_BITMAP_FLAG    0x00000400
>>>   #define CP_NOCRC_RECOVERY_FLAG    0x00000200
>>>   #define CP_TRIMMED_FLAG        0x00000100
>>>
