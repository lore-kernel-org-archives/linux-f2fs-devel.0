From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH v3] f2fs: cleanup the disk level filename
	updating
Date: Tue, 14 Mar 2017 07:14:09 +0800
Message-ID: <25d6671d-2ff3-4745-44ed-ddcdfc76fd80@gmail.com>
References: <fdfcad9e-36e6-a163-e42b-abe414c2ca9d@gmail.com>
	<eda73163-e95f-6c40-05e1-673eba87a530@gmail.com>
	<7b158dd2-9b72-bf75-e0c0-29cb364d24ea@gmail.com>
	<f3794fb1-256b-049a-1146-cdffa5e8c5d5@gmail.com>
	<20170307193029.GA2499@jaegeuk.local>
	<71b63777-c504-30d2-014b-718eb31b62c3@gmail.com>
	<481d729a-c82f-0542-c73f-93c73fa9a3a8@gmail.com>
	<20170310022330.GA17988@jaegeuk.local>
	<89421365-280c-1659-e467-e5f736f55ab7@gmail.com>
	<20170313182314.GA41055@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cnZAb-0006A2-7a
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Mar 2017 23:14:29 +0000
Received: from mail-it0-f67.google.com ([209.85.214.67])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cnZAa-0002FU-3e
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Mar 2017 23:14:29 +0000
Received: by mail-it0-f67.google.com with SMTP id g138so7590309itb.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 13 Mar 2017 16:14:28 -0700 (PDT)
In-Reply-To: <20170313182314.GA41055@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 3/14/2017 02:23, Jaegeuk Kim wrote:
> On 03/10, Kinglong Mee wrote:
>> As discuss with Jaegeuk and Chao,
>> "Once checkpoint is done, f2fs doesn't need to update there-in filename at all."
>>
>> The disk-level filename is used only one case,
>> 1. create a file A under a dir
>> 2. sync A
>> 3. godown
>> 4. umount
>> 5. mount (roll_forward)
>>
>> Only the rename/cross_rename changes the filename, if it happens,
>> a. between step 1 and 2, the sync A will caused checkpoint, so that,
>>    the roll_forward at step 5 never happens.
>> b. after step 2, the roll_forward happens, file A will roll forward
>>    to the result as after step 1.
> 
> I've checked the roll-forward recovery again and found, if pino is recovered,
> it tries to recover dentry with the written filename.
> 
> So,
> 1. create a
> 2. rename a b
> 3. fsync b, will trigger checkpoint and recover pino
> 4. fsync b
> 5. godown
> 
> Then, roll-forward recovery will do recover_dentry with "a". So, correct pino
> should have valid filename.

Is it the right operation? but the f2fs code doesn't do like that, see below.

> 
> Thoughts?

If b isn't exist when renaming, f2fs creates a new directory entry
(f2fs_add_link with name "b"), but no new inode or nid created.

The recover_dentry depends on FSYNC_BIT_SHIFT and DENT_BIT_SHIFT, as your procedures,
a roll-forward recovery will do, but no recover_dentry happens.

[ 3607.068713] do_read_inode: ino 3, name (0:0)
[ 3607.090464] do_read_inode: ino 56398, name (0:1) b
[ 3607.110743] F2FS-fs (sdb1): recover_inode: ino = dc4e, name = b
[ 3607.111802] F2FS-fs (sdb1): recover_data: ino = dc4e (i_size: recover) recovered = 0, err = 0
[ 3607.117374] F2FS-fs (sdb1): checkpoint: version = 31d5d90f
[ 3607.118384] F2FS-fs (sdb1): Mounted with checkpoint version = 31d5d90f
[ 3607.288552] NFSD: starting 90-second grace period (net ffffffffbeefd140)

After the first fsync at step 3, the IS_CHECKPOINTED is set, after that,
IS_CHECKPOINTED will exist in the nat entry forever, so DENT_BIT_SHIFT never be set.

1397 int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
1398                         struct writeback_control *wbc, bool atomic)

1460                         if (!atomic || page == last_page) {
1461                                 set_fsync_mark(page, 1);
1462                                 if (IS_INODE(page)) {
1463                                         if (is_inode_flag_set(inode,
1464                                                                 FI_DIRTY_INODE))
1465                                                 update_inode(inode, page);
1466                                         set_dentry_mark(page,
1467                                                 need_dentry_mark(sbi, ino));
1468                                 }
1469                                 /*  may be written by other thread */
1470                                 if (!PageDirty(page))
1471                                         set_page_dirty(page);
1472                         }

 195 int need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid)
 196 {
 197         struct f2fs_nm_info *nm_i = NM_I(sbi);
 198         struct nat_entry *e;
 199         bool need = false;
 200
 201         down_read(&nm_i->nat_tree_lock);
 202         e = __lookup_nat_cache(nm_i, nid);
 203         if (e) {
 204                 if (!get_nat_flag(e, IS_CHECKPOINTED) &&
 205                                 !get_nat_flag(e, HAS_FSYNCED_INODE))
 206                         need = true;
 207         }
 208         up_read(&nm_i->nat_tree_lock);
 209         return need;
 210 }

thanks,
Kinglong Mee

> 
> Thanks,
> 
>>
>> So that, any updating the disk filename is useless, just cleanup it.
>>
>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>> ---
>>  fs/f2fs/dir.c    | 25 ++++---------------------
>>  fs/f2fs/f2fs.h   |  2 --
>>  fs/f2fs/file.c   |  8 --------
>>  fs/f2fs/inline.c |  2 --
>>  fs/f2fs/namei.c  | 29 -----------------------------
>>  5 files changed, 4 insertions(+), 62 deletions(-)
>>
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index 8d5c62b..058c4f3 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -337,24 +337,6 @@ static void init_dent_inode(const struct qstr *name, struct page *ipage)
>>  	set_page_dirty(ipage);
>>  }
>>  
>> -int update_dent_inode(struct inode *inode, struct inode *to,
>> -					const struct qstr *name)
>> -{
>> -	struct page *page;
>> -
>> -	if (file_enc_name(to))
>> -		return 0;
>> -
>> -	page = get_node_page(F2FS_I_SB(inode), inode->i_ino);
>> -	if (IS_ERR(page))
>> -		return PTR_ERR(page);
>> -
>> -	init_dent_inode(name, page);
>> -	f2fs_put_page(page, 1);
>> -
>> -	return 0;
>> -}
>> -
>>  void do_make_empty_dir(struct inode *inode, struct inode *parent,
>>  					struct f2fs_dentry_ptr *d)
>>  {
>> @@ -438,8 +420,11 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
>>  		set_cold_node(inode, page);
>>  	}
>>  
>> -	if (new_name)
>> +	if (new_name) {
>>  		init_dent_inode(new_name, page);
>> +		if (f2fs_encrypted_inode(dir))
>> +			file_set_enc_name(inode);
>> +	}
>>  
>>  	/*
>>  	 * This file should be checkpointed during fsync.
>> @@ -599,8 +584,6 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
>>  			err = PTR_ERR(page);
>>  			goto fail;
>>  		}
>> -		if (f2fs_encrypted_inode(dir))
>> -			file_set_enc_name(inode);
>>  	}
>>  
>>  	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 1);
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 7edb3be..5dbc0c0 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -2093,8 +2093,6 @@ ino_t f2fs_inode_by_name(struct inode *dir, const struct qstr *qstr,
>>  			struct page **page);
>>  void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
>>  			struct page *page, struct inode *inode);
>> -int update_dent_inode(struct inode *inode, struct inode *to,
>> -			const struct qstr *name);
>>  void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
>>  			const struct qstr *name, f2fs_hash_t name_hash,
>>  			unsigned int bit_pos);
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 4ec764e..8c7923f 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -110,20 +110,12 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
>>  {
>>  	struct dentry *dentry;
>>  
>> -	if (file_enc_name(inode))
>> -		return 0;
>> -
>>  	inode = igrab(inode);
>>  	dentry = d_find_any_alias(inode);
>>  	iput(inode);
>>  	if (!dentry)
>>  		return 0;
>>  
>> -	if (update_dent_inode(inode, inode, &dentry->d_name)) {
>> -		dput(dentry);
>> -		return 0;
>> -	}
>> -
>>  	*pino = parent_ino(dentry);
>>  	dput(dentry);
>>  	return 1;
>> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
>> index e32a9e5..41fe27d 100644
>> --- a/fs/f2fs/inline.c
>> +++ b/fs/f2fs/inline.c
>> @@ -527,8 +527,6 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
>>  			err = PTR_ERR(page);
>>  			goto fail;
>>  		}
>> -		if (f2fs_encrypted_inode(dir))
>> -			file_set_enc_name(inode);
>>  	}
>>  
>>  	f2fs_wait_on_page_writeback(ipage, NODE, true);
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index 25c073f..8906c9f 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -720,13 +720,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>>  		if (err)
>>  			goto put_out_dir;
>>  
>> -		err = update_dent_inode(old_inode, new_inode,
>> -						&new_dentry->d_name);
>> -		if (err) {
>> -			release_orphan_inode(sbi);
>> -			goto put_out_dir;
>> -		}
>> -
>>  		f2fs_set_link(new_dir, new_entry, new_page, old_inode);
>>  
>>  		new_inode->i_ctime = current_time(new_inode);
>> @@ -779,8 +772,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>>  
>>  	down_write(&F2FS_I(old_inode)->i_sem);
>>  	file_lost_pino(old_inode);
>> -	if (new_inode && file_enc_name(new_inode))
>> -		file_set_enc_name(old_inode);
>>  	up_write(&F2FS_I(old_inode)->i_sem);
>>  
>>  	old_inode->i_ctime = current_time(old_inode);
>> @@ -917,18 +908,6 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>>  
>>  	f2fs_lock_op(sbi);
>>  
>> -	err = update_dent_inode(old_inode, new_inode, &new_dentry->d_name);
>> -	if (err)
>> -		goto out_unlock;
>> -	if (file_enc_name(new_inode))
>> -		file_set_enc_name(old_inode);
>> -
>> -	err = update_dent_inode(new_inode, old_inode, &old_dentry->d_name);
>> -	if (err)
>> -		goto out_undo;
>> -	if (file_enc_name(old_inode))
>> -		file_set_enc_name(new_inode);
>> -
>>  	/* update ".." directory entry info of old dentry */
>>  	if (old_dir_entry)
>>  		f2fs_set_link(old_inode, old_dir_entry, old_dir_page, new_dir);
>> @@ -972,14 +951,6 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>>  	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
>>  		f2fs_sync_fs(sbi->sb, 1);
>>  	return 0;
>> -out_undo:
>> -	/*
>> -	 * Still we may fail to recover name info of f2fs_inode here
>> -	 * Drop it, once its name is set as encrypted
>> -	 */
>> -	update_dent_inode(old_inode, old_inode, &old_dentry->d_name);
>> -out_unlock:
>> -	f2fs_unlock_op(sbi);
>>  out_new_dir:
>>  	if (new_dir_entry) {
>>  		f2fs_dentry_kunmap(new_inode, new_dir_page);
>> -- 
>> 2.9.3
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
