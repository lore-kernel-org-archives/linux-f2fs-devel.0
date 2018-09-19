From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: report ENOENT correct in f2fs_rename
Date: Wed, 19 Sep 2018 09:48:45 +0800
Message-ID: <b791b223-e962-773c-3876-7fd7773df886@huawei.com>
References: <20180918021805.85032-1-jaegeuk@kernel.org>
 <f2d06f89-4f84-8492-eeea-e1c07e5104c3@kernel.org>
 <20180918175936.GF91945@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918175936.GF91945@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/19 1:59, Jaegeuk Kim wrote:
> On 09/18, Chao Yu wrote:
>> On 2018/9/18 10:18, Jaegeuk Kim wrote:
>>> This fixes wrong error report in f2fs_rename.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/namei.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>>> index 98d3ab7c3ce6..d653be777529 100644
>>> --- a/fs/f2fs/namei.c
>>> +++ b/fs/f2fs/namei.c
>>> @@ -833,7 +833,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>>>  	struct f2fs_dir_entry *old_entry;
>>>  	struct f2fs_dir_entry *new_entry;
>>>  	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
>>> -	int err = -ENOENT;
>>> +	int err;
>>>  
>>>  	if (unlikely(f2fs_cp_error(sbi)))
>>>  		return -EIO;
>>> @@ -854,6 +854,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>>>  	if (err)
>>>  		goto out;
>>>  
>>> +	err = -ENOENT;
>>
>> I didn't get what's the difference after moving initialization of 'err' here...
> 
> One example,
> 
>         old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
>         if (!old_entry) {
>                 if (IS_ERR(old_page))
>                         err = PTR_ERR(old_page);
> 
> --> need to return ENOENT instead of 0.

Clear for me now, thanks for your explanation, I just miss that case. ;)

It would be better to add this into commit log.

I agree with Sahitya, we need to cover rename2 as well.

Thanks,

> 
>                 goto out;
>         }
> 
>>
>> Thanks,
>>
>>>  	if (new_inode) {
>>>  		err = dquot_initialize(new_inode);
>>>  		if (err)
>>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
