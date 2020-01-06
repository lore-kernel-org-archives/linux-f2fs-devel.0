Return-Path: <SRS0=h4up=23=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4A7C33C8C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jan 2020 20:44:19 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB60120731;
	Mon,  6 Jan 2020 20:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="KnBBpXug";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="CtjrTtDx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxR3Bbcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB60120731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ioZEY-0003dT-Tm; Mon, 06 Jan 2020 20:44:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1ioZEX-0003dL-5D
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Jan 2020 20:44:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c9Z19YOGHQfCJD8ZOfF2zdQhr910bfl12OKzLYcUIQo=; b=KnBBpXug8wh12N+8gdWCTGYkF1
 0VtyIl9gBGvuMZClJdP1I6AvJTYRBeF5uHiVkaonlnBgLXeAqrfhn+pdUczb0BvL31GmRqbjhH9Xz
 FsWh0+JlFtpGpm6wkyUaCZEEYkpBux6Lhe2v+Oj3N+65b63DJ8AK/9PvTofrLtBLo0qI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=c9Z19YOGHQfCJD8ZOfF2zdQhr910bfl12OKzLYcUIQo=; b=CtjrTtDxIscCgF6HE9f3Kv1iLS
 8IrdchzdvxyVuiq73OLRGZ8YPaxIved26E7ArDIqbCZk8SVgOaZM1dBXHr0IASTSZeiyjSF0RiDQ3
 HomGwXeVFtYW9NKGnRK1WtC+SEDllgWTI+Qn8yTZjLCGIJ7ztpZSClneYHUOj4C2ad9o=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ioZEQ-00BubP-9R
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Jan 2020 20:44:17 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5BADC20731;
 Mon,  6 Jan 2020 20:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578343440;
 bh=GCDF90PxaFvkCGdMTp6cM9sEWuA1IASP7woryXiIkio=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kxR3BbcmfEd73kXxSYAqfsOmgdQ2Fcysz9TiL5R0c3beHGBb4GmNNZQGIw8h8advw
 otmHqxecH+g51yMiinkK+sU1bLicbT7jDFfAd82yOqB1479nS8FFz1NO8GvTpKAp5Z
 Ti9u2rTBVrn+51T4bSV4dyCcTRYh59GowGLGVluc=
Date: Mon, 6 Jan 2020 12:43:58 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <20200106204357.GA254289@gmail.com>
References: <20191216181112.89304-1-ebiggers@kernel.org>
 <20200106181508.GA50058@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200106181508.GA50058@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1ioZEQ-00BubP-9R
Subject: Re: [f2fs-dev] [PATCH] fs-verity: implement readahead of Merkle
 tree pages
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
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-ext4@vger.kernel.org, Victor Hsieh <victorhsieh@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 06, 2020 at 10:15:08AM -0800, Jaegeuk Kim wrote:
> >  static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
> > -					       pgoff_t index)
> > +					       pgoff_t index,
> > +					       unsigned long num_ra_pages)
> >  {
> > +	struct page *page;
> > +
> >  	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
> >  
> > -	return read_mapping_page(inode->i_mapping, index, NULL);
> > +	page = find_get_page(inode->i_mapping, index);
> > +	if (!page || !PageUptodate(page)) {
> > +		if (page)
> > +			put_page(page);
> > +		else if (num_ra_pages > 1)
> > +			f2fs_merkle_tree_readahead(inode->i_mapping, index,
> > +						   num_ra_pages);
> > +		page = read_mapping_page(inode->i_mapping, index, NULL);
> > +		if (IS_ERR(page))
> > +			return page;
> 
> We don't need to check this, but can use the below return page?
> 

Indeed, I'll remove the unnecessary IS_ERR(page) check.

> > +	}
> 
> mark_page_accessed(page)?
> 
> > +	return page;
> >  }

Good idea, but read_mapping_page() already calls mark_page_accessed().  It's
just find_get_page() that doesn't.  So after this patch, mark_page_accessed() is
no longer called in the case where the page is already cached and Uptodate.
I'll change it to use:

	find_get_page_flags(inode->i_mapping, index, FGP_ACCESSED);

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
