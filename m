Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834AECA9EC5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vo63chptjbwOaVZ5DWTPxPAzPYV0aPLlKhK67txhX9g=; b=Do2qoqt2Txgum5/YPKNJI1FOv7
	4YaBaAuN0jDoFqvHwGu71cVCqojtqIiBxr2UNsBkgtmsjrWjo6utB9vFkhlXIhbuOjzjLCN0gjeat
	vGulglzfnrAZLW9r81vIZmAEVrX1lh04NrZ6ba3qBq6Dxj03QlB0ickzJmBnidIbUpKo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGAJk-0001vX-I2;
	Mon, 12 Oct 2026 07:19:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGAJR-0001vG-64
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 07:19:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AdPqNpZXmNQ43AQ3xgOVf01mH+/LX9E+Jqxlk12JjDk=; b=OIag5enHagZ5BkJXUuqQX0Xla+
 8IWwTmX+KBXZRjUrGmF7KICyIB2NKojYZ3tsqGmlhljMimCIhgwra9CsqtsHtajzWkJoy1PLbWzvr
 VIN8bWDHoiDshu5z0by7wS0vQrfRgHfk3YOX4JGgNnhbQcmJ7DpRmpBPM1wQPNOb1JzM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AdPqNpZXmNQ43AQ3xgOVf01mH+/LX9E+Jqxlk12JjDk=; b=Dvh9FiOEoTK76NNtdtXchwlVLP
 1mu1iwmzV5116bpA3N1FFGQPvgYy5n61nafLmk+UBhHezbdBchkyq5QecnK2fY2NEEzn8p1vjDJTq
 BExYEFWmaGG71NSEEn6yP7YDMM7mh3Ynu6FGnwH1LaUDMfZjISHv9XelD8jWHLbwSoPo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGAJL-0006rc-QO for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 07:19:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 20E8060AB5;
 Mon, 12 Oct 2026 07:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA531F0089B;
 Mon, 12 Oct 2026 07:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791789537;
 bh=AdPqNpZXmNQ43AQ3xgOVf01mH+/LX9E+Jqxlk12JjDk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=NrMNadbCP95GjDmY/kQ46xpmUzNaYnUbZ+Z0r80BX2zwl9Q2OGp69N9jogVH+weFP
 rBnbXZ/A0Irm01uu1dzRoQhEoCVBz97z6PzrLrBjszuaIl3lEvpDPVfmSazXsKEnyy
 S7A2JJzD+AZ10T0pSRdzWHQyOdS2R05AVXC7aFGN1pN8UMBB5w6YQWMXnyu5oVoxCk
 4yrNRtv8MrAsvXxhkML7ltTUCSG+s5SoRaF5AcEtX9JPS3HZzdRkPn43Vixd9tNcaN
 T6vrvU3g4SZhA5XIS/Di7O8USiQ3v4/pYScRLVZ6MyYXRRb5TxiT9dZXeeBE8o3UPT
 1XAOIs06Wi5gw==
Message-ID: <fdaf1bef-3d10-4d54-a8c3-087804ca57cf@kernel.org>
Date: Mon, 12 Oct 2026 15:18:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
 <20261009162828.4188050-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261009162828.4188050-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xGAJL-0006rc-QO
Subject: Re: [f2fs-dev] [PATCH v3 11/17] f2fs: support partial uptodate
 large folio read
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
 Daeho Jeong <daehojeong@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Nanzhe Zhao <nzzhao@126.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/10/26 00:28, Nanzhe Zhao wrote:
> Buffered write can have write bytes smaller than folio
> size for cases when folio minimum order is not zero.
> This can left partially uptodate folio in page cache.
> So we skip uptodate subpage read in read_data_large_folio.
> Also mark hole subpage uptodate in uptodate bitmap.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>   fs/f2fs/data.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 6f6f5223951d..21c43019167a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -148,6 +148,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>   		struct folio *folio = fi.folio;
>   		unsigned nr_pages = fi.length >> PAGE_SHIFT;
>   		bool finished = true;
> +		bool uptodate = bio->bi_status == BLK_STS_OK;
>   
>   		if (!folio_test_large(folio) &&
>   		    f2fs_is_compressed_page(folio)) {
> @@ -163,6 +164,9 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>   				(struct f2fs_folio_state *)folio->private;
>   
>   			spin_lock_irqsave(&ffs->state_lock, flags);
> +			if (bio->bi_status == BLK_STS_OK)
> +				uptodate = __ffs_mark_subrange_uptodate(folio, ffs,
> +						fi.offset, fi.length);
>   			ffs->read_pages_pending -= nr_pages;
>   			finished = !ffs->read_pages_pending;
>   			spin_unlock_irqrestore(&ffs->state_lock, flags);
> @@ -172,7 +176,8 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>   			dec_cache_count(F2FS_F_SB(folio), F2FS_RD_DATA);
>   
>   		if (finished)
> -			folio_end_read(folio, bio->bi_status == BLK_STS_OK);
> +			folio_end_read(folio,
> +				bio->bi_status == BLK_STS_OK && uptodate);

Looks weird, can we initial uptodate to true directly? and only update it according
to __ffs_mark_subrange_uptodate(), rather than (bio->bi_status == BLK_STS_OK)?

>   	}
>   
>   	if (ctx)
> @@ -3071,6 +3076,56 @@ static bool find_next_valid_block(const struct folio *folio,
>   	return false;
>   }
>   
> +static unsigned int ffs_next_uptodate_subpage(struct f2fs_folio_state *ffs,
> +			unsigned int start, unsigned int end)
> +{
> +	return find_next_bit(ffs->state, end + 1, start);
> +}
> +
> +static unsigned int ffs_next_nonuptodate_subpage(struct f2fs_folio_state *ffs,
> +			unsigned int start, unsigned int end)
> +{
> +	return find_next_zero_bit(ffs->state, end + 1, start);
> +}
> +
> +static void f2fs_skip_fully_uptodate_front(struct folio *folio,
> +			pgoff_t *index, pgoff_t *offset, unsigned int *nrpages,
> +			unsigned int *max_nr_pages)
> +{
> +	struct f2fs_folio_state *ffs;
> +	unsigned int next, skipped;
> +
> +	if (!f2fs_folio_has_ffs(folio) || !*nrpages)
> +		return;
> +
> +	ffs = (struct f2fs_folio_state *)folio->private;
> +	next = ffs_next_nonuptodate_subpage(ffs, *offset,
> +					    *offset + *nrpages - 1);
> +	skipped = next - *offset;
> +	if (!skipped)
> +		return;
> +
> +	*index += skipped;
> +	*offset += skipped;
> +	*nrpages -= skipped;
> +	*max_nr_pages -= skipped;
> +}
> +
> +static void f2fs_truncate_read_extent(struct folio *folio, pgoff_t offset,
> +				     unsigned int *len_blks)
> +{
> +	struct f2fs_folio_state *ffs;
> +	unsigned int next, end;
> +
> +	if (!f2fs_folio_has_ffs(folio) || *len_blks <= 1)
> +		return;
> +
> +	ffs = (struct f2fs_folio_state *)folio->private;
> +	end = offset + *len_blks - 1;
> +	next = ffs_next_uptodate_subpage(ffs, offset + 1, end);
> +	if (next <= end)
> +		*len_blks = next - offset;
> +}

Blank line.

Thanks,

>   static int f2fs_read_data_large_folio(struct inode *inode,
>   		struct fsverity_info *vi,
>   		struct readahead_control *rac, struct folio *folio)
> @@ -3115,6 +3170,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   
>   		len_blks = 1;
>   
> +		f2fs_skip_fully_uptodate_front(folio, &index, &offset,
> +					       &nrpages, &max_nr_pages);
> +		if (!nrpages)
> +			break;
> +
>   		/*
>   		 * Map blocks using the previous result first.
>   		 */
> @@ -3147,6 +3207,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   			len_blks = min_t(unsigned int, nrpages, max_nr_pages);
>   			len_blks = min_t(unsigned int, len_blks,
>   					(unsigned int)(map.m_lblk + map.m_len - index));
> +			f2fs_truncate_read_extent(folio, offset, &len_blks);
>   
>   			for (i = 0; i < len_blks; i++) {
>   				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
> @@ -3165,6 +3226,13 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   				ret = -EIO;
>   				goto err_out;
>   			}
> +			if (folio_test_large(folio)) {
> +				ffs = f2fs_ffs_find_or_alloc(folio);
> +				spin_lock_irq(&ffs->state_lock);
> +				__ffs_mark_subrange_uptodate(folio, ffs,
> +						page_offset, PAGE_SIZE);
> +				spin_unlock_irq(&ffs->state_lock);
> +			}
>   			continue;
>   		}
>   



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
