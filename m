Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CD2CE7B0C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Sep 2024 16:05:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1smbSE-0008FA-DL;
	Fri, 06 Sep 2024 16:04:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kbusch@kernel.org>) id 1smbSC-0008Ez-9K
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Sep 2024 16:04:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ThA79az8NKAEabW/GDtVqKt0NHUnbwrAb/R6DxsJ2pA=; b=CtZl1F2x+glMBX5mv4cqPWYrlU
 vPBPnAVY6Jvgubf2llO+8JrUbbzCjZNp5Jofo87EFxM2QZjpl51v48qQH7q7YyJCRRTkUyljrGS6x
 3POj4AHbPO1P/LvhUBit3WcTudHjiw0Mhpf7agKOwHQFvsu8qZ8EVXZSTeLMT8bVzK80=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ThA79az8NKAEabW/GDtVqKt0NHUnbwrAb/R6DxsJ2pA=; b=h8cpFkAsa9tXQdERmyAx1f8KgN
 ymDuYBQbMvRffIRBme8hTtJ2AznPTktP/Xfpf/JvYptrndETYWhc0WvsLJF5e6H0bt/ZbNvz1G0eR
 oNOAcNtAeuhNNJvL+Di057uDNlpdyCQJ2EeH2y4yhuD2+vgElYyCaRNDzoOe2v2dOEzA=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1smbSB-0006lb-KG for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Sep 2024 16:04:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7D9E9A450E2;
 Fri,  6 Sep 2024 16:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE2BC4CEC4;
 Fri,  6 Sep 2024 16:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725638684;
 bh=BZenlBD2N8AAYL+2OT/3WcZoQCY+AVCkF1sXui4p35Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F44be4vDFLCx4ewpp8POzx1WytGmpAJBWrkhnXMOdWZdPJlVz2kRfiKwhdznK2HDH
 opmZNx1MGv+Ot9ffc1C52s2VRqmwR1+Of+AjJCAtAsF+gcLYZb+hD3RDiO0gqApc2n
 2JpJCk/LkxV87d0eg/d63pqJaqhdDEIoFol1Z3x6rv1c+GMZVnl/XYM3RYvUcgFctx
 IvltQxB3DnHjdi0hAXGlcKUCrn2he5m85TiQGBZlJG0mzCOc5NB1zzf6swc/B8xPHQ
 bY+Xs9ZajwrORdx1JJQ1VQ2A+66EAIwjagZueN9BKO2sRMv6zySdjZ6i6wCYCU99LP
 59fLRfoE1AW3w==
Date: Fri, 6 Sep 2024 10:04:41 -0600
To: Kanchan Joshi <joshi.k@samsung.com>
Message-ID: <ZtsoGX2QY-TjBolb@kbusch-mbp.mynextlight.net>
References: <20240826170606.255718-1-joshi.k@samsung.com>
 <CGME20240826171430epcas5p3d8e34a266ced7b3ea0df2a11b83292ae@epcas5p3.samsung.com>
 <20240826170606.255718-6-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240826170606.255718-6-joshi.k@samsung.com>
X-Headers-End: 1smbSB-0006lb-KG
Subject: Re: [f2fs-dev] [PATCH v4 5/5] nvme: enable FDP support
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
From: Keith Busch via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, brauner@kernel.org,
 jack@suse.cz, sagi@grimberg.me, martin.petersen@oracle.com,
 Nitesh Shetty <nj.shetty@samsung.com>, gost.dev@samsung.com,
 jlayton@kernel.org, vishak.g@samsung.com, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, James.Bottomley@hansenpartnership.com,
 chuck.lever@oracle.com, javier.gonz@samsung.com, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 Hui Qi <hui81.qi@samsung.com>, hch@lst.de, bvanassche@acm.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 26, 2024 at 10:36:06PM +0530, Kanchan Joshi wrote:
> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
> to control the placement of logical blocks so as to reduce the SSD WAF.
> 
> Userspace can send the data placement information using the write hints.
> Fetch the placement-identifiers if the device supports FDP.
> 
> The incoming placement hint is mapped to a placement-identifier, which
> in turn is set in the DSPEC field of the write command.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Hui Qi <hui81.qi@samsung.com>

I'm still fine with this nvme implementation.

Acked-by: Keith Busch <kbusch@kernel.org>

The reporting via fcntl looks okay to me, but I've never added anything
to that interface, so not sure if there's any problem using it for this.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
