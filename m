From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2 1/2] f2fs: fix to avoid broken of dnode block list
Date: Sat, 7 Jul 2018 07:30:50 +0800
Message-ID: <65fb52d5-7bb6-2f01-955d-df7c2e2010a4@kernel.org>
References: <20180704085614.13004-1-yuchao0@huawei.com>
 <20180706223246.GA77984@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706223246.GA77984@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/7 6:32, Jaegeuk Kim wrote:
> On 07/04, Chao Yu wrote:
>> f2fs recovery flow is relying on dnode block link list, it means fsynced
>> file recovery depends on previous dnode's persistence in the list, so
>> during fsync() we should wait on all regular inode's dnode writebacked
>> before issuing flush.
> 
> We don't need to wait for all the writebacking nodes which can enter later.
> Can we add a list of nids that we need to wait for?

Agreed, let me update it later. :)

Thanks,

> 
>>
>> By this way, we can avoid dnode block list being broken by out-of-order
>> IO submission due to IO scheduler or driver.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v2: add missing definition modification in f2fs.h.
>>  fs/f2fs/f2fs.h |  2 +-
>>  fs/f2fs/file.c | 17 ++++-------------
>>  fs/f2fs/node.c |  4 ++--
>>  3 files changed, 7 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 859ecde81dd0..a9da5a089cb4 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -2825,7 +2825,7 @@ pgoff_t f2fs_get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs);
>>  int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode);
>>  int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);
>>  int f2fs_truncate_xattr_node(struct inode *inode);
>> -int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino);
>> +int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi);
>>  int f2fs_remove_inode_page(struct inode *inode);
>>  struct page *f2fs_new_inode_page(struct inode *inode);
>>  struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 752ff678bfe0..ecca7b833268 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -292,19 +292,10 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>  		goto sync_nodes;
>>  	}
>>  
>> -	/*
>> -	 * If it's atomic_write, it's just fine to keep write ordering. So
>> -	 * here we don't need to wait for node write completion, since we use
>> -	 * node chain which serializes node blocks. If one of node writes are
>> -	 * reordered, we can see simply broken chain, resulting in stopping
>> -	 * roll-forward recovery. It means we'll recover all or none node blocks
>> -	 * given fsync mark.
>> -	 */
>> -	if (!atomic) {
>> -		ret = f2fs_wait_on_node_pages_writeback(sbi, ino);
>> -		if (ret)
>> -			goto out;
>> -	}
>> +
>> +	ret = f2fs_wait_on_node_pages_writeback(sbi);
>> +	if (ret)
>> +		goto out;
>>  
>>  	/* once recovery info is written, don't need to tack this */
>>  	f2fs_remove_ino_entry(sbi, ino, APPEND_INO);
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 849c2ed9c152..0810c8117d46 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -1710,7 +1710,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>>  	return ret;
>>  }
>>  
>> -int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
>> +int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi)
>>  {
>>  	pgoff_t index = 0;
>>  	struct pagevec pvec;
>> @@ -1726,7 +1726,7 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
>>  		for (i = 0; i < nr_pages; i++) {
>>  			struct page *page = pvec.pages[i];
>>  
>> -			if (ino && ino_of_node(page) == ino) {
>> +			if (IS_DNODE(page) && is_cold_node(page)) {
>>  				f2fs_wait_on_page_writeback(page, NODE, true);
>>  				if (TestClearPageError(page))
>>  					ret = -EIO;
>> -- 
>> 2.18.0.rc1
