Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC08C4451C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tK0j+6N3lFoHAzgb7h5YPm2psqTiOEoW81GZtisO+Z4=; b=h51i7RtgyelOtr8fmGhCo7UpWt
	kPuMcTMpD2eujHeEmvDEvgZ5/s3uC1p+faXUQrYYjoh4oFf+2afo0aHp0E1LpcXDjMtH2HR2PV0VC
	SCXJsbl2dAs6y0gTSUidQDjc25W0rJtDHkD+CZlZcQRiIpYl4j54qh0PC3+mBqMh8lrE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wm681-0004QU-0W;
	Tue, 21 Jul 2026 08:47:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wm67f-0004Q4-AA
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 08:46:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0yqMpnEPq/L5fm2o1Ao627XzVu2ee0Fggb4NXRXVeyk=; b=REDcs311Qymoi0LU+csP/WM0jC
 HzygbCvt8U3syg3lTGkBlBBFrSQQQiFQeSh1o1PMQOrB79+n44rQPryPidzhIMCa3rxFETt4ReU6p
 LvU0lPYzHR+rirrEpq19hdLgsQ0rB/NssuMaQ07nlnc7f1LmWbnBFPImMdtiJElDXum8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0yqMpnEPq/L5fm2o1Ao627XzVu2ee0Fggb4NXRXVeyk=; b=UbU72yIFSlY3CzUUr4kGzLxUz/
 pJZcKX7csXWKFDBYKUxNzg80KYslZCBoxvtsyftArpOb9lxT/KdLakVEswsUtUgnHBnObJSf+9MRU
 wiJvL+oqgKnUaxDDC36zY1cc8hPX46qkw//FI/DFHrBZ0/U/SA353sgcK+XdtBLgb08s=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wm67e-0007ZS-Es for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 08:46:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C6B9C60A95;
 Tue, 21 Jul 2026 08:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CB71F000E9;
 Tue, 21 Jul 2026 08:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784623596;
 bh=0yqMpnEPq/L5fm2o1Ao627XzVu2ee0Fggb4NXRXVeyk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JAGHzQ186uP7n0APk7n0/dFNl53i20DQGB7zCh1e4q6hsDp040OKtMlwF7pGod4gr
 mXDZ6vU71e+hARgwbAqWmFqiIMex4OFZvYZpUZUBc6EsxGLKjJlHVNPcB9vnwWWo/p
 ABrG+EK/zKTxOrneMzZ4u1b1u4P9ltDhR+OmNv+UxZm79TGfalwpcAFGq7nnkOA66G
 k1nwuOvRK6lkWKaOE5qJs2da+htRdIeHEbaqKlo4VpG+gkp8FkpFCWOYOPTnStyb7g
 zFmFKghqldrp04le1xoxqVIslwuG94YSwevSg1YQxTW5RXRD1tKiGI5tAHGqbWm5tm
 iLyhvhu0tc2+Q==
Date: Tue, 21 Jul 2026 10:46:31 +0200
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Message-ID: <al8xgOwueDOzGakK@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260720090410.3487990-1-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260720090410.3487990-1-aalbersh@kernel.org>
X-Headers-End: 1wm67e-0007ZS-Es
Subject: Re: [f2fs-dev] [PATCH v12 00/21] fs-verity support for XFS with
 post EOF merkle tree
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: djwong@kernel.org, david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I will send v13 shortly with more sashiko.dev fixes. I run these
AI reviews locally but model is not that good.

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
