From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 4/4] f2fs: fix to spread clear_cold_data()
Date: Sun, 29 Jul 2018 10:19:26 +0800
Message-ID: <b7d39e79-dfb0-17c3-1eee-6afb969008a4@kernel.org>
References: <20180727101516.41403-1-yuchao0@huawei.com>
 <20180727101516.41403-4-yuchao0@huawei.com>
 <20180729020013.GG83620@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fjbJ5-0006Kg-So
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 Jul 2018 02:19:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fjbJ3-001Tb8-9Y
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 Jul 2018 02:19:39 +0000
In-Reply-To: <20180729020013.GG83620@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/7/29 10:00, Jaegeuk Kim wrote:
> On 07/27, Chao Yu wrote:
>> We need to drop PG_checked flag on page as well when we clear PG_uptodate
>> flag, in order to avoid treating the page as GCing one later.
> 
> What do you mean "treating the page as GCing one"?

I mean if PG_checked flag in page is not cleared, allocator will make it goes
into cold area.

static int __get_segment_type_6(struct f2fs_io_info *fio)
...
		if (is_cold_data(fio->page) || file_is_cold(inode))
			return CURSEG_COLD_DATA;

Thanks,

> 
>>
>> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/data.c    | 8 +++++++-
>>  fs/f2fs/dir.c     | 1 +
>>  fs/f2fs/segment.c | 4 +++-
>>  3 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index a29f3162b887..2817e2f4eb17 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1768,6 +1768,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>>  	/* This page is already truncated */
>>  	if (fio->old_blkaddr == NULL_ADDR) {
>>  		ClearPageUptodate(page);
>> +		clear_cold_data(page);
>>  		goto out_writepage;
>>  	}
>>  got_it:
>> @@ -1943,8 +1944,10 @@ static int __write_data_page(struct page *page, bool *submitted,
>>  
>>  out:
>>  	inode_dec_dirty_pages(inode);
>> -	if (err)
>> +	if (err) {
>>  		ClearPageUptodate(page);
>> +		clear_cold_data(page);
>> +	}
>>  
>>  	if (wbc->for_reclaim) {
>>  		f2fs_submit_merged_write_cond(sbi, inode, 0, page->index, DATA);
>> @@ -2534,6 +2537,8 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
>>  		}
>>  	}
>>  
>> +	clear_cold_data(page);
>> +
>>  	/* This is atomic written page, keep Private */
>>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
>>  		return f2fs_drop_inmem_page(inode, page);
>> @@ -2552,6 +2557,7 @@ int f2fs_release_page(struct page *page, gfp_t wait)
>>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
>>  		return 0;
>>  
>> +	clear_cold_data(page);
>>  	set_page_private(page, 0);
>>  	ClearPagePrivate(page);
>>  	return 1;
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index 7f955c4e86a4..1e4a4122eb0c 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -734,6 +734,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
>>  		clear_page_dirty_for_io(page);
>>  		ClearPagePrivate(page);
>>  		ClearPageUptodate(page);
>> +		clear_cold_data(page);
>>  		inode_dec_dirty_pages(dir);
>>  		f2fs_remove_dirty_inode(dir);
>>  	}
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 58abbdc53561..4d83961745e6 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -267,8 +267,10 @@ static int __revoke_inmem_pages(struct inode *inode,
>>  		}
>>  next:
>>  		/* we don't need to invalidate this in the sccessful status */
>> -		if (drop || recover)
>> +		if (drop || recover) {
>>  			ClearPageUptodate(page);
>> +			clear_cold_data(page);
>> +		}
>>  		set_page_private(page, 0);
>>  		ClearPagePrivate(page);
>>  		f2fs_put_page(page, 1);
>> -- 
>> 2.18.0.rc1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
