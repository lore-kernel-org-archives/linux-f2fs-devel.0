From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: handle quota for orphan inodes
Date: Tue, 27 Feb 2018 18:46:24 +0800
Message-ID: <49c1d817-f375-4194-8139-c352503a9a2d@huawei.com>
References: <20180210022841.5707-1-jaegeuk@kernel.org>
 <e48fd2e5-fab6-57c5-5fff-2e44f5a817b0@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e48fd2e5-fab6-57c5-5fff-2e44f5a817b0@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Ping,

On 2018/2/13 22:33, Chao Yu wrote:
> On 2018/2/10 10:28, Jaegeuk Kim wrote:
>> This is to fix missing dquot_initialize for orphan inodes.
> 
> IMO, we don't need to call dquot_initialize as we have call the function
> in evict(), right?
> 
> Thanks,
> 
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>  fs/f2fs/checkpoint.c | 28 ++++++++++++++++------------
>>  1 file changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 8b0945ba284d..e3bf753a47be 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -569,13 +569,8 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>>  	struct node_info ni;
>>  	int err = acquire_orphan_inode(sbi);
>>  
>> -	if (err) {
>> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
>> -		f2fs_msg(sbi->sb, KERN_WARNING,
>> -				"%s: orphan failed (ino=%x), run fsck to fix.",
>> -				__func__, ino);
>> -		return err;
>> -	}
>> +	if (err)
>> +		goto err_out;
>>  
>>  	__add_ino_entry(sbi, ino, 0, ORPHAN_INO);
>>  
>> @@ -589,6 +584,11 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>>  		return PTR_ERR(inode);
>>  	}
>>  
>> +	err = dquot_initialize(inode);
>> +	if (err)
>> +		goto err_out;
>> +
>> +	dquot_initialize(inode);
>>  	clear_nlink(inode);
>>  
>>  	/* truncate all the data during iput */
>> @@ -598,14 +598,18 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>>  
>>  	/* ENOMEM was fully retried in f2fs_evict_inode. */
>>  	if (ni.blk_addr != NULL_ADDR) {
>> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
>> -		f2fs_msg(sbi->sb, KERN_WARNING,
>> -			"%s: orphan failed (ino=%x) by kernel, retry mount.",
>> -				__func__, ino);
>> -		return -EIO;
>> +		err = -EIO;
>> +		goto err_out;
>>  	}
>>  	__remove_ino_entry(sbi, ino, ORPHAN_INO);
>>  	return 0;
>> +
>> +err_out:
>> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
>> +	f2fs_msg(sbi->sb, KERN_WARNING,
>> +			"%s: orphan failed (ino=%x), run fsck to fix.",
>> +			__func__, ino);
>> +	return err;
>>  }
>>  
>>  int recover_orphan_inodes(struct f2fs_sb_info *sbi)
>>
> 
> .
> 
