From: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: ratelimit recovery messages
Date: Tue, 28 May 2019 11:30:58 +0800
Message-ID: <b5665201-d13d-5fcb-100d-21630960e5f1@huawei.com>
References: <1558962655-25994-1-git-send-email-stummala@codeaurora.org>
 <94025a6d-f485-3811-5521-ed5c9b4d1d77@huawei.com>
 <20190528030509.GE10043@codeaurora.org>
 <2575bd54-d67c-6b26-ebf7-d6adb2e193a7@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2575bd54-d67c-6b26-ebf7-d6adb2e193a7@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Sahitya,

On 2019/5/28 11:17, Chao Yu wrote:
> Hi Sahitya,
> 
> On 2019/5/28 11:05, Sahitya Tummala wrote:
>> Hi Chao,
>>
>> On Tue, May 28, 2019 at 09:23:15AM +0800, Chao Yu wrote:
>>> Hi Sahitya,
>>>
>>> On 2019/5/27 21:10, Sahitya Tummala wrote:
>>>> Ratelimit the recovery logs, which are expected in case
>>>> of sudden power down and which could result into too
>>>> many prints.
>>>
>>> FYI
>>>
>>> https://lore.kernel.org/patchwork/patch/973837/
>>>
>>> IMO, we need those logs to provide evidence during trouble-shooting of file data
>>> corruption or file missing problem...
>>>
>> In one of the logs, I have noticed there were ~400 recovery prints in the
> 
> I think its order of magnitudes is not such bad, if there is redundant logs such
> as the one in do_recover_data(), we can improve it.
> 
>> kernel bootup. I noticed your patch above and with that now we can always get
>> the error returned by f2fs_recover_fsync_data(), which should be good enough
>> for knowing the status of recovered files I thought. Do you think we need
>> individually each file status as well?
> 
> Yes, I think so, we need them for the detailed info. :)

I personally agree with Chao's suggestion as well.

Sometimes huawei got stuck into rare potential f2fs stability issues,
which is hard to say whether it is a clearly hardware or software issues.

These messages is used as some evidences for us to guess what happened.
it'd better to handle carefully...

Thanks,
Gao Xiang

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>> So I suggest we can keep log as it is in recover_dentry/recover_inode, and for
>>> the log in do_recover_data, we can record recovery info [isize_kept,
>>> recovered_count, err ...] into struct fsync_inode_entry, and print them in
>>> batch, how do you think?
>>>
>>> Thanks,
>>>
>>>>
>>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>>> ---
>>>> v2:
>>>>  - fix minor formatting and add new line for printk
>>>>
>>>>  fs/f2fs/recovery.c | 18 +++++++++---------
>>>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>>> index e04f82b..60d7652 100644
>>>> --- a/fs/f2fs/recovery.c
>>>> +++ b/fs/f2fs/recovery.c
>>>> @@ -188,8 +188,8 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
>>>>  		name = "<encrypted>";
>>>>  	else
>>>>  		name = raw_inode->i_name;
>>>> -	f2fs_msg(inode->i_sb, KERN_NOTICE,
>>>> -			"%s: ino = %x, name = %s, dir = %lx, err = %d",
>>>> +	printk_ratelimited(KERN_NOTICE
>>>> +			"%s: ino = %x, name = %s, dir = %lx, err = %d\n",
>>>>  			__func__, ino_of_node(ipage), name,
>>>>  			IS_ERR(dir) ? 0 : dir->i_ino, err);
>>>>  	return err;
>>>> @@ -292,8 +292,8 @@ static int recover_inode(struct inode *inode, struct page *page)
>>>>  	else
>>>>  		name = F2FS_INODE(page)->i_name;
>>>>  
>>>> -	f2fs_msg(inode->i_sb, KERN_NOTICE,
>>>> -		"recover_inode: ino = %x, name = %s, inline = %x",
>>>> +	printk_ratelimited(KERN_NOTICE
>>>> +			"recover_inode: ino = %x, name = %s, inline = %x\n",
>>>>  			ino_of_node(page), name, raw->i_inline);
>>>>  	return 0;
>>>>  }
>>>> @@ -642,11 +642,11 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>>>>  err:
>>>>  	f2fs_put_dnode(&dn);
>>>>  out:
>>>> -	f2fs_msg(sbi->sb, KERN_NOTICE,
>>>> -		"recover_data: ino = %lx (i_size: %s) recovered = %d, err = %d",
>>>> -		inode->i_ino,
>>>> -		file_keep_isize(inode) ? "keep" : "recover",
>>>> -		recovered, err);
>>>> +	printk_ratelimited(KERN_NOTICE
>>>> +			"recover_data: ino = %lx (i_size: %s) recovered = %d, err = %d\n",
>>>> +			inode->i_ino,
>>>> +			file_keep_isize(inode) ? "keep" : "recover",
>>>> +			recovered, err);
>>>>  	return err;
>>>>  }
>>>>  
>>>>
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
