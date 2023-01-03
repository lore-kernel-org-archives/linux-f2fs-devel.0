Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C87C4708E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Jan 2023 20:54:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pCoIS-0003Z2-TM;
	Tue, 03 Jan 2023 20:54:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1pCoIQ-0003Yw-MK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jan 2023 20:54:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y/BxhApXGBQSkvwGPdUVtQvXgrRE60w5clbCXLT5mVE=; b=Ra3nzFCCyDEDpn5NVZomU0/8fj
 YWOOq9Md5oNhn4kR2OFlR8dxMDjOUPH+XxuBW1xydE7UzRHPGzkBM/AGjfb+wYnvYDxFaNv+Fq52i
 Az1byzRCyQMRm6iVocXhZR6Kxr5T3FTVOBJlNz2gw3rxRmV3wzzuH+ZleVOp27i5RmhQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Y/BxhApXGBQSkvwGPdUVtQvXgrRE60w5clbCXLT5mVE=; b=UncmPu3v4ZnIFJHrOQz9iQ+MKT
 mscvWXYfZr+SnIfcDmkXrkc4i0ILIum/2HeiwZXhkdsid94QhJUqUZiWGnKVIsqrrwpFkP7Si+OJj
 3N+Xnfb8p70TEcTU/05iWtB/K3L+BuN32BBLnSVNS8zK8FtKX3TdFqIWzfJs7rUboRj4=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pCoIK-00020S-PS for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jan 2023 20:54:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Y/BxhApXGBQSkvwGPdUVtQvXgrRE60w5clbCXLT5mVE=; b=IjNwZnDcV41tbThJhvL9M6k8BE
 lfROA+iOMY+Sq/4Nn+VhiuY81mClUBXyYAFUTDrji8HX8c5kKFLwdEjX1h2bAC5mx5eVCmQJeXWy3
 Hq3ywXOCBRxCTFSx2Q1sBNqBrfPn7CQvCaJaLOKfcs4sSIJHZJFx3oMIylb39cfL3t+yx5UqGDMOr
 d47/+lED0aXpBIfLPar2Mqy4W2BHZNuWr8v3EeLNvs5myTtf2Sb95Z3Q62onzgALwxyGqP7jdEyBk
 ItAQvCiw0IVprLsCfhymyzbffRAnCprWiL5WD2+giHP3fQ9fSlPKZKBq6VV0qccyvJbjWA0JFx9l0
 /GkwhozQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1pCoI7-00EP1J-Vk; Tue, 03 Jan 2023 20:53:48 +0000
Date: Tue, 3 Jan 2023 20:53:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <Y7SV23/k39ygIj8/@casper.infradead.org>
References: <0a95ba7b-9335-ce03-0f47-5d9f4cce988f@kernel.org>
 <20221212191317.9730-1-vishal.moola@gmail.com>
 <Y5tvQKT8HWxngEnc@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5tvQKT8HWxngEnc@google.com>
X-Headers-End: 1pCoIK-00020S-PS
Subject: Re: [f2fs-dev] [RFC PATCH] f2fs: Convert f2fs_write_cache_pages()
 to use filemap_get_folios_tag()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 "Vishal Moola \(Oracle\)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Dec 15, 2022 at 11:02:24AM -0800, Jaegeuk Kim wrote:
> On 12/12, Vishal Moola (Oracle) wrote:
> > @@ -2994,13 +2998,38 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
> >  		tag_pages_for_writeback(mapping, index, end);
> >  	done_index = index;
> >  	while (!done && !retry && (index <= end)) {
> > -		nr_pages = find_get_pages_range_tag(mapping, &index, end,
> > -				tag, F2FS_ONSTACK_PAGES, pages);
> > -		if (nr_pages == 0)
> > +		nr_pages = 0;
> > +again:
> > +		nr_folios = filemap_get_folios_tag(mapping, &index, end,
> > +				tag, &fbatch);
> 
> Can't folio handle this internally with F2FS_ONSTACK_PAGES and pages?

I really want to discourage filesystems from doing this kind of thing.
The folio_batch is the natural size for doing batches of work, and
having the consistency across all these APIs of passing in a folio_batch
is quite valuable.  I understand f2fs wants to get more memory in a
single batch, but the right way to do that is to use larger folios.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
