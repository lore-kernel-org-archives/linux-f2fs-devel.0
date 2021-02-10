Return-Path: <SRS0=VeSi=HM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25EDC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Feb 2021 18:01:59 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BBD64ED0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Feb 2021 18:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BBD64ED0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1l9toH-0007RK-Vl; Wed, 10 Feb 2021 18:01:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1l9toH-0007RE-D9
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Feb 2021 18:01:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tJ5PMP/cZNHQgkZf8Cwv7kk92m9a0H0un3j8S1+uVjI=; b=bV8pwYC293doiGShiaQ99iwQkR
 u5E5bLUQcIA7+1r5RYn3Q9w/J0mMY4ONjPIpUFQOiOQzbeZeilQJ65XD9XXn/GwAM7JJ9vpUBIXSj
 BHtBqOQLcChsoN4tsnMixJEWjtPQkmZYQ3RkA4jiRnTBY1VvLyf/b5k9HvayG7qetqlk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tJ5PMP/cZNHQgkZf8Cwv7kk92m9a0H0un3j8S1+uVjI=; b=gbqlBglNOF0jmDUQnOtn8jGH7j
 am0cf0sxsUA88yePJQdJmNSnTSMj/Nz3OQDlGl7ifpKNBwGNFyYQ0RX1HK49gA/sMmon+bmyZvc/h
 tQv/wCEQiXlrlbdqcd0ux71PghOtfLqVu2af6CPP8wDc3ufuQ9vpI9FAARarGaGjl6lE=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1l9to6-00085D-Sj
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Feb 2021 18:01:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C52B064DB1;
 Wed, 10 Feb 2021 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612980097;
 bh=Iudm1YPyBEuC3zsZbxFFEccmpFqohJdXbI1ik4Yv3hA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pPiT+PDAgEjsKzfsSkjSdc3SyTSYJczkvJZfDsvbkTjdsAappNeeowXVDm7c1ZfmW
 3NgRp/xNq9/vvx0MDSPwae/Pfwez3sdYXSGjB0mCQkXM9WpavXDncCN6o2jipPHrkh
 pPEd180S5qsSzBPfz3fKC18D0hy77ZQxdyct1n52BN5I8khJ6pUwIDDeMNWPNTSyHP
 vOcM8LkFe/dcdgCmlMesbTdwTfCCAbI+C7qAlMPOm0Ji98dsDjtzuQc6XBV4RIX068
 d57a0sEgyuKYO3ED/HADo5fFMtpOHocdukCHHQdd6AMMhsflHe5N6qXPTVqUly+fme
 RzYAo2VodoOwA==
Date: Wed, 10 Feb 2021 10:01:35 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Message-ID: <YCQff/XYAqDUXhhQ@sol.localdomain>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
 <20210207190425.38107-9-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210207190425.38107-9-chaitanya.kulkarni@wdc.com>
X-Headers-End: 1l9to6-00085D-Sj
Subject: Re: [f2fs-dev] [RFC PATCH 8/8] f2fs: use memcpy_to_page() in
 pagecache_write()
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
Cc: axboe@kernel.dk, hch@infradead.org, damien.lemoal@wdc.com, tytso@mit.edu,
 bvanassche@acm.org, dave.hansen@intel.com, johannes.thumshirn@wdc.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 clm@fb.com, adilger.kernel@dilger.ca, dongli.zhang@oracle.com,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, dsterba@suse.com,
 linux-ext4@vger.kernel.org, ira.weiny@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Feb 07, 2021 at 11:04:25AM -0800, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

No explanation in commit message?  There isn't much explanation needed for this,
but there should be at least one sentence.

Likewise for the other patches.

>  fs/f2fs/verity.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
> index 44e057bdc416..ca019685a944 100644
> --- a/fs/f2fs/verity.c
> +++ b/fs/f2fs/verity.c
> @@ -79,7 +79,6 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
>  				 PAGE_SIZE - offset_in_page(pos));
>  		struct page *page;
>  		void *fsdata;
> -		void *addr;
>  		int res;
>  
>  		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n, 0,
> @@ -87,9 +86,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
>  		if (res)
>  			return res;
>  
> -		addr = kmap_atomic(page);
> -		memcpy(addr + offset_in_page(pos), buf, n);
> -		kunmap_atomic(addr);
> +		memcpy_to_page(page, offset_in_page(pos) buf, n);

This is missing a comma between 'offset_in_page(pos)' and 'buf'.

Otherwise the patches to fs/{ext4,f2fs}/verity.c look fine; thanks for doing
this!

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
