Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1A4C369D1
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 27 Apr 2025 11:03:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u8zmy-0000v0-JY;
	Sun, 27 Apr 2025 11:03:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1u8zmx-0000uu-NL
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Apr 2025 11:03:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FITfeR2WhrRmkKcwe8nYyshLsEz++XPmIGf6oH0eRsM=; b=cd9FWxLjM+auGSgD62NT9/d4tj
 ++qn8nbCE/NjOrLV48ELyivPVJvlXecIsz0HdR16pp5D/uVWVfmJuywDRRA/64YLBStXg9brHGjWP
 sQxV81U2xjKDbI5pF6SZT2JqaIzkt45yr1igNzoxfnT55ctSP1G6aZCmj4P1JJXMwdvI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FITfeR2WhrRmkKcwe8nYyshLsEz++XPmIGf6oH0eRsM=; b=DRnIr5roL8edLGwMEuGZN4QuEF
 soOzYmvqdroddyTSafd1OIpQ9KE2xHUyEwfbNnc/Cu0Qxr7ZZ5lij9PwsL+omTrUYpSmW8f2Hez23
 XFy95Vj1yIx5bjaiFpum0FpYGNnTh5TbJt0lcOe6SInBpHdf8UqLvxUuNgmXM1rhZOo8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u8zmh-0007Oe-T3 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Apr 2025 11:03:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8527661157;
 Sun, 27 Apr 2025 11:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB2EC4CEE3;
 Sun, 27 Apr 2025 11:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745751764;
 bh=UCfvjREysGMcDCPOWLe0mq+icCX1uJT9owRRV85psWQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=DT43LldAhZ+lE/h0RnvlAW3ZQVpNhTgtA0A74Dj9BBD0zlrIPJuB8VeNEJYK8odUD
 9L6tQ0nsD9256Gg9bCBrG0e5JxKk72WGDpxOu6ZPsoSdoiF9gX7HXP1BSinEqhXPm5
 MHWq1TMNPlAg6A/LYSJMwKYLuzu9/IyeFCa9VxShDoH+/CjzODB0k8NHQcJgQRrkrT
 AyncPmtt+i3ut2BA15vjKowRA4kl72ly4EFsmlr+YFKhhBrn+LMTDx1R6KACAVLonP
 oCshbsnKuCZie8OPXHCZ6WxtGGArJbJOpHiEGvgKgTGwprlcP6pezywvF/TZJ9Z0XI
 DnmPHL91WRQAQ==
Message-ID: <d67890f5-9531-4814-a8e1-85c2dafd6bb2@kernel.org>
Date: Sun, 27 Apr 2025 19:02:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
 <20250331201256.1057782-10-willy@infradead.org>
Content-Language: en-US
In-Reply-To: <20250331201256.1057782-10-willy@infradead.org>
X-Headers-End: 1u8zmh-0007Oe-T3
Subject: Re: [f2fs-dev] [PATCH 009/153] f2fs: Use a folio in
 f2fs_quota_read()
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/1/25 04:10, Matthew Wilcox (Oracle) wrote:
> Support arbitrary size folios and remove a few hidden calls to
> compound_head().  Also remove an unnecessary test of the uptodaate flag;
> if mapping_read_folio_gfp() cannot bring the folio uptodate, it will
> return an error.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/f2fs/super.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f087b2b71c89..fd93581bee89 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2689,12 +2689,9 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
>  {
>  	struct inode *inode = sb_dqopt(sb)->files[type];
>  	struct address_space *mapping = inode->i_mapping;
> -	block_t blkidx = F2FS_BYTES_TO_BLK(off);
> -	int offset = off & (sb->s_blocksize - 1);
>  	int tocopy;
>  	size_t toread;
>  	loff_t i_size = i_size_read(inode);
> -	struct page *page;
>  
>  	if (off > i_size)
>  		return 0;
> @@ -2703,37 +2700,36 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
>  		len = i_size - off;
>  	toread = len;
>  	while (toread > 0) {
> -		tocopy = min_t(unsigned long, sb->s_blocksize - offset, toread);
> +		struct folio *folio;
> +		size_t offset;
> +
>  repeat:
> -		page = read_cache_page_gfp(mapping, blkidx, GFP_NOFS);
> -		if (IS_ERR(page)) {
> -			if (PTR_ERR(page) == -ENOMEM) {
> +		folio = mapping_read_folio_gfp(mapping, off >> PAGE_SHIFT,
> +				GFP_NOFS);
> +		if (IS_ERR(folio)) {
> +			if (PTR_ERR(folio) == -ENOMEM) {
>  				memalloc_retry_wait(GFP_NOFS);
>  				goto repeat;
>  			}
>  			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
> -			return PTR_ERR(page);
> +			return PTR_ERR(folio);
>  		}
> +		offset = offset_in_folio(folio, off);
> +		tocopy = min(folio_size(folio) - offset, toread);
>  
> -		lock_page(page);
> +		folio_lock(folio);
>  
> -		if (unlikely(page->mapping != mapping)) {
> -			f2fs_put_page(page, 1);
> +		if (unlikely(folio->mapping != mapping)) {
> +			f2fs_folio_put(folio, true);
>  			goto repeat;
>  		}
> -		if (unlikely(!PageUptodate(page))) {

How about adding f2fs_bug_on(, !folio_test_uptodate(folio)) here to detect
any potential bug?

Thanks,

> -			f2fs_put_page(page, 1);
> -			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
> -			return -EIO;
> -		}
>  
> -		memcpy_from_page(data, page, offset, tocopy);
> -		f2fs_put_page(page, 1);
> +		memcpy_from_folio(data, folio, offset, tocopy);
> +		f2fs_folio_put(folio, true);
>  
> -		offset = 0;
>  		toread -= tocopy;
>  		data += tocopy;
> -		blkidx++;
> +		off += tocopy;
>  	}
>  	return len;
>  }



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
