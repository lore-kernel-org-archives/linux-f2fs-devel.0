From: He YunLei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: initialize both two copies of NAT and
 SIT area
Date: Fri, 24 Jul 2015 17:55:58 +0800
Message-ID: <55B20BAE.70504@huawei.com>
References: <1437615784-16194-1-git-send-email-heyunlei@huawei.com>
	<20150723181819.GC23629@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ZIZjn-0001T9-0u
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Jul 2015 09:57:55 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZIZji-0002QA-O5
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Jul 2015 09:57:55 +0000
In-Reply-To: <20150723181819.GC23629@jaegeuk-mac02.mot.com>
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

Hi Jaegeuk
On 2015/7/24 2:18, Jaegeuk Kim wrote:
> Hi Yunlei,
>
> On Thu, Jul 23, 2015 at 09:43:04AM +0800, Yunlei He wrote:
>> In the process of formatting, we zero out only one copy of NAT and
>> SIT area, but we use both of them when the filesystem is sucessfully
>> mounted. So I change the code to initialize both of two copies in mkfs.
>
> After mounted, the other set will be filled with all valid entries by f2fs.
> Is there a bug?
>
> Thanks,
>

I think f2fs write nat and sit in two place alternately.

In function flush_sit_entries, f2fs chooses journal in curseg f2fs_summary_block firstly,
if no enough space, then it flush entries to sit pages, which wait for write back.
Pages are got by get_next_sit_page function:

1714     src_off = current_sit_addr(sbi, start);
1715     dst_off = next_sit_addr(sbi, src_off);
1716
1717     /* get current sit block page without lock */
1718     src_page = get_meta_page(sbi, src_off);
1719     dst_page = grab_meta_page(sbi, dst_off);

1722     src_addr = page_address(src_page);
1723     dst_addr = page_address(dst_page);
1724     memcpy(dst_addr, src_addr, PAGE_CACHE_SIZE);

I also make a test on my pc

SIT info on my f2fs partition is as below,
SIT(1): 1280 ~ 2816 (4k unit, total 6 MB 3 segments)
SIT(2): 2817 ~ 4352 (4k unit, total 6 MB 3 segments)

I touch 2000 empty files to make sure dirty sit entries are flushed to sit pages

[ 5870.324921]  flush to sit ~~~hyl fs/f2fs/segment.c:1875
[ 5870.324921]  src_off = 4198~~~hyl fs/f2fs/segment.c:1715
[ 5870.324921]  dst_off = 2662~~~hyl fs/f2fs/segment.c:1717

then I delete all the file and touch again

[ 5613.634439]  flush to sit ~~~hyl fs/f2fs/segment.c:1875
[ 5613.634439]  src_off = 2662~~~hyl fs/f2fs/segment.c:1715
[ 5613.634439]  dst_off = 4198~~~hyl fs/f2fs/segment.c:1717

We can see f2fs use both copies of NAT and SIT, so why we zero out just one copy ?


>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>> ---
>>   mkfs/f2fs_format.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>> index f879bca..b2b3549 100644
>> --- a/mkfs/f2fs_format.c
>> +++ b/mkfs/f2fs_format.c
>> @@ -389,7 +389,7 @@ static int f2fs_init_sit_area(void)
>>   	sit_seg_addr *= blk_size;
>>
>>   	DBG(1, "\tFilling sit area at offset 0x%08"PRIx64"\n", sit_seg_addr);
>> -	for (index = 0; index < (get_sb(segment_count_sit) / 2); index++) {
>> +	for (index = 0; index < get_sb(segment_count_sit); index++) {
>>   		if (dev_fill(zero_buf, sit_seg_addr, seg_size)) {
>>   			MSG(1, "\tError: While zeroing out the sit area \
>>   					on disk!!!\n");
>> @@ -423,14 +423,14 @@ static int f2fs_init_nat_area(void)
>>   	nat_seg_addr *= blk_size;
>>
>>   	DBG(1, "\tFilling nat area at offset 0x%08"PRIx64"\n", nat_seg_addr);
>> -	for (index = 0; index < get_sb(segment_count_nat) / 2; index++) {
>> +	for (index = 0; index < get_sb(segment_count_nat); index++) {
>>   		if (dev_fill(nat_buf, nat_seg_addr, seg_size)) {
>>   			MSG(1, "\tError: While zeroing out the nat area \
>>   					on disk!!!\n");
>>   			free(nat_buf);
>>   			return -1;
>>   		}
>> -		nat_seg_addr = nat_seg_addr + (2 * seg_size);
>> +		nat_seg_addr = nat_seg_addr + seg_size;
>>   	}
>>
>>   	free(nat_buf);
>> --
>> 1.9.1
>
> .
>


------------------------------------------------------------------------------
