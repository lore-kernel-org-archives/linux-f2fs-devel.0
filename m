Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9388CD5BAF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 May 2026 04:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=34XQ7y6gOrGqCU0dh1UYqSa1608Q9V3xPjsXnpGv87I=; b=AzY7U0K6TeTLMwJWesIyGHjIpW
	+nEtuytjFHmuhul0deFXNbUzNCKRbNjyp1wevzXc+CQL65gpAG1TL8qsaEWNSAX73fAXZRbUgKwVq
	4m4UG4UA4a3a5BICB1HMwSP7Y09TQUdUYk/x2MSDCXkeZJ1mX43p3CfQS5xWGJ8koXG4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQHNS-0007l3-Ud;
	Fri, 22 May 2026 04:20:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wQHNR-0007ku-BG
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 04:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AuDebTp9wF0S/Xn282lC6vcJ0n88XySW4ZxE0I84xZc=; b=dj+2xtSWX6Q/WqjdArcW2tg8CA
 c/I8SFaNmwLeGSNza9c9XBz6YfGHxUuTXWUIHmJ3EgZXzRBnupuiPCUiQEq/tH0Vc9J4CyEqwH4+p
 SN3Sc72OEpnHgXriSLY93B5POd+q+aqDyLl/EZAaXJa+vcqZ817E+cTjPGnLnvTb2Zd8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AuDebTp9wF0S/Xn282lC6vcJ0n88XySW4ZxE0I84xZc=; b=ADIfqkEyQgwNx7nFea5n9VMj9o
 PjVcxoOgoIWHulLyu8Ju3jUoJaeFrO2GpSGdON9qlqUDeHW6ooa6flZH3k8QaiuY+hlaSppbHcIvd
 kZINQwjoHtr4ST/hup/uNfFV9L5MI0Ol+6UuUHb+y0irOANXQBCYUsmB7RfWjRC1YFhM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQHNN-0006wh-PI for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 04:20:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9FD2D60138;
 Fri, 22 May 2026 04:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216531F000E9;
 Fri, 22 May 2026 04:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779423635;
 bh=AuDebTp9wF0S/Xn282lC6vcJ0n88XySW4ZxE0I84xZc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dvvB9zuAFepo3DHpMkWgqI60W2yhMhSg+mzRgM6P7piG79MnWnXXbWceTEI0tWUop
 AufT/oPAJadaJA7sk2Ta+p66F0bM/gj3OID4REL85XY738izVf+d/RJ3O1XZASEUlb
 iLJW3ORg4zLDYCqi3su/SJn87hHIQU8Qwb3m5KAY21D45+W+3yZPYkTjnWifpf7OZD
 9nznJ2UDG4HnOd+HwNHvk68xlcma439jfJQi8r9UegwSlC/jxmya1rsE5h4Dr6fCpZ
 SYW2xXSuWX/bMWHBcJEPptwrrABPIFzgn/eO3koct41PLwGxOrhrO5fpHEtaETA0T0
 syvx2XA1RNThA==
Date: Fri, 22 May 2026 04:20:33 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <ag_ZkRNeMqSf8sSb@google.com>
References: <20260520095204.1175117-1-qwjhust@gmail.com>
 <39c59d05-c998-456a-afae-1eee7379a04c@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <39c59d05-c998-456a-afae-1eee7379a04c@kernel.org>
X-Headers-End: 1wQHNN-0006wh-PI
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix missing read bio submission on
 large folio error
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
Cc: Wenjie Qi <qwjhust@gmail.com>, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/21, Chao Yu via Linux-f2fs-devel wrote:
> On 5/20/26 17:52, Wenjie Qi wrote:
> > From: Wenjie Qi <qiwenjie@xiaomi.com>
> > 
> > f2fs_read_data_large_folio() can keep a read bio across multiple
> > readahead folios.  If a later folio hits an error before any of its
> > blocks are added to the bio, folio_in_bio is false and the current error
> > path returns immediately after ending that folio.
> > 
> > This can leave the bio accumulated for earlier folios unsubmitted.  Those
> > folios then never receive read completion, and readers can wait
> > indefinitely on the locked folios.
> > 
> > Route errors through the common out path so any pending bio is submitted
> > before returning.  Stop consuming more readahead folios once an error is
> > seen, and only wait on and clear the current folio when it was actually
> > added to the bio.
> > 
> 
> Cc: stable@kernel.org
> 
> > Fixes: a5d8b9d94e18 ("f2fs: fix to unlock folio in f2fs_read_data_large_folio()")
> > Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> BTW, I can not apply the patch, can you please rebase it to last dev branch?

I applied.

> 
> Thanks,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
