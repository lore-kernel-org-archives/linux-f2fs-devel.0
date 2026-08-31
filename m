Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F93C61DE2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pw1jyHxksx4wcIq1e2b+KR9QFBOt1j4X58adbYXNeIk=; b=SH4a5ZGANoiE9yZg2Y009/ERvJ
	b/pdz1JzfOMA98+bNxbdE00rowbP47h+DkvtvsNDpIgVFRBdn8XKu2ABEIA2v2cQ+Jj/MC8Sa2UFW
	Fmm4jJYLvUnJadx1U0SybWPlKSpXzUbrNBRg/k+dHPi98rsdorZGqSuNB/oFQist9p0I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0xQh-0006pW-Vk;
	Mon, 31 Aug 2026 08:31:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x0xQh-0006pJ-0V
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 08:31:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W9FSC2eGwNfA3P3oUtlkGNlVhThCuQZ/AUvll1/vBLQ=; b=W+e7UyWMgL3eewEahlNK9WiLYx
 3xOs1HZJHlAbQhDoxAbbsugW4MUW4Uc6xw1mFc9Vhs1BjnK2mUUMX57KCMkm4SyaxFFGZw41Xlhdm
 JU7Jbs3on16FHZqnEc6HJ9Gr98DREYrEUhS63hiBD8VrJoenLIvl22K1p0CFQqQ4DCjo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=W9FSC2eGwNfA3P3oUtlkGNlVhThCuQZ/AUvll1/vBLQ=; b=e5nSgmkm2kPEdYIH6ctpK8p/Wc
 ahYOBMQHRSSYENwuwFADU26/HhQU00EMx7mtDUHQoxTwHsxcmDq5LEXB7kVOMVKQbAePsiN3XVaBR
 mboHL4mYCKBZvFdf+56vvCHUudxymQjtefYagFKUrNLi649/GN4xbJKVRNPLJF04cMho=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0xQg-0003aX-5X for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 08:31:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CAF50402A9;
 Mon, 31 Aug 2026 08:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE911F000E9;
 Mon, 31 Aug 2026 08:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788165100;
 bh=W9FSC2eGwNfA3P3oUtlkGNlVhThCuQZ/AUvll1/vBLQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=oHTMum7J0t+Q4BRAfYOrYHoysvYrPtezGhJQNd3jvDcOBOtJDOAwXfTm6cxitUVsW
 ylBr4VSn9rzUTRSvMOs3BZu8yjBzGIpQfSW9B7FlsPXBf4Kvaw6KFwEj7tPJW3GrZm
 FSghGOJcw95x1gLnKIbL9NgI3uXvVKYqyKnIEvy9D79Lrn9ppfTSXJNw1HuPir+d9c
 YNWV2QkZ+fHEiU9CE8h7tDLCXDREJA4C6UhkhNaq4Tnf3vFhuleykQ4O5nHUnRuBOq
 WGFYmefzXrvT9WyxYf4fvDyrR8D8JDF0UdicFqVFOkwZhfmoc7JVZhmVxZDCBg9j2L
 oPo1TpLAhxx9w==
Message-ID: <6f138a9d-1428-4813-b102-caeab9591da4@kernel.org>
Date: Mon, 31 Aug 2026 16:31:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
 <20260826130916.2231342-3-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260826130916.2231342-3-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x0xQg-0003aX-5X
Subject: Re: [f2fs-dev] [PATCH 13/14] f2fs: allow large folio support to
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

On 8/26/26 21:09, Nanzhe Zhao wrote:
> Now we make all write path support large folios,
> so we open permission to let writeable file set
> large folio mapping.
> 
> Keep fs-layer encrypted files excluded unless inline encryption is
> enabled, since f2fs_encrypt_one_page() still encrypts one PAGE_SIZE
> page and cannot handle large folios.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>   fs/f2fs/data.c  |  9 ++++++++-
>   fs/f2fs/f2fs.h  | 13 +++++++++++++
>   fs/f2fs/file.c  | 16 ----------------
>   fs/f2fs/inode.c |  4 +---
>   fs/f2fs/namei.c |  1 +
>   5 files changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 0b167b14a9a5..2e20833c6417 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2955,7 +2955,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   	int ret = 0;
>   	bool folio_in_bio = false;
>   
> -	if (!IS_IMMUTABLE(inode) || f2fs_compressed_file(inode)) {
> +	if (f2fs_compressed_file(inode)) {
>   		if (folio)
>   			folio_unlock(folio);
>   		return -EOPNOTSUPP;
> @@ -3321,6 +3321,13 @@ int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
>   	if (fscrypt_inode_uses_inline_crypto(inode))
>   		return 0;
>   
> +	if (folio_test_large(page_folio(page))) {
> +		f2fs_warn_ratelimited(F2FS_I_SB(inode),
> +			"large folio does not support fs-layer encryption, ino=%llu",
> +			(unsigned long long)inode->i_ino);
> +		return -EOPNOTSUPP;
> +	}

f2fs_encrypt_one_page() was removed, so it's unneeded.

> +
>   	fio->encrypted_page = fscrypt_encrypt_pagecache_blocks(page_folio(page),
>   					PAGE_SIZE, 0, GFP_NOFS);
>   	if (IS_ERR(fio->encrypted_page))
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 6ae249bf9aa1..04ed0ea92b26 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -5201,6 +5201,19 @@ static inline bool f2fs_quota_file(struct f2fs_sb_info *sbi, nid_t ino)
>   	return false;
>   }
>   
> +static inline void f2fs_mapping_set_large_folio(struct inode *inode)
> +{
> +	if (!S_ISREG(inode->i_mode) ||
> +	    f2fs_has_inline_data(inode) ||
> +	    f2fs_compressed_file(inode) ||
> +	    f2fs_quota_file(F2FS_I_SB(inode), inode->i_ino) ||
> +	    (f2fs_encrypted_file(inode) &&
> +	     !(inode->i_sb->s_flags & SB_INLINECRYPT)))

We start to use blk-crypto rather than fs-layer file conteents en/decryption
code, I think we update f2fs_mapping_set_large_folio() to allow encrypted
file to work w/ large folio.

commit 987387f2ec45f8dcd54f02aaf0c4fd3db9c4a598
Author: Eric Biggers <ebiggers@kernel.org>
Date:   Sun Jul 12 22:37:01 2026 -0400

     f2fs: Remove fs-layer file contents en/decryption code

     Now that fscrypt's file contents en/decryption is always implemented
     using blk-crypto when the filesystem is block-based, the fs-layer
     en/decryption code in f2fs is unused code.  Remove it.

     Note that the struct f2fs_io_info field encrypted_page is kept because
     it is still used by the garbage collection path to relocate encrypted
     blocks using raw meta pages from META_MAPPING.

     Link: https://patch.msgid.link/20260713023708.9245-11-ebiggers@kernel.org
     Signed-off-by: Eric Biggers <ebiggers@kernel.org>

> +		return;
> +
> +	mapping_set_folio_min_order(inode->i_mapping, 0);

I think we'd better set max order to zero as well, so that we can test the
code in mainline for a while before relieving the limitation of max order,
then we will have a baseline, we can roll back to the baseline if there is any
bug after we relieve the limitation of max order.

How do you think?

Thanks,


> +}
> +
>   static inline bool f2fs_block_unit_discard(struct f2fs_sb_info *sbi)
>   {
>   	return F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b82acbc3240f..c8426821e701 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -134,17 +134,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
> @@ -698,9 +687,6 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
>   	if (!f2fs_is_compress_backend_ready(inode))
>   		return -EOPNOTSUPP;
>   
> -	if (mapping_large_folio_support(inode->i_mapping) &&
> -	    filp->f_mode & FMODE_WRITE)
> -		return -EOPNOTSUPP;
>   
>   	err = fsverity_file_open(inode, filp);
>   	if (err)
> @@ -1177,8 +1163,6 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   		return -EPERM;
>   
>   	if ((attr->ia_valid & ATTR_SIZE)) {
> -		if (mapping_large_folio_support(inode->i_mapping))
> -			return -EOPNOTSUPP;
>   		if (IS_DEVICE_ALIASING(inode))
>   			return -EPERM;
>   		if (!f2fs_is_compress_backend_ready(inode))
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 96cc0e777567..7c4b5cdfe276 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -642,9 +642,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
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
> index afaab7739283..bdf4e586bfcf 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -341,6 +341,7 @@ static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
>   	f2fs_set_inode_flags(inode);
>   
>   	f2fs_init_extent_tree(inode);
> +	f2fs_mapping_set_large_folio(inode);
>   
>   	trace_f2fs_new_inode(inode, 0);
>   	return inode;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
