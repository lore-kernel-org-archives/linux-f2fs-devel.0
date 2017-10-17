From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: return error number for quota_write
Date: Tue, 17 Oct 2017 21:12:14 +0800
Message-ID: <79d07284-167a-3b12-bed3-cea138ab4eb7@kernel.org>
References: <20171012231500.19489-1-jaegeuk@kernel.org>
 <f84b3522-f53d-d91a-464d-71c194dd5864@huawei.com>
 <20171016230444.GA94030@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171016230444.GA94030@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net



On 2017/10/17 7:04, Jaegeuk Kim wrote:
> On 10/16, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2017/10/13 7:15, Jaegeuk Kim wrote:
>>> This patch returns an error number to quota_write in order for quota to handle
>>> it correctly.
>>
>> We should return error number like __generic_file_write_iter, right? it
>> needs to return written bytes if we have written one page or more, otherwise
>> return error number feedbacked from write_begin.
>>
>> So how about reverting 4f31d26b0c17 ("f2fs: return wrong error number on
>> f2fs_quota_write")?
> 
> I thought like that, but realized the code change is somewhat different between
> them.

Hmm... main structure of codes here is copied from other file systems, is there
the same problem in *_quota_write of other file systems?

BTW, it looks making below judgment condition being useless.

	if (len == towrite)
		return 0;

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/super.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 2feecf5e7f4c..840a0876005b 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -1397,8 +1397,11 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
>>>  
>>>  		err = a_ops->write_begin(NULL, mapping, off, tocopy, 0,
>>>  							&page, NULL);
>>> -		if (unlikely(err))
>>> +		if (unlikely(err)) {
>>> +			if (len == towrite)
>>> +				return err;
>>>  			break;
>>> +		}
>>>  
>>>  		kaddr = kmap_atomic(page);
>>>  		memcpy(kaddr + offset, data, tocopy);
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
