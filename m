From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: add a max block count for
 f2fs_map_blocks
Date: Sat, 26 Dec 2015 21:21:00 +0800
Message-ID: <567E943C.6050905@kernel.org>
References: <1451033257-2087-1-git-send-email-heyunlei@huawei.com>
	<018a01d13ef6$63c58120$2b508360$@samsung.com>
	<567D17B7.7060308@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1aComg-0003YL-EX
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Dec 2015 13:21:22 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aCome-0002RR-Pw for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Dec 2015 13:21:22 +0000
In-Reply-To: <567D17B7.7060308@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: liuxue <liuxueliu.liu@huawei.com>, 'Yunlei He' <heyunlei@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org

Hi,

On 12/25/15 6:17 PM, liuxue wrote:
> On 2015/12/25 17:25, Chao Yu wrote:
>> Hi,
>>
>>> -----Original Message-----
>>> From: Yunlei He [mailto:heyunlei@huawei.com]
>>> Sent: Friday, December 25, 2015 4:48 PM
>>> To: linux-f2fs-devel@lists.sourceforge.net; jaegeuk@kernel.org; chao2.yu@samsung.com
>>> Cc: bintian.wang@huawei.com; Yunlei He; Xue Liu
>>> Subject: [PATCH] f2fs: add a max block count for f2fs_map_blocks
>>>
>>> This patch adds a max block count for f2fs_map_blocks
>>
>> Maximum file size should be limited by sb->s_maxbytes which was inited
>> in max_file_size(), so logical block index should not exceed the value
>> calculated with maxbytes, why would we limit logical block index with
>> another value?
>>
>> Thanks,
>>
> 
> Hi,
> Trinity test program will send a block number as parameter into ioctl_fibmap, which will be used in
> get_node_path(), when the block number large than f2fs max blocks, it will trigger kernel bug.
> So we judge the block number in f2fs_map_blocks(), which reference ext4:

Thanks for the explanation, and this makes sense to me, it's better to add above
message in commit log.

> 
> file: fs/ext4/inode.c
> function: ext4_map_blocks()
> 
>      /* We can handle the block number less than EXT_MAX_BLOCKS */
>      if (unlikely(map->m_lblk >= EXT_MAX_BLOCKS))
>          return -EFSCORRUPTED;
> 
> 
>>>
>>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>>> Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
>>> ---
>>>   fs/f2fs/data.c | 4 ++++
>>>   fs/f2fs/f2fs.h | 3 +++
>>>   2 files changed, 7 insertions(+)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index e34b1bd..2a16c867 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -578,6 +578,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,

As you mentioned, this bug will only be triggered in bmap, so how about checking
upper boundary in get_data_block_bmap? Since we could remain bug_on in
get_node_path for other call paths to check whether this is a bug of VFS or not.

>>>   	map->m_len = 0;
>>>   	map->m_flags = 0;
>>>
>>> +	/* We can handle the block number less than F2FS_MAX_BLOCKS */
>>> +	if (unlikely(map->m_lblk >= F2FS_MAX_BLOCKS))
>>> +		return -EUCLEAN;

EFBIG ?

>>> +
>>>   	/* it only supports block size == page size */
>>>   	pgofs =	(pgoff_t)map->m_lblk;
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 19beabe..911c99b 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -331,6 +331,9 @@ enum {
>>>
>>>   #define F2FS_LINK_MAX	0xffffffff	/* maximum link count per file */
>>>
>>> +
>>> +#define F2FS_MAX_BLOCKS 0x3F015AFF      /* maximum block count per file */

Can you introduce F2FS_MAX_BLOCKS with calculation detail of constant
'0x3F015AFF', moreover need to exclude reserved space for inline xattr.

Thanks,

>>> +
>>>   #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
>>>
>>>   /* vector size for gang look-up from extent cache that consists of radix tree */
>>> --
>>> 1.9.1
>>
>>
>>
>> .
>
> 
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
