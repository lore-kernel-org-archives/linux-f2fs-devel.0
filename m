From: guoweichao <guoweichao@huawei.com>
Subject: Re: [PATCH] f2fs: no need to punch hole far beyond the
 file size
Date: Sat, 14 Oct 2017 00:03:04 +0800
Message-ID: <05b86d7f-bed8-4043-7660-6fc10fd4e782@huawei.com>
References: <59E9362FEE765E42B5D239BD8C9B523401D368BD@dggeml509-mbx.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <guoweichao@huawei.com>)
 id 1e32Qu-0001jI-Qa
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 16:03:32 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e32Qt-0002HC-2u
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 16:03:32 +0000
In-Reply-To: <59E9362FEE765E42B5D239BD8C9B523401D368BD@dggeml509-mbx.china.huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: yuchao0@huawei.com
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net



On 2017/10/13 20:43, Chao Yu wrote:
> 
> On 2017/10/14 0:59, Weichao Guo wrote:
>> Punching hole with a length which far larger than file size will cause 
>> a long time looping in truncate_hole after lock_op, it can be 
>> reproduced as the following:
>>
>>         $ echo "abc" > file
>>         $ xfs_io -c "fpunch 0 HUGE_LENGTH" file
>>
>> This may cause other I/Os blocked a long time. Let's fix this case by 
>> setting the hole to end after the page that contains i_size.
> You know, we can reserve blocks across EOF through fallocate(fd, FALLOC_FL_KEEP_SIZE, ofs, len), so this patch will cause f2fs losing ability of punching preallocated blocks across EOF.
> 
Oh, I see. Let me prepare another patch.
> How about below change:
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c index cfee75bf88d9..91fd2ef7221b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -847,7 +847,7 @@ int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
>  		err = get_dnode_of_data(&dn, pg_start, LOOKUP_NODE);
>  		if (err) {
>  			if (err == -ENOENT) {
> -				pg_start++;
> +				pg_start = get_next_page_offset(&dn, pg_start);
>  				continue;
>  			}
>  			return err;
> 
> Thanks,
> 
>>
>> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
>> ---
>>  fs/f2fs/file.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c index 517e112..1b44d26 
>> 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -873,6 +873,14 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
>>  	if (ret)
>>  		return ret;
>>  
>> +	/*
>> +	 * If the hole extends beyond i_size, set the hole
>> +	 * to end after the page that contains i_size
>> +	 */
>> +	if (offset + len > inode->i_size)
>> +		len = inode->i_size + PAGE_CACHE_SIZE -
>> +			(inode->i_size & (PAGE_CACHE_SIZE - 1)) - offset;
>> +
>>  	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
>>  	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
>>  
>>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
