From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: fix to avoid potential negative .f_bfree
Date: Mon, 29 Apr 2019 22:13:55 +0800
Message-ID: <f8b890b8-22a3-bead-7df5-6ab87deb56e9@kernel.org>
References: <20190426095754.85784-1-yuchao0@huawei.com>
 <20190428134722.GC37346@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190428134722.GC37346@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, drosen@google.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019-4-28 21:47, Jaegeuk Kim wrote:
> On 04/26, Chao Yu wrote:
>> When calculating .f_bfree value in f2fs_statfs(), sbi->unusable_block_count
>> can be increased after the judgment condition, result in overflow of
>> .f_bfree in later calculation. This patch fixes to use a temporary signed
>> variable to save the calculation result of .f_bfree.
>>
>> 	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
>>  		buf->f_bfree = 0;
>>  	else
>> 		buf->f_bfree -= sbi->unusable_block_count;
> 
> Do we just need stat_lock for this?

Like we access other stat value in statfs(), we just need the instantaneous
value of .unusable_block_count, so we don't need additional stat_lock, right?

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/super.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 2376bb01b5c4..fcc9793dbc2c 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1216,6 +1216,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>  	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
>>  	block_t total_count, user_block_count, start_count;
>>  	u64 avail_node_count;
>> +	long long bfree;
>>  
>>  	total_count = le64_to_cpu(sbi->raw_super->block_count);
>>  	user_block_count = sbi->user_block_count;
>> @@ -1226,10 +1227,12 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>  	buf->f_blocks = total_count - start_count;
>>  	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
>>  						sbi->current_reserved_blocks;
>> -	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
>> +
>> +	bfree = buf->f_bfree - sbi->unusable_block_count;
>> +	if (unlikely(bfree < 0))
>>  		buf->f_bfree = 0;
>>  	else
>> -		buf->f_bfree -= sbi->unusable_block_count;
>> +		buf->f_bfree = bfree;
>>  
>>  	if (buf->f_bfree > F2FS_OPTION(sbi).root_reserved_blocks)
>>  		buf->f_bavail = buf->f_bfree -
>> -- 
>> 2.18.0.rc1
