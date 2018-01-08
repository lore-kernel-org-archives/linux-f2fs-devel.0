From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: show precise # of blocks that
 user/root can use
Date: Mon, 8 Jan 2018 19:23:11 +0800
Message-ID: <8b4d0f60-3c5d-edce-f634-d8e489c79d59@huawei.com>
References: <20180103185845.29953-1-jaegeuk@kernel.org>
 <7206fb17-4785-756c-9fef-39565adf8780@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7206fb17-4785-756c-9fef-39565adf8780@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: miaoxie@huawei.com, chao <chao@kernel.org>, bintian.wang@huawei.com, heyunlei@huawei.com, "shengyong (A)" <shengyong1@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/1/5 15:05, Yunlong Song wrote:
> NACK
> 
> man statfs shows:
> 
> struct statfs {
>      ...
>      fsblkcnt_t   f_bfree;   /* free blocks in fs */
>      fsblkcnt_t   f_bavail;  /* free blocks available to
>                                      unprivileged user */
>      ...
> }
> 
> f_bfree is free blocks in fs, so buf->bfree should be
> 
> buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;

As I checked, some filesystems reserving over-privision space like
btrfs/xfs/ubifs, they will not calculate those space into f_bfree, IMO, we
should follow their behavior to keep compatibility for old applications.

Thanks,

> 
> On 2018/1/4 2:58, Jaegeuk Kim wrote:
>> Let's show precise # of blocks that user/root can use through bavail and bfree
>> respectively.
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>   fs/f2fs/super.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 0a820ba55b10..4c1c99cf54ef 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1005,9 +1005,9 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>   	buf->f_bsize = sbi->blocksize;
>>   
>>   	buf->f_blocks = total_count - start_count;
>> -	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
>> -	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
>> +	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
>>   						sbi->current_reserved_blocks;
>> +	buf->f_bavail = buf->f_bfree;
>>   
>>   	avail_node_count = sbi->total_node_count - sbi->nquota_files -
>>   						F2FS_RESERVED_NODE_NUM;
> 
