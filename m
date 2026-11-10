Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C2606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Nov 2026 03:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YXEUnhP+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BRRQMtxR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MjIuUK7U;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8swO+8E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TKjlS75sHQ6RFnNtJsAl9fswxLMicMuFSN4j8H+3wBA=; b=YXEUnhP+Tm39Ah
	Va9/tkWukG7peYPAi9AdmdVTXgL1AdfzKEgiqLGx8torrSy9RggTBN8q7V/rghdwcs7P0wj98+3ij
	TUZflm4MNt5U9BPRAmUHtoGZhmQ4u7Dwu06GM5F2lv9tiDpIFCXj20g0yHKKFfQ7PHIwaKfp/xqOz
	V+Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xQcAV-000000005ad-02s7;
	Tue, 10 Nov 2026 03:05:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xQcAT-000000005aV-409M
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 03:05:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q2tA8VWTe4ssWUaps8gO/lJnExS1EcWcfH6RMRgsr24=; b=BRRQMtxRqPu5EhtidGqiSEN2XA
 eU1TjQ9v8x1NkVaoCpl3sy5kZxEDZgEkhLqpLeEISZybVwk7D41foLgR868OOn151NGDmJ9HJk+1g
 vWWSsGO8belHt7hCylY+sNmt+WNdv68yWz/IycVb9Lf54Jd7vTF9utMafdq9umFKl2j8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q2tA8VWTe4ssWUaps8gO/lJnExS1EcWcfH6RMRgsr24=; b=MjIuUK7UMsdwbGgAHbXPKLsM+N
 BBIBArkvkAiFUY+Y/tPuixi8rV5eYbY908Bgx/tUXgttTW+Hy6gx/QPELfn/vEuclQen5miIbkfY+
 OF36a6l1MA/Lr4W4RhS8w7jlEdx2rLadVOrZv3A4BYR7mPwzDnyqLl9fSHYAPvKEE1T8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQcAR-0000000087B-0ChL
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 03:05:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9E68C406D9;
 Tue, 10 Nov 2026 03:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B491F008A1;
 Tue, 10 Nov 2026 03:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794279897;
 bh=q2tA8VWTe4ssWUaps8gO/lJnExS1EcWcfH6RMRgsr24=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=c8swO+8EpM/zakTcQRX+pXOzZpWhqIjQhijKUztqp+lIqFamvPH3Sd6+ICzeyzKlw
 gzRDD/a/ePcskqaY674mbLLjZDbu2dRNHFOlofDobs1BkWvptEhxvRr8h6B5zQCumO
 E/oJOEG3F+ISO9CR7n91es31yRmD/c8KgaZ4iSLYBYSjl/XNsknz2mjkEPj4Wv6VCD
 djEupiZDZcxtFn69kfFYFXfBv7TiNToqq3bej4IInvDkN0jW+2Uyj1tSjVA+NJEVu2
 sCoDOiTkbX27/srU85sP2fCkKEk64vYTU2uOLWetdUu+9sgLoUz+eXjoZxq9b4Sh6I
 RWBhhNXmq6hNQ==
Message-ID: <4e4fcefa-5a23-4210-83bf-ff1227a6aa39@kernel.org>
Date: Tue, 10 Nov 2026 11:04:53 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261102193952.3002018-1-daeho43@gmail.com>
 <20261102193952.3002018-19-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261102193952.3002018-19-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQcAR-0000000087B-0ChL
Subject: Re: [f2fs-dev] [PATCH 18/20] f2fs: support subpage blocks in
 compression
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 03:39, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> With subpage blocks, a cluster spans fewer folios than blocks, and
> several compressed blocks share a bounce folio.
> 
> - Require a cluster to cover at least one page.
> - Use block offsets and sizes for compressed data, keep each compressed
>   block at its block offset within the cluster, and count pending
>   compressed I/O in blocks so that a shared bounce folio is not
>   decompressed or freed early.
> - Submit only the written block of a shared bounce folio in
>   f2fs_submit_page_write(), at its offset in the folio.
> - Keep compressed files on the page based read and write paths, and
>   compress a cluster only when all of its blocks are dirty and below
>   EOF.
> - A folio with per-block state may hold uptodate blocks newer than the
>   on-disk cluster, so decompress into a bounce page and copy back only
>   the blocks that are not uptodate.
> - Cache compressed blocks one block at a time in the compress cache.
> - Lock only the unlocked pages in cancel_cluster_writeback() to avoid a
>   self-deadlock.
> - Attach a folio state to multi-block folios when compressed writeback
>   starts, as the raw write path does. Otherwise the write completion,
>   which does not hold the folio lock, can detach the page private flags
>   while a task is moving them into a new folio state.
> - Take sbi from the dic to count the blocks of a compressed page in
>   f2fs_finish_read_bio().
> - Write the blocks of a multi-block folio in
>   f2fs_write_single_data_page() as f2fs_write_cache_folios() does,
>   taking the write_blocks_pending bias with a new helper shared by the
>   two and dropping it with f2fs_ffs_put_write_pending().
> - Remove the -EOPNOTSUPP checks.

static inline unsigned int min_compress_log_size(struct f2fs_sb_info *sbi)
{
	return max_t(unsigned int, MIN_COMPRESS_LOG_SIZE,
			F2FS_LOG_BLKS_PER_PAGE(sbi));
}

	if (ri->i_log_cluster_size < min_compress_log_size(sbi) ||
  		ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
  		f2fs_warn(sbi,
  			"%s: inode (ino=%llx) has unsupported log cluster size: %u, run fsck to fix",

It seems we limited the min compress log size w/ F2FS_LOG_BLKS_PER_PAGE, e.g. 16k
page size, min compress cluster size is 16k, and for 64k page size, it is 64k, it
will deny to load any compress inode that cluster size is smaller than 64k when we
upgrade the kernel version, I think we need to declare it in commit message and document.

> 
> The bounce folios are now freed when the last block of a cluster
> completes, also when the block size equals PAGE_SIZE.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/compress.c | 520 +++++++++++++++++++++++++++++++--------------
>  fs/f2fs/data.c     | 248 +++++++++++++--------
>  fs/f2fs/f2fs.h     |  61 +++---
>  fs/f2fs/file.c     |  65 +++---
>  fs/f2fs/inode.c    |   2 +-
>  fs/f2fs/super.c    |   7 +-
>  6 files changed, 582 insertions(+), 321 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 0b0f31af6626..5b37ada5b111 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -57,14 +57,15 @@ struct f2fs_compress_ops {
>  	bool (*is_level_valid)(int level);
>  };
>  
> -static unsigned int offset_in_cluster(struct compress_ctx *cc, pgoff_t index)
> +static unsigned int offset_in_cluster(struct compress_ctx *cc, pgoff_t lblk)
>  {
> -	return index & (cc->cluster_size - 1);
> +	return (lblk & (cc->cluster_size - 1)) >>
> +		F2FS_LOG_BLKS_PER_PAGE(F2FS_I_SB(cc->inode));
>  }
>  
> -static pgoff_t cluster_idx(struct compress_ctx *cc, pgoff_t index)
> +static pgoff_t cluster_idx(struct compress_ctx *cc, pgoff_t lblk)
>  {
> -	return index >> cc->log_cluster_size;
> +	return lblk >> cc->log_cluster_size;
>  }
>  
>  static pgoff_t start_idx_of_cluster(struct compress_ctx *cc)
> @@ -114,7 +115,9 @@ static void f2fs_drop_rpages(struct compress_ctx *cc, int len, bool unlock)
>  
>  static void f2fs_put_rpages(struct compress_ctx *cc)
>  {
> -	f2fs_drop_rpages(cc, cc->cluster_size, false);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
> +
> +	f2fs_drop_rpages(cc, cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi), false);
>  }
>  
>  static void f2fs_unlock_rpages(struct compress_ctx *cc, int len)
> @@ -125,9 +128,11 @@ static void f2fs_unlock_rpages(struct compress_ctx *cc, int len)
>  static void f2fs_put_rpages_wbc(struct compress_ctx *cc,
>  		struct writeback_control *wbc, bool redirty, bool unlock)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
> +	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
>  	unsigned int i;
>  
> -	for (i = 0; i < cc->cluster_size; i++) {
> +	for (i = 0; i < nr_folios; i++) {
>  		if (!cc->rpages[i])
>  			continue;
>  		if (redirty)
> @@ -158,22 +163,24 @@ void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse)
>  	cc->rpages = NULL;
>  	cc->nr_rpages = 0;
>  	cc->nr_cpages = 0;
> -	cc->valid_nr_cpages = 0;
> +	cc->valid_nr_cblocks = 0;
>  	if (!reuse)
>  		cc->cluster_idx = NULL_CLUSTER;
>  }
>  
>  void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct folio *folio)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
>  	unsigned int cluster_ofs;
> +	pgoff_t lblk = f2fs_folio_lblk(sbi, folio);
>  
> -	if (!f2fs_cluster_can_merge_page(cc, folio->index))
> -		f2fs_bug_on(F2FS_I_SB(cc->inode), 1);
> +	if (!f2fs_cluster_can_merge_block(cc, lblk))
> +		f2fs_bug_on(sbi, 1);
>  
> -	cluster_ofs = offset_in_cluster(cc, folio->index);
> +	cluster_ofs = offset_in_cluster(cc, lblk);
>  	cc->rpages[cluster_ofs] = folio_page(folio, 0);
>  	cc->nr_rpages++;
> -	cc->cluster_idx = cluster_idx(cc, folio->index);
> +	cc->cluster_idx = cluster_idx(cc, lblk);
>  }
>  
>  #ifdef CONFIG_F2FS_FS_LZO
> @@ -184,7 +191,7 @@ static int lzo_init_compress_ctx(struct compress_ctx *cc)
>  	if (!cc->private)
>  		return -ENOMEM;
>  
> -	cc->clen = lzo1x_worst_compress(PAGE_SIZE << cc->log_cluster_size);
> +	cc->clen = lzo1x_worst_compress(F2FS_BLKSIZE(F2FS_I_SB(cc->inode)) << cc->log_cluster_size);
>  	return 0;
>  }
>  
> @@ -220,10 +227,11 @@ static int lzo_decompress_pages(struct decompress_io_ctx *dic)
>  		return -EIO;
>  	}
>  
> -	if (dic->rlen != PAGE_SIZE << dic->log_cluster_size) {
> +	if (dic->rlen != F2FS_BLKSIZE(dic->sbi) << dic->log_cluster_size) {
>  		f2fs_err_ratelimited(dic->sbi,
>  				"lzo invalid rlen:%zu, expected:%lu",
> -				dic->rlen, PAGE_SIZE << dic->log_cluster_size);
> +				dic->rlen, (unsigned long)F2FS_BLKSIZE(dic->sbi) <<
> +						dic->log_cluster_size);
>  		return -EIO;
>  	}
>  	return 0;
> @@ -256,7 +264,7 @@ static int lz4_init_compress_ctx(struct compress_ctx *cc)
>  	 * adapt worst compress case, because lz4 compressor can handle
>  	 * output budget properly.
>  	 */
> -	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> +	cc->clen = cc->rlen - F2FS_BLKSIZE(F2FS_I_SB(cc->inode)) - COMPRESS_HEADER_SIZE;
>  	return 0;
>  }
>  
> @@ -300,10 +308,11 @@ static int lz4_decompress_pages(struct decompress_io_ctx *dic)
>  		return -EIO;
>  	}
>  
> -	if (ret != PAGE_SIZE << dic->log_cluster_size) {
> +	if (ret != F2FS_BLKSIZE(dic->sbi) << dic->log_cluster_size) {
>  		f2fs_err_ratelimited(dic->sbi,
>  				"lz4 invalid ret:%d, expected:%lu",
> -				ret, PAGE_SIZE << dic->log_cluster_size);
> +				ret, (unsigned long)F2FS_BLKSIZE(dic->sbi) <<
> +						dic->log_cluster_size);
>  		return -EIO;
>  	}
>  	return 0;
> @@ -358,7 +367,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
>  	cc->private = workspace;
>  	cc->private2 = stream;
>  
> -	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> +	cc->clen = cc->rlen - F2FS_BLKSIZE(F2FS_I_SB(cc->inode)) - COMPRESS_HEADER_SIZE;
>  	return 0;
>  }
>  
> @@ -375,7 +384,7 @@ static int zstd_compress_pages(struct compress_ctx *cc)
>  	zstd_in_buffer inbuf;
>  	zstd_out_buffer outbuf;
>  	int src_size = cc->rlen;
> -	int dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> +	int dst_size = src_size - F2FS_BLKSIZE(F2FS_I_SB(cc->inode)) - COMPRESS_HEADER_SIZE;
>  	int ret;
>  
>  	inbuf.pos = 0;
> @@ -419,7 +428,7 @@ static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
>  	void *workspace;
>  	unsigned int workspace_size;
>  	unsigned int max_window_size =
> -			MAX_COMPRESS_WINDOW_SIZE(dic->log_cluster_size);
> +			MAX_COMPRESS_WINDOW_SIZE(dic->sbi, dic->log_cluster_size);
>  
>  	workspace_size = zstd_dstream_workspace_bound(max_window_size);
>  
> @@ -475,7 +484,7 @@ static int zstd_decompress_pages(struct decompress_io_ctx *dic)
>  		f2fs_err_ratelimited(dic->sbi,
>  				"%s ZSTD invalid rlen:%zu, expected:%lu",
>  				__func__, dic->rlen,
> -				PAGE_SIZE << dic->log_cluster_size);
> +				(unsigned long)F2FS_BLKSIZE(dic->sbi) << dic->log_cluster_size);
>  		return -EIO;
>  	}
>  
> @@ -550,8 +559,6 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
>  {
>  	if (!f2fs_compressed_file(inode))
>  		return true;
> -	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode)))
> -		return false;
>  	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
>  }
>  
> @@ -621,13 +628,23 @@ static void *f2fs_vmap(struct page **pages, unsigned int count)
>  	return buf;
>  }
>  
> +static void f2fs_vunmap(void *vaddr, unsigned int count)
> +{
> +	if (!vaddr)
> +		return;
> +	vm_unmap_ram((void *)((unsigned long)vaddr & PAGE_MASK), count);
> +}
> +
>  static int f2fs_compress_pages(struct compress_ctx *cc)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
>  	struct f2fs_inode_info *fi = F2FS_I(cc->inode);
>  	const struct f2fs_compress_ops *cops =
>  				f2fs_cops[fi->i_compress_algorithm];
> -	unsigned int max_len, new_nr_cpages;
> +	unsigned int max_len, new_cblocks;
> +	unsigned int nr_rfolios, needed_folios;
> +	unsigned int cbuf_blk_ofs = f2fs_has_subpage_blocks(sbi) ? 1 : 0;
> +	void *cbuf_vaddr;
>  	u32 chksum = 0;
>  	int i, ret;
>  
> @@ -640,9 +657,12 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
>  			goto out;
>  	}
>  
> +	nr_rfolios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
> +
>  	max_len = COMPRESS_HEADER_SIZE + cc->clen;
> -	cc->nr_cpages = DIV_ROUND_UP(max_len, PAGE_SIZE);
> -	cc->valid_nr_cpages = cc->nr_cpages;
> +	cc->valid_nr_cblocks = DIV_ROUND_UP(max_len, F2FS_BLKSIZE(sbi));

F2FS_BLK_ALIGN(sbi, max_len)?

> +	cc->nr_cpages = DIV_ROUND_UP(cbuf_blk_ofs + cc->valid_nr_cblocks,
> +					F2FS_BLKS_PER_PAGE(sbi));
>  
>  	cc->cpages = page_array_alloc(sbi, cc->nr_cpages);
>  	if (!cc->cpages) {
> @@ -653,23 +673,24 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
>  	for (i = 0; i < cc->nr_cpages; i++)
>  		cc->cpages[i] = f2fs_compress_alloc_page();
>  
> -	cc->rbuf = f2fs_vmap(cc->rpages, cc->cluster_size);
> +	cc->rbuf = f2fs_vmap(cc->rpages, nr_rfolios);
>  	if (!cc->rbuf) {
>  		ret = -ENOMEM;
>  		goto out_free_cpages;
>  	}
>  
> -	cc->cbuf = f2fs_vmap(cc->cpages, cc->nr_cpages);
> -	if (!cc->cbuf) {
> +	cbuf_vaddr = f2fs_vmap(cc->cpages, cc->nr_cpages);
> +	if (!cbuf_vaddr) {
>  		ret = -ENOMEM;
>  		goto out_vunmap_rbuf;
>  	}
> +	cc->cbuf = cbuf_vaddr + (cbuf_blk_ofs << sbi->log_blocksize);
>  
>  	ret = cops->compress_pages(cc);
>  	if (ret)
>  		goto out_vunmap_cbuf;
>  
> -	max_len = PAGE_SIZE * (cc->cluster_size - 1) - COMPRESS_HEADER_SIZE;
> +	max_len = F2FS_BLKSIZE(sbi) * (cc->cluster_size - 1) - COMPRESS_HEADER_SIZE;
>  
>  	if (cc->clen > max_len) {
>  		ret = -EAGAIN;
> @@ -685,17 +706,19 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
>  	for (i = 0; i < COMPRESS_DATA_RESERVED_SIZE; i++)
>  		cc->cbuf->reserved[i] = cpu_to_le32(0);
>  
> -	new_nr_cpages = DIV_ROUND_UP(cc->clen + COMPRESS_HEADER_SIZE, PAGE_SIZE);
> +	new_cblocks = DIV_ROUND_UP(cc->clen + COMPRESS_HEADER_SIZE, F2FS_BLKSIZE(sbi));
>  
> -	/* zero out any unused part of the last page */
> +	/* zero out any unused part of the last block */
>  	memset(&cc->cbuf->cdata[cc->clen], 0,
> -			(new_nr_cpages * PAGE_SIZE) -
> +			(new_cblocks * F2FS_BLKSIZE(sbi)) -
>  			(cc->clen + COMPRESS_HEADER_SIZE));
>  
> -	vm_unmap_ram(cc->cbuf, cc->nr_cpages);
> -	vm_unmap_ram(cc->rbuf, cc->cluster_size);
> +	f2fs_vunmap(cc->cbuf, cc->nr_cpages);
> +	f2fs_vunmap(cc->rbuf, nr_rfolios);
>  
> -	for (i = new_nr_cpages; i < cc->nr_cpages; i++) {
> +	needed_folios = DIV_ROUND_UP(cbuf_blk_ofs + new_cblocks,
> +					F2FS_BLKS_PER_PAGE(sbi));
> +	for (i = needed_folios; i < cc->nr_cpages; i++) {
>  		f2fs_compress_free_page(cc->cpages[i]);
>  		cc->cpages[i] = NULL;
>  	}
> @@ -703,16 +726,16 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
>  	if (cops->destroy_compress_ctx)
>  		cops->destroy_compress_ctx(cc);
>  
> -	cc->valid_nr_cpages = new_nr_cpages;
> +	cc->valid_nr_cblocks = new_cblocks;
>  
>  	trace_f2fs_compress_pages_end(cc->inode, cc->cluster_idx,
>  							cc->clen, ret);
>  	return 0;
>  
>  out_vunmap_cbuf:
> -	vm_unmap_ram(cc->cbuf, cc->nr_cpages);
> +	f2fs_vunmap(cc->cbuf, cc->nr_cpages);
>  out_vunmap_rbuf:
> -	vm_unmap_ram(cc->rbuf, cc->cluster_size);
> +	f2fs_vunmap(cc->rbuf, nr_rfolios);
>  out_free_cpages:
>  	for (i = 0; i < cc->nr_cpages; i++) {
>  		if (cc->cpages[i])
> @@ -741,7 +764,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
>  	const struct f2fs_compress_ops *cops =
>  			f2fs_cops[fi->i_compress_algorithm];
>  	bool bypass_callback = false;
> -	int ret;
> +	int i, ret;
>  
>  	trace_f2fs_decompress_pages_start(dic->inode, dic->cluster_idx,
>  				dic->cluster_size, fi->i_compress_algorithm);
> @@ -758,9 +781,9 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
>  	}
>  
>  	dic->clen = le32_to_cpu(dic->cbuf->clen);
> -	dic->rlen = PAGE_SIZE << dic->log_cluster_size;
> +	dic->rlen = F2FS_BLKSIZE(sbi) << dic->log_cluster_size;
>  
> -	if (dic->clen > PAGE_SIZE * dic->nr_cpages - COMPRESS_HEADER_SIZE) {
> +	if (dic->clen > F2FS_BLKSIZE(sbi) * dic->valid_nr_cblocks - COMPRESS_HEADER_SIZE) {
>  		ret = -EFSCORRUPTED;
>  
>  		/* Avoid f2fs_commit_super in irq context */
> @@ -787,6 +810,31 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
>  		}
>  	}
>  
> +	/*
> +	 * Folios with f2fs_folio_state were decompressed into bounce pages.
> +	 * Copy only the blocks that are not uptodate, so that newer data in
> +	 * the uptodate (possibly dirty) blocks is kept.
> +	 */
> +	for (i = 0; !ret && i < dic->nr_rpages; i++) {
> +		struct page *rpage = dic->rpages[i];
> +		struct folio *folio;
> +		pgoff_t lblk;
> +		unsigned int b;
> +
> +		if (!rpage || dic->tpages[i] == rpage)
> +			continue;
> +
> +		folio = page_folio(rpage);
> +		lblk = f2fs_folio_lblk(sbi, folio);
> +		for (b = 0; b < f2fs_blocks_per_folio(sbi, folio); b++) {
> +			size_t off = (size_t)b << sbi->log_blocksize;
> +
> +			if (!f2fs_ffs_test_blk_uptodate(folio, lblk + b))
> +				memcpy_page(rpage, off, dic->tpages[i], off,
> +					    F2FS_BLKSIZE(sbi));
> +		}
> +	}
> +
>  out_release:
>  	f2fs_release_decomp_mem(dic, bypass_callback, false);
>  
> @@ -796,8 +844,8 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
>  	f2fs_decompress_end_io(dic, ret, in_task);
>  }
>  
> -static void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
> -		struct folio *folio, nid_t ino, block_t blkaddr);
> +static void f2fs_cache_compressed_block(struct f2fs_sb_info *sbi,
> +		struct folio *folio, size_t offset, nid_t ino, block_t blkaddr);
>  
>  /*
>   * This is called when a page of a compressed cluster has been read from disk
> @@ -805,29 +853,35 @@ static void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
>   * page being waited on in the cluster, and if so, it decompresses the cluster
>   * (or in the case of a failure, cleans up without actually decompressing).
>   */
> -void f2fs_end_read_compressed_page(struct folio *folio, bool failed,
> -		block_t blkaddr, bool in_task)
> +void f2fs_end_read_compressed_page(struct folio *folio, size_t offset,
> +		bool failed, block_t blkaddr, unsigned int nr_blocks,
> +		bool in_task)
>  {
>  	struct decompress_io_ctx *dic = folio->private;
>  	struct f2fs_sb_info *sbi = dic->sbi;
> +	int i;
>  
> -	dec_cache_count(sbi, F2FS_RD_DATA);
> +	sub_cache_counts(sbi, F2FS_RD_DATA, nr_blocks);
>  
>  	if (failed)
>  		WRITE_ONCE(dic->failed, true);
> -	else if (blkaddr && in_task)
> -		f2fs_cache_compressed_page(sbi, folio,
> -					dic->inode->i_ino, blkaddr);
> +	else if (blkaddr && in_task) {
> +		for (i = 0; i < nr_blocks; i++)
> +			f2fs_cache_compressed_block(sbi, folio,
> +					offset + i * F2FS_BLKSIZE(sbi),
> +					dic->inode->i_ino,
> +					blkaddr + i);
> +	}
>  
> -	if (atomic_dec_and_test(&dic->remaining_pages))
> +	if (atomic_sub_and_test(nr_blocks, &dic->remaining_blocks))
>  		f2fs_decompress_cluster(dic, in_task);
>  }
>  
> -static bool is_page_in_cluster(struct compress_ctx *cc, pgoff_t index)
> +static bool is_block_in_cluster(struct compress_ctx *cc, pgoff_t lblk)
>  {
>  	if (cc->cluster_idx == NULL_CLUSTER)
>  		return true;
> -	return cc->cluster_idx == cluster_idx(cc, index);
> +	return cc->cluster_idx == cluster_idx(cc, lblk);
>  }
>  
>  bool f2fs_cluster_is_empty(struct compress_ctx *cc)
> @@ -837,19 +891,40 @@ bool f2fs_cluster_is_empty(struct compress_ctx *cc)
>  
>  static bool f2fs_cluster_is_full(struct compress_ctx *cc)
>  {
> -	return cc->cluster_size == cc->nr_rpages;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
> +	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
> +	int i;
> +
> +	if (cc->nr_rpages != nr_folios)
> +		return false;
> +
> +	/* PG_dirty is cleared for writeback; without ffs it covered every block */
> +	for (i = 0; i < nr_folios; i++) {
> +		struct folio *folio = page_folio(cc->rpages[i]);
> +		unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
> +		unsigned int start, count;
> +
> +		if (f2fs_folio_has_ffs(folio) &&
> +		    (!f2fs_ffs_dirty_blk_range(folio, 0, nr_blocks,
> +					       &start, &count) ||
> +		     count != nr_blocks))
> +			return false;
> +	}
> +	return true;
>  }
>  
> -bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index)
> +bool f2fs_cluster_can_merge_block(struct compress_ctx *cc, pgoff_t lblk)
>  {
>  	if (f2fs_cluster_is_empty(cc))
>  		return true;
> -	return is_page_in_cluster(cc, index);
> +	return is_block_in_cluster(cc, lblk);
>  }
>  
>  bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
>  				int index, int nr_pages, bool uptodate)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
> +	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
>  	unsigned long pgidx = page_folio(pages[index])->index;
>  	int i = uptodate ? 0 : 1;
>  
> @@ -857,13 +932,13 @@ bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
>  	 * when uptodate set to true, try to check all pages in cluster is
>  	 * uptodate or not.
>  	 */
> -	if (uptodate && (pgidx % cc->cluster_size))
> +	if (uptodate && (pgidx % nr_folios))
>  		return false;
>  
> -	if (nr_pages - index < cc->cluster_size)
> +	if (nr_pages - index < nr_folios)
>  		return false;
>  
> -	for (; i < cc->cluster_size; i++) {
> +	for (; i < nr_folios; i++) {
>  		struct folio *folio = page_folio(pages[index + i]);
>  
>  		if (folio->index != pgidx + i)
> @@ -877,17 +952,19 @@ bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
>  
>  static bool cluster_has_invalid_data(struct compress_ctx *cc)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
>  	loff_t i_size = i_size_read(cc->inode);
> -	unsigned nr_pages = DIV_ROUND_UP(i_size, PAGE_SIZE);
> +	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
>  	int i;
>  
> -	for (i = 0; i < cc->cluster_size; i++) {
> +	for (i = 0; i < nr_folios; i++) {
>  		struct page *page = cc->rpages[i];
>  
> -		f2fs_bug_on(F2FS_I_SB(cc->inode), !page);
> +		f2fs_bug_on(sbi, !page);
>  
> -		/* beyond EOF */
> -		if (page_folio(page)->index >= nr_pages)
> +		/* any block beyond EOF */
> +		if (folio_pos(page_folio(page)) +
> +		    folio_size(page_folio(page)) - F2FS_BLKSIZE(sbi) >= i_size)
>  			return true;
>  	}
>  	return false;
> @@ -1014,17 +1091,17 @@ static int f2fs_decompressed_blocks(struct inode *inode,
>  }
>  
>  /* return whether cluster is compressed one or not */
> -int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
> +int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t lblk)
>  {
>  	return __f2fs_cluster_blocks(inode,
> -		index >> F2FS_I(inode)->i_log_cluster_size,
> +		lblk >> F2FS_I(inode)->i_log_cluster_size,
>  		CLUSTER_IS_COMPR);
>  }
>  
>  /* return whether cluster contains non raw blocks or not */
> -bool f2fs_is_sparse_cluster(struct inode *inode, pgoff_t index)
> +bool f2fs_is_sparse_cluster(struct inode *inode, pgoff_t lblk)
>  {
> -	unsigned int cluster_idx = index >> F2FS_I(inode)->i_log_cluster_size;
> +	unsigned int cluster_idx = lblk >> F2FS_I(inode)->i_log_cluster_size;
>  
>  	return f2fs_decompressed_blocks(inode, cluster_idx) !=
>  		F2FS_I(inode)->i_cluster_size;
> @@ -1045,34 +1122,57 @@ static bool cluster_may_compress(struct compress_ctx *cc)
>  
>  static void set_cluster_writeback(struct compress_ctx *cc)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
> +	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
>  	int i;
>  
> -	for (i = 0; i < cc->cluster_size; i++) {
> -		if (cc->rpages[i])
> -			set_page_writeback(cc->rpages[i]);
> +	for (i = 0; i < nr_folios; i++) {
> +		struct folio *folio;
> +
> +		if (!cc->rpages[i])
> +			continue;
> +
> +		folio = page_folio(cc->rpages[i]);
> +		set_page_writeback(cc->rpages[i]);
> +		/*
> +		 * Attach a folio state before the I/O, as the raw write path
> +		 * does, so that the write completion, which does not hold the
> +		 * folio lock, never detaches the page private flags kept in
> +		 * folio->private.
> +		 */
> +		if (f2fs_is_multiblock_folio(sbi, folio))
> +			f2fs_ffs_find_or_alloc(folio);
>  	}
>  }
>  
>  static void cancel_cluster_writeback(struct compress_ctx *cc,
> -			struct compress_io_ctx *cic, int submitted)
> +			struct compress_io_ctx *cic, int failed_blk)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
> +	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
>  	int i;
>  
>  	/* Wait for submitted IOs. */
> -	if (submitted > 1) {
> +	if (failed_blk > 1) {
>  		f2fs_submit_merged_write(F2FS_I_SB(cc->inode), DATA);
> -		while (atomic_read(&cic->pending_pages) !=
> -					(cc->valid_nr_cpages - submitted + 1))
> +		while (atomic_read(&cic->pending_blocks) !=
> +					(cc->valid_nr_cblocks - failed_blk + 1))
>  			f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
>  	}
>  
> +	inode_add_dirty_blocks(cc->inode, failed_blk);
> +
>  	/* Cancel writeback and stay locked. */
> -	for (i = 0; i < cc->cluster_size; i++) {
> +	for (i = 0; i < nr_folios; i++) {
>  		struct folio *folio = page_folio(cc->rpages[i]);
> +		unsigned int last_blk_in_folio =
> +			((i + 1) << F2FS_LOG_BLKS_PER_PAGE(sbi)) - 1;
>  
> -		if (i < submitted) {
> -			inode_inc_dirty_block(cc->inode);
> +		if (last_blk_in_folio < failed_blk) {
>  			folio_lock(folio);
> +			/* f2fs_write_compressed_pages() cleared its dirty blocks */
> +			if (f2fs_folio_has_ffs(folio))
> +				f2fs_ffs_mark_subrange_dirty(folio, 0, PAGE_SIZE);

f2fs_ffs_mark_subrange_dirty(folio, 0, folio_size(folio));

>  		}
>  		folio_clear_f2fs_gcing(folio);
>  		if (folio_test_writeback(folio))
> @@ -1082,21 +1182,26 @@ static void cancel_cluster_writeback(struct compress_ctx *cc,
>  
>  static void set_cluster_dirty(struct compress_ctx *cc)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
> +	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
>  	int i;
>  
> -	for (i = 0; i < cc->cluster_size; i++) {
> +	for (i = 0; i < nr_folios; i++) {
>  		struct folio *folio;
>  
>  		if (!cc->rpages[i])
>  			continue;
>  		folio = page_folio(cc->rpages[i]);
> +		/* The whole cluster is rewritten */
> +		if (f2fs_folio_has_ffs(folio))
> +			f2fs_ffs_mark_subrange_dirty(folio, 0, folio_size(folio));
>  		folio_mark_dirty(folio);
>  		folio_set_f2fs_gcing(folio);
>  	}
>  }
>  
>  static int prepare_compress_overwrite(struct compress_ctx *cc,
> -		struct page **pagep, pgoff_t index, void **fsdata)
> +		struct page **pagep, pgoff_t lblk, void **fsdata)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
>  	struct address_space *mapping = cc->inode->i_mapping;
> @@ -1115,9 +1220,13 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  	if (ret)
>  		return ret;
>  
> +	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
> +
>  	/* keep folio reference to avoid page reclaim */
> -	for (i = 0; i < cc->cluster_size; i++) {
> -		folio = f2fs_filemap_get_folio(mapping, start_idx + i,
> +	for (i = 0; i < nr_folios; i++) {
> +		pgoff_t f_index = f2fs_lblk_to_folio_index(sbi, start_idx) + i;
> +
> +		folio = f2fs_filemap_get_folio(mapping, f_index,
>  				fgp_flag, GFP_NOFS);
>  		if (IS_ERR(folio)) {
>  			ret = PTR_ERR(folio);
> @@ -1147,10 +1256,12 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  			goto out;
>  	}
>  
> -	for (i = 0; i < cc->cluster_size; i++) {
> +	for (i = 0; i < nr_folios; i++) {
> +		pgoff_t f_index = f2fs_lblk_to_folio_index(sbi, start_idx) + i;
> +
>  		f2fs_bug_on(sbi, cc->rpages[i]);
>  
> -		folio = filemap_lock_folio(mapping, start_idx + i);
> +		folio = filemap_lock_folio(mapping, f_index);
>  		if (IS_ERR(folio)) {
>  			/* folio could be truncated */
>  			goto release_and_retry;
> @@ -1171,7 +1282,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  
>  	if (likely(!ret)) {
>  		*fsdata = cc->rpages;
> -		*pagep = cc->rpages[offset_in_cluster(cc, index)];
> +		*pagep = cc->rpages[offset_in_cluster(cc, lblk)];
>  		return cc->cluster_size;
>  	}
>  
> @@ -1184,23 +1295,23 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  }
>  
>  int f2fs_prepare_compress_overwrite(struct inode *inode,
> -		struct page **pagep, pgoff_t index, void **fsdata)
> +		struct page **pagep, pgoff_t lblk, void **fsdata)
>  {
>  	struct compress_ctx cc = {
>  		.inode = inode,
>  		.log_cluster_size = F2FS_I(inode)->i_log_cluster_size,
>  		.cluster_size = F2FS_I(inode)->i_cluster_size,
> -		.cluster_idx = index >> F2FS_I(inode)->i_log_cluster_size,
> +		.cluster_idx = lblk >> F2FS_I(inode)->i_log_cluster_size,
>  		.rpages = NULL,
>  		.nr_rpages = 0,
>  		.vi = NULL, /* can't write to fsverity files */
>  	};
>  
> -	return prepare_compress_overwrite(&cc, pagep, index, fsdata);
> +	return prepare_compress_overwrite(&cc, pagep, lblk, fsdata);
>  }
>  
>  bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
> -					pgoff_t index, unsigned copied)
> +					pgoff_t lblk, unsigned int copied)
>  
>  {
>  	struct compress_ctx cc = {
> @@ -1210,7 +1321,7 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
>  		.rpages = fsdata,
>  	};
>  	struct folio *folio = page_folio(cc.rpages[0]);
> -	bool first_index = (index == folio->index);
> +	bool first_index = (lblk == f2fs_folio_lblk(F2FS_I_SB(inode), folio));
>  
>  	if (copied)
>  		set_cluster_dirty(&cc);
> @@ -1223,12 +1334,15 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
>  
>  int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	void *fsdata = NULL;
>  	struct page *pagep;
>  	struct page **rpages;
>  	int log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
> -	pgoff_t start_idx = from >> (PAGE_SHIFT + log_cluster_size) <<
> +	pgoff_t start_idx = (from >> (sbi->log_blocksize + log_cluster_size)) <<
>  							log_cluster_size;
> +	unsigned int nr_folios = (1 << log_cluster_size) >>
> +					F2FS_LOG_BLKS_PER_PAGE(sbi);
>  	int i;
>  	int err;
>  
> @@ -1252,9 +1366,9 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
>  
>  	rpages = fsdata;
>  
> -	for (i = (1 << log_cluster_size) - 1; i >= 0; i--) {
> +	for (i = nr_folios - 1; i >= 0; i--) {
>  		struct folio *folio = page_folio(rpages[i]);
> -		loff_t start = (loff_t)folio->index << PAGE_SHIFT;
> +		loff_t start = folio_pos(folio);
>  		loff_t offset = from > start ? from - start : 0;
>  
>  		folio_zero_segment(folio, offset, folio_size(folio));
> @@ -1266,14 +1380,15 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
>  	f2fs_compress_write_end(inode, fsdata, start_idx, true);
>  
>  	err = filemap_write_and_wait_range(inode->i_mapping,
> -			round_down(from, 1 << log_cluster_size << PAGE_SHIFT),
> +			round_down(from, 1 << log_cluster_size << sbi->log_blocksize),
>  			LLONG_MAX);
>  	if (err)
>  		return err;
>  
>  	truncate_pagecache(inode, from);
>  
> -	return f2fs_do_truncate_blocks(inode, round_up(from, PAGE_SIZE), lock);
> +	return f2fs_do_truncate_blocks(inode, round_up(from, F2FS_BLKSIZE(sbi)),
> +				       lock);
>  }
>  
>  static int f2fs_write_compressed_pages(struct compress_ctx *cc,
> @@ -1303,8 +1418,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  	struct node_info ni;
>  	struct compress_io_ctx *cic;
>  	struct f2fs_lock_context lc;
> +	unsigned int nr_rfolios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
>  	pgoff_t start_idx = start_idx_of_cluster(cc);
> -	unsigned int last_index = cc->cluster_size - 1;
> +	unsigned int blk_idx, c_folio_idx, c_folio_ofs;
>  	loff_t psize;
>  	int i, err;
>  	bool quota_inode = IS_NOQUOTA(inode);
> @@ -1338,10 +1454,10 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  			goto out_put_dnode;
>  	}
>  
> -	folio = page_folio(cc->rpages[last_index]);
> +	folio = page_folio(cc->rpages[nr_rfolios - 1]);
>  	psize = folio_next_pos(folio);
>  
> -	err = f2fs_get_node_info(fio.sbi, dn.nid, &ni, false);
> +	err = f2fs_get_node_info(sbi, dn.nid, &ni, false);
>  	if (err)
>  		goto out_put_dnode;
>  
> @@ -1353,18 +1469,30 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  
>  	cic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
>  	cic->inode = inode;
> -	atomic_set(&cic->pending_pages, cc->valid_nr_cpages);
> -	cic->rpages = page_array_alloc(sbi, cc->cluster_size);
> +	atomic_set(&cic->pending_blocks, cc->valid_nr_cblocks);
> +	cic->rpages = page_array_alloc(sbi, nr_rfolios);
>  	if (!cic->rpages)
>  		goto out_put_cic;
>  
> -	cic->nr_rpages = cc->cluster_size;
> +	cic->nr_rpages = nr_rfolios;
> +	cic->cpages = cc->cpages;
> +	cic->nr_cpages = cc->nr_cpages;
> +	cc->cpages = NULL;
> +
> +	for (i = 0; i < cic->nr_cpages; i++) {
> +		pgoff_t fidx;
> +
> +		if (!cic->cpages[i])
> +			break;
> +
> +		fidx = f2fs_has_subpage_blocks(sbi) ?
> +				(f2fs_lblk_to_folio_index(sbi, start_idx) + i) :

It's better to explain why the start iv value is different in between subpage
blocks and non subpage blocks case. I guess it's due to we still hold the first
unused block in cpage (the special block is tagged as COMPRESS_ADDR), right?

> +				(start_idx + 1 + i);
>  
> -	for (i = 0; i < cc->valid_nr_cpages; i++) {
> -		f2fs_set_compressed_page(cc->cpages[i], inode,
> -				page_folio(cc->rpages[i + 1])->index, cic);
> -		fio.compressed_page = cc->cpages[i];
> +		f2fs_set_compressed_page(cic->cpages[i], inode, fidx, cic);
> +	}
>  
> +	for (i = 0; i < cc->valid_nr_cblocks; i++) {
>  		fio.old_blkaddr = data_blkaddr(dn.inode, dn.node_entry,
>  						dn.ofs_in_node + i + 1);
>  
> @@ -1374,14 +1502,15 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  
>  	set_cluster_writeback(cc);
>  
> -	for (i = 0; i < cc->cluster_size; i++)
> +	for (i = 0; i < nr_rfolios; i++)
>  		cic->rpages[i] = cc->rpages[i];
>  
>  	for (i = 0; i < cc->cluster_size; i++, dn.ofs_in_node++) {
>  		block_t blkaddr;
> +		unsigned int r_idx = i >> F2FS_LOG_BLKS_PER_PAGE(sbi);
>  
>  		blkaddr = f2fs_data_blkaddr(&dn);
> -		fio.folio = page_folio(cc->rpages[i]);
> +		fio.folio = page_folio(cc->rpages[r_idx]);
>  		fio.old_blkaddr = blkaddr;
>  
>  		/* cluster header */
> @@ -1397,7 +1526,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  		if (fio.compr_blocks && __is_valid_data_blkaddr(blkaddr))
>  			fio.compr_blocks++;
>  
> -		if (i > cc->valid_nr_cpages) {
> +		if (i > cc->valid_nr_cblocks) {
>  			if (__is_valid_data_blkaddr(blkaddr)) {
>  				f2fs_invalidate_blocks(sbi, blkaddr, 1);
>  				f2fs_update_data_blkaddr(&dn, NEW_ADDR);
> @@ -1407,9 +1536,13 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  
>  		f2fs_bug_on(fio.sbi, blkaddr == NULL_ADDR);
>  
> -		fio.compressed_page = cc->cpages[i - 1];
> +		blk_idx = f2fs_has_subpage_blocks(sbi) ? i : (i - 1);
> +		c_folio_idx = blk_idx / F2FS_BLKS_PER_PAGE(sbi);
> +		c_folio_ofs = blk_idx % F2FS_BLKS_PER_PAGE(sbi);
> +
> +		fio.compressed_page = cic->cpages[c_folio_idx];
> +		fio.folio_offset = c_folio_ofs;
>  
> -		cc->cpages[i - 1] = NULL;
>  		fio.submitted = 0;
>  		f2fs_outplace_write_data(&dn, &fio);
>  		if (unlikely(!fio.submitted)) {
> @@ -1420,13 +1553,20 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  		(*submitted)++;
>  unlock_continue:
>  		inode_dec_dirty_block(cc->inode);
> -		folio_unlock(fio.folio);
> +		if ((i + 1) % F2FS_BLKS_PER_PAGE(sbi) == 0) {
> +			f2fs_ffs_clear_subrange_dirty_and_test(fio.folio,
> +							       0, PAGE_SIZE);
> +			folio_unlock(fio.folio);
> +		}
>  	}
>  
> +	/* count pages like the raw write path */
> +	*submitted = DIV_ROUND_UP(*submitted, F2FS_BLKS_PER_PAGE(sbi));
> +
>  	if (fio.compr_blocks)
>  		f2fs_i_compr_blocks_update(inode, fio.compr_blocks - 1, false);
> -	f2fs_i_compr_blocks_update(inode, cc->valid_nr_cpages, true);
> -	add_compr_block_stat(inode, cc->valid_nr_cpages);
> +	f2fs_i_compr_blocks_update(inode, cc->valid_nr_cblocks, true);
> +	add_compr_block_stat(inode, cc->valid_nr_cblocks);
>  
>  	set_inode_flag(cc->inode, FI_APPEND_WRITE);
>  
> @@ -1442,13 +1582,18 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  	spin_unlock(&fi->i_size_lock);
>  
>  	f2fs_put_rpages(cc);
> -	page_array_free(sbi, cc->cpages, cc->nr_cpages);
> -	cc->cpages = NULL;
>  	f2fs_destroy_compress_ctx(cc, false);
>  	return 0;
>  
>  out_free_page_array:
> -	page_array_free(sbi, cic->rpages, cc->cluster_size);
> +	page_array_free(sbi, cic->rpages, nr_rfolios);
> +
> +	for (i = 0; i < cic->nr_cpages; i++) {
> +		if (!cic->cpages[i])
> +			continue;
> +		f2fs_compress_free_page(cic->cpages[i]);
> +	}
> +	page_array_free(sbi, cic->cpages, cic->nr_cpages);
>  out_put_cic:
>  	kmem_cache_free(cic_entry_slab, cic);
>  out_put_dnode:
> @@ -1459,18 +1604,21 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  	else
>  		f2fs_unlock_op(sbi, &lc);
>  out_free:
> -	for (i = 0; i < cc->valid_nr_cpages; i++) {
> -		f2fs_compress_free_page(cc->cpages[i]);
> -		cc->cpages[i] = NULL;
> +	if (cc->cpages) {
> +		for (i = 0; i < cc->nr_cpages; i++) {
> +			if (!cc->cpages[i])
> +				continue;
> +			f2fs_compress_free_page(cc->cpages[i]);
> +		}
> +		page_array_free(sbi, cc->cpages, cc->nr_cpages);
> +		cc->cpages = NULL;
>  	}
> -	page_array_free(sbi, cc->cpages, cc->nr_cpages);
> -	cc->cpages = NULL;
>  	return -EAGAIN;
>  }
>  
> -void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
> +void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio,
> +				unsigned int nr_blocks)
>  {
> -	struct page *page = &folio->page;
>  	struct f2fs_sb_info *sbi = bio->bi_private;
>  	struct compress_io_ctx *cic = folio->private;
>  	enum count_type type = WB_DATA_TYPE(folio, true);
> @@ -1479,13 +1627,17 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
>  	if (unlikely(bio->bi_status != BLK_STS_OK))
>  		mapping_set_error(cic->inode->i_mapping, -EIO);
>  
> -	f2fs_compress_free_page(page);
> -
> -	if (atomic_dec_return(&cic->pending_pages)) {
> -		dec_cache_count(sbi, type);
> +	if (!atomic_sub_and_test(nr_blocks, &cic->pending_blocks)) {
> +		sub_cache_counts(sbi, type, nr_blocks);
>  		return;
>  	}
>  
> +	for (i = 0; i < cic->nr_cpages; i++) {
> +		if (cic->cpages[i])
> +			f2fs_compress_free_page(cic->cpages[i]);
> +	}
> +	page_array_free(sbi, cic->cpages, cic->nr_cpages);
> +
>  	for (i = 0; i < cic->nr_rpages; i++) {
>  		struct folio *rfolio;
>  
> @@ -1499,12 +1651,12 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
>  	kmem_cache_free(cic_entry_slab, cic);
>  
>  	/*
> -	 * Make sure dec_cache_count() is the last access to sbi.
> +	 * Make sure sub_cache_counts() is the last access to sbi.
>  	 * Once it drops the F2FS_WB_CP_DATA counter to zero, the
>  	 * unmount thread can proceed to destroy sbi and
>  	 * sbi->page_array_slab.
>  	 */
> -	dec_cache_count(sbi, type);
> +	sub_cache_counts(sbi, type, nr_blocks);
>  }
>  
>  static int f2fs_write_raw_pages(struct compress_ctx *cc,
> @@ -1517,10 +1669,12 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
>  	struct f2fs_lock_context lc;
>  	int submitted, compr_blocks, i;
>  	int ret = 0;
> +	unsigned int nr_folios = cc->cluster_size >>
> +					F2FS_LOG_BLKS_PER_PAGE(sbi);
>  
>  	compr_blocks = f2fs_compressed_blocks(cc);
>  
> -	for (i = 0; i < cc->cluster_size; i++) {
> +	for (i = 0; i < nr_folios; i++) {
>  		if (!cc->rpages[i])
>  			continue;
>  
> @@ -1535,7 +1689,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
>  	if (compr_blocks > 0)
>  		f2fs_lock_op(sbi, &lc);
>  
> -	for (i = 0; i < cc->cluster_size; i++) {
> +	for (i = 0; i < nr_folios; i++) {
>  		struct folio *folio;
>  
>  		if (!cc->rpages[i])
> @@ -1639,17 +1793,27 @@ static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic,
>  		bool pre_alloc)
>  {
>  	const struct f2fs_compress_ops *cops = f2fs_cops[dic->compress_algorithm];
> +	unsigned int nr_rfolios = dic->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(dic->sbi);
> +	unsigned int cbuf_blk_ofs = f2fs_has_subpage_blocks(dic->sbi) ? 1 : 0;
> +	void *cbuf_vaddr;
>  	int i;
>  
>  	if (!allow_memalloc_for_decomp(dic->sbi, pre_alloc))
>  		return 0;
>  
> -	dic->tpages = page_array_alloc(dic->sbi, dic->cluster_size);
> +	dic->tpages = page_array_alloc(dic->sbi, nr_rfolios);
>  	if (!dic->tpages)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < dic->cluster_size; i++) {
> -		if (dic->rpages[i]) {
> +	for (i = 0; i < nr_rfolios; i++) {
> +		/*
> +		 * A folio with f2fs_folio_state may have uptodate blocks newer
> +		 * than the on-disk cluster (e.g., dirty blocks left after a
> +		 * partial truncate). Decompress it into a bounce page instead,
> +		 * see f2fs_decompress_cluster().
> +		 */
> +		if (dic->rpages[i] &&
> +		    !f2fs_folio_has_ffs(page_folio(dic->rpages[i]))) {
>  			dic->tpages[i] = dic->rpages[i];
>  			continue;
>  		}
> @@ -1657,14 +1821,16 @@ static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic,
>  		dic->tpages[i] = f2fs_compress_alloc_page();
>  	}
>  
> -	dic->rbuf = f2fs_vmap(dic->tpages, dic->cluster_size);
> +	dic->rbuf = f2fs_vmap(dic->tpages, nr_rfolios);
>  	if (!dic->rbuf)
>  		return -ENOMEM;
>  
> -	dic->cbuf = f2fs_vmap(dic->cpages, dic->nr_cpages);
> -	if (!dic->cbuf)
> +	cbuf_vaddr = f2fs_vmap(dic->cpages, dic->nr_cpages);
> +	if (!cbuf_vaddr)
>  		return -ENOMEM;
>  
> +	dic->cbuf = cbuf_vaddr + (cbuf_blk_ofs << dic->sbi->log_blocksize);
> +
>  	if (cops->init_decompress_ctx)
>  		return cops->init_decompress_ctx(dic);
>  
> @@ -1675,6 +1841,7 @@ static void f2fs_release_decomp_mem(struct decompress_io_ctx *dic,
>  		bool bypass_destroy_callback, bool pre_alloc)
>  {
>  	const struct f2fs_compress_ops *cops = f2fs_cops[dic->compress_algorithm];
> +	unsigned int nr_rfolios = dic->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(dic->sbi);
>  
>  	if (!allow_memalloc_for_decomp(dic->sbi, pre_alloc))
>  		return;
> @@ -1682,11 +1849,15 @@ static void f2fs_release_decomp_mem(struct decompress_io_ctx *dic,
>  	if (!bypass_destroy_callback && cops->destroy_decompress_ctx)
>  		cops->destroy_decompress_ctx(dic);
>  
> -	if (dic->cbuf)
> -		vm_unmap_ram(dic->cbuf, dic->nr_cpages);
> +	if (dic->cbuf) {
> +		f2fs_vunmap(dic->cbuf, dic->nr_cpages);
> +		dic->cbuf = NULL;
> +	}
>  
> -	if (dic->rbuf)
> -		vm_unmap_ram(dic->rbuf, dic->cluster_size);
> +	if (dic->rbuf) {
> +		f2fs_vunmap(dic->rbuf, nr_rfolios);
> +		dic->rbuf = NULL;
> +	}
>  }
>  
>  static void f2fs_free_dic(struct decompress_io_ctx *dic,
> @@ -1697,13 +1868,17 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
>  	struct decompress_io_ctx *dic;
>  	pgoff_t start_idx = start_idx_of_cluster(cc);
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
> +	unsigned int nr_rfolios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
> +	unsigned int cbuf_blk_ofs = f2fs_has_subpage_blocks(sbi) ? 1 : 0;
> +	unsigned int nr_cpages = DIV_ROUND_UP(cbuf_blk_ofs + cc->valid_nr_cblocks,
> +					F2FS_BLKS_PER_PAGE(sbi));
>  	int i, ret;
>  
>  	dic = f2fs_kmem_cache_alloc(dic_entry_slab, GFP_F2FS_ZERO, false, sbi);
>  	if (!dic)
>  		return ERR_PTR(-ENOMEM);
>  
> -	dic->rpages = page_array_alloc(sbi, cc->cluster_size);
> +	dic->rpages = page_array_alloc(sbi, nr_rfolios);
>  	if (!dic->rpages) {
>  		kmem_cache_free(dic_entry_slab, dic);
>  		return ERR_PTR(-ENOMEM);
> @@ -1713,33 +1888,38 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
>  	dic->inode = cc->inode;
>  	dic->sbi = sbi;
>  	dic->compress_algorithm = F2FS_I(cc->inode)->i_compress_algorithm;
> -	atomic_set(&dic->remaining_pages, cc->nr_cpages);
> +	atomic_set(&dic->remaining_blocks, cc->valid_nr_cblocks);
>  	dic->cluster_idx = cc->cluster_idx;
>  	dic->cluster_size = cc->cluster_size;
>  	dic->log_cluster_size = cc->log_cluster_size;
> -	dic->nr_cpages = cc->nr_cpages;
> +	dic->valid_nr_cblocks = cc->valid_nr_cblocks;
> +	dic->nr_cpages = nr_cpages;
>  	refcount_set(&dic->refcnt, 1);
>  	dic->failed = false;
>  	dic->vi = cc->vi;
>  
> -	for (i = 0; i < dic->cluster_size; i++)
> +	for (i = 0; i < nr_rfolios; i++)
>  		dic->rpages[i] = cc->rpages[i];
> -	dic->nr_rpages = cc->cluster_size;
> +	dic->nr_rpages = nr_rfolios;
>  
> -	dic->cpages = page_array_alloc(sbi, dic->nr_cpages);
> +	dic->cpages = page_array_alloc(sbi, nr_cpages);
>  	if (!dic->cpages) {
>  		ret = -ENOMEM;
>  		goto out_free;
>  	}
>  
> -	for (i = 0; i < dic->nr_cpages; i++) {
> +	for (i = 0; i < nr_cpages; i++) {
>  		struct page *page;
> +		pgoff_t fidx = f2fs_has_subpage_blocks(sbi) ?
> +				(f2fs_lblk_to_folio_index(sbi, start_idx) + i) :
> +				(start_idx + 1 + i);
>  
>  		page = f2fs_compress_alloc_page();
> -		f2fs_set_compressed_page(page, cc->inode,
> -					start_idx + i + 1, dic);
> +		f2fs_set_compressed_page(page, cc->inode, fidx, dic);
>  		dic->cpages[i] = page;
>  	}
> +	dic->valid_nr_cblocks = cc->valid_nr_cblocks;
> +	dic->nr_cpages = nr_cpages;
>  
>  	ret = f2fs_prepare_decomp_mem(dic, true);
>  	if (ret)
> @@ -1758,18 +1938,19 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
>  	int i;
>  	/* use sbi in dic to avoid UFA of dic->inode*/
>  	struct f2fs_sb_info *sbi = dic->sbi;
> +	unsigned int nr_rfolios = dic->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
>  
>  	f2fs_release_decomp_mem(dic, bypass_destroy_callback, true);
>  
>  	if (dic->tpages) {
> -		for (i = 0; i < dic->cluster_size; i++) {
> -			if (dic->rpages[i])
> +		for (i = 0; i < nr_rfolios; i++) {
> +			if (dic->tpages[i] == dic->rpages[i])
>  				continue;
>  			if (!dic->tpages[i])
>  				continue;
>  			f2fs_compress_free_page(dic->tpages[i]);
>  		}
> -		page_array_free(sbi, dic->tpages, dic->cluster_size);
> +		page_array_free(sbi, dic->tpages, nr_rfolios);
>  	}
>  
>  	if (dic->cpages) {
> @@ -1812,15 +1993,19 @@ static void f2fs_verify_cluster(struct work_struct *work)
>  	int i;
>  
>  	/* Verify, update, and unlock the decompressed pages. */
> -	for (i = 0; i < dic->cluster_size; i++) {
> +	for (i = 0; i < dic->nr_rpages; i++) {
>  		struct page *rpage = dic->rpages[i];
>  		struct folio *rfolio;
>  
>  		if (!rpage)
>  			continue;
>  		rfolio = page_folio(rpage);
> -		if (fsverity_verify_folio(dic->vi, rfolio))
> +		if (fsverity_verify_folio(dic->vi, rfolio)) {
> +			if (f2fs_is_multiblock_folio(dic->sbi, rfolio))
> +				f2fs_ffs_mark_subrange_uptodate(rfolio, 0,
> +							folio_size(rfolio));
>  			folio_mark_uptodate(rfolio);
> +		}
>  		folio_unlock(rfolio);
>  	}
>  
> @@ -1849,16 +2034,20 @@ void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
>  	}
>  
>  	/* Update and unlock the cluster's pagecache pages. */
> -	for (i = 0; i < dic->cluster_size; i++) {
> +	for (i = 0; i < dic->nr_rpages; i++) {
>  		struct page *rpage = dic->rpages[i];
>  
>  		if (!rpage)
>  			continue;
>  
> -		if (failed)
> +		if (failed) {
>  			ClearPageUptodate(rpage);
> -		else
> +		} else {
> +			if (f2fs_is_multiblock_folio(dic->sbi, page_folio(rpage)))
> +				f2fs_ffs_mark_subrange_uptodate(page_folio(rpage), 0,
> +								folio_size(page_folio(rpage)));
>  			SetPageUptodate(rpage);
> +		}
>  		unlock_page(rpage);
>  	}
>  
> @@ -1916,8 +2105,8 @@ void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
>  	f2fs_drop_cache_range(COMPRESS_CACHE(sbi), blkaddr, len, false);
>  }
>  
> -static void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
> -		struct folio *folio, nid_t ino, block_t blkaddr)
> +static void f2fs_cache_compressed_block(struct f2fs_sb_info *sbi,
> +		struct folio *folio, size_t offset, nid_t ino, block_t blkaddr)
>  {
>  	struct f2fs_cached_block *entry;
>  
> @@ -1961,13 +2150,14 @@ static void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
>  	}
>  
>  	entry->ino = ino;
> -	memcpy(cache_address(entry), folio_address(folio), sbi->blocksize);
> +	memcpy(cache_address(entry), folio_address(folio) + offset,
> +							sbi->blocksize);
>  	f2fs_cache_set_uptodate(entry);
>  	f2fs_put_cache(entry, true);
>  }
>  
> -bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi, struct folio *folio,
> -								block_t blkaddr)
> +bool f2fs_load_compressed_block(struct f2fs_sb_info *sbi, struct folio *folio,
> +				size_t offset, block_t blkaddr)
>  {
>  	struct f2fs_cached_block *entry;
>  	bool hitted = false;
> @@ -1982,8 +2172,8 @@ bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi, struct folio *folio,
>  		if (f2fs_is_compress_cache(entry) &&
>  				f2fs_cache_test_uptodate(entry)) {
>  			atomic_inc(&sbi->compress_page_hit);
> -			memcpy(folio_address(folio),
> -				cache_address(entry), folio_size(folio));
> +			memcpy(folio_address(folio) + offset,
> +				cache_address(entry), sbi->blocksize);
>  			hitted = true;
>  		}
>  		f2fs_put_cache(entry, true);
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a7cc7231b572..869005dfb40b 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -150,12 +150,17 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>  		bool finished = true;
>  		bool uptodate = bio->bi_status == BLK_STS_OK;
>  
> -		if (!folio_test_large(folio) &&
> -		    f2fs_is_compressed_page(folio)) {
> +		if (f2fs_is_compressed_page(folio)) {
> +			struct decompress_io_ctx *dic = folio->private;
> +
> +			/* The cluster may be unlocked, so do not use its inode. */
> +			nr_blocks = fi.length >> dic->sbi->log_blocksize;
>  			if (ctx && !ctx->decompression_attempted)
> -				f2fs_end_read_compressed_page(folio, true, 0,
> +				f2fs_end_read_compressed_page(folio, fi.offset,
> +							true, 0, nr_blocks,
>  							in_task);
> -			f2fs_put_folio_dic(folio, in_task);
> +			while (nr_blocks--)
> +				f2fs_put_folio_dic(folio, in_task);
>  			continue;
>  		}
>  
> @@ -265,14 +270,18 @@ static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx,
>  
>  	bio_for_each_folio_all(fi, ctx->bio) {
>  		struct folio *folio = fi.folio;
> +		struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
> +		unsigned int nr_blocks = fi.length >> sbi->log_blocksize;
>  
> -		if (f2fs_is_compressed_page(folio))
> -			f2fs_end_read_compressed_page(folio, false, blkaddr,
> -						      in_task);
> -		else
> +		if (f2fs_is_compressed_page(folio)) {
> +			f2fs_end_read_compressed_page(folio, fi.offset,
> +						      false, blkaddr,
> +						      nr_blocks, in_task);
> +		} else {
>  			all_compressed = false;
> +		}
>  
> -		blkaddr++;
> +		blkaddr += nr_blocks;
>  	}
>  
>  	ctx->decompression_attempted = true;
> @@ -425,7 +434,7 @@ static void f2fs_write_end_bio(struct bio *bio)
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  		if (f2fs_is_compressed_page(folio)) {
> -			f2fs_compress_write_end_io(bio, folio);
> +			f2fs_compress_write_end_io(bio, folio, nr_blocks);
>  			continue;
>  		}
>  #endif
> @@ -1337,9 +1346,14 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  		io->fio = *fio;
>  	}
>  
> -	bio_offset = bio_folio == fio->folio ? F2FS_FIO_BIO_OFFSET(fio) : 0;
> -	bio_len = bio_folio == fio->folio ? F2FS_FIO_BIO_SIZE(fio) :
> -					    folio_size(bio_folio);
> +	/* A compressed page holds several blocks with subpage blocks. */
> +	if (bio_folio == fio->folio || fio->compressed_page) {
> +		bio_offset = F2FS_FIO_BIO_OFFSET(fio);
> +		bio_len = F2FS_FIO_BIO_SIZE(fio);
> +	} else {
> +		bio_offset = 0;
> +		bio_len = folio_size(bio_folio);
> +	}
>  
>  	if (!bio_add_folio(io->bio, bio_folio, bio_len, bio_offset)) {
>  		__submit_merged_bio(io);
> @@ -2728,7 +2742,7 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
> -				unsigned nr_pages, sector_t *last_block_in_bio,
> +				unsigned int nr_blocks, sector_t *last_block_in_bio,
>  				struct readahead_control *rac, bool for_write)
>  {
>  	struct dnode_of_data dn;
> @@ -2765,7 +2779,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>  			continue;
>  
>  		folio = page_folio(page);
> -		if ((sector_t)folio->index >= last_block_in_file) {
> +		if ((sector_t)f2fs_folio_lblk(sbi, folio) >= last_block_in_file) {
>  			folio_zero_segment(folio, 0, folio_size(folio));
>  			if (!folio_test_uptodate(folio))
>  				folio_mark_uptodate(folio);
> @@ -2811,14 +2825,14 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>  			ret = -EFAULT;
>  			goto out_put_dnode;
>  		}
> -		cc->nr_cpages++;
> +		cc->valid_nr_cblocks++;
>  
>  		if (!from_dnode && i >= ei.c_len)
>  			break;
>  	}
>  
>  	/* nothing to decompress */
> -	if (cc->nr_cpages == 0) {
> +	if (cc->valid_nr_cblocks == 0) {
>  		ret = 0;
>  		goto out_put_dnode;
>  	}
> @@ -2829,8 +2843,12 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>  		goto out_put_dnode;
>  	}
>  
> -	for (i = 0; i < cc->nr_cpages; i++) {
> -		struct folio *folio = page_folio(dic->cpages[i]);
> +	for (i = 0; i < cc->valid_nr_cblocks; i++) {
> +		unsigned int blk_idx = f2fs_has_subpage_blocks(sbi) ? (1 + i) : i;
> +		unsigned int c_folio_idx = blk_idx / F2FS_BLKS_PER_PAGE(sbi);
> +		unsigned int c_folio_ofs = blk_idx % F2FS_BLKS_PER_PAGE(sbi);
> +		struct folio *folio = page_folio(dic->cpages[c_folio_idx]);
> +		size_t offset = c_folio_ofs * blocksize;
>  		block_t blkaddr;
>  		struct bio_post_read_ctx *ctx;
>  
> @@ -2840,8 +2858,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>  
>  		f2fs_wait_on_block_writeback(inode, blkaddr);
>  
> -		if (f2fs_load_compressed_folio(sbi, folio, blkaddr)) {
> -			if (atomic_dec_and_test(&dic->remaining_pages)) {
> +		if (f2fs_load_compressed_block(sbi, folio, offset, blkaddr)) {
> +			if (atomic_dec_and_test(&dic->remaining_blocks)) {
>  				f2fs_decompress_cluster(dic, true);
>  				break;
>  			}
> @@ -2850,7 +2868,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>  
>  		if (bio && (!page_is_mergeable(sbi, bio,
>  					*last_block_in_bio, blkaddr) ||
> -		    !f2fs_crypt_mergeable_bio(bio, inode, folio->index, NULL))) {
> +		    !f2fs_crypt_mergeable_bio(bio, inode, start_idx + 1 + i, NULL))) {
>  submit_and_realloc:
>  			f2fs_submit_read_bio(sbi, bio, DATA);
>  			bio = NULL;
> @@ -2858,11 +2876,11 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>  
>  		if (!bio)
>  			bio = f2fs_grab_read_bio(inode, cc->vi, blkaddr,
> -						 nr_pages - i,
> +						 nr_blocks - i,
>  						 f2fs_ra_op_flags(rac),
> -						 folio->index, for_write);
> +						 start_idx + 1 + i, for_write);
>  
> -		if (!bio_add_folio(bio, folio, blocksize, 0))
> +		if (!bio_add_folio(bio, folio, blocksize, offset))
>  			goto submit_and_realloc;
>  
>  		ctx = get_post_read_ctx(bio);
> @@ -3525,7 +3543,7 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
>  		.rpages = NULL,
>  		.cpages = NULL,
>  		.nr_rpages = 0,
> -		.nr_cpages = 0,
> +		.valid_nr_cblocks = 0,
>  	};
>  	pgoff_t nc_cluster_idx = NULL_CLUSTER;
>  	pgoff_t index;
> @@ -3535,14 +3553,19 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
>  	unsigned max_nr_pages = nr_pages;
>  	int ret = 0;
>  
> -	if (f2fs_has_multiblock_folios(inode))
> +	if (mapping_large_folio_support(inode->i_mapping) ||
> +	    (f2fs_has_subpage_blocks(F2FS_I_SB(inode)) &&
> +	     !f2fs_compressed_file(inode)))
>  		return f2fs_read_data_large_folio(inode, vi, rac, folio);
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  	if (f2fs_compressed_file(inode)) {
> +		unsigned int nr_rfolios = cc.cluster_size >>
> +				F2FS_LOG_BLKS_PER_PAGE(F2FS_I_SB(inode));
> +
>  		index = rac ? readahead_index(rac) : folio->index;
> -		max_nr_pages = round_up(index + nr_pages, cc.cluster_size) -
> -				round_down(index, cc.cluster_size);
> +		max_nr_pages = round_up(index + nr_pages, nr_rfolios) -
> +				round_down(index, nr_rfolios);
>  	}
>  #endif
>  
> @@ -3564,16 +3587,16 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
>  		f2fs_update_read_folio_count(F2FS_I_SB(inode), folio);
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
> -		index = folio->index;
> +		pgoff_t f_lblk = f2fs_folio_lblk(F2FS_I_SB(inode), folio);
>  
>  		if (!f2fs_compressed_file(inode))
>  			goto read_single_page;
>  
>  		/* there are remained compressed pages, submit them */
> -		if (!f2fs_cluster_can_merge_page(&cc, index)) {
> +		if (!f2fs_cluster_can_merge_block(&cc, f_lblk)) {
>  			cc.vi = vi;
>  			ret = f2fs_read_multi_pages(&cc, &bio,
> -						max_nr_pages,
> +						max_nr_pages * F2FS_BLKS_PER_PAGE(F2FS_I_SB(inode)),

max_nr_pages << F2FS_LOG_BLKS_PER_PAGE ?

>  						&last_block_in_bio,
>  						rac, false);
>  			f2fs_destroy_compress_ctx(&cc, false);
> @@ -3581,15 +3604,15 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
>  				goto set_error_page;
>  		}
>  		if (cc.cluster_idx == NULL_CLUSTER) {
> -			if (nc_cluster_idx == index >> cc.log_cluster_size)
> +			if (nc_cluster_idx == f_lblk >> cc.log_cluster_size)
>  				goto read_single_page;
>  
> -			ret = f2fs_is_compressed_cluster(inode, index);
> +			ret = f2fs_is_compressed_cluster(inode, f_lblk);
>  			if (ret < 0)
>  				goto set_error_page;
>  			else if (!ret) {
>  				nc_cluster_idx =
> -					index >> cc.log_cluster_size;
> +					f_lblk >> cc.log_cluster_size;
>  				goto read_single_page;
>  			}
>  
> @@ -3605,15 +3628,21 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
>  read_single_page:
>  #endif
>  
> -		ret = f2fs_read_single_page(inode, vi, folio, max_nr_pages,
> -					    &map, &bio, &last_block_in_bio,
> -					    rac);
> -		if (ret) {
> +		if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio)) {
> +			ret = f2fs_read_data_large_folio(inode, vi, NULL, folio);
> +			if (ret)
> +				continue;
> +		} else {
> +			ret = f2fs_read_single_page(inode, vi, folio,
> +						    max_nr_pages, &map, &bio,
> +						    &last_block_in_bio, rac);
> +			if (ret) {
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  set_error_page:
>  #endif
> -			folio_zero_segment(folio, 0, folio_size(folio));
> -			folio_unlock(folio);
> +				folio_zero_segment(folio, 0, folio_size(folio));
> +				folio_unlock(folio);
> +			}
>  		}
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  next_page:
> @@ -3625,7 +3654,8 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
>  			if (nr_pages == 1 && !f2fs_cluster_is_empty(&cc)) {
>  				cc.vi = vi;
>  				ret = f2fs_read_multi_pages(&cc, &bio,
> -							max_nr_pages,
> +							max_nr_pages *
> +							F2FS_BLKS_PER_PAGE(F2FS_I_SB(inode)),

max_nr_pages << F2FS_LOG_BLKS_PER_PAGE ?

>  							&last_block_in_bio,
>  							rac, false);
>  				f2fs_destroy_compress_ctx(&cc, false);
> @@ -3934,7 +3964,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>  static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
>  					struct writeback_control *wbc,
>  					enum iostat_type io_type,
> -					u64 start, u64 end)
> +					u64 start, u64 end,
> +					int compr_blocks)
>  {
>  	struct inode *inode = folio->mapping->host;
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> @@ -3967,6 +3998,7 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
>  			.folio_blkcnt = 1,
>  			.encrypted_page = NULL,
>  			.submitted = 0,
> +			.compr_blocks = (i == 0) ? compr_blocks : 0,
>  			.need_lock = LOCK_DONE,
>  			.meta_gc = f2fs_meta_inode_gc_required(inode) ? 1 : 0,
>  			.io_type = io_type,
> @@ -3977,8 +4009,12 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
>  			struct f2fs_folio_state *ffs =
>  				(struct f2fs_folio_state *)folio->private;
>  
> -			/* Write only dirty blocks */
> -			if (!f2fs_ffs_test_blk_dirty(folio, data_idx))
> +			/*
> +			 * Write only dirty blocks, or all blocks of a
> +			 * compressed cluster.
> +			 */
> +			if (!compr_blocks &&
> +			    !f2fs_ffs_test_blk_dirty(folio, data_idx))
>  				continue;
>  			atomic_inc(&ffs->write_blocks_pending);
>  		}
> @@ -4053,6 +4089,9 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
>  
>  		fio.version = ni.version;
>  
> +		if (fio.compr_blocks && fio.old_blkaddr == COMPRESS_ADDR)
> +			f2fs_i_compr_blocks_update(inode, fio.compr_blocks - 1, false);
> +
>  		f2fs_outplace_write_data(&dn, &fio);
>  		f2fs_put_dnode(&dn);
>  		/* The outplace write path failed to submit this block. */
> @@ -4139,6 +4178,22 @@ static enum f2fs_wb_action f2fs_wb_folio_action(struct f2fs_sb_info *sbi,
>  	return F2FS_WB_WRITE;
>  }
>  
> +/*
> + * Hold a bias on write_blocks_pending while the blocks of a multi-block
> + * folio are submitted, so that their completions cannot end the folio
> + * writeback early. Without ffs, the folio dirty flag covered @len bytes.
> + */
> +static void f2fs_folio_get_write_bias(struct folio *folio, size_t len)
> +{
> +	struct f2fs_folio_state *ffs;
> +
> +	if (!f2fs_folio_has_ffs(folio))
> +		f2fs_ffs_mark_subrange_dirty(folio, 0, len);
> +	ffs = folio->private;
> +	WARN_ON_ONCE(atomic_read(&ffs->write_blocks_pending) != 0);
> +	atomic_inc(&ffs->write_blocks_pending);
> +}
> +
>  int f2fs_write_single_data_page(struct folio *folio, int *submitted,
>  				struct bio **bio,
>  				sector_t *last_block,
> @@ -4157,6 +4212,7 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
>  	bool need_balance_fs = false;
>  	bool quota_inode = IS_NOQUOTA(inode);
>  	int err = 0;
> +	int local_submitted = 0;
>  	struct f2fs_io_info fio = {
>  		.sbi = sbi,
>  		.ino = inode->i_ino,
> @@ -4203,6 +4259,42 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
>  
>  	folio_zero_segment(folio, offset, folio_size(folio));
>  write:
> +	if (f2fs_is_multiblock_folio(sbi, folio)) {
> +		struct f2fs_lock_context lc;
> +		unsigned int to_blk = f2fs_blocks_per_folio(sbi, folio);
> +		u64 pos = folio_pos(folio);
> +
> +		if (!compr_blocks && !f2fs_verity_in_progress(inode))
> +			to_blk = min_t(unsigned int,
> +					F2FS_BLK_ALIGN(sbi, i_size - pos),
> +					to_blk);
> +
> +		/* Deadlock due to between page->lock and f2fs_lock_op */
> +		if (!compr_blocks && !f2fs_trylock_op(sbi, &lc)) {
> +			err = -EAGAIN;
> +			goto redirty_out;
> +		}
> +
> +		folio_start_writeback(folio);
> +		f2fs_folio_get_write_bias(folio, F2FS_BLK_TO_BYTES(sbi, to_blk));
> +
> +		err = f2fs_write_folio_dirty_range(folio, &local_submitted,
> +					wbc, io_type, pos,
> +					pos + F2FS_BLK_TO_BYTES(sbi, to_blk),
> +					compr_blocks);
> +
> +		if (!compr_blocks)
> +			f2fs_unlock_op(sbi, &lc);
> +
> +		if (!err)
> +			f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
> +					F2FS_BLK_TO_BYTES(sbi, to_blk));
> +
> +		f2fs_ffs_put_write_pending(folio, 1);
> +
> +		goto done;
> +	}
> +
>  	if (f2fs_cp_controlled_inode(inode)) {
>  		struct f2fs_lock_context lc;
>  
> @@ -4272,7 +4364,9 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
>  	}
>  
>  	if (submitted)
> -		*submitted = fio.submitted;
> +		*submitted = f2fs_is_multiblock_folio(sbi, folio) ?
> +			DIV_ROUND_UP(local_submitted, F2FS_BLKS_PER_PAGE(sbi)) :
> +			fio.submitted;
>  
>  	return 0;
>  
> @@ -4317,10 +4411,10 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  		.rpages = NULL,
>  		.nr_rpages = 0,
>  		.cpages = NULL,
> -		.valid_nr_cpages = 0,
> +		.valid_nr_cblocks = 0,
>  		.rbuf = NULL,
>  		.cbuf = NULL,
> -		.rlen = PAGE_SIZE * F2FS_I(inode)->i_cluster_size,
> +		.rlen = F2FS_BLKSIZE(sbi) * F2FS_I(inode)->i_cluster_size,
>  		.private = NULL,
>  	};
>  #endif
> @@ -4409,6 +4503,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  				void *fsdata = NULL;
>  				struct page *pagep;
>  				int ret2;
> +				pgoff_t f_lblk = f2fs_folio_lblk(sbi, folio);
>  
>  				ret = f2fs_init_compress_ctx(&cc);
>  				if (ret) {
> @@ -4416,8 +4511,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  					break;
>  				}
>  
> -				if (!f2fs_cluster_can_merge_page(&cc,
> -								folio->index)) {
> +				if (!f2fs_cluster_can_merge_block(&cc, f_lblk)) {
>  					ret = f2fs_write_multi_pages(&cc,
>  						&submitted, wbc, io_type);
>  					if (!ret)
> @@ -4437,14 +4531,14 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  
>  				ret2 = f2fs_prepare_compress_overwrite(
>  							inode, &pagep,
> -							folio->index, &fsdata);
> +							f_lblk, &fsdata);
>  				if (ret2 < 0) {
>  					ret = ret2;
>  					done = 1;
>  					break;
>  				} else if (ret2 &&
>  					(!f2fs_compress_write_end(inode,
> -						fsdata, folio->index, 1) ||
> +						fsdata, f_lblk, 1) ||
>  					 !f2fs_all_cluster_page_ready(&cc,
>  						pages, i, nr_pages,
>  						false))) {
> @@ -4599,7 +4693,6 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
>  		clear_inode_flag(inode, FI_HOT_DATA);
>  
>  	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
> -		struct f2fs_folio_state *ffs = NULL;
>  		u64 isize;
>  		size_t poff;
>  		pgoff_t end_index;
> @@ -4623,16 +4716,6 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
>  			goto retry_out;
>  		}
>  
> -		if (f2fs_has_subpage_blocks(sbi) &&
> -		    f2fs_compressed_file(inode)) {
> -			WARN_ON_ONCE(1);
> -			mapping_set_error(mapping, -EOPNOTSUPP);
> -			folio_clear_dirty_for_io(folio);
> -			inode_sub_dirty_blocks(inode, f2fs_blocks_per_folio(sbi, folio));
> -			err = -EOPNOTSUPP;
> -			goto retry_out;
> -		}
> -
>  		/*
>  		 * Writing back one large folio performs multiple block allocations, so
>  		 * best-effort balance the filesystem before writing it back.
> @@ -4754,25 +4837,12 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
>  		 * folio has no ffs, so its whole folio is written.
>  		 */
>  		if (f2fs_is_multiblock_folio(sbi, folio)) {
> -			if (!f2fs_folio_has_ffs(folio))
> -				f2fs_ffs_mark_subrange_dirty(folio, 0, end_pos - pos);
> -			ffs = (struct f2fs_folio_state *)folio->private;
> -			/*
> -			 * Multiblock folios can be submitted as multiple bios,
> -			 * which may complete while we are still submitting the
> -			 * remaining dirty ranges.  Hold a bias on
> -			 * write_blocks_pending to prevent folio_end_writeback()
> -			 * from being called early.
> -			 */
> -			if (!bias_added) {
> -				WARN_ON_ONCE(atomic_read(&ffs->write_blocks_pending) != 0);
> -				atomic_inc(&ffs->write_blocks_pending);
> -				bias_added = true;
> -			}
> +			f2fs_folio_get_write_bias(folio, end_pos - pos);
> +			bias_added = true;
>  		}
>  
>  		err = f2fs_write_folio_dirty_range(folio, &submitted, wbc, io_type,
> -						   pos, end_pos);
> +						   pos, end_pos, 0);
>  		folio_submitted += submitted;
>  		nwritten += submitted;
>  		if (err)
> @@ -4928,7 +4998,8 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>  	account_writeback(inode, true);
>  
>  	blk_start_plug(&plug);
> -	if (f2fs_has_multiblock_folios(inode))
> +	if (mapping_large_folio_support(mapping) ||
> +	    (f2fs_has_subpage_blocks(sbi) && !f2fs_compressed_file(inode)))
>  		ret = f2fs_write_cache_folios(mapping, wbc, io_type);
>  	else
>  		ret = f2fs_write_cache_pages(mapping, wbc, io_type);
> @@ -5267,10 +5338,6 @@ static int prepare_large_folio_write_begin(struct inode *inode,
>  	size_t need_off = ori_off;
>  	int err = 0;
>  
> -	if (f2fs_has_subpage_blocks(sbi) &&
> -	    f2fs_compressed_file(inode))
> -		return -EOPNOTSUPP;
> -
>  	/*
>  	 * Reserve blocks without f2fs_balance_fs() since the folio is locked;
>  	 * the caller balances after unlocking it if *need_balance is set.
> @@ -5464,12 +5531,6 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>  		goto fail;
>  	}
>  
> -	if (f2fs_has_subpage_blocks(sbi) &&
> -	    f2fs_compressed_file(inode)) {
> -		err = -EOPNOTSUPP;
> -		goto fail;
> -	}
> -
>  	/*
>  	 * We should check this at this moment to avoid deadlock on inode page
>  	 * and #0 page. The locking rule for inline_data conversion should be:
> @@ -5490,11 +5551,13 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>  
>  		*fsdata = NULL;
>  
> +		pgoff_t f_lblk = F2FS_BYTES_TO_BLK(sbi, pos);
> +
>  		if (len == PAGE_SIZE && !(f2fs_is_atomic_file(inode)))
>  			goto repeat;
>  
>  		ret = f2fs_prepare_compress_overwrite(inode, &page,
> -							index, fsdata);
> +							f_lblk, fsdata);
>  		if (ret < 0) {
>  			err = ret;
>  			goto fail;
> @@ -5670,7 +5733,8 @@ static int f2fs_write_end(const struct kiocb *iocb,
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  	/* overwrite compressed file */
>  	if (f2fs_compressed_file(inode) && fsdata) {
> -		f2fs_compress_write_end(inode, fsdata, folio->index, copied);
> +		f2fs_compress_write_end(inode, fsdata,
> +				f2fs_folio_lblk(F2FS_I_SB(inode), folio), copied);
>  		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
>  
>  		if (pos + copied > i_size_read(inode) &&
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8e38d46c446c..0a11c61ee3cf 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1696,7 +1696,7 @@ struct compress_ctx {
>  	unsigned int nr_rpages;		/* total page number in rpages */
>  	struct page **cpages;		/* pages store compressed data in cluster */
>  	unsigned int nr_cpages;		/* total page number in cpages */
> -	unsigned int valid_nr_cpages;	/* valid page number in cpages */
> +	unsigned int valid_nr_cblocks;	/* valid block number in cpages */
>  	void *rbuf;			/* virtual mapped address on rpages */
>  	struct compress_data *cbuf;	/* virtual mapped address on cpages */
>  	size_t rlen;			/* valid data length in rbuf */
> @@ -1712,7 +1712,9 @@ struct compress_io_ctx {
>  	struct inode *inode;		/* inode the context belong to */
>  	struct page **rpages;		/* pages store raw data in cluster */
>  	unsigned int nr_rpages;		/* total page number in rpages */
> -	atomic_t pending_pages;		/* in-flight compressed page count */
> +	atomic_t pending_blocks;	/* in-flight compressed block count */
> +	struct page **cpages;		/* bounce pages store compressed data */
> +	unsigned int nr_cpages;		/* total page number in cpages */
>  };
>  
>  /* Context for decompressing one cluster on the read IO path */
> @@ -1727,6 +1729,7 @@ struct decompress_io_ctx {
>  	unsigned int nr_rpages;		/* total page number in rpages */
>  	struct page **cpages;		/* pages store compressed data in cluster */
>  	unsigned int nr_cpages;		/* total page number in cpages */
> +	unsigned int valid_nr_cblocks;	/* valid compressed block number */
>  	struct page **tpages;		/* temp pages to pad holes in cluster */
>  	void *rbuf;			/* virtual mapped address on rpages */
>  	struct compress_data *cbuf;	/* virtual mapped address on cpages */
> @@ -1734,16 +1737,16 @@ struct decompress_io_ctx {
>  	size_t clen;			/* valid data length in cbuf */
>  
>  	/*
> -	 * The number of compressed pages remaining to be read in this cluster.
> -	 * This is initially nr_cpages.  It is decremented by 1 each time a page
> -	 * has been read (or failed to be read).  When it reaches 0, the cluster
> -	 * is decompressed (or an error is reported).
> +	 * The number of compressed blocks remaining to be read in this cluster.
> +	 * This is initially valid_nr_cblocks.  It is decremented by the number
> +	 * of blocks each time they have been read (or failed to be read).  When
> +	 * it reaches 0, the cluster is decompressed (or an error is reported).
>  	 *
>  	 * If an error occurs before all the pages have been submitted for I/O,
>  	 * then this will never reach 0.  In this case the I/O submitter is
>  	 * responsible for calling f2fs_decompress_end_io() instead.
>  	 */
> -	atomic_t remaining_pages;
> +	atomic_t remaining_blocks;
>  
>  	/*
>  	 * Number of references to this decompress_io_ctx.
> @@ -1770,7 +1773,7 @@ struct decompress_io_ctx {
>  #define NULL_CLUSTER			((unsigned int)(~0))
>  #define MIN_COMPRESS_LOG_SIZE		2
>  #define MAX_COMPRESS_LOG_SIZE		8
> -#define MAX_COMPRESS_WINDOW_SIZE(log_size)	((PAGE_SIZE) << (log_size))
> +#define MAX_COMPRESS_WINDOW_SIZE(sbi, log_size)	((F2FS_BLKSIZE(sbi)) << (log_size))
>  
>  struct f2fs_gc_kthread {
>  	struct task_struct *f2fs_gc_task;
> @@ -2338,6 +2341,12 @@ static inline unsigned int f2fs_blocks_per_folio(struct f2fs_sb_info *sbi,
>  
>  #define F2FS_LOG_BLKS_PER_PAGE(sbi)	(PAGE_SHIFT - (sbi)->log_blocksize)
>  
> +static inline unsigned int min_compress_log_size(struct f2fs_sb_info *sbi)
> +{
> +	return max_t(unsigned int, MIN_COMPRESS_LOG_SIZE,
> +			F2FS_LOG_BLKS_PER_PAGE(sbi));
> +}
> +
>  static inline bool f2fs_has_subpage_blocks(struct f2fs_sb_info *sbi)
>  {
>  	return F2FS_BLKSIZE(sbi) < PAGE_SIZE;
> @@ -4990,20 +4999,22 @@ enum cluster_check_type {
>  bool f2fs_is_compressed_page(struct folio *folio);
>  struct folio *f2fs_compress_control_folio(struct folio *folio);
>  int f2fs_prepare_compress_overwrite(struct inode *inode,
> -			struct page **pagep, pgoff_t index, void **fsdata);
> +			struct page **pagep, pgoff_t lblk, void **fsdata);
>  bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
> -					pgoff_t index, unsigned copied);
> +					pgoff_t lblk, unsigned int copied);
>  int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);
> -void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio);
> +void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio,
> +				unsigned int nr_blocks);
>  bool f2fs_is_compress_backend_ready(struct inode *inode);
>  bool f2fs_is_compress_level_valid(int alg, int lvl);
>  int __init f2fs_init_compress_mempool(void);
>  void f2fs_destroy_compress_mempool(void);
>  void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task);
> -void f2fs_end_read_compressed_page(struct folio *folio, bool failed,
> -				block_t blkaddr, bool in_task);
> +void f2fs_end_read_compressed_page(struct folio *folio, size_t offset,
> +				bool failed, block_t blkaddr,
> +				unsigned int nr_blocks, bool in_task);
>  bool f2fs_cluster_is_empty(struct compress_ctx *cc);
> -bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
> +bool f2fs_cluster_can_merge_block(struct compress_ctx *cc, pgoff_t lblk);
>  bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
>  				int index, int nr_pages, bool uptodate);
>  bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
> @@ -5012,13 +5023,13 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
>  						int *submitted,
>  						struct writeback_control *wbc,
>  						enum iostat_type io_type);
> -int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index);
> -bool f2fs_is_sparse_cluster(struct inode *inode, pgoff_t index);
> +int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t lblk);
> +bool f2fs_is_sparse_cluster(struct inode *inode, pgoff_t lblk);
>  void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
>  				pgoff_t fofs, block_t blkaddr,
>  				unsigned int llen, unsigned int c_len);
>  int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
> -				unsigned nr_pages, sector_t *last_block_in_bio,
> +				unsigned int nr_blocks, sector_t *last_block_in_bio,
>  				struct readahead_control *rac, bool for_write);
>  struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc);
>  void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
> @@ -5036,8 +5047,8 @@ int __init f2fs_init_compress_cache(void);
>  void f2fs_destroy_compress_cache(void);
>  void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
>  					block_t blkaddr, unsigned int len);
> -bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi, struct folio *folio,
> -								block_t blkaddr);
> +bool f2fs_load_compressed_block(struct f2fs_sb_info *sbi, struct folio *folio,
> +				size_t offset, block_t blkaddr);
>  void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino);
>  #define inc_compr_inode_stat(inode)					\
>  	do {								\
> @@ -5071,7 +5082,8 @@ static inline void f2fs_destroy_compress_mempool(void) { }
>  static inline void f2fs_decompress_cluster(struct decompress_io_ctx *dic,
>  				bool in_task) { }
>  static inline void f2fs_end_read_compressed_page(struct folio *folio,
> -				bool failed, block_t blkaddr, bool in_task)
> +				size_t offset, bool failed, block_t blkaddr,
> +				unsigned int nr_blocks, bool in_task)
>  {
>  	WARN_ON_ONCE(1);
>  }
> @@ -5089,17 +5101,18 @@ static inline int __init f2fs_init_compress_cache(void) { return 0; }
>  static inline void f2fs_destroy_compress_cache(void) { }
>  static inline void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
>  				block_t blkaddr, unsigned int len) { }
> -static inline bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi,
> -		struct folio *folio, block_t blkaddr) { return false; }
> +static inline bool f2fs_load_compressed_block(struct f2fs_sb_info *sbi,
> +		struct folio *folio, size_t offset,
> +		block_t blkaddr) { return false; }
>  static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi,
>  							nid_t ino) { }
>  #define inc_compr_inode_stat(inode)		do { } while (0)
>  static inline int f2fs_is_compressed_cluster(
>  				struct inode *inode,
> -				pgoff_t index) { return 0; }
> +				pgoff_t lblk) { return 0; }
>  static inline bool f2fs_is_sparse_cluster(
>  				struct inode *inode,
> -				pgoff_t index) { return true; }
> +				pgoff_t lblk) { return true; }
>  static inline void f2fs_update_read_extent_tree_range_compressed(
>  				struct inode *inode,
>  				pgoff_t fofs, block_t blkaddr,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 67ed6be8952f..952896640e72 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -178,7 +178,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  	if (f2fs_compressed_file(inode)) {
> -		int ret = f2fs_is_compressed_cluster(inode, pidx);
> +		int ret = f2fs_is_compressed_cluster(inode, bidx);
>  
>  		if (ret < 0) {
>  			err = ret;
> @@ -1019,7 +1019,8 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
>  	 */
>  	if (f2fs_compressed_file(inode))
>  		free_from = round_up(from,
> -				F2FS_I(inode)->i_cluster_size << PAGE_SHIFT);
> +				F2FS_BLK_TO_BYTES(F2FS_I_SB(inode),
> +					F2FS_I(inode)->i_cluster_size));
>  #endif
>  
>  	err = f2fs_do_truncate_blocks(inode, free_from, lock);
> @@ -2298,13 +2299,6 @@ static long f2fs_fallocate(struct file *file, int mode,
>  		goto out;
>  	}
>  
> -	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode))) {
> -		if (f2fs_compressed_file(inode)) {
> -			ret = -EOPNOTSUPP;
> -			goto out;
> -		}
> -	}
> -
>  	ret = file_modified(file);
>  	if (ret)
>  		goto out;
> @@ -4447,9 +4441,6 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>  	int ret;
>  	int writecount;
>  
> -	if (f2fs_has_subpage_blocks(sbi))
> -		return -EOPNOTSUPP;
> -
>  	if (!f2fs_sb_has_compression(sbi))
>  		return -EOPNOTSUPP;
>  
> @@ -4645,9 +4636,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>  	unsigned int reserved_blocks = 0;
>  	int ret;
>  
> -	if (f2fs_has_subpage_blocks(sbi))
> -		return -EOPNOTSUPP;
> -
>  	if (!f2fs_sb_has_compression(sbi))
>  		return -EOPNOTSUPP;
>  
> @@ -4969,9 +4957,6 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
>  	struct f2fs_comp_option option;
>  	int ret = 0;
>  
> -	if (f2fs_has_subpage_blocks(sbi))
> -		return -EOPNOTSUPP;
> -
>  	if (!f2fs_sb_has_compression(sbi))
>  		return -EOPNOTSUPP;
>  
> @@ -4982,7 +4967,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
>  				sizeof(option)))
>  		return -EFAULT;
>  
> -	if (option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> +	if (option.log_cluster_size < min_compress_log_size(sbi) ||
>  		option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
>  		option.algorithm >= COMPRESS_MAX)
>  		return -EINVAL;
> @@ -5076,16 +5061,22 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
>  		off = offset_in_folio(folio, (loff_t)redirty_idx << PAGE_SHIFT);
>  		dlen = (size_t)(next_idx - redirty_idx) << PAGE_SHIFT;
>  
> -		if (folio_test_large(folio)) {
> +		if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio)) {
> +			loff_t eof = i_size_read(inode) - folio_pos(folio);
> +
>  			/*
> -			 * A compressed inode can keep using large folios, in
> +			 * folio_mark_dirty() does not dirty the blocks of a folio
> +			 * state.  A compressed inode can keep using large folios, in
>  			 * which case the compression flag only works as a hint
>  			 * until the inode is evicted.  Update the subpage dirty
>  			 * bitmap as well, otherwise f2fs_write_cache_folios()
> -			 * finds no dirty range and skips the whole folio.
> +			 * finds no dirty range and skips the whole folio.  Do
> +			 * not dirty the blocks past EOF.
>  			 */
> -			f2fs_ffs_find_or_alloc(folio);
> -			f2fs_ffs_mark_subrange_dirty(folio, off, dlen);
> +			if ((loff_t)(off + dlen) > eof)
> +				dlen = eof > (loff_t)off ? eof - off : 0;
> +			if (dlen)
> +				f2fs_ffs_mark_subrange_dirty(folio, off, dlen);
>  		}
>  
>  		folio_mark_dirty(folio);
> @@ -5103,12 +5094,9 @@ static int f2fs_ioc_decompress_file(struct file *filp)
>  	struct inode *inode = file_inode(filp);
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
> -	pgoff_t page_idx = 0, last_idx, cluster_idx;
> +	pgoff_t lblk = 0, last_idx, cluster_idx;
>  	int ret;
>  
> -	if (f2fs_has_subpage_blocks(sbi))
> -		return -EOPNOTSUPP;
> -
>  	if (!f2fs_sb_has_compression(sbi) ||
>  			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
>  		return -EOPNOTSUPP;
> @@ -5145,12 +5133,14 @@ static int f2fs_ioc_decompress_file(struct file *filp)
>  	last_idx >>= fi->i_log_cluster_size;
>  
>  	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
> -		page_idx = cluster_idx << fi->i_log_cluster_size;
> +		lblk = cluster_idx << fi->i_log_cluster_size;
>  
> -		if (!f2fs_is_compressed_cluster(inode, page_idx))
> +		if (!f2fs_is_compressed_cluster(inode, lblk))
>  			continue;
>  
> -		ret = redirty_blocks(inode, page_idx, fi->i_cluster_size);
> +		ret = redirty_blocks(inode,
> +			f2fs_lblk_to_folio_index(sbi, lblk),
> +			fi->i_cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi));
>  		if (ret < 0)
>  			break;
>  
> @@ -5187,12 +5177,9 @@ static int f2fs_ioc_compress_file(struct file *filp)
>  	struct inode *inode = file_inode(filp);
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
> -	pgoff_t page_idx = 0, last_idx, cluster_idx;
> +	pgoff_t lblk = 0, last_idx, cluster_idx;
>  	int ret;
>  
> -	if (f2fs_has_subpage_blocks(sbi))
> -		return -EOPNOTSUPP;
> -
>  	if (!f2fs_sb_has_compression(sbi) ||
>  			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
>  		return -EOPNOTSUPP;
> @@ -5235,12 +5222,14 @@ static int f2fs_ioc_compress_file(struct file *filp)
>  	last_idx >>= fi->i_log_cluster_size;
>  
>  	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
> -		page_idx = cluster_idx << fi->i_log_cluster_size;
> +		lblk = cluster_idx << fi->i_log_cluster_size;
>  
> -		if (f2fs_is_sparse_cluster(inode, page_idx))
> +		if (f2fs_is_sparse_cluster(inode, lblk))
>  			continue;
>  
> -		ret = redirty_blocks(inode, page_idx, fi->i_cluster_size);
> +		ret = redirty_blocks(inode,
> +			f2fs_lblk_to_folio_index(sbi, lblk),
> +			fi->i_cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi));
>  		if (ret < 0)
>  			break;
>  
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 5c6a64b31b05..aad5fbbcc5a2 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -225,7 +225,7 @@ static bool sanity_check_compress_inode(struct inode *inode,
>  			SECTOR_TO_BLOCK(sbi, inode->i_blocks));
>  		return false;
>  	}
> -	if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> +	if (ri->i_log_cluster_size < min_compress_log_size(sbi) ||
>  		ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
>  		f2fs_warn(sbi,
>  			"%s: inode (ino=%llx) has unsupported log cluster size: %u, run fsck to fix",
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fa74564adcfb..b2669057b7d2 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1447,6 +1447,11 @@ static int f2fs_check_compression(struct fs_context *fc,
>  		ctx_clear_opt_mask(ctx, F2FS_MOUNT_COMPRESS_CACHE);
>  		return 0;
>  	}
> +	if ((ctx->spec_mask & F2FS_SPEC_compress_log_size) &&
> +	    F2FS_CTX_INFO(ctx).compress_log_size < min_compress_log_size(sbi)) {
> +		f2fs_err(sbi, "Compress cluster log size is out of range");
> +		return -EINVAL;
> +	}
>  	if (ctx->spec_mask & F2FS_SPEC_compress_extension) {
>  		cnt = F2FS_CTX_INFO(ctx).compress_ext_cnt;
>  		for (i = 0; i < F2FS_CTX_INFO(ctx).compress_ext_cnt; i++) {
> @@ -2630,7 +2635,7 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
>  	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
>  	if (f2fs_sb_has_compression(sbi)) {
>  		F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
> -		F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
> +		F2FS_OPTION(sbi).compress_log_size = min_compress_log_size(sbi);
>  		F2FS_OPTION(sbi).compress_ext_cnt = 0;
>  		F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
>  	}



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
