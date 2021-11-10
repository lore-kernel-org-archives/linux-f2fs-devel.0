Return-Path: <SRS0=H/qu=P5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A63C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Nov 2021 19:09:10 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1080610A0;
	Wed, 10 Nov 2021 19:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1080610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mksy3-0006jS-8z; Wed, 10 Nov 2021 19:09:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1mksy1-0006jL-M1
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Nov 2021 19:09:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6/nD6RHPMbEX2XmCimwrFP17MrEDyh3byENIqq7uyKM=; b=AEvuTpub0qy/8IS+zaY46sOEPF
 fZ3J/Tfin6WAmNQ65B7DyapcV0YgfaaeblZyeC0DsOouC7lelDlCGG07bsF0IiV+hk4siYifI7Jcn
 OFWaQkt4eQWGjRxHCEfIBjPBs8NCq5AnLzUCR03yzFSamdWGDKK+Zxpkom3IHGMbBnug=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6/nD6RHPMbEX2XmCimwrFP17MrEDyh3byENIqq7uyKM=; b=VobZOVWGMg0aeOC8vRDI6CdCx8
 OZX0VyToNLAax5qN4dKQcvHMbzPLn0USxUb7F8TUp3tlQ52cyyYKLVtdoiiLrVEvxIxDyB6RVoa4R
 1RVfY5JGtsAUtQPCdEjUiDNVXmHli9vdxLNYyoE9d0MXfPSlQ5TSqgjtpxTR70OSUPkM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mksy2-0005Vv-8C
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Nov 2021 19:09:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B84C961077;
 Wed, 10 Nov 2021 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636571335;
 bh=/nlf8a6pijn/h9Jdun7z44dTvfnUp17fW2yftSoPyRI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KI2Dy0nHL566ZVbhotl37oq3zis86my26aRiwp23gDxMbYLh4CW2ATAArBqyACntA
 PdAmISJzZ4fxYBJ9UhMhAEIdM8N2kEWrA31LetW0jWXNY79LZvPU4M3B0w99rZnluf
 9+tMU62qpoEf9qc0LjufjQa8czLmCMzHeP5ldgmyE4fT75bI9bYA/B13nya1S6YmAQ
 LWXs+JOk0EB+kvsJRy3UXPk0XaVpnF0b9Ws+SPNaIUvmKiFKxIK2M5vCdEjeJ0XCzR
 1uqjWsFEHdqA4MXiiNocLTXraZWbQ83HppyRyu+HXnuptAydLfTcJIF7NTrQjPOKh9
 VqAvFrp8IrWnA==
Date: Wed, 10 Nov 2021 11:08:54 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Message-ID: <YYwYxv4s1ZzBZRtC@google.com>
References: <20211109021336.3796538-1-jaegeuk@kernel.org>
 <YYqkWWZZsMW49/xu@infradead.org>
 <042997ce-8382-40fe-4840-25f40a84c4bf@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <042997ce-8382-40fe-4840-25f40a84c4bf@kernel.dk>
X-Headers-End: 1mksy2-0005Vv-8C
Subject: Re: [f2fs-dev] [PATCH] f2fs: provide a way to attach HIPRI for
 Direct IO
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
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 11/09, Jens Axboe wrote:
> On 11/9/21 9:39 AM, Christoph Hellwig wrote:
> > On Mon, Nov 08, 2021 at 06:13:36PM -0800, Jaegeuk Kim wrote:
> >> This patch adds a way to attach HIPRI by expanding the existing sysfs's
> >> data_io_flag. User can measure IO performance by enabling it.
> > 
> > NAK.  This flag should only be used when explicitly specified by
> > the submitter of the I/O.
> 
> Yes, this cannot be set in the middle for a multitude of reasons. I wonder
> if we should add a comment to that effect near the definition of it.

Not surprising. I was wondering we can add this for testing purpose only.
Btw, is there a reasonable way that filesystem can use IO polling?

> 
> -- 
> Jens Axboe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
