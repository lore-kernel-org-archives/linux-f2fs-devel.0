From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH RESEND v2] f2fs: release cp and dnode lock
	before IPU
Date: Fri, 28 Apr 2017 09:20:26 +0800
Message-ID: <2e30111a-4d99-e00c-d358-92d6af983f22@huawei.com>
References: <20170426161721.9362-1-chao@kernel.org>
	<20170427180857.GA10978@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d3uah-0005Z5-Pn
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Apr 2017 01:20:59 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187]
	helo=dggrg01-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d3uad-0004l2-D6
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Apr 2017 01:20:59 +0000
In-Reply-To: <20170427180857.GA10978@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2017/4/28 2:08, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On 04/27, Chao Yu wrote:
>> From: Hou Pengyang <houpengyang@huawei.com>
>>
>> We don't need to rewrite the page under cp_rwsem and dnode locks.
>>
>> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>  fs/f2fs/data.c    | 39 ++++++++++++++++++++++++---------------
>>  fs/f2fs/f2fs.h    |  2 +-
>>  fs/f2fs/gc.c      |  1 +
>>  fs/f2fs/segment.c |  1 +
>>  4 files changed, 27 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index ca21ecbd6bbd..632008241470 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1361,12 +1361,17 @@ int do_write_data_page(struct f2fs_io_info *fio)
>>  		if (fio->old_blkaddr != NULL_ADDR &&
>>  				fio->old_blkaddr != NEW_ADDR) {
>>  			ipu_force = true;
>> +			fio->need_lock = false;
>>  			goto got_it;
>>  		}
>>  	}
>> +
>> +	if (fio->need_lock)
>> +		f2fs_lock_op(fio->sbi);
>> +
>>  	err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
>>  	if (err)
>> -		return err;
>> +		goto out;
>>  
>>  	fio->old_blkaddr = dn.data_blkaddr;
>>  
>> @@ -1387,22 +1392,26 @@ int do_write_data_page(struct f2fs_io_info *fio)
>>  	 * it had better in-place writes for updated data.
>>  	 */
>>  	if (ipu_force || need_inplace_update(fio)) {
>> -		f2fs_bug_on(fio->sbi, !fio->cp_rwsem_locked);
>> -		f2fs_unlock_op(fio->sbi);
>> -		fio->cp_rwsem_locked = false;
>> -
>> +		f2fs_put_dnode(&dn);
>> +		if (fio->need_lock)
>> +			f2fs_unlock_op(fio->sbi);
>>  		err = rewrite_data_page(fio);
>>  		trace_f2fs_do_write_data_page(fio->page, IPU);
>>  		set_inode_flag(inode, FI_UPDATE_WRITE);
>> -	} else {
>> -		write_data_page(&dn, fio);
>> -		trace_f2fs_do_write_data_page(page, OPU);
>> -		set_inode_flag(inode, FI_APPEND_WRITE);
>> -		if (page->index == 0)
>> -			set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
>> +		return err;
>>  	}
>> +
>> +	/* LFS mode write path */
>> +	write_data_page(&dn, fio);
>> +	trace_f2fs_do_write_data_page(page, OPU);
>> +	set_inode_flag(inode, FI_APPEND_WRITE);
>> +	if (page->index == 0)
>> +		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
>>  out_writepage:
>>  	f2fs_put_dnode(&dn);
>> +out:
>> +	if (fio->need_lock)
>> +		f2fs_unlock_op(fio->sbi);
>>  	return err;
>>  }
>>  
>> @@ -1427,7 +1436,7 @@ static int __write_data_page(struct page *page, bool *submitted,
>>  		.page = page,
>>  		.encrypted_page = NULL,
>>  		.submitted = false,
>> -		.cp_rwsem_locked = true,
>> +		.need_lock = true,
>>  	};
>>  
>>  	trace_f2fs_writepage(page, DATA);
>> @@ -1463,6 +1472,7 @@ static int __write_data_page(struct page *page, bool *submitted,
>>  
>>  	/* Dentry blocks are controlled by checkpoint */
>>  	if (S_ISDIR(inode->i_mode)) {
>> +		fio.need_lock = false;
>>  		err = do_write_data_page(&fio);
>>  		goto done;
>>  	}
>> @@ -1480,13 +1490,12 @@ static int __write_data_page(struct page *page, bool *submitted,
>>  		if (!err)
>>  			goto out;
>>  	}
>> -	f2fs_lock_op(sbi);
>> +
>>  	if (err == -EAGAIN)
>>  		err = do_write_data_page(&fio);
>>  	if (F2FS_I(inode)->last_disk_size < psize)
>>  		F2FS_I(inode)->last_disk_size = psize;
>> -	if (fio.cp_rwsem_locked)
>> -		f2fs_unlock_op(sbi);
>> +
>>  done:
>>  	if (err && err != -ENOENT)
>>  		goto redirty_out;
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index bf48213642ab..95fb347e7abe 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -802,7 +802,7 @@ struct f2fs_io_info {
>>  	struct page *page;	/* page to be written */
>>  	struct page *encrypted_page;	/* encrypted page */
>>  	bool submitted;		/* indicate IO submission */
>> -	bool cp_rwsem_locked;	/* indicate cp_rwsem is held */
>> +	bool need_lock;		/* indicate we need to lock cp_rwsem */
>>  };
>>  
>>  #define is_read_io(rw) ((rw) == READ)
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index c2a9ae8397d3..ffabdcf52b85 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -717,6 +717,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>>  			.old_blkaddr = NULL_ADDR,
>>  			.page = page,
>>  			.encrypted_page = NULL,
>> +			.need_lock = false,
> 
> Should be true.
> 
>>  		};
>>  		bool is_dirty = PageDirty(page);
>>  		int err;
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 4ba61ca430d0..63ea066f7dc0 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -293,6 +293,7 @@ static int __commit_inmem_pages(struct inode *inode,
>>  		.op_flags = REQ_SYNC | REQ_PRIO,
>>  		.old_blkaddr = NULL_ADDR,
>>  		.encrypted_page = NULL,
>> +		.need_lock = false,
> 
> Set it below per each do_write_page() call.
> 
>>  	};
>>  	pgoff_t last_idx = ULONG_MAX;
>>  	int err = 0;
>> -- 
>> 2.12.2.575.gb14f27f
> 
> So, like this?

Yup, thanks for the fixing. ;)

Thanks,


> 
>>From 7718913e1c2bf8eb7f7719c40390e86f11d00f28 Mon Sep 17 00:00:00 2001
> From: Hou Pengyang <houpengyang@huawei.com>
> Date: Thu, 27 Apr 2017 00:17:21 +0800
> Subject: [PATCH] f2fs: release cp and dnode lock before IPU
> 
> We don't need to rewrite the page under cp_rwsem and dnode locks.
> 
> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c    | 39 ++++++++++++++++++++++++---------------
>  fs/f2fs/f2fs.h    |  2 +-
>  fs/f2fs/gc.c      |  1 +
>  fs/f2fs/segment.c |  1 +
>  4 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 2f2de18d24fe..1254986dd6eb 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1368,12 +1368,17 @@ int do_write_data_page(struct f2fs_io_info *fio)
>  
>  		if (valid_ipu_blkaddr(fio)) {
>  			ipu_force = true;
> +			fio->need_lock = false;
>  			goto got_it;
>  		}
>  	}
> +
> +	if (fio->need_lock)
> +		f2fs_lock_op(fio->sbi);
> +
>  	err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
>  	if (err)
> -		return err;
> +		goto out;
>  
>  	fio->old_blkaddr = dn.data_blkaddr;
>  
> @@ -1394,22 +1399,26 @@ int do_write_data_page(struct f2fs_io_info *fio)
>  	 * it had better in-place writes for updated data.
>  	 */
>  	if (ipu_force || (valid_ipu_blkaddr(fio) && need_inplace_update(fio))) {
> -		f2fs_bug_on(fio->sbi, !fio->cp_rwsem_locked);
> -		f2fs_unlock_op(fio->sbi);
> -		fio->cp_rwsem_locked = false;
> -
> +		f2fs_put_dnode(&dn);
> +		if (fio->need_lock)
> +			f2fs_unlock_op(fio->sbi);
>  		err = rewrite_data_page(fio);
>  		trace_f2fs_do_write_data_page(fio->page, IPU);
>  		set_inode_flag(inode, FI_UPDATE_WRITE);
> -	} else {
> -		write_data_page(&dn, fio);
> -		trace_f2fs_do_write_data_page(page, OPU);
> -		set_inode_flag(inode, FI_APPEND_WRITE);
> -		if (page->index == 0)
> -			set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
> +		return err;
>  	}
> +
> +	/* LFS mode write path */
> +	write_data_page(&dn, fio);
> +	trace_f2fs_do_write_data_page(page, OPU);
> +	set_inode_flag(inode, FI_APPEND_WRITE);
> +	if (page->index == 0)
> +		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
>  out_writepage:
>  	f2fs_put_dnode(&dn);
> +out:
> +	if (fio->need_lock)
> +		f2fs_unlock_op(fio->sbi);
>  	return err;
>  }
>  
> @@ -1434,7 +1443,7 @@ static int __write_data_page(struct page *page, bool *submitted,
>  		.page = page,
>  		.encrypted_page = NULL,
>  		.submitted = false,
> -		.cp_rwsem_locked = true,
> +		.need_lock = true,
>  	};
>  
>  	trace_f2fs_writepage(page, DATA);
> @@ -1470,6 +1479,7 @@ static int __write_data_page(struct page *page, bool *submitted,
>  
>  	/* Dentry blocks are controlled by checkpoint */
>  	if (S_ISDIR(inode->i_mode)) {
> +		fio.need_lock = false;
>  		err = do_write_data_page(&fio);
>  		goto done;
>  	}
> @@ -1487,13 +1497,12 @@ static int __write_data_page(struct page *page, bool *submitted,
>  		if (!err)
>  			goto out;
>  	}
> -	f2fs_lock_op(sbi);
> +
>  	if (err == -EAGAIN)
>  		err = do_write_data_page(&fio);
>  	if (F2FS_I(inode)->last_disk_size < psize)
>  		F2FS_I(inode)->last_disk_size = psize;
> -	if (fio.cp_rwsem_locked)
> -		f2fs_unlock_op(sbi);
> +
>  done:
>  	if (err && err != -ENOENT)
>  		goto redirty_out;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 59eea5b9f6a1..914b5c64cfae 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -803,7 +803,7 @@ struct f2fs_io_info {
>  	struct page *page;	/* page to be written */
>  	struct page *encrypted_page;	/* encrypted page */
>  	bool submitted;		/* indicate IO submission */
> -	bool cp_rwsem_locked;	/* indicate cp_rwsem is held */
> +	bool need_lock;		/* indicate we need to lock cp_rwsem */
>  };
>  
>  #define is_read_io(rw) ((rw) == READ)
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index c2a9ae8397d3..026522107ca3 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -717,6 +717,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>  			.old_blkaddr = NULL_ADDR,
>  			.page = page,
>  			.encrypted_page = NULL,
> +			.need_lock = true,
>  		};
>  		bool is_dirty = PageDirty(page);
>  		int err;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 656e1515ff56..e302f30ec7fe 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -312,6 +312,7 @@ static int __commit_inmem_pages(struct inode *inode,
>  			fio.page = page;
>  			fio.old_blkaddr = NULL_ADDR;
>  			fio.encrypted_page = NULL;
> +			fio.need_lock = false,
>  			err = do_write_data_page(&fio);
>  			if (err) {
>  				unlock_page(page);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
