Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B3BD1950F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f35mdMxIDklzi1Bi8vlhCs4sm7nphoT4k4D+ZxexUD4=; b=duCcb7vZ1FfszExbJODMiN6o3u
	BVtSSAvzcuP7aazrwqOchKqyvn5I3Pq2Di3N31uE0SCVINKzqyx4fDl+z7UWvY/FcQ7YKc8ghnXT6
	f/eUPu08XkF+B4+tfLZPCHln0V3PkDjf4By4IoU+hAjsZmzLTEsYlotxRNSNChp/ktCA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkS1i-0002oA-Ck;
	Mon, 26 Jan 2026 19:13:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1vkS1h-0002o3-9L
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 19:13:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H7Y/EvwhTDAFpMzzKX6cQuW/Vp0D9yns/CH4VB9LuBw=; b=aAj0teOLf/YAjncPnvVv3IUIfT
 2DrKESyCArCKzQ/MzrL8mp9umBLkuesUqsGhYd2ejwKtuvx39RmnYVpEuW79ExA45McEMLSBNbigI
 rkNXAf4CGVoaCGflDXhg/9/24i8TXwh7pcriAZlL494MNh01yUBr2uV18uarJGYGHJJQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H7Y/EvwhTDAFpMzzKX6cQuW/Vp0D9yns/CH4VB9LuBw=; b=lqcx2+wwNri0dRvb1OegAW7z8q
 lrxlXr31I5HKdCRigReWYtQLTJKHY7Gll7MdpiT5pEhYqfec0COQFV0JytTmF2PzGTk+Jwrv4NdsQ
 CrZCicXaExpPf9vGcROCVUVfdxzu+5quEoW692oe8MxTbu7E/28421rcVeRcAgscpGG4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkS1h-0005Hx-IL for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 19:13:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EA6B860121;
 Mon, 26 Jan 2026 19:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D57C116C6;
 Mon, 26 Jan 2026 19:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769454798;
 bh=eT3IR992p6oONvMpC+r6wQi71diCQPvsBYr8PIDAS60=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qUeTP6mYSouKnWqfts+Fd19K43rbbbzw/DMIIBchyEZpiveM1eUIckXa5l9Y8CLII
 TGk0KsSO/SimN8kSWWweGqMOI3Om+eiAFauIUzVuFTqYiWdERA7xniuhhlBpZW/s/1
 9/sqbhas1kG6h24grwtNZ75DknHZtlCGdKKcFhhDhBOB8unb/xHimGxplEItnKPflp
 6MmU6kU2OPoGvMdCu4G3dohIxAxFohOepqwzoX3BvFADp+iSe8Yqi5PVutA/SbBEZI
 wnLrdel391jDTv3Msymbi/OtiEdPBhpuAMlZdWTdeRgWb80SHsv+MXJKeLc0wjDRsE
 RmeIuLcKu5N7Q==
Date: Mon, 26 Jan 2026 11:13:18 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260126191318.GP5910@frogsfrogsfrogs>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-10-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260126045212.1381843-10-hch@lst.de>
X-Headers-End: 1vkS1h-0005Hx-IL
Subject: Re: [f2fs-dev] [PATCH 09/16] fsverity: constify the vi pointer in
 fsverity_verification_context
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

On Mon, Jan 26, 2026 at 05:50:55AM +0100, Christoph Hellwig wrote:
> struct fsverity_info contains information that is only read in the
> verification path.  Apply the const qualifier to match various explicitly
> passed arguments.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Seems fine to me...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/verity/verify.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index 32cadb71953c..881af159e705 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -21,7 +21,7 @@ struct fsverity_pending_block {
>  
>  struct fsverity_verification_context {
>  	struct inode *inode;
> -	struct fsverity_info *vi;
> +	const struct fsverity_info *vi;
>  
>  	/*
>  	 * This is the queue of data blocks that are pending verification.  When
> @@ -84,8 +84,8 @@ EXPORT_SYMBOL_GPL(fsverity_readahead);
>   * Returns true if the hash block with index @hblock_idx in the tree, located in
>   * @hpage, has already been verified.
>   */
> -static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
> -				   unsigned long hblock_idx)
> +static bool is_hash_block_verified(const struct fsverity_info *vi,
> +				   struct page *hpage, unsigned long hblock_idx)
>  {
>  	unsigned int blocks_per_page;
>  	unsigned int i;
> @@ -156,7 +156,8 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
>   *
>   * Return: %true if the data block is valid, else %false.
>   */
> -static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
> +static bool verify_data_block(struct inode *inode,
> +			      const struct fsverity_info *vi,
>  			      const struct fsverity_pending_block *dblock)
>  {
>  	const u64 data_pos = dblock->pos;
> @@ -315,7 +316,7 @@ static void
>  fsverity_init_verification_context(struct fsverity_verification_context *ctx,
>  				   struct inode *inode)
>  {
> -	struct fsverity_info *vi = *fsverity_info_addr(inode);
> +	const struct fsverity_info *vi = *fsverity_info_addr(inode);
>  
>  	ctx->inode = inode;
>  	ctx->vi = vi;
> @@ -342,7 +343,7 @@ fsverity_clear_pending_blocks(struct fsverity_verification_context *ctx)
>  static bool
>  fsverity_verify_pending_blocks(struct fsverity_verification_context *ctx)
>  {
> -	struct fsverity_info *vi = ctx->vi;
> +	const struct fsverity_info *vi = ctx->vi;
>  	const struct merkle_tree_params *params = &vi->tree_params;
>  	int i;
>  
> @@ -372,7 +373,7 @@ static bool fsverity_add_data_blocks(struct fsverity_verification_context *ctx,
>  				     struct folio *data_folio, size_t len,
>  				     size_t offset)
>  {
> -	struct fsverity_info *vi = ctx->vi;
> +	const struct fsverity_info *vi = ctx->vi;
>  	const struct merkle_tree_params *params = &vi->tree_params;
>  	const unsigned int block_size = params->block_size;
>  	u64 pos = (u64)data_folio->index << PAGE_SHIFT;
> -- 
> 2.47.3
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
