From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH RFC] f2fs: fix an error case of missing
 update inode page
Date: Fri, 15 Dec 2017 02:24:32 +0000
Message-ID: <42B685BFA705F94C860C6DD0752F0565482FA1E8@DGGEMA503-MBX.china.huawei.com>
References: <1512446867-29122-1-git-send-email-heyunlei@huawei.com>
 <20171214194627.GB35234@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1ePfgG-0001R9-Pi
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Dec 2017 02:24:56 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1ePfgE-0001Jc-DT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Dec 2017 02:24:56 +0000
In-Reply-To: <20171214194627.GB35234@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "Jianing (Euler)" <ning.jia@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>



>-----Original Message-----
>From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
>Sent: Friday, December 15, 2017 3:46 AM
>To: heyunlei
>Cc: Yuchao (T); linux-f2fs-devel@lists.sourceforge.net; Wangbintian; Jianing (Euler)
>Subject: Re: [f2fs-dev][PATCH RFC] f2fs: fix an error case of missing update inode page
>
>On 12/05, Yunlei He wrote:
>> -Thread A					Thread B
>>
>> -write_checkpoint
>> 	-block_operations
>> 		-f2fs_unlock_all		-f2fs_sync_file
>> 							-f2fs_write_inode
>> 								-f2fs_inode_synced
>>
>> 			-f2fs_sync_inode_meta
>> 				-sync_node_pages
>> 									-set_page_drity
>>
>> In this case, if sudden power off without next new checkpoint,
>> the last inode page update will lost. wb_writeback is same with
>> fsync.
>
>Does this patch fix the problem?
>
I modify code as below:
@@ -366,7 +366,7 @@ int update_inode(struct inode *inode, struct page *node_page)
        struct extent_tree *et = F2FS_I(inode)->extent_tree;
 
        f2fs_inode_synced(inode);
-
+       msleep(10000);
        f2fs_wait_on_page_writeback(node_page, NODE, true);

shell 1:                                       shell2:
dd if=/dev/zero of=./test bs=1M count=10
sync
echo "hello" >> ./test
fsync test  // sleep 10s
                   	                         sync  //return quickly
											 echo c > /proc/sysrq-trigger  //before fsync return 
fsck will find iblocks mismatch, and with this patch it 's ok.

Besides,I came across another error like this:

f2fs_inode-> i_xattr_nid is non-zero, but node blkaddr in raw nat entry is NULL.

This case makes sense to this problem also.

> -write_checkpoint
> 	-block_operations
> 		-f2fs_unlock_all		-f2fs_sync_file
> 							-f2fs_write_inode
> 								-set_page_drity
> 								-f2fs_inode_synced
> 			-f2fs_sync_inode_meta
> 				-sync_node_pages
>
>I think, we need to cover f2fs_lock_op() for f2fs_write_inode() again.

It can also work well with f2fs_lock_op(), I am afraid other cases will update inode
like f2fs_write_inode without f2fs_lock_op

Thanks
>
>Thanks,
>
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>> ---
>>  fs/f2fs/f2fs.h  |  4 ++--
>>  fs/f2fs/inode.c | 15 +++++++--------
>>  2 files changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 82f1dc3..38f9324 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -2513,8 +2513,8 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
>>  struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
>>  struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
>>  int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
>> -int update_inode(struct inode *inode, struct page *node_page);
>> -int update_inode_page(struct inode *inode);
>> +void update_inode(struct inode *inode, struct page *node_page);
>> +void update_inode_page(struct inode *inode);
>>  int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc);
>>  void f2fs_evict_inode(struct inode *inode);
>>  void handle_failed_inode(struct inode *inode);
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index b4c4f2b..10d3c7c 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -360,14 +360,15 @@ struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino)
>>  	return inode;
>>  }
>>
>> -int update_inode(struct inode *inode, struct page *node_page)
>> +void update_inode(struct inode *inode, struct page *node_page)
>>  {
>>  	struct f2fs_inode *ri;
>>  	struct extent_tree *et = F2FS_I(inode)->extent_tree;
>>
>> -	f2fs_inode_synced(inode);
>> -
>>  	f2fs_wait_on_page_writeback(node_page, NODE, true);
>> +	set_page_dirty(node_page);
>> +
>> +	f2fs_inode_synced(inode);
>>
>>  	ri = F2FS_INODE(node_page);
>>
>> @@ -426,10 +427,9 @@ int update_inode(struct inode *inode, struct page *node_page)
>>  	if (inode->i_nlink == 0)
>>  		clear_inline_node(node_page);
>>
>> -	return set_page_dirty(node_page);
>>  }
>>
>> -int update_inode_page(struct inode *inode)
>> +void update_inode_page(struct inode *inode)
>>  {
>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>  	struct page *node_page;
>> @@ -444,11 +444,10 @@ int update_inode_page(struct inode *inode)
>>  		} else if (err != -ENOENT) {
>>  			f2fs_stop_checkpoint(sbi, false);
>>  		}
>> -		return 0;
>> +		return;
>>  	}
>> -	ret = update_inode(inode, node_page);
>> +	update_inode(inode, node_page);
>>  	f2fs_put_page(node_page, 1);
>> -	return ret;
>>  }
>>
>>  int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
>> --
>> 1.9.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
