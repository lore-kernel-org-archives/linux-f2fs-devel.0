From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: use cur_map instead of ckpt_map
Date: Fri, 20 Apr 2018 11:31:31 +0800
Message-ID: <06e5b8aa-c26a-d78d-5d94-79e0bdd522a0@huawei.com>
References: <1523328631-6658-1-git-send-email-heyunlei@huawei.com>
 <20180412223700.GA46603@jaegeuk-macbookpro.roam.corp.google.com>
 <d0d71e2a-962f-c987-4bc9-9ccbd234529e@huawei.com>
 <42B685BFA705F94C860C6DD0752F056548377BBD@DGGEMA503-MBS.china.huawei.com>
 <20180420032644.GF39280@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f9Mm4-0005v0-Td
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Apr 2018 03:31:48 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f9Mm1-00Axw9-U8
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Apr 2018 03:31:47 +0000
In-Reply-To: <20180420032644.GF39280@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, heyunlei <heyunlei@huawei.com>
Cc: "Zhangdianfang (Euler)" <zhangdianfang@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On 2018/4/20 11:26, Jaegeuk Kim wrote:
> On 04/20, heyunlei wrote:
>>
>>
>>> -----Original Message-----
>>> From: Yuchao (T)
>>> Sent: Friday, April 13, 2018 9:12 AM
>>> To: Jaegeuk Kim; heyunlei
>>> Cc: linux-f2fs-devel@lists.sourceforge.net; Wangbintian; Zhangdianfang (Euler)
>>> Subject: Re: [f2fs-dev][PATCH v2] f2fs: use cur_map instead of ckpt_map
>>>
>>> On 2018/4/13 6:37, Jaegeuk Kim wrote:
>>>> On 04/10, Yunlei He wrote:
>>>>> In flush_sit_entries::add_discard_addrs path, cur_map and ckpt_map
>>>>> are the same, but in exist_trim_candidates::add_discard_addrs,
>>>>> cur_map is updated one, and newer than ckpt_map, so we need to use
>>>>> cur_map to check whether there are discard candidates.
>>>>>
>>>>> v1->v2: one problem of check discard candidates reported by Chao,
>>>>> besides, update commit message.
>>>>>
>>>>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>>>>> ---
>>>>>  fs/f2fs/segment.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index 5854cc4..f5d0499 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -1559,7 +1559,7 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
>>>>>
>>>>>  	/* SIT_VBLOCK_MAP_SIZE should be multiple of sizeof(unsigned long) */
>>>>>  	for (i = 0; i < entries; i++)
>>>>> -		dmap[i] = force ? ~ckpt_map[i] & ~discard_map[i] :
>>>>> +		dmap[i] = force ? ~cur_map[i] & ~discard_map[i] :
>>>>
>>>> NAK. We're able to loose data for roll-forward recovery.
>> Ping
>>
>> Thanks.
>>>
>>> Actually, in fstrim flow (force == 1), cur_map is complete the same as ckpt_map.
>>> Do you suffer data corruption during testing this patch?
> 
> So, we don't need this patch, IIUC.

No, in precheck flow, we haven't flush cur_map to ckpt_map, so they are different.

- fstrim
 - exist_trim_candidates
  - add_discard_addrs

> 
>>>
>>> Thanks,
>>>
>>>>
>>>>>  				(cur_map[i] ^ ckpt_map[i]) & ckpt_map[i];
>>>>>
>>>>>  	while (force || SM_I(sbi)->dcc_info->nr_discards <=
>>>>> --
>>>>> 1.9.1
>>>>
>>>> .
>>>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
