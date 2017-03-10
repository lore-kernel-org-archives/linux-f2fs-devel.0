From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH v2] f2fs: sync the enc name flags with disk
	level filename
Date: Fri, 10 Mar 2017 10:00:09 +0800
Message-ID: <481d729a-c82f-0542-c73f-93c73fa9a3a8@gmail.com>
References: <fdfcad9e-36e6-a163-e42b-abe414c2ca9d@gmail.com>
	<eda73163-e95f-6c40-05e1-673eba87a530@gmail.com>
	<7b158dd2-9b72-bf75-e0c0-29cb364d24ea@gmail.com>
	<f3794fb1-256b-049a-1146-cdffa5e8c5d5@gmail.com>
	<20170307193029.GA2499@jaegeuk.local>
	<71b63777-c504-30d2-014b-718eb31b62c3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cm9qw-0007jo-E7
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 02:00:22 +0000
Received: from mail-it0-f67.google.com ([209.85.214.67])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cm9qv-0003zD-BY
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 02:00:22 +0000
Received: by mail-it0-f67.google.com with SMTP id g138so133330itb.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 09 Mar 2017 18:00:21 -0800 (PST)
In-Reply-To: <71b63777-c504-30d2-014b-718eb31b62c3@gmail.com>
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

On 3/8/2017 18:56, Kinglong Mee wrote:
> On 3/8/2017 03:30, Jaegeuk Kim wrote:
>> Hi Kinglong,
>>
>> Can we make a testcase in xfstests to check this clearly?
>> 1. creat A under encrypted dir
>> 2. rename A to B
>> 3. fsync B
>> 4. power-cut
>>
>> Is this your concern?
> 
> Yes, it is.
> If B isn't exist, rename A to B means create a new A (unlink the old).
> B is exist, the inode (include disk node) will be replace by A, but,
> for the file_enc_name, the disk i_name/i_namelen isn't updated.
> 
> For the rename, A and B lost there parent, so the 3 step will cause checkpoint, 
> after that, everything is updated to disk (with the unchanged filename), 
> so that the 4 step of power-cut can't cause a roll_forward.
> 
> If fsync A for flags the inode and then rename as,
> 1. creat A and B under encrypted dir
> 2. fsync A          (after rename, B will be unlink)
> 3. rename A to B
> 4. godown 
> 5. umount/mount
> 
> A roll_forward (recover_dentry) happens, the result is same as after setp1,
> that's not my needs.
> 
> For the IS_CHECKPOINTED flag, after a new created file sync to the disk,
> it's cleared, and never appears again, after that a roll_forward of 
> recover_dentry will never happen (it means the disk i_name will not be
> used forever). Am I right?
> 
> If that's right, next update_dent_inode after file created is useless,
> we can remove them include the FADVISE_ENC_NAME_BIT.

Hi Jaegeuk, 

What's your opinion?
If you agree that they are useless of the disk-level filename updating, 
I will cleanup them.

thanks,
Kinglong Mee

> 
>>
>> Hmm, on-disk filename is used when doing roll-forward recovery, and it seems
>> there is a hole in try_to_fix_pino() to recover its pino without filename.
>>
>> Like this?
>>
>> >From 7efde035d9f930fc63c30b25327e870b021750f3 Mon Sep 17 00:00:00 2001
>> From: Jaegeuk Kim <jaegeuk@kernel.org>
>> Date: Tue, 7 Mar 2017 11:22:45 -0800
>> Subject: [PATCH] f2fS: don't allow to get pino when filename is encrypted
>>
>> After renaming an encrypted file, we have no way to get its
>> encrypted filename from its dentry.
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>  fs/f2fs/file.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index e0b2378f8519..852195b3bcce 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -110,6 +110,9 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
>>  {
>>  	struct dentry *dentry;
>>  
>> +	if (file_enc_name(inode))
>> +		return 0;
>> +
>>  	inode = igrab(inode);
>>  	dentry = d_find_any_alias(inode);
>>  	iput(inode);
>>

Yes, this patch is needed, but it causes the following problem of 
the forever lost parent inode flags for encrypted files after rename.

thanks,
Kinglong Mee

> 
> The renamed inode will lost their parent ino, and try to fix it when fsync.
> With the file_enc_name checking, get_parent_ino return 0 without parent ino
> for encrypted inode, after that the FADVISE_COLD_BIT will exist forever, 
> fsync the encrypted inode causing do_checkpoint every time.
> 
> static void try_to_fix_pino(struct inode *inode)
> {
>         struct f2fs_inode_info *fi = F2FS_I(inode);
>         nid_t pino;
> 
>         down_write(&fi->i_sem);
>         if (file_wrong_pino(inode) && inode->i_nlink == 1 &&
>                         get_parent_ino(inode, &pino)) {
>                 f2fs_i_pino_write(inode, pino);
>                 file_got_pino(inode);
>         }
>         up_write(&fi->i_sem);
> }
> 
> thanks,
> Kinglong Mee
> 

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
