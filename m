Return-Path: <SRS0=CXlU=4H=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D76C3402F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Feb 2020 03:10:54 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CA724658;
	Wed, 19 Feb 2020 03:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fuqv1vhc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="TYyO89Wf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xohwgk2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CA724658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j4FlG-0005MR-8m; Wed, 19 Feb 2020 03:10:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1j4FlE-0005MC-Q3
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Feb 2020 03:10:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T0QyU29cAbySRxZqthN3ac8NaPJxOdzZN/Pa62Y5nQ8=; b=fuqv1vhcLaI8Goh3/+gBGin0ap
 1swK8PoJ7xWGafz6SVM6umcL5WL0GL4CU04Otr2L+eqsD9FkjA3qjS5/xCup6fZbQomgzIoPNAvmS
 XvRBft+md6ZyZTtQUe29SZwJFirh+9nhGR9Uj0x9fKsTvdf/E3z1YGapRudCyvYkD5E0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=T0QyU29cAbySRxZqthN3ac8NaPJxOdzZN/Pa62Y5nQ8=; b=TYyO89WfU1GlXkhynU+0ViUbQq
 9exEJCCoHtSbxGswjgkY3Hhd2BlUPRbwGNLIbZPeQbmEewG/+JXHOJU+EJbFBUfaLLd1VmDO8m3qf
 QanQTxllgMs6lWvHwY8/YlKio1Bf5e+P+2Nk4PJOKZmILehGvpi8ZwjgIEjh98VoTIu4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j4FlD-00H9qq-Nu
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Feb 2020 03:10:52 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C25D02176D;
 Wed, 19 Feb 2020 03:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582081846;
 bh=+z7KkP//J/UyJ36xlsIoqcFUH/Jfs5y+BREf1Vh0pOQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xohwgk2QG5tvLYMrLa5W6KYoeoixjneJ8R68r7nk/sL00PH6Wcz+epEQQXtUSH/SY
 dwE777Hz4Bn6KBu2rtmu5FImDWOhXEfHmk622/WQkEj14uuWbvkMxoOMJo59Ka2mcn
 wgYL1H+yiSctZQzbmYXGu4bWezIpNQUGBp3ZkGP8=
Date: Tue, 18 Feb 2020 19:10:44 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200219031044.GA1075@sol.localdomain>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-14-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-14-willy@infradead.org>
X-Headers-End: 1j4FlD-00H9qq-Nu
Subject: Re: [f2fs-dev] [PATCH v6 08/19] mm: Add readahead address space
 operation
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
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Feb 17, 2020 at 10:45:54AM -0800, Matthew Wilcox wrote:
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 7d4d09dd5e6d..81ab30fbe45c 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -706,6 +706,7 @@ cache in your filesystem.  The following members are defined:
>  		int (*readpage)(struct file *, struct page *);
>  		int (*writepages)(struct address_space *, struct writeback_control *);
>  		int (*set_page_dirty)(struct page *page);
> +		void (*readahead)(struct readahead_control *);
>  		int (*readpages)(struct file *filp, struct address_space *mapping,
>  				 struct list_head *pages, unsigned nr_pages);
>  		int (*write_begin)(struct file *, struct address_space *mapping,
> @@ -781,12 +782,24 @@ cache in your filesystem.  The following members are defined:
>  	If defined, it should set the PageDirty flag, and the
>  	PAGECACHE_TAG_DIRTY tag in the radix tree.
>  
> +``readahead``
> +	Called by the VM to read pages associated with the address_space
> +	object.  The pages are consecutive in the page cache and are
> +	locked.  The implementation should decrement the page refcount
> +	after starting I/O on each page.  Usually the page will be
> +	unlocked by the I/O completion handler.  If the function does
> +	not attempt I/O on some pages, the caller will decrement the page
> +	refcount and unlock the pages for you.	Set PageUptodate if the
> +	I/O completes successfully.  Setting PageError on any page will
> +	be ignored; simply unlock the page if an I/O error occurs.
> +

This is unclear about how "not attempting I/O" works and how that affects who is
responsible for putting and unlocking the pages.  How does the caller know which
pages were not attempted?  Can any arbitrary subset of pages be not attempted,
or just the last N pages?

In the code, the caller actually uses readahead_for_each() to iterate through
and put+unlock the pages.  That implies that ->readahead() must also use
readahead_for_each() as well, in order for the iterator to be advanced
correctly... Right?  And the ownership of each page is transferred to the callee
when the callee advances the iterator past that page.

I don't see how ext4_readahead() and f2fs_readahead() can work at all, given
that they don't advance the iterator.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
