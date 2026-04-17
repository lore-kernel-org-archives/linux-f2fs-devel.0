Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFA6F8E497
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Apr 2026 00:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XjKPyfJAo6yVTk9ZzaN7Lt6B+y1GeRXCMoH4I+MAfJI=; b=XBLrs8LY6Fq0xa0+A4InxmSm9/
	CxpiiUgu5dX0Go09Rl9c+eB3vu3mDltb/LzYumvt/h4x3nx7VnD5jCuMG8bCd+Gz4Ao82O5+lVtZC
	qwF9iFRt9FbVYYWL0+0nKe5J3Ms8ExODeztT2GKMsBqsUEp64NyBpOVqHT2Wkk77i6vs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wDXXX-0000Cj-BI;
	Fri, 17 Apr 2026 00:58:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wDXXV-0000Cd-U0
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Apr 2026 00:58:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cAQKy7Bs3J1i0yM92nrtKkT4LZT8AcAt4vb6TWR+bPI=; b=h1WUQVjA+koPlcIWUjp2H0AT+A
 DCPcCM9DA6d9Zgzm6lI1MrAZIanl8LrfnVcKhNdHjfGJzvuycxxnLtfwJO7jAXjrULt0OdZ2kKlc1
 pOGwVE3FLvuNXHm+ks9Dm+ngM0YMh/js4CY7Zs5TP5zl7a4AfloGzqO/4pQK1OsjqFYc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cAQKy7Bs3J1i0yM92nrtKkT4LZT8AcAt4vb6TWR+bPI=; b=fp5VMk3WfElgCCPOu4SvKEM4D7
 YqpWVI2gR+Rw7FpecdILk43nKFGYJvudMenYHHP6cSHm07nszS5NLWSk38bVpYi36vwTQUIkQUYXX
 MrRUsR1Urhb8A7u4OoXq0lU8JynaCx2rccUMNwmqacquRfdiIdhEXLVjyGU9EpvRXgGQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wDXXU-0000WS-VJ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Apr 2026 00:58:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DF46F60128;
 Fri, 17 Apr 2026 00:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF93C2BCAF;
 Fri, 17 Apr 2026 00:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776387506;
 bh=603I3qQjSsXLM/yTbnCL6QqU1CtpDkMfnt44/3rr7lQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=FPjReCmc85ECpgRSfHioQEPXsvCc/POnYn8F08geJlMJBgD9Dx26Md24kos9hokbV
 IncpbUgfF/07JbQB8MtZNHJ4LS01sdQGi4Rbd3ITj3wqe/HzMaNq6O3sgrc6BkiQoy
 hu6hqrLHi3uCHSmuTJeIhgySGeocOqNw2uJ3CygtLveXTu2gNEkWy39xPNRca4uRqU
 iiViFHUI/gfwOyzsS8D96vka28cQSxbV9FIQoVqMU4S62cHrPYpFQAHyae8Sml6LcR
 rDw4DlVVruocUVa8prqVhsNJgYv+AMiawfntCN+wIpW6+fMG2+SJ5rnRR5vnL5CoIW
 sJm6ej4dmdSvA==
Message-ID: <7b6334a4-4aa1-4489-8fe1-499f0d32e38f@kernel.org>
Date: Fri, 17 Apr 2026 08:58:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
Content-Language: en-US
In-Reply-To: <adhPZxtbZxgU-37v@google.com>
X-Headers-End: 1wDXXU-0000WS-VJ
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Akilesh Kailash <akailash@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/10/2026 9:16 AM, Jaegeuk Kim via Linux-f2fs-devel wrote:
> enum {
>         F2FS_XATTR_FADV_LARGEFOLIO,
> };
> 
> unsigned int value = BIT(F2FS_XATTR_FADV_LARGEFOLIO);
> 
> 1. setxattr(file, "user.fadvise", &value, sizeof(unsigned int), 0)
>   -> register the inode number for large folio
> 2. chmod(0400, file)
>   -> make Read-Only
> 3. fsync() && close() && open(READ)
>   -> f2fs_iget() with large folio
> 4. open(WRITE), mkwrite on mmap, chmod(WRITE)
>   -> return error
> 5. close() and open()
>   -> goto #3
> 6. unlink
>   -> deregister the inode number
> 
> Suggested-by: Akilesh Kailash <akailash@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   
>    Log from v1:
>     - add a condition in f2fs_drop_inode
>     - add Doc
> 
>   Documentation/filesystems/f2fs.rst | 41 ++++++++++++++++++++++++++----
>   fs/f2fs/checkpoint.c               |  2 +-
>   fs/f2fs/data.c                     |  2 +-
>   fs/f2fs/f2fs.h                     |  1 +
>   fs/f2fs/file.c                     | 11 ++++++--
>   fs/f2fs/inode.c                    | 19 +++++++++++---
>   fs/f2fs/super.c                    |  7 +++++
>   fs/f2fs/xattr.c                    | 35 ++++++++++++++++++++++++-
>   fs/f2fs/xattr.h                    |  6 +++++
>   9 files changed, 111 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 7e4031631286..de899d0d3088 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -1044,11 +1044,14 @@ page allocation for significant performance gains. To minimize code complexity,
>   this support is currently excluded from the write path, which requires handling
>   complex optimizations such as compression and block allocation modes.
>   
> -This optional feature is triggered only when a file's immutable bit is set.
> -Consequently, F2FS will return EOPNOTSUPP if a user attempts to open a cached
> -file with write permissions, even immediately after clearing the bit. Write
> -access is only restored once the cached inode is dropped. The usage flow is
> -demonstrated below:
> +This optional feature is triggered by two mechanisms: the file's immutable bit
> +or a specific xattr flag. In both cases, F2FS ensures data integrity by
> +restricting the file to a read-only state while large folios are active.
> +
> +1. Immutable Bit Approach:
> +Triggered when the FS_IMMUTABLE_FL is set. This is a strict enforcement
> +where the file cannot be modified at all until the bit is cleared and
> +the cached inode is dropped.
>   
>   .. code-block::
>   
> @@ -1078,3 +1081,31 @@ demonstrated below:
>      Written 4096 bytes with pattern = zero, total_time = 29 us, max_latency = 28 us
>   
>      # rm /data/testfile_read_seq
> +
> +2. XATTR fadvise Approach:
> +A more flexible registration via extended attributes.
> +
> +.. code-block::
> +
> +    enum {
> +        F2FS_XATTR_FADV_LARGEFOLIO,
> +    };
> +    unsigned int value = BIT(F2FS_XATTR_FADV_LARGEFOLIO);
> +
> +    /* Registers the inode number for large folio support in the subsystem.*/
> +    # setxattr(file, "user.fadvise", &value, sizeof(unsigned int), 0)
> +
> +    /* The file must be made Read-Only to transition into the large folio path. */
> +    # fchmod(0400, fd)
> +
> +    /* clean up dirty inode state. */
> +    # fsync(fd)
> +
> +    /* Drop the inode cache.
> +    # close(fd)

If drop_cache or memory reclaim was called here, then LARGE_FOLIO_INO will
be dropped in f2fs_evict_inode(), do we need to keep LARGE_FOLIO_INO if
inode->i_nlink is valid in f2fs_evict_inode()?

Thanks,

> +
> +    /* f2fs_iget() instantiates the inode with large folio support.*/
> +    # open()
> +
> +    /* Returns -EOPNOTSUPP or error to protect the large folio cache.*/
> +    # open(WRITE), mkwrite on mmap, or chmod(WRITE)
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 01e1ba77263e..fdd62ddc3ed6 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -778,7 +778,7 @@ void f2fs_remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
>   	__remove_ino_entry(sbi, ino, type);
>   }
>   
> -/* mode should be APPEND_INO, UPDATE_INO or TRANS_DIR_INO */
> +/* mode should be APPEND_INO, UPDATE_INO, LARGE_FOLIO_IO, or TRANS_DIR_INO */
>   bool f2fs_exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode)
>   {
>   	struct inode_management *im = &sbi->im[mode];
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 965d4e6443c6..5e46230398d7 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2494,7 +2494,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   	int ret = 0;
>   	bool folio_in_bio;
>   
> -	if (!IS_IMMUTABLE(inode) || f2fs_compressed_file(inode)) {
> +	if (f2fs_compressed_file(inode)) {
>   		if (folio)
>   			folio_unlock(folio);
>   		return -EOPNOTSUPP;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e40b6b2784ee..02bc6eb96a59 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -381,6 +381,7 @@ enum {
>   /* for the list of ino */
>   enum {
>   	ORPHAN_INO,		/* for orphan ino list */
> +	LARGE_FOLIO_INO,	/* for large folio case */
>   	APPEND_INO,		/* for append ino list */
>   	UPDATE_INO,		/* for update ino list */
>   	TRANS_DIR_INO,		/* for transactions dir ino list */
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index c0220cd7b332..64ba900410fc 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2068,9 +2068,16 @@ static long f2fs_fallocate(struct file *file, int mode,
>   
>   static int f2fs_release_file(struct inode *inode, struct file *filp)
>   {
> -	if (atomic_dec_and_test(&F2FS_I(inode)->open_count))
> +	if (atomic_dec_and_test(&F2FS_I(inode)->open_count)) {
>   		f2fs_remove_donate_inode(inode);
> -
> +		/*
> +		 * In order to get large folio as soon as possible, let's drop
> +		 * inode cache asap. See also f2fs_drop_inode.
> +		 */
> +		if (f2fs_exist_written_data(F2FS_I_SB(inode),
> +					    inode->i_ino, LARGE_FOLIO_INO))
> +                       d_drop(filp->f_path.dentry);
> +	}
>   	/*
>   	 * f2fs_release_file is called at every close calls. So we should
>   	 * not drop any inmemory pages by close called by other process.
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 89240be8cc59..e100bc5a378c 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -565,6 +565,20 @@ static bool is_meta_ino(struct f2fs_sb_info *sbi, unsigned int ino)
>   		ino == F2FS_COMPRESS_INO(sbi);
>   }
>   
> +static void f2fs_mapping_set_large_folio(struct inode *inode)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +
> +	if (f2fs_compressed_file(inode))
> +		return;
> +	if (f2fs_quota_file(sbi, inode->i_ino))
> +		return;
> +	if (IS_IMMUTABLE(inode) ||
> +	    (f2fs_exist_written_data(sbi, inode->i_ino, LARGE_FOLIO_INO) &&
> +	     !(inode->i_mode & S_IWUGO)))
> +	    mapping_set_folio_min_order(inode->i_mapping, 0);
> +}
> +
>   struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> @@ -620,9 +634,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>   		inode->i_op = &f2fs_file_inode_operations;
>   		inode->i_fop = &f2fs_file_operations;
>   		inode->i_mapping->a_ops = &f2fs_dblock_aops;
> -		if (IS_IMMUTABLE(inode) && !f2fs_compressed_file(inode) &&
> -		    !f2fs_quota_file(sbi, inode->i_ino))
> -			mapping_set_folio_min_order(inode->i_mapping, 0);
> +		f2fs_mapping_set_large_folio(inode);
>   	} else if (S_ISDIR(inode->i_mode)) {
>   		inode->i_op = &f2fs_dir_inode_operations;
>   		inode->i_fop = &f2fs_dir_operations;
> @@ -895,6 +907,7 @@ void f2fs_evict_inode(struct inode *inode)
>   	f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
>   	f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
>   	f2fs_remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);
> +	f2fs_remove_ino_entry(sbi, inode->i_ino, LARGE_FOLIO_INO);
>   
>   	if (!is_sbi_flag_set(sbi, SBI_IS_FREEZING)) {
>   		sb_start_intwrite(inode->i_sb);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ccf806b676f5..11d1e0c99ac1 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1844,6 +1844,13 @@ static int f2fs_drop_inode(struct inode *inode)
>   			return 1;
>   		}
>   	}
> +	/*
> +	 * In order to get large folio as soon as possible, let's drop
> +	 * inode cache asap. See also f2fs_release_file.
> +	 */
> +	if (f2fs_exist_written_data(sbi, inode->i_ino, LARGE_FOLIO_INO) &&
> +	    !is_inode_flag_set(inode, FI_DIRTY_INODE))
> +		return 1;
>   
>   	/*
>   	 * This is to avoid a deadlock condition like below.
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 941dc62a6d6f..0c0e44c2dcdd 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -44,6 +44,16 @@ static void xattr_free(struct f2fs_sb_info *sbi, void *xattr_addr,
>   		kfree(xattr_addr);
>   }
>   
> +static int f2fs_xattr_fadvise_get(struct inode *inode, void *buffer)
> +{
> +	if (!buffer)
> +		goto out;
> +	if (mapping_large_folio_support(inode->i_mapping))
> +		*((unsigned int *)buffer) |= BIT(F2FS_XATTR_FADV_LARGEFOLIO);
> +out:
> +	return sizeof(unsigned int);
> +}
> +
>   static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
>   		struct dentry *unused, struct inode *inode,
>   		const char *name, void *buffer, size_t size)
> @@ -61,10 +71,29 @@ static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
>   	default:
>   		return -EINVAL;
>   	}
> +	if (handler->flags == F2FS_XATTR_INDEX_USER &&
> +	    !strcmp(name, "fadvise"))
> +		return f2fs_xattr_fadvise_get(inode, buffer);
> +
>   	return f2fs_getxattr(inode, handler->flags, name,
>   			     buffer, size, NULL);
>   }
>   
> +static int f2fs_xattr_fadvise_set(struct inode *inode, const void *value)
> +{
> +	unsigned int new_fadvise;
> +
> +	new_fadvise = *(unsigned int *)value;
> +
> +	if (new_fadvise & BIT(F2FS_XATTR_FADV_LARGEFOLIO))
> +		f2fs_add_ino_entry(F2FS_I_SB(inode),
> +				inode->i_ino, LARGE_FOLIO_INO);
> +	else
> +		f2fs_remove_ino_entry(F2FS_I_SB(inode),
> +				inode->i_ino, LARGE_FOLIO_INO);
> +	return 0;
> +}
> +
>   static int f2fs_xattr_generic_set(const struct xattr_handler *handler,
>   		struct mnt_idmap *idmap,
>   		struct dentry *unused, struct inode *inode,
> @@ -84,6 +113,10 @@ static int f2fs_xattr_generic_set(const struct xattr_handler *handler,
>   	default:
>   		return -EINVAL;
>   	}
> +	if (handler->flags == F2FS_XATTR_INDEX_USER &&
> +	    !strcmp(name, "fadvise"))
> +		return f2fs_xattr_fadvise_set(inode, value);
> +
>   	return f2fs_setxattr(inode, handler->flags, name,
>   					value, size, NULL, flags);
>   }
> @@ -842,4 +875,4 @@ int __init f2fs_init_xattr_cache(void)
>   void f2fs_destroy_xattr_cache(void)
>   {
>   	kmem_cache_destroy(inline_xattr_slab);
> -}
> \ No newline at end of file
> +}
> diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
> index bce3d93e4755..455f460d014e 100644
> --- a/fs/f2fs/xattr.h
> +++ b/fs/f2fs/xattr.h
> @@ -24,6 +24,7 @@
>   #define F2FS_XATTR_REFCOUNT_MAX         1024
>   
>   /* Name indexes */
> +#define F2FS_USER_FADVISE_NAME			"user.fadvise"
>   #define F2FS_SYSTEM_ADVISE_NAME			"system.advise"
>   #define F2FS_XATTR_INDEX_USER			1
>   #define F2FS_XATTR_INDEX_POSIX_ACL_ACCESS	2
> @@ -39,6 +40,11 @@
>   #define F2FS_XATTR_NAME_ENCRYPTION_CONTEXT	"c"
>   #define F2FS_XATTR_NAME_VERITY			"v"
>   
> +/* used for F2FS_USER_FADVISE_NAME */
> +enum {
> +	F2FS_XATTR_FADV_LARGEFOLIO,
> +};
> +
>   struct f2fs_xattr_header {
>   	__le32  h_magic;        /* magic number for identification */
>   	__le32  h_refcount;     /* reference count */



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
