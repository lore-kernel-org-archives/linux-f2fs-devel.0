Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43AAC53215
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=43mvinwRKhgUww39ApXUABptxA0SsPSnvWOu0zGazmE=; b=O+gvqPLPfuKDATAu2EyJcy7+Nk
	0ltuNaaJQrxv9hXCi+Za4sJbCh2FVIcLUkHoTMd9kWLLOoWfmk2juvaZVe2WRhJALUKJhE3GJiwCE
	ajxLYwHLWoNtEsftXnwPnr0GfbFXCYtFbiYug8UPwkGQZxPEGQbhKmegE+lIzyfnEyUI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnHdg-0007xq-Uf;
	Fri, 24 Jul 2026 15:16:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wnHdf-0007xc-LM
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:16:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yo68qjongadB1GZqXZprYtsFAZFHbGPoQ+5S7vlZ7+E=; b=UbVaoGa3yOUYJnaUcIfq3ihAWw
 RJHv5+gJ0gduHjalTfYNfaMOfBBGBd8o5hUs/7YjV96LaTWU+C4I167wzcjTO4vwnYIwqipQTsL/b
 9uzT8Ivxq4AfXqNjj8O/DYXvAPiotl2dWv6WuEuZa1w16FlSGso8ymsNzRj0PCzXpaDs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yo68qjongadB1GZqXZprYtsFAZFHbGPoQ+5S7vlZ7+E=; b=UDS3dD2m4ifWt91gJjHTENEE+e
 QgYBpsXpa/GauhtbXs8KnaSMWDKxHfY7nUUzeX2YjyfG60r0iMsjSrfYRVDit4A1SuIXvMxLyRyp0
 NFvO3SU5wZPHlV8UgpOb2RzJYkvri/XItKuszlV9w5MzF2C6Acni125ZV1/t1NgMe0M8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnHdj-0003wv-C2 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:16:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 51857600AA;
 Fri, 24 Jul 2026 14:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47191F000E9;
 Fri, 24 Jul 2026 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784902899;
 bh=yo68qjongadB1GZqXZprYtsFAZFHbGPoQ+5S7vlZ7+E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bfqTKrQZoghsWVyi+N3a1tMHl+uOYqNHFzxanWJM5XT8Mq2ua1dbXs6VjffBJc6e3
 2Y7FwpnYv0gSI+QpfA+4acSlm/1QRI7FGdDk6a5rxjF8/XLwwhSeuWc9fPOOOdVtFe
 gZZQDpxnXCzr9T4B3SYJVw/5u+3ZMaNuBqx3Tc/PhS2+aKgh+2/7wx4Lu6bnQRTyXn
 IGRh1YpWIYvZZEaZWi7IYYopm8m98ahUlSEuubXPt4gn9xl5I1AbSCVZRXc9E7hqCO
 KeTAaDc8Mf+HRtHgNnIYv/+HDtzAr8N+bAbN3sMBDGLyKAoNheQebkE8aJT5SSv15S
 XlX7BYRPjj5Ow==
Date: Fri, 24 Jul 2026 07:19:47 -0700
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260724141947.GC1876@sol>
References: <20260721184346.416657-1-aalbersh@kernel.org>
 <20260721184346.416657-7-aalbersh@kernel.org>
 <20260724131353.GB27878@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260724131353.GB27878@lst.de>
X-Headers-End: 1wnHdj-0003wv-C2
Subject: Re: [f2fs-dev] [PATCH v13 06/23] fsverity: don't allow setting DAX
 file attribute on fsverity files
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
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 djwong@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 24, 2026 at 03:13:53PM +0200, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Shouldn't this have a fixes tag and go into -stable as well as it already
> affects ext4?
> 

ext4 already checks this, as I pointed out before
(https://lore.kernel.org/linux-fsdevel/20260710234643.GF1911@quark/).
It would be good to note this in the commit message...

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
