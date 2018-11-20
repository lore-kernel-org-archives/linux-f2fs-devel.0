From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: Re: [PATCH] f2fs: fix wrong return value of
 f2fs_acl_create
Date: Wed, 21 Nov 2018 06:38:29 +0800 (CST)
Message-ID: <889a0da.8ee.16733466169.Coremail.kernelpatch@126.com>
References: <26a3c90d.498.1672de9287d.Coremail.kernelpatch@126.com>
 <e5461383-aac2-f922-fe06-7350b887da8e@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <kernelpatch@126.com>) id 1gPEfO-0003es-Q8
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Nov 2018 22:38:46 +0000
Received: from m15-62.126.com ([220.181.15.62])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1gPEfK-00FTX1-Kb
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Nov 2018 22:38:46 +0000
In-Reply-To: <e5461383-aac2-f922-fe06-7350b887da8e@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

At 2018-11-20 20:07:55, "Chao Yu" <chao@kernel.org> wrote:
>On 2018-11-20 5:38, Tiezhu Yang wrote:
>> When call f2fs_acl_create_masq() failed, the caller f2fs_acl_create()
>> should return -EIO instead of -ENOMEM, this patch makes it consistent
>> with posix_acl_create() which has been fixed in commit beaf226b863a
>> ("posix_acl: don't ignore return value of posix_acl_create_masq()").
>> 
>> Fixes: 83dfe53c185e ("f2fs: fix reference leaks in f2fs_acl_create")
>> Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
>> ---
>>  fs/f2fs/acl.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>> 
>> diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
>> index fa707cd..b791c24 100644
>> --- a/fs/f2fs/acl.c
>> +++ b/fs/f2fs/acl.c
>> @@ -351,13 +351,14 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
>>  	if (IS_ERR(p))
>>  		return PTR_ERR(p);
>>  
>> +	ret = -ENOMEM;
>>  	clone = f2fs_acl_clone(p, GFP_NOFS);
>>  	if (!clone)
>
>We can avoid assigning ret by:
>
>clone = f2fs_acl_clone(p, GFP_NOFS);
>if (!clone) {
>	ret = -ENOMEM;
>	goto release_acl;
>}
>
>> -		goto no_mem;
>> +		goto err_release;
>>  
>>  	ret = f2fs_acl_create_masq(clone, mode);
>>  	if (ret < 0)
>> -		goto no_mem_clone;
>> +		goto err_release_clone;
>>  
>>  	if (ret == 0)
>>  		posix_acl_release(clone);
>> @@ -371,11 +372,11 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
>>  
>>  	return 0;
>>  
>> -no_mem_clone:
>> +err_release_clone:
>
>release_clone:
>
>>  	posix_acl_release(clone);
>> -no_mem:
>> +err_release:
>
>release_acl:
>
>Tag naming is minor, anyway this patch looks good to me.

Thanks for your suggestion, I will send a v2 patch.

Thanks,

>
>Reviewed-by: Chao Yu <yuchao0@huawei.com>
>
>Thanks,
>
>>  	posix_acl_release(p);
>> -	return -ENOMEM;
>> +	return ret;
>>  }
>>  
>>  int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
>> 
