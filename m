From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: change the codes of checking CP_CRC_RECOVERY_FLAG
 to macro
Date: Fri, 24 Feb 2017 19:57:52 +0800
Message-ID: <58B01FC0.8060901@huawei.com>
References: <1487930771-14491-1-git-send-email-yunlong.song@huawei.com>
 <096f8d0b-774c-2065-db96-dde455a4ec53@huawei.com>
 <58B014FC.6090308@huawei.com>
 <3e2f166f-e532-a04b-d8dd-6b21d7243bc4@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3e2f166f-e532-a04b-d8dd-6b21d7243bc4@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org, cm224.lee@samsung.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com
Cc: bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/2/24 19:37, Chao Yu wrote:
> On 2017/2/24 19:11, Yunlong Song wrote:
>> I think we do not need to care about the CP_CRC_RECOVERY_FLAG status of old image, I mean we
>> do not need to check the already-been-written node footer in the image, what we care about is the
>> on-going-to-write node footer, which is used for recovery.
>>
>> If  CP_CRC_RECOVERY_FLAG is defined, then __set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG); is
>> executed in each do_checkpoint actually, and CP will have that flag for each on-going-to-write node footer.
>> I think the recovery process only needs to use the on-going-to-write node rather than the already-been-written
>> node in the old image. The  already-been-written node in the old image should not appear in the node
>> chain of recovery process, right?
> Previously, we changed the disk layout of footer in node block, and then we
> applied new verifying approach which has better reliability in order to avoid
> chaining garbage node block.
>
> In order to distinguish old disk layout and the new one, we introduce
> CP_CRC_RECOVERY_FLAG, once a CP is triggered, we will tag current CP with the
> flag, and use new disk layout and new verifying approach for the following node
> block updating flow and abnormal power-cut recovery flow.
>
> For old image which has no CP_CRC_RECOVERY_FLAG flag been set, f2fs needs to use
> old disk layout and old verifying approach during recovery for the
> compatibility. So that's why we need to check the flag in CP here.

For the old disk layout, because we still use new approach to set CP_CRC_RECOVERY_FLAG in the node footer in each do_checkpoint,
then I think f2fs should also use new verifying approach during recovery rather than old verifying approach. What is the problem if
we do like this?

> Thanks,
>
>> On 2017/2/24 18:29, Chao Yu wrote:
>>> On 2017/2/24 18:06, Yunlong Song wrote:
>>>> No need to check the "if" condition each time, just change it to macro codes.
>>> We're going to check flag in CP, not just in code of f2fs.
>>>
>>> Thanks,
>>>
>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>> ---
>>>>  fs/f2fs/node.h    | 20 ++++++++++----------
>>>>  fs/f2fs/segment.c |  5 +++--
>>>>  2 files changed, 13 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
>>>> index 3fc9c4b..3e5a58b 100644
>>>> --- a/fs/f2fs/node.h
>>>> +++ b/fs/f2fs/node.h
>>>> @@ -303,11 +303,11 @@ static inline void fill_node_footer_blkaddr(struct page *page, block_t blkaddr)
>>>>  	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
>>>>  	__u64 cp_ver = le64_to_cpu(ckpt->checkpoint_ver);
>>>>  
>>>> -	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG)) {
>>>> -		__u64 crc = le32_to_cpu(*((__le32 *)
>>>> -				((unsigned char *)ckpt + crc_offset)));
>>>> -		cp_ver |= (crc << 32);
>>>> -	}
>>>> +#ifdef CP_CRC_RECOVERY_FLAG
>>>> +	__u64 crc = le32_to_cpu(*((__le32 *)
>>>> +			((unsigned char *)ckpt + crc_offset)));
>>>> +	cp_ver |= (crc << 32);
>>>> +#endif
>>>>  	rn->footer.cp_ver = cpu_to_le64(cp_ver);
>>>>  	rn->footer.next_blkaddr = cpu_to_le32(blkaddr);
>>>>  }
>>>> @@ -318,11 +318,11 @@ static inline bool is_recoverable_dnode(struct page *page)
>>>>  	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
>>>>  	__u64 cp_ver = cur_cp_version(ckpt);
>>>>  
>>>> -	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG)) {
>>>> -		__u64 crc = le32_to_cpu(*((__le32 *)
>>>> -				((unsigned char *)ckpt + crc_offset)));
>>>> -		cp_ver |= (crc << 32);
>>>> -	}
>>>> +#ifdef CP_CRC_RECOVERY_FLAG
>>>> +	__u64 crc = le32_to_cpu(*((__le32 *)
>>>> +			((unsigned char *)ckpt + crc_offset)));
>>>> +	cp_ver |= (crc << 32);
>>>> +#endif
>>>>  	return cp_ver == cpver_of_node(page);
>>>>  }
>>>>  
>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>> index 9eb6d89..6c2e1ee 100644
>>>> --- a/fs/f2fs/segment.c
>>>> +++ b/fs/f2fs/segment.c
>>>> @@ -1573,9 +1573,10 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
>>>>  {
>>>>  	if (force)
>>>>  		new_curseg(sbi, type, true);
>>>> -	else if (!is_set_ckpt_flags(sbi, CP_CRC_RECOVERY_FLAG) &&
>>>> -					type == CURSEG_WARM_NODE)
>>>> +#ifndef CP_CRC_RECOVERY_FLAG
>>>> +	else if (type == CURSEG_WARM_NODE)
>>>>  		new_curseg(sbi, type, false);
>>>> +#endif
>>>>  	else if (need_SSR(sbi) && get_ssr_segment(sbi, type))
>>>>  		change_curseg(sbi, type, true);
>>>>  	else
>>>>
>>> .
>>>
>>
>
> .
>


-- 
Thanks,
Yunlong Song
