From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: use flexible array for
 f2fs_checkpoint::sit_nat_version_bitmap
Date: Thu, 4 Jan 2018 09:20:48 +0800
Message-ID: <75170acd-f4e4-dd12-23c6-ab3f27b17fa7@huawei.com>
References: <20180103093251.13597-1-yuchao0@huawei.com>
 <20180103201237.GD30014@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103201237.GD30014@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/1/4 4:12, Jaegeuk Kim wrote:
> On 01/03, Chao Yu wrote:
>> If we need an array with variable size in the end of structure, we
>> can utilize flexible array feature which is supported in C99, so
>> let's change sit_nat_version_bitmap[] to flexible array in struct
>> f2fs_checkpoint for readability.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/f2fs.h          | 4 ++--
>>  include/linux/f2fs_fs.h | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 83d1f697388b..ad19d29688ae 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1719,13 +1719,13 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
>>  
>>  	if (__cp_payload(sbi) > 0) {
>>  		if (flag == NAT_BITMAP)
>> -			return &ckpt->sit_nat_version_bitmap;
>> +			return ckpt->sit_nat_version_bitmap;
>>  		else
>>  			return (unsigned char *)ckpt + F2FS_BLKSIZE;
>>  	} else {
>>  		offset = (flag == NAT_BITMAP) ?
>>  			le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
>> -		return &ckpt->sit_nat_version_bitmap + offset;
>> +		return ckpt->sit_nat_version_bitmap + offset;
>>  	}
>>  }
>>  
>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>> index 43e98d30d2df..564f65fc192f 100644
>> --- a/include/linux/f2fs_fs.h
>> +++ b/include/linux/f2fs_fs.h
>> @@ -157,7 +157,7 @@ struct f2fs_checkpoint {
>>  	unsigned char alloc_type[MAX_ACTIVE_LOGS];
>>  
>>  	/* SIT and NAT version bitmap */
>> -	unsigned char sit_nat_version_bitmap[1];
>> +	unsigned char sit_nat_version_bitmap[];
> 
> I cannot find any benefit to do this. Moreover, it just makes the header

I intend to change both kernel and tools, sorry, I didn't send out the
patch on tools. Anyway, I think it could be used to avoid checkpoint
structure size calculation by "sizeof(struct checkpoint) - 1", with the
patch, readability can be improved. Right?

Thanks,

> structure be different from the one in f2fs-tools.
> 
>>  } __packed;
>>  
>>  /*
>> -- 
>> 2.15.0.55.gc2ece9dc4de6
> 
> .
> 
