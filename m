From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: use cur_map instead of ckpt_map
Date: Tue, 10 Apr 2018 02:55:23 +0000
Message-ID: <42B685BFA705F94C860C6DD0752F056548363733@DGGEMA503-MBS.china.huawei.com>
References: <1523273795-2913-1-git-send-email-heyunlei@huawei.com>
 <779015a9-3523-3c79-f1c2-9a636de597b1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1f5jV1-0005aY-4w
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 02:59:14 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5jUy-004CPZ-Iz
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 02:59:11 +0000
In-Reply-To: <779015a9-3523-3c79-f1c2-9a636de597b1@huawei.com>
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Yuchao (T)" <yuchao0@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: "Zhangdianfang (Euler)" <zhangdianfang@huawei.com>



>-----Original Message-----
>From: Yuchao (T)
>Sent: Tuesday, April 10, 2018 10:45 AM
>To: heyunlei; jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net
>Cc: Wangbintian; Zhangdianfang (Euler)
>Subject: Re: [f2fs-dev][PATCH] f2fs: use cur_map instead of ckpt_map
>
>On 2018/4/9 19:36, Yunlei He wrote:
>> This patch use cur_map instead of ckpt_map for easy to
>> understand, no functional change.
>
>Actually, it does change the logic, but I think it can fix a issue..
>
>In flush_sit_entries::add_discard_addrs path, cur_map and ckpt_map are
>the same, but in exist_trim_candidates::add_discard_addrs, cur_map is
>updated one, and newer than ckpt_map, so we need to use cur_map to check
>whether there are discard candidates.
>
>Can you change commit message as described above and resend the patch?

Okay, I'll do it. 

Thanks.
>
>Thanks,
>
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>> ---
>>  fs/f2fs/segment.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 5854cc4..f5d0499 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1559,7 +1559,7 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
>>
>>  	/* SIT_VBLOCK_MAP_SIZE should be multiple of sizeof(unsigned long) */
>>  	for (i = 0; i < entries; i++)
>> -		dmap[i] = force ? ~ckpt_map[i] & ~discard_map[i] :
>> +		dmap[i] = force ? ~cur_map[i] & ~discard_map[i] :
>>  				(cur_map[i] ^ ckpt_map[i]) & ckpt_map[i];
>>
>>  	while (force || SM_I(sbi)->dcc_info->nr_discards <=
>>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
