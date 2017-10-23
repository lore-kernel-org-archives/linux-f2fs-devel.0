From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: expose some sectors to user in inline
 data or dentry case
Date: Mon, 23 Oct 2017 18:11:36 +0800
Message-ID: <c7307af7-8d04-e19e-bb21-76617d66678c@kernel.org>
References: <20171013173145.36510-1-jaegeuk@kernel.org>
 <6ecc1778-bcf8-c07d-037a-dd733e247fa9@huawei.com>
 <20171017220327.GA20428@jaegeuk-macbookpro.roam.corp.google.com>
 <4e39c0c5-2cfb-5dd5-4c29-5bff7b2373f8@huawei.com>
 <20171019191229.GC82186@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e6Zi0-0003tQ-0J
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Oct 2017 10:11:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e6Zhy-0001rz-R2
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Oct 2017 10:11:47 +0000
In-Reply-To: <20171019191229.GC82186@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/20 3:12, Jaegeuk Kim wrote:
> On 10/18, Chao Yu wrote:
>> On 2017/10/18 6:03, Jaegeuk Kim wrote:
>>> On 10/16, Chao Yu wrote:
>>>> On 2017/10/14 1:31, Jaegeuk Kim wrote:
>>>>> If there's some data written through inline data or dentry, we need to shouw
>>>>> st_blocks. This fixes reporting zero blocks even though there is small written
>>>>> data.
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>
>>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>>
>>>> Thanks,
>>>>
>>>>> ---
>>>>>  fs/f2fs/file.c | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>> index 2eb3efe92018..f7be6c394fa8 100644
>>>>> --- a/fs/f2fs/file.c
>>>>> +++ b/fs/f2fs/file.c
>>>>> @@ -698,6 +698,11 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
>>>>>  				  STATX_ATTR_NODUMP);
>>>>>  
>>>>>  	generic_fillattr(inode, stat);
>>>>> +
>>>>> +	/* we need to show initial sectors used for inline_data/dentries */
>>>>> +	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
>>>
>>> FYI;
>>> I added S_ISREG(inode->i_mode) with f2fs_has_inline_data() to avoid quotacheck
>>> error.
>>
>> If this patch is related to quotacheck issue, I doubt that there will be
>> problemetic, in no journalled quota case, fs quota system won't stat blocks
>> in inline file, however, after SPO, when using quotacheck to scan file to
>> recover quota info, blocks of inline file showed in getattr can be stated
>> into quota. That would be inconsistent.
> 
> FWIW, quotacheck counts i_blocks via ioctl for normal files. Without this
> modification, xfstests gives an failure on quota cases.

OK, let's fix this issue first. ;)

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>> +		stat->blocks += (stat->size + 511) >> 9;
>>>>> +
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>>
>>>
>>> .
>>>
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
