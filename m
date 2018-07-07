From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: enable real-time discard by default
Date: Sat, 7 Jul 2018 09:44:32 +0800
Message-ID: <50f73892-fc50-f6c5-02ec-cd41f6bdb6fc@kernel.org>
References: <20180705062411.3757-1-yuchao0@huawei.com>
 <20180707011348.GB3904@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180707011348.GB3904@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/7 9:13, Jaegeuk Kim wrote:
> On 07/05, Chao Yu wrote:
>> f2fs is focused on flash based storage, so let's enable real-time
>> discard by default, if user don't want to enable it, 'nodiscard'
>> mount option should be used on mount.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/super.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 848badda50ad..980edeb0b650 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1366,12 +1366,11 @@ static void default_options(struct f2fs_sb_info *sbi)
>>  	set_opt(sbi, NOHEAP);
>>  	sbi->sb->s_flags |= SB_LAZYTIME;
>>  	set_opt(sbi, FLUSH_MERGE);
>> -	if (f2fs_sb_has_blkzoned(sbi->sb)) {
> 
> I added this.
> 
> 	if (blk_queue_discard(bdev_get_queue(sbi->sb->s_bdev)))

That's correct. Thank you! :)

Thanks,

> 
>> +	set_opt(sbi, DISCARD);
>> +	if (f2fs_sb_has_blkzoned(sbi->sb))
>>  		set_opt_mode(sbi, F2FS_MOUNT_LFS);
>> -		set_opt(sbi, DISCARD);
>> -	} else {
>> +	else
>>  		set_opt_mode(sbi, F2FS_MOUNT_ADAPTIVE);
>> -	}
>>  
>>  #ifdef CONFIG_F2FS_FS_XATTR
>>  	set_opt(sbi, XATTR_USER);
>> -- 
>> 2.18.0.rc1
