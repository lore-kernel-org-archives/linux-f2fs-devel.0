From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v4 1/2] f2fs: fix to avoid broken of dnode block list
Date: Fri, 27 Jul 2018 19:55:03 +0800
Message-ID: <06ed02ea-aba0-a771-155a-fc000564f6c7@kernel.org>
References: <20180725111621.37564-1-yuchao0@huawei.com>
 <20180727100344.GD16155@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180727100344.GD16155@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/27 18:03, Jaegeuk Kim wrote:
> On 07/25, Chao Yu wrote:
>> f2fs recovery flow is relying on dnode block link list, it means fsynced
>> file recovery depends on previous dnode's persistence in the list, so
>> during fsync() we should wait on all regular inode's dnode writebacked
>> before issuing flush.
>>
>> By this way, we can avoid dnode block list being broken by out-of-order
>> IO submission due to IO scheduler or driver.
>>
>> Sheng Yong helps to do the test with this patch:
>>
>> Target:/data (f2fs, -)
>> 64MB / 32768KB / 4KB / 8
>>
>> 1 / PERSIST / Index
>>
>> Base:
>> 	SEQ-RD(MB/s)	SEQ-WR(MB/s)	RND-RD(IOPS)	RND-WR(IOPS)	Insert(TPS)	Update(TPS)	Delete(TPS)
>> 1	867.82		204.15		41440.03	41370.54	680.8		1025.94		1031.08
>> 2	871.87		205.87		41370.3		40275.2		791.14		1065.84		1101.7
>> 3	866.52		205.69		41795.67	40596.16	694.69		1037.16		1031.48
>> Avg	868.7366667	205.2366667	41535.33333	40747.3		722.21		1042.98		1054.753333
> 
> I merged it tho, do you know why SEQ-RD is much better?

I have no idea about what happened, this patch should only affect write path.
Let me and Sheng do one more round test to check the result.

> 
>> +void f2fs_reset_fsync_node_info(struct f2fs_sb_info *sbi)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&sbi->fsync_node_lock, flags);
>> +	sbi->fsync_node_num = 0;

I reviewed the patch again, and found that here it needs to update the code to
sbi->fsync_seg_id = 0; Let me send v5.

Thanks,
