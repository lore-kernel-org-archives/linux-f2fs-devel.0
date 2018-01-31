From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: add sanity check for quota sysfile ino
Date: Wed, 31 Jan 2018 11:38:57 +0800
Message-ID: <edc49b65-2f18-26a2-a97d-ee89143e7ece@huawei.com>
References: <20180129082933.64556-1-yuchao0@huawei.com>
 <20180131013556.GE65489@jaegeuk-macbookpro.roam.corp.google.com>
 <f27cbf43-eb34-5e21-8016-c1a17203cf0b@huawei.com>
 <20180131023607.GA87929@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1egjF2-0003eR-TT
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jan 2018 03:39:20 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1egjF1-0003hQ-BM
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jan 2018 03:39:20 +0000
In-Reply-To: <20180131023607.GA87929@jaegeuk-macbookpro.roam.corp.google.com>
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

On 2018/1/31 10:36, Jaegeuk Kim wrote:
> On 01/31, Chao Yu wrote:
>> On 2018/1/31 9:35, Jaegeuk Kim wrote:
>>> On 01/29, Chao Yu wrote:
>>>> Add missing sanity check for quota sysfile ino.
>>>
>>> We don't need to limit the specific inode numbers for quota files, since
>>> we may be able to set any inode numbers later. How about checkint the
>>> numbers are allocated as quota?
> 
> If quota_ino is set, f2fs_enable_quotas() will be failed, if its ino is invalid.
> It'd be also fine, if we have no inode numbers there. What I mean was we may need
> to consider reallocating or deallocating inode numbers later.

Oh, so that it will be better to do more check & repair in fsck tools, right?

Thanks,

> 
>>
>> Do you mean:
>>
>> 	if (raw_super->feature & cpu_to_le32(F2FS_FEATURE_QUOTA_INO)) {
>> 		if (!le32_to_cpu(raw_super->qf_ino[0]) ||
>> 			!le32_to_cpu(raw_super->qf_ino[1])) {
>> 			f2fs_msg(sb, KERN_INFO,
>> 				"Invalid Quota Ino: user_ino(%u), grp_ino(%u)",
>> 				le32_to_cpu(raw_super->qf_ino[0]),
>> 				le32_to_cpu(raw_super->qf_ino[1]));
>> 			return 1;
>> 		}
>> 		if (raw_super->feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA) &&
>> 			!le32_to_cpu(raw_super->qf_ino[2])) {
>> 			f2fs_msg(sb, KERN_INFO,
>> 				"Invalid Quota Ino: prj_ino(%u)",
>> 				le32_to_cpu(raw_super->qf_ino[2]));
>> 			return 1;
>> 		}
>> 	}
>>
>> I think it's equal to:
>>
>> 	if (raw_super->feature & cpu_to_le32(F2FS_FEATURE_QUOTA_INO)) {
>> 		unsigned int qf_cnt = 0;
>> 		if (qf_ino[0])
>> 			qf_cnt++;
>> 		if (qf_ino[1])
>> 			qf_cnt++;
>> 		if (qf_cnt != 2) {
>> 			f2fs_msg();
>> 			return 1;
>> 		}
>> 		if (raw_super->feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA)) {
>> 			if (qf_ino[2])
>> 				qf_cnt++;
>> 			if (qf_cnt != 3) {
>> 				f2fs_msg();
>> 				return 1;
>> 			}
>> 		}
>> 	}
>>
>> Thanks,
>>
>>>
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/super.c | 19 +++++++++++++++++++
>>>>  1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>> index 368f63d7bad2..6011071688ca 100644
>>>> --- a/fs/f2fs/super.c
>>>> +++ b/fs/f2fs/super.c
>>>> @@ -2116,6 +2116,25 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>>>>  		return 1;
>>>>  	}
>>>>  
>>>> +	/* check quota sysfile ino info */
>>>> +	if (raw_super->feature & cpu_to_le32(F2FS_FEATURE_QUOTA_INO)) {
>>>> +		if (le32_to_cpu(raw_super->qf_ino[0]) != 4 ||
>>>> +			le32_to_cpu(raw_super->qf_ino[1]) != 5) {
>>>> +			f2fs_msg(sb, KERN_INFO,
>>>> +				"Invalid Quota Ino: user_ino(%u), grp_ino(%u)",
>>>> +				le32_to_cpu(raw_super->qf_ino[0]),
>>>> +				le32_to_cpu(raw_super->qf_ino[1]));
>>>> +			return 1;
>>>> +		}
>>>> +		if (raw_super->feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA) &&
>>>> +			le32_to_cpu(raw_super->qf_ino[2]) != 6) {
>>>> +			f2fs_msg(sb, KERN_INFO,
>>>> +				"Invalid Quota Ino: prj_ino(%u)",
>>>> +				le32_to_cpu(raw_super->qf_ino[2]));
>>>> +			return 1;
>>>> +		}
>>>> +	}
>>>> +
>>>>  	if (le32_to_cpu(raw_super->segment_count) > F2FS_MAX_SEGMENT) {
>>>>  		f2fs_msg(sb, KERN_INFO,
>>>>  			"Invalid segment count (%u)",
>>>> -- 
>>>> 2.15.0.55.gc2ece9dc4de6
>>>
>>> .
>>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
