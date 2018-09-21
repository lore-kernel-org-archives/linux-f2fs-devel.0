From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: avoid GC causing encrypted file corrupted
Date: Fri, 21 Sep 2018 22:20:20 +0800
Message-ID: <aa837149-1dc3-9b75-a54c-00703781b2b4@kernel.org>
References: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
 <20180918181705.GG91945@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918181705.GG91945@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Yunlong Song <yunlong.song@huawei.com>
Cc: yuchao0@huawei.com, yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/19 2:17, Jaegeuk Kim wrote:
> On 09/18, Yunlong Song wrote:
>> The encrypted file may be corrupted by GC in following case:
>>
>> Time 1: | segment 1 blkaddr = A |  GC -> | segment 2 blkaddr = B |
>> Encrypted block 1 is moved from blkaddr A of segment 1 to blkaddr B of
>> segment 2,
>>
>> Time 2: | segment 1 blkaddr = B |  GC -> | segment 3 blkaddr = C |
> 
>             segment 2 blkaddr = B?
> 
>>
>> Before page 1 is written back and if segment 2 become a victim, then
>> page 1 is moved from blkaddr B of segment 2 to blkaddr Cof segment 3,
> 
>                                                          C of ?
> 
>> during the GC process of Time 2, f2fs should wait for page 1 written back
>> before reading it, or move_data_block will read a garbage block from
>> blkaddr B since page is not written back to blkaddr B yet.
> 
> move_data_block() checks PageUptodate() so it won't get garbage, yes?

I think the problem here is:

Thread A				Background GC Thread
- writepage
 - f2fs_outplace_write_data
 fio->encrypted_page is in-flight
					- gc_data_segment
					 - ra_data_block
					  - f2fs_pagecache_get_page
					  - f2fs_submit_page_bio
					  cache garbage data in meta page
Device
Receive encrypted data
- f2fs_write_end_io
					 - move_data_block
					  - f2fs_pagecache_get_page
					  - if (PageUptodate(mpage)) memcpy()
					  So here we copy garbage data into meta page
					  - f2fs_submit_page_write
					  Here we migrate incorrect data to new address

> So, does ra_data_block need to check PageUptodate?

Yes, I think so, could improve this in another patch.

Thanks,

> 
>>
>> Commit 6aa58d8a ("f2fs: readahead encrypted block during GC") introduce
>> ra_data_block to read encrypted block, but it forgets to add
>> f2fs_wait_on_page_writeback to avoid racing between GC and flush.
>>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>  fs/f2fs/gc.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index a4c1a41..c55fb62 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -641,6 +641,14 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>>  	fio.page = page;
>>  	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
>>  
>> +	/*
>> +	 * don't cache encrypted data into meta inode until previous dirty
>> +	 * data were writebacked to avoid racing between GC and flush.
>> +	 */
>> +	f2fs_wait_on_page_writeback(page, DATA, true);
>> +
>> +	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
>> +
>>  	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(sbi),
>>  					dn.data_blkaddr,
>>  					FGP_LOCK | FGP_CREAT, GFP_NOFS);
>> @@ -723,6 +731,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>  	 */
>>  	f2fs_wait_on_page_writeback(page, DATA, true);
>>  
>> +	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
>> +
>>  	err = f2fs_get_node_info(fio.sbi, dn.nid, &ni);
>>  	if (err)
>>  		goto put_out;
>> -- 
>> 1.8.5.2
