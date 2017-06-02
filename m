From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/1] f2fs: sanity check size of nat and sit
 cache
Date: Fri, 2 Jun 2017 14:22:13 +0800
Message-ID: <d3eb8c87-d356-c6fd-63d2-4637ccf32caa@huawei.com>
References: <CA+yUs=yynPLetzzZRCCkK3X1Ayej6NKV1k9R6jJhp3JybOQReA@mail.gmail.com>
	<20170601232847.GC41246@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dGfyv-0001ld-R5
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Jun 2017 06:22:45 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dGfyt-0007Rx-Hj
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Jun 2017 06:22:45 +0000
In-Reply-To: <20170601232847.GC41246@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Jin Qian <jinqian@android.com>
Cc: stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net



On 2017/6/2 7:28, Jaegeuk Kim wrote:
> Hi Jin,
> 
> The patch format is not applicable to be merged.
> I'll take care of this at this time, so please check it from f2fs/dev-test.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> 
> On 06/01, Jin Qian wrote:
>> Make sure number of entires doesn't exceed max journal size.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jin Qian <jinqian@android.com>
>> ---
>>  fs/f2fs/segment.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index de31030b5041..b07385630150 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -2337,10 +2337,15 @@ static int read_compacted_summaries(struct
>> f2fs_sb_info *sbi)
>>         /* Step 1: restore nat cache */
>>         seg_i = CURSEG_I(sbi, CURSEG_HOT_DATA);
>>         memcpy(seg_i->journal, kaddr, SUM_JOURNAL_SIZE);
>> +       if (nats_in_cursum(seg_i->journal) > NAT_JOURNAL_ENTRIES)
>> +               return -EINVAL;
>>
>>         /* Step 2: restore sit cache */
>>         seg_i = CURSEG_I(sbi, CURSEG_COLD_DATA);
>>         memcpy(seg_i->journal, kaddr + SUM_JOURNAL_SIZE, SUM_JOURNAL_SIZE);
>> +       if (sits_in_cursum(seg_i->journal) > SIT_JOURNAL_ENTRIES)
>> +               return -EINVAL;
>> +
>>         offset = 2 * SUM_JOURNAL_SIZE;
>>
>>         /* Step 3: restore summary entries */
>> @@ -2431,6 +2436,12 @@ static int read_normal_summaries(struct
>> f2fs_sb_info *sbi, int type)
>>                                 return err;
>>                         }
>>                 }
>> +       } else {
>> +               if ((type == CURSEG_HOT_DATA &&
>> +                       nats_in_cursum(sum->journal) > NAT_JOURNAL_ENTRIES) ||
>> +                   (type == CURSEG_COLD_DATA &&
>> +                       sits_in_cursum(sum->journal) > SIT_JOURNAL_ENTRIES))
>> +               return -EINVAL;
>>         }
>>
>>         /* set uncompleted segment to curseg */
>> -- 
>> 2.13.0.506.g27d5fe0cd-goog
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
