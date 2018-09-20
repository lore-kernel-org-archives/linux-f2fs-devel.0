From: Junling Zheng <zhengjunling@huawei.com>
Subject: Re: [PATCH 5/5] fsck.f2fs: try to recover cp_payload
 from valid cp pack
Date: Thu, 20 Sep 2018 10:38:27 +0800
Message-ID: <0e66c219-1691-bb5d-ee7c-338a2a1f49f8@huawei.com>
References: <20180919135352.173525-1-zhengjunling@huawei.com>
 <20180919135352.173525-5-zhengjunling@huawei.com>
 <20180919233850.GC84041@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1g2ori-0007H5-BO
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Sep 2018 02:38:50 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g2orf-006IC1-Az
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Sep 2018 02:38:49 +0000
In-Reply-To: <20180919233850.GC84041@jaegeuk-macbookpro.roam.corp.google.com>
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
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/9/20 7:38, Jaegeuk Kim wrote:
> On 09/19, Junling Zheng wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> If sb checksum is not enabled, and cp pack is valid due to no
>> crc inconsistence, let's try to recover cp_payload based on
>> cp_pack_start_sum in cp pack.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fsck/f2fs.h  |  5 +++++
>>  fsck/mount.c | 10 +++++++---
>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/fsck/f2fs.h b/fsck/f2fs.h
>> index d216444..0d0d5e2 100644
>> --- a/fsck/f2fs.h
>> +++ b/fsck/f2fs.h
>> @@ -259,6 +259,11 @@ static inline unsigned long __bitmap_size(struct f2fs_sb_info *sbi, int flag)
>>  	return 0;
>>  }
>>  
>> +static inline block_t __cp_payload(struct f2fs_sb_info *sbi)
>> +{
>> +	return le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
>> +}
>> +
>>  static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
>>  {
>>  	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
>> diff --git a/fsck/mount.c b/fsck/mount.c
>> index 9019921..0e8fa41 100644
>> --- a/fsck/mount.c
>> +++ b/fsck/mount.c
>> @@ -975,12 +975,16 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
>>  	}
>>  
>>  	cp_pack_start_sum = __start_sum_addr(sbi);
>> -	cp_payload = get_sb(cp_payload);
>> +	cp_payload = __cp_payload(sbi);
>>  	if (cp_pack_start_sum < cp_payload + 1 ||
>>  		cp_pack_start_sum > blocks_per_seg - 1 -
>>  			NR_CURSEG_TYPE) {
>> -		MSG(0, "\tWrong cp_pack_start_sum(%u)\n", cp_pack_start_sum);
>> -		return 1;
>> +		MSG(0, "\tWrong cp_pack_start_sum(%u) or cp_payload(%u)\n",
>> +			cp_pack_start_sum, cp_payload);
>> +		if ((get_sb(feature) & F2FS_FEATURE_SB_CHKSUM))
>> +			return 1;
> 
> Is this trying to fix superblock? Why is it related to SB_CHKSUM?
> 

If sb_checksum is enabled, we should not try to fix superblock.
In this situation, both sb and cp are verified with crc, so we
don't know which one, cp_payload or cp_pack_start_sum, is the
exact one.

By contraries, if sb_checksum is disabled, we could try to fix
superblock as below :)

>> +		set_sb(cp_payload, cp_pack_start_sum - 1);
>> +		update_superblock(sb, SB_ALL);
>>  	}
>>  >>  	return 0;
>> -- 
>> 2.19.0
> 
> .
> 
