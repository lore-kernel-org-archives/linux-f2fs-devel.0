Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434E5C982C1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MVk8RCbsYuPC0VEHKz9f9lUHFlVee3Pyy+zSmF6T1sY=; b=HOPVEu8tod4Bf2PDzh0cgYUozc
	aDYb9T+b1rT+NgWlhbAM3NdTWT54ifSUbTTDQUbUZ6c7YZUzfFyAFd0n6uW3LhXMgVD6YPVqNXcC9
	0mu10jiFdeEU5eakJ82C0uObgtuMgZ6lYPs3MGdmHVNYtlVLnk9npo7PIsr+FWmFS8j8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x77WQ-0000Ts-1v;
	Thu, 17 Sep 2026 08:31:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x77WP-0000Tm-DK
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 08:31:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lFdpvrBU8kEVcsoKwwf3D1dYac6o7xDt4OTJI4v73rQ=; b=M/0xMC1xm6s+MJRE25Pv/kejF9
 dEHQJTi14Lsy1+JHVJ1Qma1XNp8MFZ3TJxoB55ryhL6rghNVX4j7dmxcICdJtWNglCv6t+/7zvKil
 ty8iyBquA/qgyCpBbGSgxYdNXatQP0GxXGRi311TFOovPCByjjXqL3abKY62C8qdgZVc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lFdpvrBU8kEVcsoKwwf3D1dYac6o7xDt4OTJI4v73rQ=; b=Ym8qyMw4LAdfFafRFqnyPux8Hl
 qLC1EvTfe7Me9cz5UJy3dV8o+laq6w0B+akEMhWD2Hlgra23i9Xp12oApQD4ClAE1qj4ksUyVgP0Q
 0bEhiW27Gw4FnxICoMHGpewJRoyOxrFNCniDWwC3wJIVPNOScNQYN8m/1yZ4y646yOVs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x77WO-0001Ej-35 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 08:31:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B9E964142F;
 Thu, 17 Sep 2026 08:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9ED1F000FF;
 Thu, 17 Sep 2026 08:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789633862;
 bh=lFdpvrBU8kEVcsoKwwf3D1dYac6o7xDt4OTJI4v73rQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=SgqCzWbBDNH2jCl7z1oeAFeSuA8kZQMe7Z3rLtBDqd74tak6GhPOAPioQSJmU6IdZ
 zFfaZZJTou5qOUd0A3SIS0y5rxt9vP4ewctohpyuI5picascFmUi4tRqy9NQWeQEvS
 SVBGaq7VCA2wkostOG6qpUSwoF/cI0gvI6g0rADeZLzwrmiDhg+sWnkA1ZxT1Pxrd1
 NdwWrXe0+UT80wkw0rwHKPPXKmqlYUPKPmJNoCzrHI3lWfm7yAvRKs0FNlrQYk5Q0P
 MQpOUec3d2zGlZwm31Mq7mAl326Q6Ji/4Y2qCsGv63FgK+uQPe2yKPoMDO9kmVBcGk
 PIVui0aWcIgcA==
Message-ID: <c4e0c6d3-ad28-4e5e-a938-08b7658e9931@kernel.org>
Date: Thu, 17 Sep 2026 16:30:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
 <20260915041909.2903887-11-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260915041909.2903887-11-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x77WO-0001Ej-35
Subject: Re: [f2fs-dev] [PATCH v2 10/14] f2fs: handle partial truncate of
 large folio dirty subpages
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

On 9/15/26 12:19, Nanzhe Zhao wrote:
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
>  fs/f2fs/data.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d9e3a5c370d7..bf9b9c9b722f 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2679,6 +2679,34 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
>  		folio_mark_uptodate(folio);
>  }
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
>  bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index)
>  {
>  	struct f2fs_folio_state *ffs;
> @@ -3545,6 +3573,14 @@ static int f2fs_write_single_data_folio(struct folio *folio, int *submitted,
>  
>  		fio.old_blkaddr = dn.data_blkaddr;
>  
> +		/* This page is already truncated */
> +		if (fio.old_blkaddr == NULL_ADDR) {
> +			ffs_clear_subrange_uptodate(folio,
> +					i << PAGE_SHIFT, PAGE_SIZE);
> +			folio_clear_f2fs_gcing(folio);

Since gcing flag is per-folio, so if block #0 is on gcing, but block #1 is
truncated, it will drop on gcing flag of folio, result in triggering IPU on
such dirtied block of large folio? also it will affect f2fs_is_cp_guaranteed()?

Thanks,

> +			goto block_done;
> +		}
> +
>  got_it:
>  		if (__is_valid_data_blkaddr(fio.old_blkaddr) &&
>  		    !f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
> @@ -4987,8 +5023,36 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  
>  	if (inode->i_ino >= F2FS_ROOT_INO(sbi) &&
> -				(offset || length != folio_size(folio)))
> +				(offset || length != folio_size(folio))) {
> +		size_t clear_start = round_up(offset, PAGE_SIZE);
> +		size_t clear_end = round_down(offset + length, PAGE_SIZE);
> +		size_t clear_length;
> +		bool dirty;
> +
> +		/*
> +		 * If the truncated range falls within a single subpage, no
> +		 * subpage state needs to be cleared.
> +		 */
> +		if (clear_start >= clear_end || !f2fs_folio_has_ffs(folio))
> +			return;
> +
> +		clear_length = clear_end - clear_start;
> +		dirty = f2fs_ffs_clear_subrange_dirty_and_test(folio,
> +						clear_start, clear_length);
> +		ffs_clear_subrange_uptodate(folio, clear_start, clear_length);
> +
> +		/*
> +		 * If the truncated subrange happens to clear the remaining
> +		 * dirty bitmap of the whole folio, cancel the folio-level
> +		 * dirty state.
> +		 */
> +		if (!dirty && folio_test_dirty(folio)) {
> +			inode_dec_dirty_pages(inode);
> +			f2fs_remove_dirty_inode(inode);
> +			folio_cancel_dirty(folio);
> +		}
>  		return;
> +	}
>  
>  	if (folio_test_dirty(folio)) {
>  		if (inode->i_ino == F2FS_META_INO(sbi)) {



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
