Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB452C61DB9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TWvpof+xBzjH2X+aoUtZFwJMrhN8ty8Fw0/DdKblqiI=; b=fo6/B1tNCY1WNzwg7ipz41kytj
	Do4HzRWYE6SsfD8wim5Pq+lybvxn48Xst20of2CXzd22WrV54Q5NW1FSzsxDhdM4G02qFFd6PbV6t
	efhz1tMonLpw/3XJmj20CwrSK/zlGdmEoRZhrkfqyH4fj+LRjjqHcR97hlfZNSNWmFGg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzUM2-0005kr-17;
	Thu, 27 Aug 2026 07:16:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzULz-0005kj-4x
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 07:16:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tPLA3RkuZIumhqwSS/uvWPLXsqpPYd79cJpclLT4Fp8=; b=j1Tn7MTWF6ep5q5ZhKrZlhskZO
 JpiSKvSvZuWyaLIcO9fIhPmOzrRgjv5I7MDtAh8/CuIDGXiKj8IOC1Gu/MRl512ofL3+zr/RmzX8J
 Y4hH73+Y2W9vcaWPuoDvyncwABcPS2Dlw8RBJXnGZsMRJ6980JRDOBCP34YmwyYWpnKs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tPLA3RkuZIumhqwSS/uvWPLXsqpPYd79cJpclLT4Fp8=; b=ErxugvcryU/IV+Vaivyf7XsZS+
 tylXYlU3LfNNQEYfDRL4FZzPYriW+rKKlVIEuC44G72wyxkV/hURedTk1Ej8oYPrp5kiJg9Jg9Lo6
 eRw8tOLMHstmYCM/A5K+v4AnOmudZhLndJdSYD2BAQgsc4gyjJU70Ovx722t8aSOdqyQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzULy-0005mj-6u for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 07:16:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C056A400B6;
 Thu, 27 Aug 2026 07:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE4C1F000E9;
 Thu, 27 Aug 2026 07:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787815004;
 bh=tPLA3RkuZIumhqwSS/uvWPLXsqpPYd79cJpclLT4Fp8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Q/aitK2EKCPBCQex7Y9h20PK2mKieT3UXBrcRiKhR2IawZYvsgySRaf6NibTCBgx3
 VqHGbm9x1FcwEf/Q43Bc61yefaI1I0z08Okeb/5+N8zgg5iM2MqiN1AiYKPcu0ZR1z
 3id5UQ9jm9bmvRgAgd/3bIU85pzi2L/LoZTrcaMmXV+RMciVoyv6KRUMH3AdlBIorS
 BUFRW2G5Q2FnkIa36Ef3Sxryum7mvV/d/R94mPD5teFSsp7mpE7bSQQpsqzpQvpnjT
 /Fr1DexZj03HlIn/0zpgzEi5QPCZwkXHlXyftCIAaZ4wf6Wz1Ibc1IpPr+tqKoSsba
 xzl1aLwGtqP8g==
Message-ID: <3771dfee-db35-4af4-a15d-28b8fa98fe96@kernel.org>
Date: Thu, 27 Aug 2026 15:16:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
 <20260826082641.2007658-3-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260826082641.2007658-3-zhaonanzhe@xiaomi.com>
X-Headers-End: 1wzULy-0005mj-6u
Subject: Re: [f2fs-dev] [PATCH 02/14] f2fs: carry subpage offset and count
 in write IO
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/26/26 16:26, Nanzhe Zhao wrote:
> Large folio write paths need to submit I/O for a range inside a
> folio instead of always submitting the whole folio from offset zero.
> Add folio_offset and folio_blkcnt to f2fs_io_info to describe the
> block offset inside the folio and the number of contiguous blocks
> covered by the I/O.
> 
> Apply the new fields to the bio submit paths that need the subpage
> offset or contiguous block count.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>  fs/f2fs/data.c    | 59 ++++++++++++++++++++++++++++++++---------------
>  fs/f2fs/f2fs.h    | 11 +++++++++
>  fs/f2fs/segment.c |  3 ++-
>  3 files changed, 54 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 578a90d427e2..8649d443ca74 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -783,6 +783,9 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>  	struct folio *fio_folio = fio->folio;
>  	struct folio *data_folio = fio->encrypted_page ?
>  			page_folio(fio->encrypted_page) : fio_folio;
> +	pgoff_t fio_lblk = F2FS_FIO_LBLK(fio_folio, fio);
> +	size_t bio_offset = F2FS_FIO_BIO_OFFSET(fio);
> +	size_t bio_len = F2FS_FIO_BIO_SIZE(fio);
>  
>  	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
>  			fio->is_por ? META_POR : (__is_meta_io(fio) ?
> @@ -795,11 +798,11 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>  	bio = __bio_alloc(fio, 1);
>  
>  	f2fs_set_bio_crypt_ctx(bio, fio_folio->mapping->host,
> -			fio_folio->index, fio, GFP_NOIO);
> -	bio_add_folio_nofail(bio, data_folio, folio_size(data_folio), 0);
> +			fio_lblk, fio, GFP_NOIO);
> +	bio_add_folio_nofail(bio, data_folio, bio_len, bio_offset);
>  
>  	if (fio->io_wbc && !is_read_io(fio->op))
> -		wbc_account_cgroup_owner(fio->io_wbc, fio_folio, PAGE_SIZE);
> +		wbc_account_cgroup_owner(fio->io_wbc, fio_folio, bio_len);
>  
>  	inc_page_count(fio->sbi, is_read_io(fio->op) ?
>  			__read_io_type(data_folio) : WB_DATA_TYPE(fio->folio, false));
> @@ -844,7 +847,8 @@ static bool io_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
>  }
>  
>  static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
> -				struct folio *folio, enum temp_type temp)
> +				struct folio *folio, size_t len, size_t offset,
> +				enum temp_type temp)
>  {
>  	struct f2fs_bio_info *io = sbi->write_io[DATA] + temp;
>  	struct bio_entry *be;
> @@ -853,7 +857,7 @@ static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
>  	be->bio = bio;
>  	bio_get(bio);
>  
> -	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
> +	bio_add_folio_nofail(bio, folio, len, offset);
>  
>  	f2fs_down_write(&io->bio_list_lock);
>  	list_add_tail(&be->list, &io->bio_list);
> @@ -870,6 +874,9 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
>  							struct folio *folio)
>  {
>  	struct folio *fio_folio = fio->folio;
> +	pgoff_t fio_lblk = F2FS_FIO_LBLK(fio_folio, fio);
> +	size_t bio_offset = F2FS_FIO_BIO_OFFSET(fio);
> +	size_t bio_len = F2FS_FIO_BIO_SIZE(fio);
>  	struct f2fs_sb_info *sbi = fio->sbi;
>  	enum temp_type temp;
>  	bool found = false;
> @@ -892,8 +899,8 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
>  							    fio->new_blkaddr));
>  			if (f2fs_crypt_mergeable_bio(*bio,
>  					fio_folio->mapping->host,
> -					fio_folio->index, fio) &&
> -			    bio_add_folio(*bio, folio, folio_size(folio), 0)) {
> +					fio_lblk, fio) &&
> +			    bio_add_folio(*bio, folio, bio_len, bio_offset)) {
>  				ret = 0;
>  				break;
>  			}
> @@ -1007,6 +1014,10 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>  	struct folio *data_folio = fio->encrypted_page ?
>  			page_folio(fio->encrypted_page) : fio->folio;
>  	struct folio *folio = fio->folio;
> +	pgoff_t fio_lblk = F2FS_FIO_LBLK(folio, fio);
> +	unsigned int fio_cnt = F2FS_FIO_BLKCNT(fio);
> +	size_t bio_offset = F2FS_FIO_BIO_OFFSET(fio);
> +	size_t bio_len = F2FS_FIO_BIO_SIZE(fio);
>  
>  	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
>  			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
> @@ -1021,9 +1032,10 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>  	if (!bio) {
>  		bio = __bio_alloc(fio, BIO_MAX_VECS);
>  		f2fs_set_bio_crypt_ctx(bio, folio->mapping->host,
> -				folio->index, fio, GFP_NOIO);
> +				fio_lblk, fio, GFP_NOIO);
>  
> -		add_bio_entry(fio->sbi, bio, data_folio, fio->temp);
> +		add_bio_entry(fio->sbi, bio, data_folio, bio_len,
> +			     bio_offset, fio->temp);
>  	} else {
>  		if (add_ipu_page(fio, &bio, data_folio))
>  			goto alloc_new;
> @@ -1034,7 +1046,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>  
>  	inc_page_count(fio->sbi, WB_DATA_TYPE(folio, false));
>  
> -	*fio->last_block = fio->new_blkaddr;
> +	*fio->last_block = fio->new_blkaddr + fio_cnt - 1;
>  	*fio->bio = bio;
>  
>  	return 0;
> @@ -1070,6 +1082,10 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  	struct folio *bio_folio;
>  	struct f2fs_lock_context lc;
>  	enum count_type type;
> +	pgoff_t fio_lblk;
> +	unsigned int fio_cnt;
> +	size_t bio_offset;
> +	size_t bio_len;
>  
>  	f2fs_bug_on(sbi, is_read_io(fio->op));
>  
> @@ -1108,6 +1124,9 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  	/* set submitted = true as a return value */
>  	fio->submitted = 1;
>  
> +	fio_lblk = F2FS_FIO_LBLK(fio->folio, fio);
> +	fio_cnt = F2FS_FIO_BLKCNT(fio);
> +
>  	type = WB_DATA_TYPE(bio_folio, fio->compressed_page);
>  	inc_page_count(sbi, type);
>  
> @@ -1115,26 +1134,28 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
>  			      fio->new_blkaddr) ||
>  	     !f2fs_crypt_mergeable_bio(io->bio, fio_inode(fio),
> -				bio_folio->index, fio)))
> +				fio_lblk, fio)))
>  		__submit_merged_bio(io);
>  alloc_new:
>  	if (io->bio == NULL) {
>  		io->bio = __bio_alloc(fio, BIO_MAX_VECS);
>  		f2fs_set_bio_crypt_ctx(io->bio, fio_inode(fio),
> -				bio_folio->index, fio, GFP_NOIO);
> +				fio_lblk, fio, GFP_NOIO);
>  		io->fio = *fio;
>  	}
>  
> -	if (!bio_add_folio(io->bio, bio_folio, folio_size(bio_folio), 0)) {
> +	bio_offset = F2FS_FIO_BIO_OFFSET(fio);
> +	bio_len = F2FS_FIO_BIO_SIZE(fio);
> +
> +	if (!bio_add_folio(io->bio, bio_folio, bio_len, bio_offset)) {
>  		__submit_merged_bio(io);
>  		goto alloc_new;
>  	}
>  
>  	if (fio->io_wbc)
> -		wbc_account_cgroup_owner(fio->io_wbc, fio->folio,
> -				folio_size(fio->folio));
> +		wbc_account_cgroup_owner(fio->io_wbc, fio->folio, bio_len);
>  
> -	io->last_block_in_bio = fio->new_blkaddr;
> +	io->last_block_in_bio = fio->new_blkaddr + fio_cnt - 1;
>  
>  	trace_f2fs_submit_folio_write(fio->folio, fio);
>  #ifdef CONFIG_BLK_DEV_ZONED
> @@ -3039,7 +3060,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>  		set_new_dnode(&dn, inode, NULL, NULL, 0);
>  
>  	if (need_inplace_update(fio) &&
> -	    f2fs_lookup_read_extent_cache_block(inode, folio->index,
> +	    f2fs_lookup_read_extent_cache_block(inode,
> +						F2FS_FIO_LBLK(folio, fio),
>  						&fio->old_blkaddr)) {
>  		if (!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
>  						DATA_GENERIC_ENHANCE))
> @@ -3058,7 +3080,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>  	if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi, &lc))
>  		return -EAGAIN;
>  
> -	err = f2fs_get_dnode_of_data(&dn, folio->index, LOOKUP_NODE);
> +	err = f2fs_get_dnode_of_data(&dn, F2FS_FIO_LBLK(folio, fio),
> +				     LOOKUP_NODE);
>  	if (err)
>  		goto out;
>  
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 2e8f85cea6d0..31ddd321daf6 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1357,6 +1357,8 @@ struct f2fs_io_info {
>  	blk_opf_t op_flags;	/* req_flag_bits */
>  	block_t new_blkaddr;	/* new block address to be written */
>  	block_t old_blkaddr;	/* old block address before Cow */
> +	pgoff_t folio_offset;	/* offset in large folio */
> +	unsigned int folio_blkcnt;	/* block count in large folio */
>  	union {
>  		struct page *page;	/* page to be written */
>  		struct folio *folio;
> @@ -1378,6 +1380,15 @@ struct f2fs_io_info {
>  	sector_t *last_block;		/* last block number in bio */
>  };
>  
> +#define F2FS_FIO_LBLK(folio, fio)					\
> +	((folio)->index + (fio)->folio_offset)

#define F2FS_FIO_LBLK(fio)					\
	(((fio)->folio)->index + (fio)->folio_offset)

> +#define F2FS_FIO_BLKCNT(fio)						\
> +	((fio)->folio_blkcnt ? (fio)->folio_blkcnt : 1)

Hmm, it's better to not leaving fio.folio_blkcnt as zero, can we set
fio.folio_blkcnt to 1 by default? and use fio->folio_blkcnt.

Thanks,

> +#define F2FS_FIO_BIO_OFFSET(fio)					\
> +	((fio)->folio_offset << PAGE_SHIFT)
> +#define F2FS_FIO_BIO_SIZE(fio)					\
> +	F2FS_BLK_TO_BYTES(F2FS_FIO_BLKCNT(fio))
> +
>  struct bio_entry {
>  	struct bio *bio;
>  	struct list_head list;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index df10119d94ad..5bb1e51a38a0 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3816,7 +3816,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>  		if (file_is_cold(inode) || f2fs_need_compress_data(inode))
>  			return CURSEG_COLD_DATA;
>  
> -		type = __get_age_segment_type(inode, fio->folio->index);
> +		type = __get_age_segment_type(inode,
> +					     F2FS_FIO_LBLK(fio->folio, fio));
>  		if (type != NO_CHECK_TYPE)
>  			return type;
>  



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
