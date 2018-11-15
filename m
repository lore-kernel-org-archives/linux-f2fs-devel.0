From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: add bio cache for IPU
Date: Thu, 15 Nov 2018 16:32:22 +0800
Message-ID: <944355f6-49d8-f579-aad6-53c54258e90b@huawei.com>
References: <20181023083817.3466-1-yuchao0@huawei.com>
 <20181115075226.GA83610@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gND4l-0002zp-Re
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 15 Nov 2018 08:32:35 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gND4j-000tKc-5v
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 15 Nov 2018 08:32:35 +0000
In-Reply-To: <20181115075226.GA83610@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaeguek,

On 2018/11/15 15:52, Jaegeuk Kim wrote:
> Hi Chao,
> 
> I suspect this brings a system stuck by missing bio being flushed. Please check
> the changes.

Oh, let me check this patch.

Thanks,

> 
> Thanks,
> 
> On 10/23, Chao Yu wrote:
>> SQLite in Wal mode may trigger sequential IPU write in db-wal file, after
>> commit d1b3e72d5490 ("f2fs: submit bio of in-place-update pages"), we
>> lost the chance of merging page in inner managed bio cache, result in
>> submitting more small-sized IO.
>>
>> So let's add temporary bio in writepages() to cache mergeable write IO as
>> much as possible.
>>
>> Test case:
>> 1. xfs_io -f /mnt/f2fs/file -c "pwrite 0 65536" -c "fsync"
>> 2. xfs_io -f /mnt/f2fs/file -c "pwrite 0 65536" -c "fsync"
>>
>> Before:
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65544, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65552, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65560, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65568, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65576, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65584, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65592, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65600, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65608, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65616, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65624, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65632, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65640, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65648, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65656, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65664, size = 4096
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), NODE, sector = 57352, size = 4096
>>
>> After:
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65544, size = 65536
>> f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), NODE, sector = 57368, size = 4096
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/data.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++--
>>  fs/f2fs/f2fs.h    |  3 +++
>>  fs/f2fs/segment.c |  5 ++++-
>>  3 files changed, 62 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 01b7f59523dc..0c8f18dc140d 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -491,6 +491,49 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>>  	return 0;
>>  }
>>  
>> +int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>> +{
>> +	struct bio *bio = *fio->bio;
>> +	struct page *page = fio->encrypted_page ?
>> +			fio->encrypted_page : fio->page;
>> +
>> +	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
>> +			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
>> +		return -EFAULT;
>> +
>> +	trace_f2fs_submit_page_bio(page, fio);
>> +	f2fs_trace_ios(fio, 0);
>> +
>> +	if (bio && (*fio->last_block + 1 != fio->new_blkaddr ||
>> +			!__same_bdev(fio->sbi, fio->new_blkaddr, bio))) {
>> +		__submit_bio(fio->sbi, bio, fio->type);
>> +		bio = NULL;
>> +	}
>> +alloc_new:
>> +	if (!bio) {
>> +		bio = __bio_alloc(fio->sbi, fio->new_blkaddr, fio->io_wbc,
>> +				BIO_MAX_PAGES, false, fio->type, fio->temp);
>> +		*fio->last_block = fio->new_blkaddr;
>> +		bio_set_op_attrs(bio, fio->op, fio->op_flags);
>> +	}
>> +
>> +	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
>> +		__submit_bio(fio->sbi, bio, fio->type);
>> +		bio = NULL;
>> +		goto alloc_new;
>> +	}
>> +
>> +	if (fio->io_wbc)
>> +		wbc_account_io(fio->io_wbc, page, PAGE_SIZE);
>> +
>> +	*fio->last_block = fio->new_blkaddr;
>> +
>> +	inc_page_count(fio->sbi, WB_DATA_TYPE(fio->page));
>> +
>> +	*fio->bio = bio;
>> +	return 0;
>> +}
>> +
>>  void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>  {
>>  	struct f2fs_sb_info *sbi = fio->sbi;
>> @@ -1899,6 +1942,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>>  }
>>  
>>  static int __write_data_page(struct page *page, bool *submitted,
>> +				struct bio **bio,
>> +				sector_t *last_block,
>>  				struct writeback_control *wbc,
>>  				enum iostat_type io_type)
>>  {
>> @@ -1924,6 +1969,8 @@ static int __write_data_page(struct page *page, bool *submitted,
>>  		.need_lock = LOCK_RETRY,
>>  		.io_type = io_type,
>>  		.io_wbc = wbc,
>> +		.bio = bio,
>> +		.last_block = last_block,
>>  	};
>>  
>>  	trace_f2fs_writepage(page, DATA);
>> @@ -2051,7 +2098,7 @@ static int __write_data_page(struct page *page, bool *submitted,
>>  static int f2fs_write_data_page(struct page *page,
>>  					struct writeback_control *wbc)
>>  {
>> -	return __write_data_page(page, NULL, wbc, FS_DATA_IO);
>> +	return __write_data_page(page, NULL, NULL, NULL, wbc, FS_DATA_IO);
>>  }
>>  
>>  /*
>> @@ -2067,6 +2114,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>  	int done = 0;
>>  	struct pagevec pvec;
>>  	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
>> +	struct bio *bio = NULL;
>> +	sector_t last_block;
>>  	int nr_pages;
>>  	pgoff_t uninitialized_var(writeback_index);
>>  	pgoff_t index;
>> @@ -2154,7 +2203,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>  			if (!clear_page_dirty_for_io(page))
>>  				goto continue_unlock;
>>  
>> -			ret = __write_data_page(page, &submitted, wbc, io_type);
>> +			ret = __write_data_page(page, &submitted, &bio,
>> +						&last_block, wbc, io_type);
>>  			if (unlikely(ret)) {
>>  				/*
>>  				 * keep nr_to_write, since vfs uses this to
>> @@ -2201,6 +2251,9 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>  	if (nwritten)
>>  		f2fs_submit_merged_write_cond(F2FS_M_SB(mapping), mapping->host,
>>  								NULL, 0, DATA);
>> +	/* submit cached bio of IPU write */
>> +	if (bio)
>> +		__submit_bio(sbi, bio, DATA);
>>  
>>  	return ret;
>>  }
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 8932276015f9..6af2a105529d 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1042,6 +1042,8 @@ struct f2fs_io_info {
>>  	bool retry;		/* need to reallocate block address */
>>  	enum iostat_type io_type;	/* io type */
>>  	struct writeback_control *io_wbc; /* writeback control */
>> +	struct bio **bio;		/* bio for ipu */
>> +	sector_t *last_block;		/* last block number in bio */
>>  	unsigned char version;		/* version of the node */
>>  };
>>  
>> @@ -3085,6 +3087,7 @@ void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
>>  				nid_t ino, enum page_type type);
>>  void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi);
>>  int f2fs_submit_page_bio(struct f2fs_io_info *fio);
>> +int f2fs_merge_page_bio(struct f2fs_io_info *fio);
>>  void f2fs_submit_page_write(struct f2fs_io_info *fio);
>>  struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
>>  			block_t blk_addr, struct bio *bio);
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 3aa2f00262b3..b51b182dd7f4 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -3194,7 +3194,10 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
>>  
>>  	stat_inc_inplace_blocks(fio->sbi);
>>  
>> -	err = f2fs_submit_page_bio(fio);
>> +	if (fio->bio)
>> +		err = f2fs_merge_page_bio(fio);
>> +	else
>> +		err = f2fs_submit_page_bio(fio);
>>  	if (!err)
>>  		update_device_state(fio);
>>  
>> -- 
>> 2.18.0.rc1
> 
> .
> 
