Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54332C55822
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K1Wwgo1baQPq1GkAiHcIHXhoH5Q5woAdxvKtMSk1Dgo=; b=Ah9ZGAWPHHI5BT9bJArr0L/tfo
	jhSBFkmylLc3QlJSZXnc096VXoUaCdj6+6i71ZaQfCShIpBSO/p4/M1uR71FIeOgCMIvmEBPjVw3S
	+Znmwy5CUZ9+gwSc0LiHMP1M5eyhxK3VlDKLecfS8II4Ft/fka//n+U6X+FhXDfZe9x4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrJ9u-0003Fs-7r;
	Tue, 04 Aug 2026 17:42:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wrJ9s-0003Fa-CX
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 17:42:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8w/ohgcu4Mfi0ZoiQHxNZNhOBkWlBvr6z32bq2NqJjg=; b=WI3F04YxW5lyIuq0el8TTcl/L4
 Tqi7YUVGzxuVAw4cKRZTchkiPxAZb96870HwT9tjcCO8GPjIeB3bqVRNpJR8rYHR2y4So/AfsD/rZ
 CbqVBHK6pbsJ6fF966xXJca0UPOkExSY3Pe9GUp/zDG7ZC/tQ8aJJdjKZ/X/A1bkQPQc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8w/ohgcu4Mfi0ZoiQHxNZNhOBkWlBvr6z32bq2NqJjg=; b=Ml7fgkUhN5351IGmadpdzlpiD5
 cE0NPqTReGs6CRU6BxwLXsgvAt7xuVR2gdx9yWzUKsgdQ+l8TRsSHd4xEFCaKDav/in6mTnHBhi21
 xzWUzQkOuM3ngrUdJCKTN/NA61QOBKrLTQy4fvCdRN01zhB1UR8/O8bEabiIdUhPi3+0=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrJ9w-0007qD-6l for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 17:42:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7AB316732A; Tue,  4 Aug 2026 19:42:23 +0200 (CEST)
Date: Tue, 4 Aug 2026 19:42:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260804174223.GB14046@lst.de>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-6-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803200820.393203-6-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wrJ9w-0007qD-6l
Subject: Re: [f2fs-dev] [PATCH v14 05/21] fsverity: improve flushing
 performance of fsverity_fill_zerohash
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 03, 2026 at 10:07:55PM +0200, Andrey Albershteyn wrote:
> The current version calls flush_dcache_folio(), in memcpy_to_folio(), to
> flush whole folio on every digest (which is 128 for 4k) on the HIGHMEM
> systems. Open code folio mapping and flushing to copy all digests at
> once.

This looks correct, although to me optimizing for this feels like
premature optimizations not worth the ugly code unless we have numbers
to justify it.

If Eric wants it:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> +		if (folio_test_partial_kmap(folio) &&
> +		    off > PAGE_SIZE - offset_in_page(offset))
> +			off = PAGE_SIZE - offset_in_page(offset);
> +		for (; to < (vaddr + off); to += vi->tree_params.digest_size)

Style nitpick: no need for braces when comparing with simple
integer arithmetics like this.

> +	for (off = offset; off < (offset + len);

Same here.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
