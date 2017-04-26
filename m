From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/4] f2fs: check IPU before cp to avoid IPU
 being blocked by cp
Date: Wed, 26 Apr 2017 10:23:58 +0800
Message-ID: <17a356ed-3d52-7d37-ed51-acb32c7d1314@huawei.com>
References: <20170425124515.160446-1-houpengyang@huawei.com>
	<20170425124515.160446-4-houpengyang@huawei.com>
	<20170426012258.GA13347@jaegeuk.local>
	<20170426012752.GA13449@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d3Cd1-00067D-Fd
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Apr 2017 02:24:27 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189]
	helo=dggrg03-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d3Ccz-0002SJ-7H
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Apr 2017 02:24:27 +0000
In-Reply-To: <20170426012752.GA13449@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Hou Pengyang <houpengyang@huawei.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk, Pengyang,

On 2017/4/26 9:27, Jaegeuk Kim wrote:
> On 04/25, Jaegeuk Kim wrote:
>> Hi Pengyang,
>>
>> This makes xfstests/generic/013 stuck on fsstress.
> 
> Oh, it seems lock inversion problem between f2fs_lock_op and get_dnode_of_data.
> The basic rule is get_dnode_of_data is covered by f2fs_lock_op.
> I'll drop this patch at this moment.

Seems we need to change as below?

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ec9eace05df..f3564a948293 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1364,12 +1364,17 @@ int do_write_data_page(struct f2fs_io_info *fio)

 		if (valid_ipu_blkaddr(fio)) {
 			ipu_force = true;
+			fio->need_lock = false;
 			goto got_it;
 		}
 	}
+
+	if (fio->need_lock)
+		f2fs_lock_op(fio->sbi);
+
 	err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
 	if (err)
-		return err;
+		goto out;

 	fio->old_blkaddr = dn.data_blkaddr;

@@ -1400,17 +1405,16 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	}

 	/* LFS mode write path */
-	if (!fio->cp_rwsem_locked)
-		f2fs_lock_op(fio->sbi);
 	write_data_page(&dn, fio);
 	trace_f2fs_do_write_data_page(page, OPU);
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	if (page->index == 0)
 		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
-	if (!fio->cp_rwsem_locked)
-		f2fs_unlock_op(fio->sbi);
 out_writepage:
 	f2fs_put_dnode(&dn);
+out:
+	if (fio->need_lock)
+		f2fs_unlock_op(fio->sbi);
 	return err;
 }

@@ -1435,7 +1439,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 		.page = page,
 		.encrypted_page = NULL,
 		.submitted = false,
-		.cp_rwsem_locked = true,
+		.need_lock = true,
 	};

 	trace_f2fs_writepage(page, DATA);
@@ -1471,6 +1475,7 @@ static int __write_data_page(struct page *page, bool *submitted,

 	/* Dentry blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode)) {
+		fio.need_lock = false,
 		err = do_write_data_page(&fio);
 		goto done;
 	}
@@ -1488,13 +1493,12 @@ static int __write_data_page(struct page *page, bool *submitted,
 		if (!err)
 			goto out;
 	}
-	f2fs_lock_op(sbi);
+
 	if (err == -EAGAIN)
 		err = do_write_data_page(&fio);
 	if (F2FS_I(inode)->last_disk_size < psize)
 		F2FS_I(inode)->last_disk_size = psize;
-	if (fio.cp_rwsem_locked)
-		f2fs_unlock_op(sbi);
+
 done:
 	if (err && err != -ENOENT)
 		goto redirty_out;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bf48213642ab..95fb347e7abe 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -802,7 +802,7 @@ struct f2fs_io_info {
 	struct page *page;	/* page to be written */
 	struct page *encrypted_page;	/* encrypted page */
 	bool submitted;		/* indicate IO submission */
-	bool cp_rwsem_locked;	/* indicate cp_rwsem is held */
+	bool need_lock;		/* indicate we need to lock cp_rwsem */
 };

 #define is_read_io(rw) ((rw) == READ)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c2a9ae8397d3..ffabdcf52b85 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -717,6 +717,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 			.old_blkaddr = NULL_ADDR,
 			.page = page,
 			.encrypted_page = NULL,
+			.need_lock = false,
 		};
 		bool is_dirty = PageDirty(page);
 		int err;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ee9b56da0b7e..c155adbac8fc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -293,6 +293,7 @@ static int __commit_inmem_pages(struct inode *inode,
 		.op_flags = REQ_SYNC | REQ_PRIO,
 		.old_blkaddr = NULL_ADDR,
 		.encrypted_page = NULL,
+		.need_lock = false,
 	};
 	pgoff_t last_idx = ULONG_MAX;
 	int err = 0;


> 
> Thanks,
> 
>>
>> Thanks,
>>
>> On 04/25, Hou Pengyang wrote:
>>> IPU checking is under f2fs_lock_op, as a result, some IPU page(such as fsync/fdatasync IPU)
>>> may be blocked by a long time cp.
>>>
>>> This patch fix this by doing IPU checking before f2fs_lock_op, so fsync IPU could go along with cp.
>>>
>>> Suggested-by: He Yunlei <heyunlei@huawei.com>
>>> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
>>> ---
>>>  fs/f2fs/data.c    | 14 +++++++-------
>>>  fs/f2fs/gc.c      |  1 +
>>>  fs/f2fs/segment.c |  1 +
>>>  3 files changed, 9 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 183a426..9bf9c7d 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1380,19 +1380,20 @@ int do_write_data_page(struct f2fs_io_info *fio)
>>>  	 * it had better in-place writes for updated data.
>>>  	 */
>>>  	if (need_inplace_update(fio)) {
>>> -		f2fs_bug_on(fio->sbi, !fio->cp_rwsem_locked);
>>> -		f2fs_unlock_op(fio->sbi);
>>> -		fio->cp_rwsem_locked = false;
>>> -
>>> +		f2fs_bug_on(fio->sbi, fio->cp_rwsem_locked);
>>>  		err = rewrite_data_page(fio);
>>>  		trace_f2fs_do_write_data_page(fio->page, IPU);
>>>  		set_inode_flag(inode, FI_UPDATE_WRITE);
>>>  	} else {
>>> +		if (!fio->cp_rwsem_locked)
>>> +			f2fs_lock_op(fio->sbi);
>>>  		write_data_page(&dn, fio);
>>>  		trace_f2fs_do_write_data_page(page, OPU);
>>>  		set_inode_flag(inode, FI_APPEND_WRITE);
>>>  		if (page->index == 0)
>>>  			set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
>>> +		if (!fio->cp_rwsem_locked)
>>> +			f2fs_unlock_op(fio->sbi);
>>>  	}
>>>  out_writepage:
>>>  	f2fs_put_dnode(&dn);
>>> @@ -1473,13 +1474,12 @@ static int __write_data_page(struct page *page, bool *submitted,
>>>  		if (!err)
>>>  			goto out;
>>>  	}
>>> -	f2fs_lock_op(sbi);
>>> +
>>> +	fio.cp_rwsem_locked = false;
>>>  	if (err == -EAGAIN)
>>>  		err = do_write_data_page(&fio);
>>>  	if (F2FS_I(inode)->last_disk_size < psize)
>>>  		F2FS_I(inode)->last_disk_size = psize;
>>> -	if (fio.cp_rwsem_locked)
>>> -		f2fs_unlock_op(sbi);
>>>  done:
>>>  	if (err && err != -ENOENT)
>>>  		goto redirty_out;
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index e034857..b32cc30 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -715,6 +715,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>>>  			.old_blkaddr = NULL_ADDR,
>>>  			.page = page,
>>>  			.encrypted_page = NULL,
>>> +			.cp_rwsem_locked = true,
>>>  		};
>>>  		bool is_dirty = PageDirty(page);
>>>  		int err;
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 9f86b98..463a77b 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -293,6 +293,7 @@ static int __commit_inmem_pages(struct inode *inode,
>>>  		.op_flags = REQ_SYNC | REQ_PRIO,
>>>  		.old_blkaddr = NULL_ADDR,
>>>  		.encrypted_page = NULL,
>>> +		.cp_rwsem_locked = true,
>>>  	};
>>>  	pgoff_t last_idx = ULONG_MAX;
>>>  	int err = 0;
>>> -- 
>>> 2.10.1
>>>
>>>
>>> ------------------------------------------------------------------------------
>>> Check out the vibrant tech community on one of the world's most
>>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
