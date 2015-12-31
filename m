From: He YunLei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: add a segment and section num check in
 sanity_check_raw_super
Date: Thu, 31 Dec 2015 09:02:21 +0800
Message-ID: <56847E9D.9030809@huawei.com>
References: <1451097979-4589-1-git-send-email-heyunlei@huawei.com>
	<567E01B1.5090207@huawei.com>
	<20151228231056.GA65529@jaegeuk.local>
	<5681DAB0.9020902@huawei.com>
	<20151229014657.GA66567@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1aERdq-0000L3-7g
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 01:02:58 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aERdj-0005xX-Rl
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 01:02:58 +0000
In-Reply-To: <20151229014657.GA66567@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2015/12/29 9:46, Jaegeuk Kim wrote:
> Hi Yunlei,
>
> Could you send a v2 for this?
>
> Thanks,
Hi Kim,

    OK! I have sent it.

Thanks,
>
> On Tue, Dec 29, 2015 at 08:58:24AM +0800, He YunLei wrote:
>> On 2015/12/29 7:10, Jaegeuk Kim wrote:
>>> Hi Yunlei,
>>>
>>> On Sat, Dec 26, 2015 at 10:55:45AM +0800, He YunLei wrote:
>>>> On 2015/12/26 10:46, Yunlei He wrote:
>>>>> This patch add a mismatch check between segment and section in
>>>>> sanity_check_raw_super.
>>>>>
>>>>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>>>>> ---
>>>>>   fs/f2fs/super.c | 11 +++++++++++
>>>>>   1 file changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>> index c3070c1..b51a690 100644
>>>>> --- a/fs/f2fs/super.c
>>>>> +++ b/fs/f2fs/super.c
>>>>> @@ -1036,6 +1036,17 @@ static int sanity_check_raw_super(struct super_block *sb,
>>>>>   		return 1;
>>>>>   	}
>>>>>
>>>>> +	/* check seg # corresponding to sec # */
>>>>> +	if (le32_to_cpu(raw_super->segment_count)
>>>
>>> 			raw_super->segment_count_main ?
>>>
>>> Thanks,
>>
>> yes, you are right, mistake also in f2fs_msg.
>>
>>>
>>>>> +			* le32_to_cpu(raw_super->segs_per_sec)
>>>>
>>>> I am sorry that here is :
>>>> 			/ le32_to_cpu(raw_super->segs_per_sec)
>>>>> +				!= le32_to_cpu(raw_super->section_count)) {
>>>>> +		f2fs_msg(sb, KERN_INFO,
>>>>> +			"Mismatch seg num (%u) and sec num (%u) \n",
>>>>> +			le32_to_cpu(raw_super->segment_count),
>> here is also need change:
>> 			le32_to_cpu(raw_super->segment_count_main),
>> Thanks,
>>>>> +			le32_to_cpu(raw_super->section_count));
>>>>> +		return 1;
>>>>> +	}
>>>>> +
>>>>>   	/* Currently, support 512/1024/2048/4096 bytes sector size */
>>>>>   	if (le32_to_cpu(raw_super->log_sectorsize) >
>>>>>   				F2FS_MAX_LOG_SECTOR_SIZE ||
>>>>>
>>>
>>> .
>>>
>
> .
>


------------------------------------------------------------------------------
