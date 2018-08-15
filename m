From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] Revert "f2fs: use printk_ratelimited for
 f2fs_msg"
Date: Wed, 15 Aug 2018 11:11:55 +0800
Message-ID: <8f5fb053-6244-45a6-7393-cbab2c239930@huawei.com>
References: <20180813062845.25394-1-yuchao0@huawei.com>
 <20180814170956.GA56510@jaegeuk-macbookpro.roam.corp.google.com>
 <51fabc55-ba93-1845-da39-0ee203fe2098@huawei.com>
 <20180815030114.GD84720@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fpmEA-0000iZ-DH
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Aug 2018 03:12:06 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fpmE8-003DvJ-8E
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Aug 2018 03:12:06 +0000
In-Reply-To: <20180815030114.GD84720@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/8/15 11:01, Jaegeuk Kim wrote:
> On 08/15, Chao Yu wrote:
>> On 2018/8/15 1:09, Jaegeuk Kim wrote:
>>> On 08/13, Chao Yu wrote:
>>>> Don't limit printing log, so that we will not miss any key messages.
>>>
>>> For example, this can avoid lots of messages during roll-forward recovery.
>>
>> That's really important evidence that can prove filesystem didn't lose last
>> fsynced data, when file/data is missing after SPO, otherwise, filesystem will
>> still be treated as suspect... :(
> 
> It's too bad that we need to rely on kernel messages for that purpose. Anyway,

Yes, it's very hard to make sure the problem is not caused by filesystem's bug
when trouble shooting, unless there is explicit kernel message.

Also, without message, trouble shooting becomes harder.

> if so, we may need to use printk() for essential messages only.

Now, during our debugging, we have to change to use printk to avoid potential
message missing...

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> This reverts commit a36c106dffb616250117efb1cab271c19a8f94ff.
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/super.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>> index bf4c919fe418..3d89d94191e7 100644
>>>> --- a/fs/f2fs/super.c
>>>> +++ b/fs/f2fs/super.c
>>>> @@ -209,7 +209,7 @@ void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
>>>>  	va_start(args, fmt);
>>>>  	vaf.fmt = fmt;
>>>>  	vaf.va = &args;
>>>> -	printk_ratelimited("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
>>>> +	printk("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
>>>>  	va_end(args);
>>>>  }
>>>>  
>>>> -- 
>>>> 2.18.0.rc1
>>>
>>> .
>>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
