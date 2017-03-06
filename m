From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH 2/2] f2fs: avoid new_inode's flags overwrite
 the old_node
Date: Mon, 6 Mar 2017 19:10:02 +0800
Message-ID: <1d5adb13-f16c-faaa-b67e-7a887373e275@gmail.com>
References: <fdfcad9e-36e6-a163-e42b-abe414c2ca9d@gmail.com>
	<82efe5bc-bd78-9fe3-dc22-373f09939a6b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1ckqWx-0004KE-Er
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Mar 2017 11:10:19 +0000
Received: from mail-io0-f193.google.com ([209.85.223.193])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ckqWw-0006hi-2p
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Mar 2017 11:10:19 +0000
Received: by mail-io0-f193.google.com with SMTP id f84so17929212ioj.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 06 Mar 2017 03:10:18 -0800 (PST)
In-Reply-To: <82efe5bc-bd78-9fe3-dc22-373f09939a6b@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 3/6/2017 19:06, Chao Yu wrote:
> On 2017/3/4 21:44, Kinglong Mee wrote:
>> Note, rename with old_inode (enc_name) and new_inode (no_enc_name),
>> the result will be old_indoe(enc_name) and new_inode(enc_name).
> 
> IIRC, we don't allow rename files in different dirs that:
> 1. One dir is encrypted, another is not encrypted;
> 2. or src/dst dir has different encryption policy.
> 
> So that will not happen, right?

Yes, you are right.
This patch is bad one, please ignore this and check my latest fix, 
[PATCH v2] f2fs: sync the enc name flags with disk level filename

thanks,
Kinglong Mee
> 
> Thanks,
> 
>>
>> Needs swap the enc_name flags?
>> If needed, this patch needs update of clear the flags.
>> otherwise, this patch only fix the logic with any result changing.
>>
>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>> ---
>>  fs/f2fs/namei.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index 3231a0a..db2ab7f 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -846,6 +846,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>>  	struct page *old_page, *new_page;
>>  	struct f2fs_dir_entry *old_dir_entry = NULL, *new_dir_entry = NULL;
>>  	struct f2fs_dir_entry *old_entry, *new_entry;
>> +	bool old_inode_enc = false, new_inode_enc = false;
>>  	int old_nlink = 0, new_nlink = 0;
>>  	int err = -ENOENT;
>>  
>> @@ -917,17 +918,16 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>>  
>>  	f2fs_lock_op(sbi);
>>  
>> +	old_inode_enc = file_enc_name(old_inode);
>> +	new_inode_enc = file_enc_name(new_inode);
>> +
>>  	err = update_dent_inode(old_inode, new_inode, &new_dentry->d_name);
>>  	if (err)
>>  		goto out_unlock;
>> -	if (file_enc_name(new_inode))
>> -		file_set_enc_name(old_inode);
>>  
>>  	err = update_dent_inode(new_inode, old_inode, &old_dentry->d_name);
>>  	if (err)
>>  		goto out_undo;
>> -	if (file_enc_name(old_inode))
>> -		file_set_enc_name(new_inode);
>>  
>>  	/* update ".." directory entry info of old dentry */
>>  	if (old_dir_entry)
>> @@ -942,6 +942,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>>  
>>  	down_write(&F2FS_I(old_inode)->i_sem);
>>  	file_lost_pino(old_inode);
>> +	if (new_inode_enc)
>> +		file_set_enc_name(old_inode);
>>  	up_write(&F2FS_I(old_inode)->i_sem);
>>  
>>  	old_dir->i_ctime = current_time(old_dir);
>> @@ -957,6 +959,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>>  
>>  	down_write(&F2FS_I(new_inode)->i_sem);
>>  	file_lost_pino(new_inode);
>> +	if (old_inode_enc)
>> +		file_set_enc_name(new_inode);
>>  	up_write(&F2FS_I(new_inode)->i_sem);
>>  
>>  	new_dir->i_ctime = current_time(new_dir);
>>
> 
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
