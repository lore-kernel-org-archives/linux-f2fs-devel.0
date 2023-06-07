Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66DBC7EE2F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 09:25:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6pPk-0005st-4E;
	Wed, 07 Jun 2023 09:25:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1q6pPi-0005sn-AR
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 09:25:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ki87ibK1tm2wqzFPMXWkJl7nWoKXWybi7GQjVNJ+V5M=; b=ZjIO6bkRaa1ZmDrTOpogSEifkU
 QIg7lMsIWJoKqSvHejjt5qSR5mBLoqgbsI84wBUbIkJsAi+adXOEH0579YOLwMCLv4ngma4yXW6Js
 /RY9agB/W2wRLQogEsZRzXj+6dQnjgA/9Uzl3EJgPU0KJoueFUSzc2GYZ+Wnv/R9GKQA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ki87ibK1tm2wqzFPMXWkJl7nWoKXWybi7GQjVNJ+V5M=; b=ReDYx2pORTSR71+3KoGqERQDIA
 +G2OL++JZwNbosGKrO8Mpd6XyPndbtf4a2eI5384/ionOci/1kVj2dYLXFCHwYdkSpOlaIibcrwI8
 g+T+UJ6R17/4sU2jB0ru4xpczUDIbYmawQ0uR70IRJlRCQm6j6FGTkOpxThPYI3I7XJA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6pPi-0005qn-1o for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 09:25:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A27A160EF2;
 Wed,  7 Jun 2023 09:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA78C433EF;
 Wed,  7 Jun 2023 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686129904;
 bh=PVPEiqQnbOrHGRENvLEdaR/nzeey8b8ZshNSuWbTzrk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ALdNOSLUKbyG4MtN9g4NY65h2phNBq7vkw8myPQgpJG2PzaM8f/SVslVCmF/QOc3T
 Bwp8JuH17KAppuZAf9ArpxZTmb2lgZ7cED8j2ebPZYTj2IOo1Pq/kE6GkpjP2srCxN
 XuLDkhy5x7omz7gFdxwTAPV7lc6Gdyrkd5NATTyExP7JIaWtEnHvRju/P8W1jwC/ZQ
 pgr661S3TGnNa0/R8XJs7I9augkFB3fO/k2xICj9Rw66l5DVIPYSNCIJVnNMEfjw+Z
 gguliFEjC8Gq4dp0LyuKCQZnO9AA7rkPsqLnWoRqyaIZ4YpfwuJwZivsVp2KmUYvZJ
 O4+xhtnOR9qOw==
Date: Wed, 7 Jun 2023 11:24:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230607-verjagen-weise-4fb3d76a6313@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-31-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-31-hch@lst.de>
X-Headers-End: 1q6pPi-0005qn-1o
Subject: Re: [f2fs-dev] [PATCH 30/31] block: store the holder in
 file->private_data
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
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-nvme@lists.infradead.org,
 Phillip Potter <phil@philpotter.co.uk>, Chris Mason <clm@fb.com>,
 dm-devel@redhat.com, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Pavel Machek <pavel@ucw.cz>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Jack Wang <jinpu.wang@ionos.com>, linux-nilfs@vger.kernel.org,
 linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 linux-pm@vger.kernel.org, linux-um@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 06, 2023 at 09:39:49AM +0200, Christoph Hellwig wrote:
> Store the file struct used as the holder in file->private_data as an
> indicator that this file descriptor was opened exclusively to  remove
> the last use of FMODE_EXCL.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Feels a bit odd to store the object itself but anyway,
Acked-by: Christian Brauner <brauner@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
