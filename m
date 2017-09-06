From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix wrong bfree and bavail
Date: Wed, 6 Sep 2017 11:19:34 +0800
Message-ID: <58ffa17c-286a-a7e6-8cf8-7213bfe2acf7@huawei.com>
References: <20170905210653.46186-1-jaegeuk@kernel.org>
 <a6954033-c98a-44e9-69ce-d1416aa64640@huawei.com>
 <20170906031028.GA61332@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170906031028.GA61332@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/9/6 11:10, Jaegeuk Kim wrote:
> On 09/06, Chao Yu wrote:
>> On 2017/9/6 5:06, Jaegeuk Kim wrote:
>>> This patch fixes bavail and bfree finally.
>>>
>>> long    f_bfree;    /* free blocks in fs */
>>> long    f_bavail;   /* free blocks avail to non-superuser */
>>>
>>> So, bfree represents all the reserved blocks, while bavail does the space only
>>> visible to normal user.
>>>
>>> Fix: 3e6d0b4d9c1c ("f2fs: fix incorrect f_bfree calculation in ->statfs")
>>> Cc: <stable@vger.kernel.org> # 4.8+
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/super.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 7e29db227910..17cca4cb93af 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -955,8 +955,8 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>>  	buf->f_bsize = sbi->blocksize;
>>>  
>>>  	buf->f_blocks = total_count - start_count;
>>> -	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
>>> -	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
>>> +	buf->f_bfree = user_block_count - valid_user_blocks(sbi);
>>> +	buf->f_bavail = user_block_count - valid_user_blocks(sbi) - ovp_count -
>>
>> 	set_cp(user_block_count, ((get_cp(free_segment_count) + 6 -
>> 			get_cp(overprov_segment_count)) * c.blks_per_seg));
>>
>> As we calculated in mkfs, we have removed ovp_count in user_block_count, so
>> shouldn't we add ovp_count for f_bfree here?
> 
> Hehe, I already dropped this. :P

Alright. :)

> It seems like something wrong with df in android.

Maybe its version is too old?

Thanks,

> 
>>
>> Thanks,
>>
>>>  						sbi->reserved_blocks;
>>>  
>>>  	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
>>>
> 
> .
> 
