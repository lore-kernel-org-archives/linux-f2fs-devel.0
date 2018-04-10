From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: stop issue discard if something
 wrong with f2fs
Date: Tue, 10 Apr 2018 11:12:25 +0800
Message-ID: <45c2b065-f462-9553-d969-ff853c993b6b@huawei.com>
References: <1523273251-29871-1-git-send-email-heyunlei@huawei.com>
 <c303bb52-c464-a122-e5ff-c95f5f7abecf@huawei.com>
 <42B685BFA705F94C860C6DD0752F056548363715@DGGEMA503-MBS.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f5ji7-0004jJ-Mo
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 03:12:43 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5ji5-004EHV-D7
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 03:12:43 +0000
In-Reply-To: <42B685BFA705F94C860C6DD0752F056548363715@DGGEMA503-MBS.china.huawei.com>
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

On 2018/4/10 10:46, heyunlei wrote:
> 
> 
>> -----Original Message-----
>> From: Yuchao (T)
>> Sent: Tuesday, April 10, 2018 10:36 AM
>> To: heyunlei; jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net
>> Cc: Wangbintian; Zhangdianfang (Euler)
>> Subject: Re: [f2fs-dev][PATCH v3] f2fs: stop issue discard if something wrong with f2fs
>>
>> On 2018/4/9 19:27, Yunlei He wrote:
>>> This patch stop async thread and umount process to issue discard
>>> if something wrong with f2fs, which is similar to fstrim.
>>>
>>> v1->v2: add fs error check in not only discard thread but also umount process
>>> v2->v3: remove redundant error message
>>>
>>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>>> ---
>>>  fs/f2fs/segment.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 5854cc4..e31d506 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1202,6 +1202,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>  	int i, iter = 0, issued = 0;
>>>  	bool io_interrupted = false;
>>>
>>> +	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
>>> +		return issued;
>>
>> Hmm.. except here, I mean we'd better add it into issue_discard_thread too?
> 
> Async thread will also use this function to issue discard, besides, in this case
> __issue_discard_cmd will return zero to async thread, thread will wait max 
> Interval 60s. Anything I missed?

There is still locking overhead from sb_{start,end}_intwrite, although it's tiny,
but since there is no way to revert NEED_FSCK status, so just let discard thread
be aware of this to walk around is OK.

Thanks,

> 
> Thanks.
> 
>>
>> Thanks,
>>
>>> +
>>>  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>>>  		if (i + 1 < dpolicy->granularity)
>>>  			break;
>>>
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
