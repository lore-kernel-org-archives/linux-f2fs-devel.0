From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH] f2fs: don't allow rename unencrypted file to
 encrypted directory
Date: Wed, 8 Mar 2017 21:35:25 +0800
Message-ID: <99c57433-c631-4516-b5a2-e22c79e9a93d@gmail.com>
References: <20170308120820.86785-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1clbkh-0007X0-6X
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 13:35:39 +0000
Received: from mail-it0-f65.google.com ([209.85.214.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1clbkg-0001sz-5J
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 13:35:39 +0000
Received: by mail-it0-f65.google.com with SMTP id f203so5184001itf.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 08 Mar 2017 05:35:38 -0800 (PST)
In-Reply-To: <20170308120820.86785-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 3/8/2017 20:08, Chao Yu wrote:
> In commit d9cdc9033181 ("ext4 crypto: enforce context consistency") we
> declared that:
> 
> 2) All files or directories in a directory must be protected using the
>     same key as their containing directory.
> 
> But in f2fs_cross_rename there is a vulnerability that allow to cross
> rename unencrypted file into encrypted directory, it needs to be refused.

fscrypt_has_permitted_context has do the checking as this patch,

168         /* no restrictions if the parent directory is not encrypted */
169         if (!parent->i_sb->s_cop->is_encrypted(parent))
170                 return 1;
171         /* if the child directory is not encrypted, this is always a problem */
172         if (!parent->i_sb->s_cop->is_encrypted(child))
173                 return 0;

So, the cross rename unencrypted file into encrypted directory is permitted right now. 

I have a encrypted directory "ncry",  "new" is unencrypted file.

[root@nfstestnic f2fs]# renameat2 -x encry/hello new
Operation not permitted
[root@nfstestnic f2fs]# renameat2 -x encry/hello new
Operation not permitted

How do you test it? 

thanks,
Kinglong Mee
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/namei.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 25c073f6c7d4..8de684b84cb9 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -855,6 +855,10 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  			!fscrypt_has_encryption_key(new_dir)))
>  		return -ENOKEY;
>  
> +	if (f2fs_encrypted_inode(old_dir) && !f2fs_encrypted_inode(new_inode) ||
> +		f2fs_encrypted_inode(new_dir) && !f2fs_encrypted_inode(old_inode))
> +		return -EPERM;
> +
>  	if ((f2fs_encrypted_inode(old_dir) || f2fs_encrypted_inode(new_dir)) &&
>  			(old_dir != new_dir) &&
>  			(!fscrypt_has_permitted_context(new_dir, old_inode) ||
> 

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
