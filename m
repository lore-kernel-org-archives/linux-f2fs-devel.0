From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4] f2fs: check segment type in
 __f2fs_replace_block
Date: Thu, 4 Jan 2018 15:22:45 +0800
Message-ID: <9344a0ca-960c-3643-e360-433b70b05516@huawei.com>
References: <1514619768-134531-1-git-send-email-yunlong.song@huawei.com>
 <1515049322-29555-1-git-send-email-yunlong.song@huawei.com>
 <20180104071054.GD54234@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eWzrj-0003dZ-Ro
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Jan 2018 07:23:03 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eWzri-0000M3-Ih
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Jan 2018 07:23:03 +0000
In-Reply-To: <20180104071054.GD54234@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Yunlong Song <yunlong.song@huawei.com>
Cc: shengyong1@huawei.com, yunlong.song@icloud.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, miaoxie@huawei.com

On 2018/1/4 15:10, Jaegeuk Kim wrote:
> On 01/04, Yunlong Song wrote:
>> In some case, the node blocks has wrong blkaddr whose segment type is
>> NODE, e.g., recover inode has missing xattr flag and the blkaddr is in
>> the xattr range. Since fsck.f2fs does not check the recovery nodes, this
>> will cause __f2fs_replace_block change the curseg of node and do the
>> update_sit_entry(sbi, new_blkaddr, 1) with no next_blkoff refresh, as a
>> result, when recovery process write checkpoint and sync nodes, the
>> next_blkoff of curseg is used in the segment bit map, then it will
>> cause f2fs_bug_on. So let's check segment type in __f2fs_replace_block.
>>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>  fs/f2fs/segment.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 890d483..50575d5 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -2720,6 +2720,7 @@ void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>  	type = se->type;
>>  
>>  	down_write(&SM_I(sbi)->curseg_lock);
>> +	f2fs_bug_on(sbi, se->valid_blocks && !IS_DATASEG(type));
> 
> Let me just move this below like this and start some tests.
> 
> ...
> 
> +       f2fs_bug_on(sbi, !IS_DATASEG(type));

Better,

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>         curseg = CURSEG_I(sbi, type);
> 
>>  
>>  	if (!recover_curseg) {
>>  		/* for recovery flow */
>> -- 
>> 1.8.5.2
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
