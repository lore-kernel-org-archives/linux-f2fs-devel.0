From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: expose some sectors to user in inline data or
 dentry case
Date: Wed, 18 Oct 2017 10:32:17 +0800
Message-ID: <4e39c0c5-2cfb-5dd5-4c29-5bff7b2373f8@huawei.com>
References: <20171013173145.36510-1-jaegeuk@kernel.org>
 <6ecc1778-bcf8-c07d-037a-dd733e247fa9@huawei.com>
 <20171017220327.GA20428@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171017220327.GA20428@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/10/18 6:03, Jaegeuk Kim wrote:
> On 10/16, Chao Yu wrote:
>> On 2017/10/14 1:31, Jaegeuk Kim wrote:
>>> If there's some data written through inline data or dentry, we need to shouw
>>> st_blocks. This fixes reporting zero blocks even though there is small written
>>> data.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> Thanks,
>>
>>> ---
>>>  fs/f2fs/file.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 2eb3efe92018..f7be6c394fa8 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -698,6 +698,11 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
>>>  				  STATX_ATTR_NODUMP);
>>>  
>>>  	generic_fillattr(inode, stat);
>>> +
>>> +	/* we need to show initial sectors used for inline_data/dentries */
>>> +	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
> 
> FYI;
> I added S_ISREG(inode->i_mode) with f2fs_has_inline_data() to avoid quotacheck
> error.

If this patch is related to quotacheck issue, I doubt that there will be
problemetic, in no journalled quota case, fs quota system won't stat blocks
in inline file, however, after SPO, when using quotacheck to scan file to
recover quota info, blocks of inline file showed in getattr can be stated
into quota. That would be inconsistent.

Thanks,

> 
>>> +		stat->blocks += (stat->size + 511) >> 9;
>>> +
>>>  	return 0;
>>>  }
>>>  
>>>
> 
> .
> 
