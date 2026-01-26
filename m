Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBC0D1950F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ROippmq8CJjgnvxzD8xGPDhxRCmLsHomzTXg7XzDMCI=; b=c+vJ7pteuW+VLqGcBxzZ8kkbbv
	jqP8eY8/4jMvUhEkqeB/FEhLagUVV2pBDXgGckSVSBO6hi6aenG4dt4lCmMtaOpmUKNg9PlyEdlk9
	Qn6HjryZ80zZIfhFy1eLNwUNUEiahBYTNZH8xxIyn4UgS7/KgrvJMRRYryDuYCuZBBys=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkS2D-0006BK-0G;
	Mon, 26 Jan 2026 19:14:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1vkS2B-0006BD-Gt
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 19:13:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dsk4ApLoAel2/ZFvL2VDFNREwWm15f5vwyt2T8rwaD0=; b=T0b//eXxtSXD94iwZa2QvPUU2F
 5S/7DRBWtKW8MKMF+ogtPR2KMir/EL+NCGPJm1ckxspIIx9mwN2SiSXpo/EB+7kIGqtOHtmeyQ8Rh
 /4Uv0LKClBAfvVQOXwbhCA5LU6txovw86jhCq09Hi+zKYqiyiTU10EVUrJcEj58rr/Ns=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Dsk4ApLoAel2/ZFvL2VDFNREwWm15f5vwyt2T8rwaD0=; b=KwN/U/NlJIlT8XDXu/CNJHjGrV
 iWuNMuFWL6iDkvyZITM2nwLZqJhWSzYU5OEIFsXSGoqaNWIAfjUjSI+7xOV9EpQZUp7ROOQBtSo94
 6C4jCAWqsi946MMc7/CSJKwHODZobhU/iPaMMY4UCWN96FrnvesRlDZ/xWfOMy6w6C+k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkS2A-0005Ir-SJ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 19:13:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 85A2543E42;
 Mon, 26 Jan 2026 19:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E91C116C6;
 Mon, 26 Jan 2026 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769454828;
 bh=uJ4TrmswYapcKpzl6+LRL/lyOK9W/uASjQX0lK7L4Fc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d91eKtPfJIqQiS47895fe4SYkOiehS91isvaJmb2kzCOv872oSVjNl0gCClWHWg9u
 92iD8pIPgJOrOwu4Lny6esjp5zDSZzg040JGMyM1d4RK76OHlTqyjXCNmzcxhiPapQ
 QCn+tDe7zjTqQ/JDMJzss0MeB3frIj3Lo4p2Aiu3izb4F+hvvQZN3dZLvwN2G57CQx
 TSUVaXvK5UfYxwC/LUEf88kZsCRirWDJDFocByCGEDqvh6Mfif66BP0agKg4NCzPGW
 tMVFSSAJOmzTRtDXwSJZcZdMC7IVUO9Yo4U7i4c4nRjZpDAfGBEia0MV5FkjEQsRcP
 FwamTTBa4x5UA==
Date: Mon, 26 Jan 2026 11:13:47 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260126191347.GQ5910@frogsfrogsfrogs>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-11-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260126045212.1381843-11-hch@lst.de>
X-Headers-End: 1vkS2A-0005Ir-SJ
Subject: Re: [f2fs-dev] [PATCH 10/16] fsverity: deconstify the inode pointer
 in struct fsverity_info
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Andrey Albershteyn <aalbersh@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 26, 2026 at 05:50:56AM +0100, Christoph Hellwig wrote:
> A lot of file system code expects a non-const inode pointer.  Dropping
> the const qualifier here allows using the inode pointer in
> verify_data_block and prepares for further argument reductions.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good, though I'm leaning heavily on the build bot and your local
gcc to find any weird problems,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/verity/fsverity_private.h | 4 ++--
>  fs/verity/open.c             | 2 +-
>  fs/verity/verify.c           | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> index dd20b138d452..f9f3936b0a89 100644
> --- a/fs/verity/fsverity_private.h
> +++ b/fs/verity/fsverity_private.h
> @@ -73,7 +73,7 @@ struct fsverity_info {
>  	struct merkle_tree_params tree_params;
>  	u8 root_hash[FS_VERITY_MAX_DIGEST_SIZE];
>  	u8 file_digest[FS_VERITY_MAX_DIGEST_SIZE];
> -	const struct inode *inode;
> +	struct inode *inode;
>  	unsigned long *hash_block_verified;
>  };
>  
> @@ -124,7 +124,7 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
>  				     unsigned int log_blocksize,
>  				     const u8 *salt, size_t salt_size);
>  
> -struct fsverity_info *fsverity_create_info(const struct inode *inode,
> +struct fsverity_info *fsverity_create_info(struct inode *inode,
>  					   struct fsverity_descriptor *desc);
>  
>  void fsverity_set_info(struct inode *inode, struct fsverity_info *vi);
> diff --git a/fs/verity/open.c b/fs/verity/open.c
> index 090cb77326ee..128502cf0a23 100644
> --- a/fs/verity/open.c
> +++ b/fs/verity/open.c
> @@ -175,7 +175,7 @@ static void compute_file_digest(const struct fsverity_hash_alg *hash_alg,
>   * appended builtin signature), and check the signature if present.  The
>   * fsverity_descriptor must have already undergone basic validation.
>   */
> -struct fsverity_info *fsverity_create_info(const struct inode *inode,
> +struct fsverity_info *fsverity_create_info(struct inode *inode,
>  					   struct fsverity_descriptor *desc)
>  {
>  	struct fsverity_info *vi;
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index 881af159e705..55f1078c645a 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -156,10 +156,10 @@ static bool is_hash_block_verified(const struct fsverity_info *vi,
>   *
>   * Return: %true if the data block is valid, else %false.
>   */
> -static bool verify_data_block(struct inode *inode,
> -			      const struct fsverity_info *vi,
> +static bool verify_data_block(const struct fsverity_info *vi,
>  			      const struct fsverity_pending_block *dblock)
>  {
> +	struct inode *inode = vi->inode;
>  	const u64 data_pos = dblock->pos;
>  	const struct merkle_tree_params *params = &vi->tree_params;
>  	const unsigned int hsize = params->digest_size;
> @@ -362,7 +362,7 @@ fsverity_verify_pending_blocks(struct fsverity_verification_context *ctx)
>  	}
>  
>  	for (i = 0; i < ctx->num_pending; i++) {
> -		if (!verify_data_block(ctx->inode, vi, &ctx->pending_blocks[i]))
> +		if (!verify_data_block(vi, &ctx->pending_blocks[i]))
>  			return false;
>  	}
>  	fsverity_clear_pending_blocks(ctx);
> -- 
> 2.47.3
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
