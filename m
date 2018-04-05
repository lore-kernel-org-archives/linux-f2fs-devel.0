From: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH] f2fs: no need to take the address of the
 array of sb->s_uuid
Date: Thu, 5 Apr 2018 12:04:32 +0800
Message-ID: <60ebbf0a-b569-7f79-1786-f17d457f6943@huawei.com>
References: <df2be96b-c613-def5-98e2-ed310e0b2f4b@huawei.com>
 <20180405035444.GD50337@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <gaoxiang25@huawei.com>) id 1f3w9y-0000iE-6o
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Apr 2018 04:06:02 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f3w9w-003m7N-Ck
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Apr 2018 04:06:02 +0000
In-Reply-To: <20180405035444.GD50337@jaegeuk-macbookpro.roam.corp.google.com>
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
Cc: Gao Xiang <hsiangkao@aol.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Jaegeuk,

On 2018/4/5 11:54, Jaegeuk Kim wrote:
> Hi Gao,
> 
> Could you please check your email settings?
> It's broken.
> 
> Thanks,Sorry to bother for the pervious email..
My business email client was just in a mess. :(

Thanks,

> 
> On 04/05, Gao Xiang wrote:
>> Keep in line with the common case since it is some weird
>> to take the address of an array again.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>>  fs/f2fs/super.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 42d564c5ccd0..f864ab702fa2 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2701,7 +2701,7 @@ static int f2fs_fill_super(struct super_block *sb,
>> void *data, int silent)
>>  	sb->s_time_gran = 1;
>>  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
>>  		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
>> -	memcpy(&sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
>> +	memcpy(sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
>>  	sb->s_iflags |= SB_I_CGROUPWB;
>>   	/* init f2fs-specific super block info */
>> -- 
>> 2.12.2

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
