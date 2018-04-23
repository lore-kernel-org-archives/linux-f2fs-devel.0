From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: move mnt_want_write_file after range
 check
Date: Mon, 23 Apr 2018 18:52:41 +0800
Message-ID: <8e854f8d-748d-dcdd-0a4b-873a65aa29d3@huawei.com>
References: <1524451043-22501-1-git-send-email-heyunlei@huawei.com>
 <42B685BFA705F94C860C6DD0752F05654837C7AC@DGGEMA503-MBS.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fAZ5r-0005UY-T0
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 10:53:11 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fAZ5n-008XC4-56
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 10:53:11 +0000
In-Reply-To: <42B685BFA705F94C860C6DD0752F05654837C7AC@DGGEMA503-MBS.china.huawei.com>
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
To: heyunlei <heyunlei@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: "Zhangdianfang (Euler)" <zhangdianfang@huawei.com>

On 2018/4/23 17:11, heyunlei wrote:
> 
> 
>> -----Original Message-----
>> From: heyunlei
>> Sent: Monday, April 23, 2018 10:37 AM
>> To: jaegeuk@kernel.org; Yuchao (T); linux-f2fs-devel@lists.sourceforge.net
>> Cc: Wangbintian; heyunlei; Zhangdianfang (Euler)
>> Subject: [f2fs-dev][PATCH] f2fs: move mnt_want_write_file after range check
>>
>> This patch move mnt_want_write_file after range check,
>> it's needless to check arguments with it.
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>> ---
>> fs/f2fs/file.c | 13 ++++++++-----
>> 1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 16dad2b..165a60f 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -2061,15 +2061,18 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
>> 	if (f2fs_readonly(sbi->sb))
>> 		return -EROFS;
>>
>> +	end = range.start + range.len;
>> +	if (range.start < MAIN_BLKADDR(sbi) || end >= MAX_BLKADDR(sbi)) {
>> +		f2fs_msg(sbi->sb, KERN_WARNING,
>> +			"range should be located in (%u, %u]",
>> +			MAIN_BLKADDR(sbi), MAX_BLKADDR(sbi));
>> +		return -EINVAL;
>> +	}
> 
> Okay, btw, should we combine f2fs_ioc_gc and f2fs_ioc_gc_range? 
> we can add a value in input arguments to indicate whether it's range gc or not.

That's not a big problem since it's just cleanup, if you want to, please go
ahead. :)

Thanks,

> 
> Thanks. 
>> +
>> 	ret = mnt_want_write_file(filp);
>> 	if (ret)
>> 		return ret;
>>
>> -	end = range.start + range.len;
>> -	if (range.start < MAIN_BLKADDR(sbi) || end >= MAX_BLKADDR(sbi)) {
>> -		ret = -EINVAL;
>> -		goto out;
>> -	}
>> do_more:
>> 	if (!range.sync) {
>> 		if (!mutex_trylock(&sbi->gc_mutex)) {
>> --
>> 1.9.1
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
