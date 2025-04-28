Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABE0C3ABA4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Apr 2025 15:23:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u9QK4-0000bV-Ns;
	Mon, 28 Apr 2025 15:23:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1u9QK3-0000bK-PM
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Apr 2025 15:23:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gDYpqasfpa3uQkr3YTN3RxVvZOorxW9UQ5I6IWdhaiA=; b=PR988vMJBdXt6Xd1dZaWXwqyfP
 mYVPBHGINSFMbh/tUbch6lz64fAkM/NJ6B2F6RDN1CkWV4NE1bj/sd5Aijn0H3y1CgPx4Dzn4XLVq
 m4FbX6T7Kd1ZhfDIpGbvXG6mF1sC8xBgNaqVvkQ1WZHw8fzHaATh6hEiGBRgCK4HvwVo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gDYpqasfpa3uQkr3YTN3RxVvZOorxW9UQ5I6IWdhaiA=; b=eQOdADjD1W7hfHbTFzaOKWKsY9
 IUeLdHduSAH/zpZekeUvw0CpUhzjCmIaajd0eb1Z1UbBccNlPavhfQqfIaomy/MJfzTp+HWInea0b
 rSlRHljr5MKhR1+gW+iL53jev3RsRpHioU6HWuyO5cesaNMwSCnOrjX3FxfsmgnmZEVg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u9QJo-0000jw-Qq for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Apr 2025 15:23:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6163343BCC;
 Mon, 28 Apr 2025 15:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32652C4CEE4;
 Mon, 28 Apr 2025 15:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745853762;
 bh=odTJoZOpYlRffWr0J4GEXJb+dDps65fSFN/g0JyQvuo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e/hqkRO4jAvEXn8FYO5Z+T7SFuYVHofvF6nn8QPFQOFF/8BOEV0Wui2JsGlQgcUU/
 PhSwr+U+dSbetiI7SvbAsQNEcA1SQCJ+8hFdF+CmrjFZtIhB31PSHrBziWRRwJLSrB
 sW+UJcuzb1onM/l8jR607CapS2IS68+VI439WbqQ5z/nOCL0mFg32Yi7A3Ij1nSpGT
 m8Lv30DoIESHd2HyCCqNLi1lpEgmft4iBC99DsAs6wB6UxPFxGgys3fxnlzCbSkJh1
 bG0hJrrJ1hptb+z4qH8F4lnm7vE5pC6M4ceKdZj7ZiYNTwdFSgBlHOweWJLy/0s4xB
 RByaDFSD6qsVg==
Date: Mon, 28 Apr 2025 15:22:40 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <aA-dQKvhIMFuYXSh@google.com>
References: <20250331201256.1057782-1-willy@infradead.org>
 <20250331201256.1057782-10-willy@infradead.org>
 <d67890f5-9531-4814-a8e1-85c2dafd6bb2@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d67890f5-9531-4814-a8e1-85c2dafd6bb2@kernel.org>
X-Headers-End: 1u9QJo-0000jw-Qq
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/27, Chao Yu wrote:
> On 4/1/25 04:10, Matthew Wilcox (Oracle) wrote:
> > Support arbitrary size folios and remove a few hidden calls to
> > compound_head().  Also remove an unnecessary test of the uptodaate flag;
> > if mapping_read_folio_gfp() cannot bring the folio uptodate, it will
> > return an error.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/f2fs/super.c | 36 ++++++++++++++++--------------------
> >  1 file changed, 16 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index f087b2b71c89..fd93581bee89 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -2689,12 +2689,9 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
> >  {
> >  	struct inode *inode = sb_dqopt(sb)->files[type];
> >  	struct address_space *mapping = inode->i_mapping;
> > -	block_t blkidx = F2FS_BYTES_TO_BLK(off);
> > -	int offset = off & (sb->s_blocksize - 1);
> >  	int tocopy;
> >  	size_t toread;
> >  	loff_t i_size = i_size_read(inode);
> > -	struct page *page;
> >  
> >  	if (off > i_size)
> >  		return 0;
> > @@ -2703,37 +2700,36 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
> >  		len = i_size - off;
> >  	toread = len;
> >  	while (toread > 0) {
> > -		tocopy = min_t(unsigned long, sb->s_blocksize - offset, toread);
> > +		struct folio *folio;
> > +		size_t offset;
> > +
> >  repeat:
> > -		page = read_cache_page_gfp(mapping, blkidx, GFP_NOFS);
> > -		if (IS_ERR(page)) {
> > -			if (PTR_ERR(page) == -ENOMEM) {
> > +		folio = mapping_read_folio_gfp(mapping, off >> PAGE_SHIFT,
> > +				GFP_NOFS);
> > +		if (IS_ERR(folio)) {
> > +			if (PTR_ERR(folio) == -ENOMEM) {
> >  				memalloc_retry_wait(GFP_NOFS);
> >  				goto repeat;
> >  			}
> >  			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
> > -			return PTR_ERR(page);
> > +			return PTR_ERR(folio);
> >  		}
> > +		offset = offset_in_folio(folio, off);
> > +		tocopy = min(folio_size(folio) - offset, toread);
> >  
> > -		lock_page(page);
> > +		folio_lock(folio);
> >  
> > -		if (unlikely(page->mapping != mapping)) {
> > -			f2fs_put_page(page, 1);
> > +		if (unlikely(folio->mapping != mapping)) {
> > +			f2fs_folio_put(folio, true);
> >  			goto repeat;
> >  		}
> > -		if (unlikely(!PageUptodate(page))) {
> 
> How about adding f2fs_bug_on(, !folio_test_uptodate(folio)) here to detect
> any potential bug?

It seems we can add f2fs_bug_on() separately.

> 
> Thanks,
> 
> > -			f2fs_put_page(page, 1);
> > -			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
> > -			return -EIO;
> > -		}
> >  
> > -		memcpy_from_page(data, page, offset, tocopy);
> > -		f2fs_put_page(page, 1);
> > +		memcpy_from_folio(data, folio, offset, tocopy);
> > +		f2fs_folio_put(folio, true);
> >  
> > -		offset = 0;
> >  		toread -= tocopy;
> >  		data += tocopy;
> > -		blkidx++;
> > +		off += tocopy;
> >  	}
> >  	return len;
> >  }


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
