From: Shuoran <liushuoran@huawei.com>
Subject: Re: [PATCH] f2fs: Introduce lifetime write IO statistics
Date: Mon, 22 Feb 2016 09:12:41 +0800
Message-ID: <56CA6089.20905@huawei.com>
References: <1453778182-66323-1-git-send-email-liushuoran@huawei.com>
	<20160220170802.GB4662@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liushuoran@huawei.com>) id 1aXf3t-0001ym-Ag
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 01:13:17 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aXf3l-0002nG-8A
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 01:13:17 +0000
In-Reply-To: <20160220170802.GB4662@amd>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Pavel,

On 2016/2/21 1:08, Pavel Machek wrote:
> Hi!
>
>> From: Shuoran Liu <liushuoran@huawei.com>
>>
>> Signed-off-by: Shuoran Liu <liushuoran@huawei.com>
>> Signed-off-by: Pengyang Hou <houpengyang@huawei.com>
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -921,6 +921,10 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>   	int cp_payload_blks = __cp_payload(sbi);
>>   	block_t discard_blk = NEXT_FREE_BLKADDR(sbi, curseg);
>>   	bool invalidate = false;
>> +	struct super_block *sb = sbi->sb;
>> +	struct curseg_info *seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
>> +	__u64 kbytes_written;
>> +
> No need to __prefix in kernel.

There is a v2 version of the patch according to the suggestions of Kim 
and Chao Yu, and is merged into the "dev" branch.

>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>> index e59c3be..05ae034 100644
>> --- a/include/linux/f2fs_fs.h
>> +++ b/include/linux/f2fs_fs.h
>> @@ -387,6 +387,11 @@ struct sit_journal {
>>   	__u8 reserved[SIT_JOURNAL_RESERVED];
>>   } __packed;
>>   
>> +struct f2fs_extra_info {
>> +	__le64 kbytes_written;
>> +	__u8 reserved[SUM_JOURNAL_SIZE - 10];
>> +} __packed;
>> +
> Unless this is exported to userspace, no need for __ here, either.
>
> (Would it make sense to store bytes_written, as it is not going to
> overflow, anyway?)
>
> Is this going to be exported to userspace somehow?

This stat is exposed to the sysfs interface. Since Ext4 is using kbytes 
named "lifetime_kbytes_written", we tend to maintain compatibility in 
case some upper level applications are using it. Besides, the 
information is obtained from block layer in the unit of "sectors"(512 
bytes). So it is not necessary to use bytes.

> 									Pavel

Regards,
Shuoran


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
