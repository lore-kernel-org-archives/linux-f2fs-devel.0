Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26012CDB479
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Jun 2026 23:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Aeo2N4fvdCOayjUbQ8F6DlgaucHyZAyJWpqqsX+t2Ss=; b=Q5sg4k4AzFe9uHkvbQA3crE/0F
	P/BFBmTLSpauh9pe7kp1MW9zkLEVADzDA5VRJ0d6siaqdIddK0ccIosIyu8q2kkpwo/ZW/vO2tIdh
	Yvg5E2a2Nvnzgj8dmg6Pglq/Jk+X8niCbjhPnt8lAgQA6DStb36Do5oJcc+56jIDMFzw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcAYo-0003IW-As;
	Tue, 23 Jun 2026 23:29:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wcAYk-0003IO-US
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 23:29:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MG2chgvKp3NnapFIMPyD3yJcnZQlz6w1e1Zp8agMT60=; b=VrffJlL+9hdc4VNY5JxQOiA4ea
 PsdEteRm2XzUFOmsn/Upfyx1JIHFUiUSvNVF5PqmrrA3VE9cd0pLwICow+VG5ppIzHwpJOQqQTHjV
 rtRq59/vmsaERGu9Xg6EWzZhB5Yt+7RbhKJf0BHrsx22cwuKi8yAz9XL5GgzpU+u7tTI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MG2chgvKp3NnapFIMPyD3yJcnZQlz6w1e1Zp8agMT60=; b=K2kiGK2CkB9JIztMVGpJW9pQyw
 Qkaaf4waiIVmlrc7GaHeXPa5PllwyVrP/ok/WSyp40ogLPZS2XYeR//VYzzaBD3tipGw3AKp9QCma
 ONLJXfV7mHklkgwc86riL3zbzlFqnGIvEhOxHNcWhnYAWSrSB3h79NIs2wsWdNzHah1Y=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcAYk-0006JM-Ha for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 23:29:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 829F841A6C;
 Tue, 23 Jun 2026 23:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339361F00A3A;
 Tue, 23 Jun 2026 23:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782257368;
 bh=MG2chgvKp3NnapFIMPyD3yJcnZQlz6w1e1Zp8agMT60=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GofQy6/y8GikkwOWVw5H5BvZjXigBICa+iuINQbxMtOxZhvOT2Ls1H+bXY62xMScp
 IBNOI99ejbAtCzGAB3IorEp9ZZznV7VQoZ+Uz4EwmHsqssyJIEaUMCdoeMPlhw4LUx
 VZDXpwRqth7ttisI7nevSg4tJfBFGmBIhsGf3SnNndqSgb93wrvlkG0iX6UXaXGR3E
 14TTbmzrDGsBwmlrBpeZn2JZMBaJIZPRD8JMlX2PeqaBQMCnK58AXDLKpyx+XQW17u
 nA5DuOixt7eSEYiI8fJWOzRnPygC1m+p5Kzd4ozPK5x+9G5ptisx5a/xbqXP01gkak
 6t4u3kM2zU5qA==
Date: Tue, 23 Jun 2026 16:29:26 -0700
To: Chao Yu <chao@kernel.org>
Message-ID: <20260623232926.GA7864@quark>
References: <20260622011539.2292553-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260622011539.2292553-1-chao@kernel.org>
X-Headers-End: 1wcAYk-0006JM-Ha
Subject: Re: [f2fs-dev] [PATCH] fscrypt,
 f2fs: introduce fscrypt_finalize_bounce_folio() for cleanup
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: jaegeuk@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 22, 2026 at 01:15:39AM +0000, Chao Yu wrote:
> As part of the linux kernel's migration to folio-based APIs, introduce
> fscrypt_finalize_bounce_folio() as the folio equivalent of
> fscrypt_finalize_bounce_page(), and clean up f2fs codes with this new
> helper.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> 
> Is it worth to introduce fscrypt_finalize_bounce_folio(), then try to
> do clean in f2fs_write_end_bio() first, and then replace
> fscrypt_finalize_bounce_page() later?

I'm working on making ext4 and f2fs always do file contents
en/decryption using fscrypt_set_bio_crypt_ctx(), which already supports
large folios and doesn't require the filesystem to manage bounce
buffers.  I don't think these minor tweaks to the other implementation
(which don't actually make it support large folios) accomplish anything
useful, and we should focus on removing it instead.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
