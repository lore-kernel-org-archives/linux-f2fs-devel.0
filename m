Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EBBC982D6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xZx/ILBHMlQ8bN1ezpVwfkHGzppQ/voaOVsfYbY7+Bw=; b=BiIQo+vlX3UoRUY0MddcgmBfQJ
	/xi+XyXv+LFQFXEPfitDLqhGQG+UyoOOoidr/3+69knjA/nmJeREbBz7KMwVe94FlghQ9YSVOQJ60
	DZJvFM2M2LZMxQv1MIjVGsQHaQqa2Ylt6q8u7A60HeMBlskLC0B7vor3c16T6japXSfY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x7CmA-0007LZ-2O;
	Thu, 17 Sep 2026 14:07:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x7Clz-0007LM-G6
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 14:07:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h7pqj0YxpHMi63B64gZEgXFV3uLjgyTkVmBX3XBFZ7E=; b=FAMbebhA65UI0Lu8AqaCjkbvg4
 dH8xvJF0D//wPnkH5G3xsVdNR8BtxyBHXg6KzQiSBiDbNR1CVHLaPB4kP66GyqNaDaB0lbxJ9z0vT
 REfp7+9Nh+BdxcLvtEFznTAbgQtTv0TDtcftzSkIPVGzN3gt6Fm5akfchj3mmg0CwOY4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=h7pqj0YxpHMi63B64gZEgXFV3uLjgyTkVmBX3XBFZ7E=; b=mNdYbTvDe/TfnTFefvTOHh4UN9
 6oqy7Rek6NR1zzO09f24MXGm5C6O23uJBEGdoIv+JN16lEvVW1OyPkxsO6u2Rg/1fW2gP4drnYhNw
 PuzhVFuAHxzDuCxZKXPorCNID+5L9sQHdd+sTQUoH1GJKqmxvnLdTrAnH/Ebked+mnGo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7Clu-0000a6-BR for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 14:07:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B45F160514;
 Thu, 17 Sep 2026 14:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842361F000FF;
 Thu, 17 Sep 2026 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789654044;
 bh=h7pqj0YxpHMi63B64gZEgXFV3uLjgyTkVmBX3XBFZ7E=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=QIMHBD3Uy8NqKDMUV+2Qyzy+SN8Bwx29gXUsPNIggQpmYRQwh+3sj2G4ryqaU5UxF
 U6Jgk1uHIG+7ltheqCd5lkrZhd246syZSUT1mRN3Vydy8uugcD4HssLNXQqMGuOpTQ
 RdLALAtji2c4qulHed5MK4QUeAhyZqcGUxP6JVqU0b3OIPeYGV8CX8HO2xADdUj3xL
 coTdps7e8AWbPbWh5SMXYehrtU9PANw/H7VLN1ISJourSYm+NXowN8OrXWTikgInUP
 K2ylW0X/2sSUx5H3tSOqhznNzkL+zDIxDMadV2N0aNTVYjlzfD/yXusGK4ChWYrYKp
 kfp/X2kgjG+9w==
Message-ID: <4abc50b3-6e6f-4ba9-9e81-c802e5b90ab2@kernel.org>
Date: Thu, 17 Sep 2026 22:07:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
 <20260915042503.2912616-3-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260915042503.2912616-3-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x7Clu-0000a6-BR
Subject: Re: [f2fs-dev] [PATCH v2 13/14] f2fs: allow large folio support to
 writeable files
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/15/26 12:25, Nanzhe Zhao wrote:
> Now we make all write path support large folios,
> so we open permission to let writeable file set
> large folio mapping.
> 
> Keep fs-layer encrypted files excluded unless inline encryption is
> enabled, since f2fs_encrypt_one_page() still encrypts one PAGE_SIZE
> page and cannot handle large folios.
> 
> Inline files are allowed as well; their index #0 folio stays order-0
> (see the large folio write path), so the existing inline read/convert
> paths are not affected and large folios are used from the second folio
> on.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>   fs/f2fs/data.c   |  2 +-
>   fs/f2fs/f2fs.h   | 17 +++++++++++++++++
>   fs/f2fs/file.c   | 16 ----------------
>   fs/f2fs/inline.c |  6 ++++++
>   fs/f2fs/inode.c  |  4 +---
>   fs/f2fs/namei.c  |  1 +
>   6 files changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 295424f2ade5..c9dba8d0ad3d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2941,7 +2941,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   	int ret = 0;
>   	bool folio_in_bio = false;
>   
> -	if (!IS_IMMUTABLE(inode) || f2fs_compressed_file(inode)) {
> +	if (f2fs_compressed_file(inode)) {
>   		if (folio)
>   			folio_unlock(folio);
>   		return -EOPNOTSUPP;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index d99a812810d3..d608376b1456 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -5251,6 +5251,23 @@ static inline bool f2fs_quota_file(struct f2fs_sb_info *sbi, nid_t ino)
>   	return false;
>   }
>   
> +static inline void f2fs_mapping_set_large_folio(struct inode *inode)
> +{
> +	if (!S_ISREG(inode->i_mode) ||
> +	    f2fs_compressed_file(inode) ||
> +	    f2fs_quota_file(F2FS_I_SB(inode), inode->i_ino))
> +		return;
> +
> +	/*
> +	 * Keep the folio order range at 0 as a transitional step; large
> +	 * folios will be enabled once the whole write path is audited.
> +	 */
> +	if (IS_IMMUTABLE(inode))
> +		mapping_set_folio_min_order(inode->i_mapping, 0);
> +	else
> +		mapping_set_folio_order_range(inode->i_mapping, 0, 0);
> +}
> +
>   static inline bool f2fs_block_unit_discard(struct f2fs_sb_info *sbi)
>   {
>   	return F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index a36d243ca305..db71cadefabd 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -162,17 +162,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>   	int err = 0;
>   	vm_fault_t ret;
>   
> -	/*
> -	 * We only support large folio on the read case.
> -	 * Don't make any dirty pages.
> -	 */
> -	if (unlikely(IS_IMMUTABLE(inode)) ||
> -	    mapping_large_folio_support(inode->i_mapping)) {
> -		f2fs_err(sbi, "Not expected: immutable: %d large_folio: %d",
> -				IS_IMMUTABLE(inode),
> -				mapping_large_folio_support(inode->i_mapping));
> -		return VM_FAULT_SIGBUS;
> -	}
>   
>   	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
>   		err = -EIO;
> @@ -712,9 +701,6 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
>   	if (!f2fs_is_compress_backend_ready(inode))
>   		return -EOPNOTSUPP;
>   
> -	if (mapping_large_folio_support(inode->i_mapping) &&
> -	    filp->f_mode & FMODE_WRITE)
> -		return -EOPNOTSUPP;
>   
>   	err = fsverity_file_open(inode, filp);
>   	if (err)
> @@ -1186,8 +1172,6 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   		return -EPERM;
>   
>   	if ((attr->ia_valid & ATTR_SIZE)) {
> -		if (mapping_large_folio_support(inode->i_mapping))
> -			return -EOPNOTSUPP;
>   		if (IS_DEVICE_ALIASING(inode))
>   			return -EPERM;
>   		if (!f2fs_is_compress_backend_ready(inode))
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 8db083b545bc..51cc2e6c0284 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -238,6 +238,12 @@ int f2fs_convert_inline_inode(struct inode *inode)
>   	if (IS_ERR(folio))
>   		return PTR_ERR(folio);
>   
> +	/*
> +	 * Inline data is only supported in an order-0 index #0 folio; the
> +	 * inline write and mmap fault paths never request a larger order.
> +	 */
> +	f2fs_bug_on(sbi, folio_test_large(folio));
> +
>   	f2fs_lock_op(sbi, &lc);
>   
>   	ifolio = f2fs_get_inode_folio(sbi, inode->i_ino);
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 24205a35be04..c8a4c62c9927 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -643,9 +643,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
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
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index ff86ee07290d..9d0cec72aacc 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -341,6 +341,7 @@ static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
>   	f2fs_set_inode_flags(inode);
>   
>   	f2fs_init_extent_tree(inode);
> +	f2fs_mapping_set_large_folio(inode);
>   
>   	trace_f2fs_new_inode(inode, 0);

After this patch, we can set set large folio bit on new inode, and then
setting compressed flag via ioctl.

It allows to write data on large folio of compressed file, but still it
does not support read via f2fs_read_data_large_folio()? IIUC.

Thanks,

>   	return inode;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
