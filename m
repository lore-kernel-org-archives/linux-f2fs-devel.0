Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCAAC624A5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RaZBBSCCp66IVngtxNGhVqgJ4g3YRlD/4ogvEviXrGw=; b=lXxMU/eHa/YdUINtWHekWyPze0
	GXKSy9Mai2LHSvTmcTWbDLD4fOv+iTBbZg2gtrFM1QnmIUio96UqP3DpT0bl3bLHX94b/cxBwJ9d6
	B3xNzP6MgATPQp68Qwa1lfV0Xb0XzGEtW5MHFQOFEyRjyE4EuS/1ekfa/6W5HjSduzQk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0wix-0006Mo-TS;
	Mon, 31 Aug 2026 07:46:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x0wiw-0006Mi-Py
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 07:46:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VsPmteMgnqcVdcLhtU+19faUBqt6fMPz0Emib+Jo0kw=; b=HbBWoku8B1Q96FyDzcbhOa6DBC
 dUfhmkFigvY8GSV1CBm/vcRRdo+T9+o6lAqXaigioAK7aJClR5CVwd23FXtGwW5xpWJmcH0+zxDgH
 ZwR0mOOfJqnxnKdkVhZ6GjeOcottTMgWx08QWrqQlVrHe2OnFMdUWEVcdPYgC2DoFvXc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VsPmteMgnqcVdcLhtU+19faUBqt6fMPz0Emib+Jo0kw=; b=mzB4vD+WDLZQH5ODWM9lE/SLYP
 +WL5+CIo1mF9cgV20L6kJwRdMk7g/8ejY7DRZ+y82dE3sTP3HiWmjsDRPBEEXU0rajZq/y/ouatdV
 9CteTMdUlKHzwaey2QUJfvSWtEdK6T5MkKyHVox+OpQFajO9+tkOKyMmHxjmWPgF8kZ8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0wis-0002We-Md for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 07:46:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 592E941569;
 Mon, 31 Aug 2026 07:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C428E1F000E9;
 Mon, 31 Aug 2026 07:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788162385;
 bh=VsPmteMgnqcVdcLhtU+19faUBqt6fMPz0Emib+Jo0kw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=oLQry5P8smWmfIAGXsHLVdtag7oTjwjxrlgyLqUKWYK4Z7+fWcFfy7M1BxBW/KTux
 JZFIpBNAmqwf66QJHCY0nV2coIl/eyEm7EK3voBc6QwcFFHmENbE7aj/AdqOjffWvr
 j1D5I0ygP2eq5qCwuhJ4QLGdeayj1Y7U/aaibkUhMYo4h3sUah1LhlN8uZIGgnt7dw
 QEl4dN8b5RyQ73MtoFHoTSxQB1/BRC+CQB2Q2/GHV2h4vLx/aFco2F+S4613rVjK3V
 iXBz7RG0ZgBx3qP+v+S6M57Glp/6Ugla5K+oV8ZwLDiQwDNUkGKhrsyYYdzpkG1QcZ
 A5V47NwLm60XA==
Message-ID: <404d2f2b-c8b6-43de-a6e4-9e4989ae5d44@kernel.org>
Date: Mon, 31 Aug 2026 15:46:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
 <20260826082641.2007658-11-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260826082641.2007658-11-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x0wis-0002We-Md
Subject: Re: [f2fs-dev] [PATCH 10/14] f2fs: handle partial truncate of large
 folio dirty subpages
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

On 8/26/26 16:26, Nanzhe Zhao wrote:
> A large folio can be partial truncated and stays in folio mapping, we
> need to clear the subrange dirty bits and uptodate bits that the partial
> truncate covers. If this partial truncate happens to clear the last
> subrange dirty bits, then cancel the whole folio dirty state.
> 
> Also add a guard in f2fs_write_single_data_folio() so a large folio
> subpage whose disk block was already truncated (NULL_ADDR) is skipped
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>   fs/f2fs/data.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 59b07b83b216..15774e8e8795 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2693,6 +2693,34 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
>   		folio_mark_uptodate(folio);
>   }
>   
> +static void ffs_clear_subrange_uptodate(struct folio *folio,
> +					size_t offset, size_t len)
> +{
> +	struct f2fs_folio_state *ffs;
> +	unsigned int nr_subpages, start, end;
> +	unsigned long flags;
> +
> +	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
> +
> +	if (!f2fs_folio_has_ffs(folio)) {
> +		if (folio_test_uptodate(folio))
> +			folio_clear_uptodate(folio);
> +		return;
> +	}
> +
> +	ffs = (struct f2fs_folio_state *)folio->private;
> +	nr_subpages = folio_nr_pages(folio);
> +	start = offset >> PAGE_SHIFT;
> +	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	end = min(end, nr_subpages);
> +
> +	spin_lock_irqsave(&ffs->state_lock, flags);
> +	bitmap_clear(ffs->state, start, end - start);
> +	spin_unlock_irqrestore(&ffs->state_lock, flags);
> +	if (folio_test_uptodate(folio))
> +		folio_clear_uptodate(folio);
> +}
> +
>   bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index)
>   {
>   	struct f2fs_folio_state *ffs;
> @@ -3599,6 +3627,21 @@ static int f2fs_write_single_data_folio(struct folio *folio, int *submitted,
>   
>   		fio.old_blkaddr = dn.data_blkaddr;
>   
> +		/* This page is already truncated */
> +		if (fio.old_blkaddr == NULL_ADDR) {
> +			ffs_clear_subrange_uptodate(folio,
> +					i << PAGE_SHIFT, PAGE_SIZE);
> +			folio_clear_f2fs_gcing(folio);
> +			f2fs_put_dnode(&dn);
> +			if (f2fs_folio_has_ffs(folio)) {
> +				struct f2fs_folio_state *ffs =
> +					(struct f2fs_folio_state *)folio->private;
> +
> +				atomic_dec(&ffs->write_pages_pending);
> +			}
> +			continue;
> +		}
> +
>   got_it:
>   		if (__is_valid_data_blkaddr(fio.old_blkaddr) &&
>   		    !f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
> @@ -5075,8 +5118,37 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   
>   	if (inode->i_ino >= F2FS_ROOT_INO(sbi) &&
> -				(offset || length != folio_size(folio)))
> +				(offset || length != folio_size(folio))) {
> +		size_t clear_start = ALIGN(offset, PAGE_SIZE);

round_up(offset, PAGE_SIZE) will be more efficient?

> +		size_t clear_end = round_down(offset + length, PAGE_SIZE);
> +		size_t clear_length = 0;
> +
> +		/*
> +		 * If the truncated range falls within a single subpage, no
> +		 * subpage state needs to be cleared.
> +		 */
> +		if (clear_start < clear_end && f2fs_folio_has_ffs(folio)) {

How about cleaning up to avoid long line w/

if (clear_start >= clear_end || !f2fs_folio_has_ffs(folio))
	return;

> +			bool dirty;
> +
> +			clear_length = clear_end - clear_start;
> +			dirty = f2fs_ffs_clear_subrange_dirty(folio,
> +							clear_start, clear_length);
> +			ffs_clear_subrange_uptodate(folio, clear_start,
> +							clear_length);
> +
> +			/*
> +			 * If the truncated subrange happens to clear the
> +			 * remaining dirty bitmap of the whole folio, cancel
> +			 * the folio-level dirty state.
> +			 */
> +			if (!dirty && folio_test_dirty(folio)) {
> +				inode_dec_dirty_pages(inode);
> +				f2fs_remove_dirty_inode(inode);
> +				folio_cancel_dirty(folio);
> +			}
> +		}
>   		return;
> +	}
>   
>   	if (folio_test_dirty(folio)) {
>   		if (inode->i_ino == F2FS_META_INO(sbi)) {



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
