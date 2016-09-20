From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/6] f2fs: fix to avoid race condition when updating sbi
 flag
Date: Tue, 20 Sep 2016 09:41:32 +0800
Message-ID: <5129623b-f261-3eb4-d82d-3fedee91644f@huawei.com>
References: <1474212608-6930-1-git-send-email-chao@kernel.org>
 <1474212608-6930-3-git-send-email-chao@kernel.org>
 <20160919214058.GA68913@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160919214058.GA68913@jaegeuk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/9/20 5:40, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On Sun, Sep 18, 2016 at 11:30:05PM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> Making updating of sbi flag atomic by using {test,set,clear}_bit,
>> otherwise in concurrency scenario, the flag could be updated incorrectly.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/f2fs.h | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 9b4bbf2..c30f744b 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -794,7 +794,7 @@ struct f2fs_sb_info {
>>  	struct proc_dir_entry *s_proc;		/* proc entry */
>>  	struct f2fs_super_block *raw_super;	/* raw super block pointer */
>>  	int valid_super_block;			/* valid super block no */
>> -	int s_flag;				/* flags for sbi */
>> +	unsigned long s_flag;				/* flags for sbi */
>>  
>>  #ifdef CONFIG_F2FS_FS_ENCRYPTION
>>  	u8 key_prefix[F2FS_KEY_DESC_PREFIX_SIZE];
>> @@ -1063,17 +1063,19 @@ static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
>>  
>>  static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
>>  {
>> -	return sbi->s_flag & (0x01 << type);
>> +	return test_bit(type, &sbi->s_flag);
>>  }
>>  
>>  static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
>>  {
>> -	sbi->s_flag |= (0x01 << type);
>> +	if (!test_bit(type, &sbi->s_flag))
>> +		set_bit(type, &sbi->s_flag);
> 
> The set_bit() is enough, no?

It seems OK to me, let me send v2.

Thanks,

> 
>>  }
>>  
>>  static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
>>  {
>> -	sbi->s_flag &= ~(0x01 << type);
>> +	if (test_bit(type, &sbi->s_flag))
>> +		clear_bit(type, &sbi->s_flag);
> 
> ditto.
> 
> Thanks,
> 
>>  }
>>  
>>  static inline unsigned long long cur_cp_version(struct f2fs_checkpoint *cp)
>> -- 
>> 2.7.2
> 
> .
> 
