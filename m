From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: discard small invalid blocks in current active
 segments
Date: Mon, 28 Aug 2017 21:21:29 +0800
Message-ID: <61d97244-c4e5-0008-ab30-fc52a05e0b24@huawei.com>
References: <1503751772-158812-1-git-send-email-yunlong.song@huawei.com>
 <fd445a69-d860-2185-bfef-bf037a1f513e@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fd445a69-d860-2185-bfef-bf037a1f513e@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

How? Can the invalid blocks of file A be discarded, if file B is alive 
all the time and fggc_threshold is 507 ?

On 2017/8/28 17:59, Chao Yu wrote:
> On 2017/8/26 20:49, Yunlong Song wrote:
>> 1. write file A with 5 blocks to current empty active segment
>> 2. remove file A
>> 3. write checkpoint
>> 4. write file B with 507 blocks to the same active segment
>>
>> If file B is alive all the time, the blocks used by file A will never be
>> discarded. So current active segment should also be treated as a candidate
>> for small discards.
> I don't think that would be a big issue, since there will not be any freezing
> log headers, once log header moves, later invalid blocks could be discarded.
>
> Thanks,
>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>   fs/f2fs/segment.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 8375257..a2e7c8f 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1339,7 +1339,9 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
>>   		return false;
>>   
>>   	if (!force) {
>> -		if (!test_opt(sbi, DISCARD) || !se->valid_blocks ||
>> +		if (!test_opt(sbi, DISCARD) ||
>> +			(!se->valid_blocks &&
>> +			!IS_CURSEG(sbi, cpc->trim_start)) ||
>>   			SM_I(sbi)->dcc_info->nr_discards >=
>>   				SM_I(sbi)->dcc_info->max_discards)
>>   			return false;
>>
>
> .
>

-- 
Thanks,
Yunlong Song
