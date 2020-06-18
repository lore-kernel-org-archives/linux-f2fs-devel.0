Return-Path: <SRS0=lp92=77=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAE1C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Jun 2020 18:14:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81537207DD;
	Thu, 18 Jun 2020 18:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Uy3DG79Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="CO55k892";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj44c8BD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81537207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jlz3I-0007OB-RH; Thu, 18 Jun 2020 18:14:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jlz3H-0007O4-JM
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jun 2020 18:14:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H190nc5plzyOtod2z8roe5vwvKpfYdIrcYj0utOvDAw=; b=Uy3DG79QQnziynCYLIPd8ZAPHH
 IV2wgUlLFwN+szfg2xP4IfukJRzUAnOcO7xVpKuenq9o9g9tesK0rgrF+bxif3WvUlRDOmZTPhNm5
 lccynWrTUE+/iRmPaQFaOhdrsoe1D1U+Q/Rs2FqAGvcNnkVwzC5FGAyiBzVmP6BOR+uU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H190nc5plzyOtod2z8roe5vwvKpfYdIrcYj0utOvDAw=; b=CO55k892q8WI0niqRiGv/zogNz
 pIgU5z1GkAXmomA721EeinD2gMKbBam1tvRYDa3bWJ2HmiqDbVOl+bC+lxfH7kHCPmR9ZpQF6jOkv
 Rh8ORiACI0Zfrr7g8gmdpnAwudCKrf/VKg2H7ohEjlRgG+p+v0U/OoDS0nCBwpgO4E5E=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jlz3D-0082UK-8K
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jun 2020 18:14:15 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7B07B207DD;
 Thu, 18 Jun 2020 18:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592504038;
 bh=bwNYqgDUO017MhDp1XZiVpKnHtAB2QtXNRfOAYLMONc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nj44c8BDwdwmj65JkoVS7rOTVPn0mr7uCVkNf9JjQIUmN1TkxqZsq8p9c/xPrAllH
 1fQ5ghO5VRsv0ISAMty3/l8dm+CnP14pR6qAK5LfXlE8bhRsRzR7dUM1T+8sIbmv+w
 I3wY+qmuCvXhbP18xDxhx5u/HRrxT2uha+9wwD64=
Date: Thu, 18 Jun 2020 11:13:57 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200618181357.GC2957@sol.localdomain>
References: <20200617075732.213198-1-satyat@google.com>
 <20200617075732.213198-4-satyat@google.com>
 <5e78e1be-f948-d54c-d28e-50f1f0a92ab3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5e78e1be-f948-d54c-d28e-50f1f0a92ab3@huawei.com>
X-Headers-End: 1jlz3D-0082UK-8K
Subject: Re: [f2fs-dev] [PATCH 3/4] f2fs: add inline encryption support
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

On Thu, Jun 18, 2020 at 06:06:02PM +0800, Chao Yu wrote:
> > @@ -936,8 +972,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
> >  
> >  	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
> >  
> > -	if (io->bio && !io_is_mergeable(sbi, io->bio, io, fio,
> > -			io->last_block_in_bio, fio->new_blkaddr))
> > +	if (io->bio &&
> > +	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
> > +			      fio->new_blkaddr) ||
> > +	     !f2fs_crypt_mergeable_bio(io->bio, fio->page->mapping->host,
> > +				       fio->page->index, fio)))
> 
> bio_page->index, fio)))
> 
> >  		__submit_merged_bio(io);
> >  alloc_new:
> >  	if (io->bio == NULL) {
> > @@ -949,6 +988,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
> >  			goto skip;
> >  		}
> >  		io->bio = __bio_alloc(fio, BIO_MAX_PAGES);
> > +		f2fs_set_bio_crypt_ctx(io->bio, fio->page->mapping->host,
> > +				       fio->page->index, fio, GFP_NOIO);
> 
> bio_page->index, fio, GFP_NOIO);
> 

We're using ->mapping->host and ->index.  Ordinarily that would mean the page
needs to be a pagecache page.  But bio_page can also be a compressed page or a
bounce page containing fs-layer encrypted contents.

Is your suggestion to keep using fio->page->mapping->host (since encrypted pages
don't have a mapping), but start using bio_page->index (since f2fs apparently
*does* set ->index for compressed pages, and if the file uses fs-layer
encryption then f2fs_set_bio_crypt_ctx() won't use the index anyway)?

Does this mean the code is currently broken for compression + inline encryption
because it's using the wrong ->index?  I think the answer is no, since
f2fs_write_compressed_pages() will still pass the first 'nr_cpages' pagecache
pages along with the compressed pages.  In that case, your suggestion would be a
cleanup rather than a fix?

It would be helpful if there was an f2fs mount option to auto-enable compression
on all files (similar to how test_dummy_encryption auto-enables encryption on
all files) so that it could be tested more easily.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
