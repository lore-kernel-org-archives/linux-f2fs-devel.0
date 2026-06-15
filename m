Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242E3CD98DA
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 16:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dKTUu+8KeAWBaY+pyhYWKiuQt+z5bM80Kk6hwyhZnFc=; b=go+QDNgYzwZwpLFyGaoPEM2c84
	C7wOENbB1OVkqgiDjb3q6myKIaLhAXWQP/tH2sBnDSUFb0ggqEi5hn5vc98c4aOHCqHSTSQy4bC/O
	qvXJzOMyyAJsSn6efv+04QU2gSKeHfD8Lv295IBaiZ7rFxv9zdC/AwF/OXiiBHT4d6as=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ9mQ-0000U4-HM;
	Mon, 15 Jun 2026 16:03:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wZ9mO-0000Ty-Du
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 16:03:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zM2UIEqZ+ogIfPXei1CZrjqkGFh+JkeK3mPI+hoVzPI=; b=H/+5sY7m0K1UG5ABt+TiFboal3
 fb6QDPy3N1mP4UrlNrSvJxTV/YzA58RUZ0ktMVRsZwKLpAn8BesC7SKAb2ZsylIE3QTl7YWFnD6Oq
 b3RbCaTUnClBUAUXP9G3zte8TfP3O9JbVNf/g0FDxYZo0oPBJd6h9JQS1aaIIduYGSDM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zM2UIEqZ+ogIfPXei1CZrjqkGFh+JkeK3mPI+hoVzPI=; b=ZP5/wECnEHfFloIrZBt9DsMlsk
 W/JqD8LPuC9MNaV7oVN6F1NI2c1OscwRtCgrLDaFK+jcpdb/GlWRrvvhk32KEcaFI4H/DMX/40ON8
 vUuTrYG2cKh3V82PtUAeylpKvYIAW5/fiK5j7LYs/2kRnQRSw/Z55DbJXWgLHnzVUDXo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ9mN-0001wW-LO for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 16:03:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 39B67601E4;
 Mon, 15 Jun 2026 16:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06421F00A3A;
 Mon, 15 Jun 2026 16:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781539384;
 bh=zM2UIEqZ+ogIfPXei1CZrjqkGFh+JkeK3mPI+hoVzPI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=n4CERkz1CpuanHeKAjgIdUXgAePNqSYVbTyDtdg5xLjOKo/b3EJW27olylYYkv8y0
 Tr7NeYygSQ41z1oNxtAyqBOSAVtWObM58L3+iDB7fDh6or53ogLUgAkw7Pcul4EpfH
 M6ZSAuNpBIWsYckYedseLP3DdCcN0krMTax6Z0tOcD1NbdpLRxev3ezA49N92Z+om7
 iJfpUvGADf7OyJIt/Adch9ojYrPFQ9UkpOnFv8nENCM7xXqDhNVEAy0jmF61TYZ54X
 mf5J3+PiBPQSIxnaRXHTh4Z2KzqYkDJg4chOZ/iVgEo+lNdQn2ohnyDR5CRK2kpKTC
 VjBZvpp8Bj6Ig==
Date: Mon, 15 Jun 2026 16:03:03 +0000
To: Mikhail Lobanov <m.lobanov@rosa.ru>
Message-ID: <ajAiNyPcqd4Blujr@google.com>
References: <20260615113613.20762-1-m.lobanov@rosa.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260615113613.20762-1-m.lobanov@rosa.ru>
X-Headers-End: 1wZ9mN-0001wW-LO
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: read COW data with the original
 inode during atomic write
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: daehojeong@google.com, linux-f2fs-devel@lists.sourceforge.net,
 lvc-project@linuxtesting.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Thanks, I have made further clean-ups. Could you please check this?

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev

On 06/15, Mikhail Lobanov via Linux-f2fs-devel wrote:
> When updating an atomic-write file, f2fs_write_begin() may read the
> previously written data back from the COW inode:
> prepare_atomic_write_begin() locates the block in the COW inode and sets
> use_cow, and the read bio is then built with the COW inode:
> 
> 	f2fs_submit_page_read(use_cow ? F2FS_I(inode)->cow_inode : inode,
> 			      ...);
> 
> and f2fs_grab_read_bio() decides whether to schedule fs-layer decryption
> (STEP_DECRYPT) for the bio based on that inode via
> fscrypt_inode_uses_fs_layer_crypto().
> 
> However, the folio being filled belongs to the original inode
> (folio->mapping->host == inode), and the data stored in the COW block was
> encrypted (or left as plaintext) using the original inode's context, not
> the COW inode's -- see f2fs_encrypt_one_page(), which keys off
> fio->page->mapping->host.  fscrypt_decrypt_pagecache_blocks() likewise
> operates on folio->mapping->host.
> 
> The COW inode is created as a tmpfile in the parent directory and inherits
> its encryption policy from there.  With test_dummy_encryption the newly
> created COW inode gets the dummy policy and becomes encrypted, while a
> pre-existing regular file -- created before the policy applied, e.g.
> already present in the on-disk image -- stays unencrypted.  The read
> path then sets STEP_DECRYPT based on the encrypted COW inode and calls
> fscrypt_decrypt_pagecache_blocks() on a folio whose host (the unencrypted
> original inode) has a NULL ->i_crypt_info, dereferencing it:
> 
>   Oops: general protection fault, probably for non-canonical address ...
>   KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>   RIP: 0010:fscrypt_decrypt_pagecache_blocks+0xa0/0x310
>   Workqueue: f2fs_post_read_wq f2fs_post_read_work
>   Call Trace:
>    fscrypt_decrypt_bio+0x1eb/0x340
>    f2fs_post_read_work+0xba/0x140
>    process_one_work+0x91c/0x1a40
>    worker_thread+0x677/0xe90
>    kthread+0x2bc/0x3a0
> 
> The COW inode is only needed to locate the on-disk block, and that block
> address is already resolved into @blkaddr by prepare_atomic_write_begin()
> via __find_data_block(cow_inode, ...); f2fs_submit_page_read() then reads
> from that physical @blkaddr directly, so the inode argument only selects
> the post-read crypto context, not which block is fetched.  Reading with
> @inode therefore returns the same (latest, not-yet-committed) COW data,
> while making both the fs-layer decryption decision and the inline crypto
> path use the correct (original inode's) key.
> 
> With the COW inode no longer used at the read site, the use_cow flag has no
> remaining consumer; drop it from f2fs_write_begin() and
> prepare_atomic_write_begin().
> 
> Fixes: 591fc34e1f98 ("f2fs: use cow inode data when updating atomic write")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
> Reviewed-by: Chao Yu <chao@kernel.org>
> ---
> v2: drop the now-unused use_cow flag from f2fs_write_begin() and
>     prepare_atomic_write_begin() (Chao Yu); no functional change beyond
>     v1.  Carried Chao's Reviewed-by as the cleanup was his request.
>     Rebased on current mainline (f2fs_submit_page_read() now takes a
>     fsverity_info argument and returns void).
> 
>  fs/f2fs/data.c | 17 ++++++++++++-----
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8d4f1e75dee3..9016272b68c7 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3822,7 +3822,7 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
>  
>  static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
>  			struct folio *folio, loff_t pos, unsigned int len,
> -			block_t *blk_addr, bool *node_changed, bool *use_cow)
> +			block_t *blk_addr, bool *node_changed)
>  {
>  	struct inode *inode = folio->mapping->host;
>  	struct inode *cow_inode = F2FS_I(inode)->cow_inode;
> @@ -3839,7 +3839,6 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
>  	if (err) {
>  		return err;
>  	} else if (*blk_addr != NULL_ADDR) {
> -		*use_cow = true;
>  		return 0;
>  	}
>  
> @@ -3873,7 +3872,6 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>  	struct folio *folio;
>  	pgoff_t index = pos >> PAGE_SHIFT;
>  	bool need_balance = false;
> -	bool use_cow = false;
>  	block_t blkaddr = NULL_ADDR;
>  	int err = 0;
>  
> @@ -3936,7 +3934,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>  
>  	if (f2fs_is_atomic_file(inode))
>  		err = prepare_atomic_write_begin(sbi, folio, pos, len,
> -					&blkaddr, &need_balance, &use_cow);
> +					&blkaddr, &need_balance);
>  	else
>  		err = prepare_write_begin(sbi, folio, pos, len,
>  					&blkaddr, &need_balance);
> @@ -3976,8 +3974,15 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>  			err = -EFSCORRUPTED;
>  			goto put_folio;
>  		}
> -		f2fs_submit_page_read(use_cow ? F2FS_I(inode)->cow_inode :
> -						inode,
> +		/*
> +		 * Although the block may be stored in the COW inode, the folio
> +		 * belongs to @inode and its data was encrypted (or not) using
> +		 * @inode's context (see f2fs_encrypt_one_page()).  Read with
> +		 * @inode so the post-read decryption decision matches the
> +		 * folio's owner; otherwise an unencrypted @inode whose COW inode
> +		 * is encrypted hits a NULL ->i_crypt_info on decryption.
> +		 */
> +		f2fs_submit_page_read(inode,
>  				      NULL, /* can't write to fsverity files */
>  				      folio, blkaddr, 0, true);
>  
> 
> -- 
> 2.34.1
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
