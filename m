From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: correct cp_ver for compatibility to
	old image
Date: Mon, 6 Mar 2017 18:23:03 +0800
Message-ID: <2b7a24e8-9c85-9646-059b-153a4f796bef@huawei.com>
References: <20170302032233.89189-1-yuchao0@huawei.com>
	<20170302185518.GA1030@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ckpnZ-00026H-ET
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Mar 2017 10:23:25 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ckpnX-0000ZV-PE
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Mar 2017 10:23:25 +0000
In-Reply-To: <20170302185518.GA1030@jaegeuk.local>
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/3/3 2:55, Jaegeuk Kim wrote:
> On 03/02, Chao Yu wrote:
>> There is no CP_CRC_RECOVERY_FLAG tagged in checkpoint pack, calculate
>> cp_version as old format.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/node.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 6c027b6833f4..0d46404ca769 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -2507,7 +2507,9 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
>>  		f2fs_put_page(page, 1);
>>  	}
>>  
>> -	cp_ver |= (cur_cp_crc(ckpt) << 32);
>> +	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
>> +		cp_ver |= (cur_cp_crc(ckpt) << 32);
> 
> Well, we always write nat_bits with crc. So if it's different, something is
> wrong and we need to drop it.

Got it. :)

Thanks,

> CP-CRC_RECOVERY_FLAG is used for roll-forward recovery, which is a different context.
> 
>> +
>>  	if (cpu_to_le64(cp_ver) != *(__le64 *)nm_i->nat_bits) {
>>  		disable_nat_bits(sbi, true);
>>  		return 0;
>> -- 
>> 2.8.2.295.g3f1c1d0
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
