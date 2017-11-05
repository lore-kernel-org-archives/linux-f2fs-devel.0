From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: stop all the operations by
 cp_error flag
Date: Sun, 5 Nov 2017 11:39:59 +0800
Message-ID: <1d3d0d9c-a20a-9d3a-0b7f-a34e2e62b8a5@kernel.org>
References: <20171023221409.59148-1-jaegeuk@kernel.org>
 <20171023221409.59148-2-jaegeuk@kernel.org>
 <200e3f93-c9bb-381e-9b00-1f50ab82631c@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1eBBnC-0001E9-9J
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 Nov 2017 03:40:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1eBBnA-0004sA-Qg
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 Nov 2017 03:40:14 +0000
In-Reply-To: <200e3f93-c9bb-381e-9b00-1f50ab82631c@huawei.com>
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
To: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2017/10/24 17:51, Chao Yu wrote:
> On 2017/10/24 6:14, Jaegeuk Kim wrote:
>> This patch replaces to use cp_error flag instead of RDONLY for quota off.

We should convert error number with block_page_mkwrite_return in .page_mkwrite,
otherwise generic/019 will cause a deadlock issue with below kernel message
printed:

============================================
WARNING: possible recursive locking detected
4.14.0-rc1 #35 Tainted: G        W  O
--------------------------------------------
fio/5845 is trying to acquire lock:
 (&mm->mmap_sem){++++}, at: [<c104be02>] __do_page_fault+0x482/0x510

but task is already holding lock:
 (&mm->mmap_sem){++++}, at: [<c104ba9e>] __do_page_fault+0x11e/0x510

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&mm->mmap_sem);
  lock(&mm->mmap_sem);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by fio/5845:
 #0:  (&mm->mmap_sem){++++}, at: [<c104ba9e>] __do_page_fault+0x11e/0x510

stack backtrace:
CPU: 3 PID: 5845 Comm: fio Tainted: G        W  O    4.14.0-rc1 #35
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Call Trace:
 dump_stack+0x5f/0x92
 __lock_acquire+0x1019/0x12c0
 lock_acquire+0xae/0x220
 down_read+0x38/0x60
 __do_page_fault+0x482/0x510
 do_page_fault+0x26/0x290
 common_exception+0x64/0x6a


---
 fs/f2fs/file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e67f03546391..0ce1e82591d1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -53,8 +53,10 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct dnode_of_data dn;
 	int err;

-	if (unlikely(f2fs_cp_error(sbi)))
-		return -EIO;
+	if (unlikely(f2fs_cp_error(sbi))) {
+		err = -EIO;
+		goto out;
+	}

 	sb_start_pagefault(inode->i_sb);

@@ -66,7 +68,7 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	err = f2fs_reserve_block(&dn, page->index);
 	if (err) {
 		f2fs_unlock_op(sbi);
-		goto out;
+		goto out_end;
 	}
 	f2fs_put_dnode(&dn);
 	f2fs_unlock_op(sbi);
@@ -114,9 +116,10 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)

 out_sem:
 	up_read(&F2FS_I(inode)->i_mmap_sem);
-out:
+out_end:
 	sb_end_pagefault(inode->i_sb);
 	f2fs_update_time(sbi, REQ_TIME);
+out:
 	return block_page_mkwrite_return(err);
 }

-- 


Thanks,

>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
>> ---
>>  fs/f2fs/acl.c        |  3 +++
>>  fs/f2fs/checkpoint.c |  1 -
>>  fs/f2fs/file.c       | 23 +++++++++++++++++++++++
>>  fs/f2fs/namei.c      | 30 ++++++++++++++++++++++++++++++
>>  fs/f2fs/super.c      |  3 +++
>>  5 files changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
>> index f6471f9d707e..a9bf5151e7c2 100644
>> --- a/fs/f2fs/acl.c
>> +++ b/fs/f2fs/acl.c
>> @@ -254,6 +254,9 @@ static int __f2fs_set_acl(struct inode *inode, int type,
>>  
>>  int f2fs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
>>  {
>> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
>> +		return -EIO;
>> +
>>  	return __f2fs_set_acl(inode, type, acl, NULL);
>>  }
>>  
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 201608281681..6b52d4b66c7b 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -29,7 +29,6 @@ struct kmem_cache *inode_entry_slab;
>>  void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
>>  {
>>  	set_ckpt_flags(sbi, CP_ERROR_FLAG);
>> -	sbi->sb->s_flags |= MS_RDONLY;
>>  	if (!end_io)
>>  		f2fs_flush_merged_writes(sbi);
>>  }
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 56232a72d2a3..0e09b9f02dc5 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -53,6 +53,9 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>>  	struct dnode_of_data dn;
>>  	int err;
>>  
>> +	if (unlikely(f2fs_cp_error(sbi)))
>> +		return -EIO;
>> +
>>  	sb_start_pagefault(inode->i_sb);
>>  
>>  	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
>> @@ -310,6 +313,8 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>  
>>  int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>>  {
>> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(file)))))
>> +		return -EIO;
>>  	return f2fs_do_sync_file(file, start, end, datasync, false);
>>  }
>>  
>> @@ -446,6 +451,9 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
>>  	struct inode *inode = file_inode(file);
>>  	int err;
>>  
>> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
>> +		return -EIO;
>> +
>>  	/* we don't need to use inline_data strictly */
>>  	err = f2fs_convert_inline_inode(inode);
>>  	if (err)
>> @@ -632,6 +640,9 @@ int f2fs_truncate(struct inode *inode)
>>  {
>>  	int err;
>>  
>> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
>> +		return -EIO;
>> +
>>  	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
>>  				S_ISLNK(inode->i_mode)))
>>  		return 0;
>> @@ -731,6 +742,9 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
>>  	int err;
>>  	bool size_changed = false;
>>  
>> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
>> +		return -EIO;
>> +
>>  	err = setattr_prepare(dentry, attr);
>>  	if (err)
>>  		return err;
>> @@ -1459,6 +1473,9 @@ static long f2fs_fallocate(struct file *file, int mode,
>>  	struct inode *inode = file_inode(file);
>>  	long ret = 0;
>>  
>> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
>> +		return -EIO;
>> +
>>  	/* f2fs only support ->fallocate for regular file */
>>  	if (!S_ISREG(inode->i_mode))
>>  		return -EINVAL;
>> @@ -2637,6 +2654,9 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
>>  
>>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>  {
>> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
>> +		return -EIO;
>> +
>>  	switch (cmd) {
>>  	case F2FS_IOC_GETFLAGS:
>>  		return f2fs_ioc_getflags(filp, arg);
>> @@ -2694,6 +2714,9 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>  	struct blk_plug plug;
>>  	ssize_t ret;
>>  
>> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
>> +		return -EIO;
>> +
>>  	inode_lock(inode);
>>  	ret = generic_write_checks(iocb, from);
>>  	if (ret > 0) {
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index e6f86d5d97b9..944f7a6940b6 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -183,6 +183,9 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
>>  	nid_t ino = 0;
>>  	int err;
>>  
>> +	if (unlikely(f2fs_cp_error(sbi)))
>> +		return -EIO;
>> +
>>  	err = dquot_initialize(dir);
>>  	if (err)
>>  		return err;
>> @@ -227,6 +230,9 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
>>  	int err;
>>  
>> +	if (unlikely(f2fs_cp_error(sbi)))
>> +		return -EIO;
>> +
>>  	if (f2fs_encrypted_inode(dir) &&
>>  			!fscrypt_has_permitted_context(dir, inode))
>>  		return -EPERM;
>> @@ -426,6 +432,9 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>>  
>>  	trace_f2fs_unlink_enter(dir, dentry);
>>  
>> +	if (unlikely(f2fs_cp_error(sbi)))
>> +		return -EIO;
>> +
>>  	err = dquot_initialize(dir);
>>  	if (err)
>>  		return err;
>> @@ -481,6 +490,9 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
>>  	struct fscrypt_symlink_data *sd = NULL;
>>  	int err;
>>  
>> +	if (unlikely(f2fs_cp_error(sbi)))
>> +		return -EIO;
>> +
>>  	if (f2fs_encrypted_inode(dir)) {
>>  		err = fscrypt_get_encryption_info(dir);
>>  		if (err)
>> @@ -587,6 +599,9 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
>>  	struct inode *inode;
>>  	int err;
>>  
>> +	if (unlikely(f2fs_cp_error(sbi)))
>> +		return -EIO;
>> +
>>  	err = dquot_initialize(dir);
>>  	if (err)
>>  		return err;
>> @@ -639,6 +654,9 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
>>  	struct inode *inode;
>>  	int err = 0;
>>  
>> +	if (unlikely(f2fs_cp_error(sbi)))
>> +		return -EIO;
>> +
>>  	err = dquot_initialize(dir);
>>  	if (err)
>>  		return err;
>> @@ -733,6 +751,9 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
>>  
>>  static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
>>  {
>> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(dir))))
>> +		return -EIO;
>> +
>>  	if (f2fs_encrypted_inode(dir)) {
>>  		int err = fscrypt_get_encryption_info(dir);
>>  		if (err)
>> @@ -744,6 +765,9 @@ static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
>>  
>>  static int f2fs_create_whiteout(struct inode *dir, struct inode **whiteout)
>>  {
>> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(dir))))
>> +		return -EIO;
>> +
>>  	return __f2fs_tmpfile(dir, NULL, S_IFCHR | WHITEOUT_MODE, whiteout);
>>  }
>>  
>> @@ -763,6 +787,9 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>>  	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
>>  	int err = -ENOENT;
>>  
>> +	if (unlikely(f2fs_cp_error(sbi)))
>> +		return -EIO;
>> +
>>  	if ((f2fs_encrypted_inode(old_dir) &&
>>  			!fscrypt_has_encryption_key(old_dir)) ||
>>  			(f2fs_encrypted_inode(new_dir) &&
>> @@ -956,6 +983,9 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>>  	int old_nlink = 0, new_nlink = 0;
>>  	int err = -ENOENT;
>>  
>> +	if (unlikely(f2fs_cp_error(sbi)))
>> +		return -EIO;
>> +
>>  	if ((f2fs_encrypted_inode(old_dir) &&
>>  			!fscrypt_has_encryption_key(old_dir)) ||
>>  			(f2fs_encrypted_inode(new_dir) &&
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 7659b348582a..213d2c1e5759 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -885,6 +885,9 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
>>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>>  	int err = 0;
>>  
>> +	if (unlikely(f2fs_cp_error(sbi)))
>> +		return 0;
>> +
>>  	trace_f2fs_sync_fs(sb, sync);
>>  
>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>>
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
