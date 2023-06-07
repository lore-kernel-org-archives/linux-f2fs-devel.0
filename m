Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9A3C7EE43
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 08:55:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6oxC-0000G8-K3;
	Wed, 07 Jun 2023 08:55:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1q6ox8-0000Ff-5c
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 08:55:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oEcu81lifRnejWTt2cOqWrH1ruVsIwwlYPHLeeKCts8=; b=Ish9dST/e2CqODK2tcGDtwf2Sn
 mcUzNaeyiFbHK29/mqvcKLRnSmhKbea4+AtRa16PewpfGJmrZ8Iak2wIjJciH4qldPZrbOS48GouV
 1FCt9bt/2IefFtWp4m8UCU2b3Qvhphj0X3PbSSVVCuuSzRPz81MmKk3SBNnRRrW1xqVM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oEcu81lifRnejWTt2cOqWrH1ruVsIwwlYPHLeeKCts8=; b=Vr9QG9/Yl19DDi2M5B+sY4xuPY
 OQimd/ZRnnS78/ysMvnmr1N4L2nN/jVZZvPX3uIbV4yXNaxxp2FEwThG5zGClZscZvYEuWPwma5Az
 Filtnhslyne+SwgFV7sjydPERGt28xYNcxvlNWFGlNJZBmlNbDTJt56Ibnl9aA4HxDK8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6ox4-0004s4-Lf for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 08:55:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DAEC563090;
 Wed,  7 Jun 2023 08:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A3BC433EF;
 Wed,  7 Jun 2023 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686128128;
 bh=FoyjSRZZap6QVtk4PUjAg/56aVYmk7Q/bKSVf+qsCpE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lbLPSEzx5CHmJxbGbMCZtSL+WOgA+Ir+19+KzebHBOcStdriYooqRFCT5Z85L5SBQ
 26HQ8bhocu6wvemqw13N0fGcVjMBRXTDOwCQLDmfzOEmX7ULrDVKcbEwQ6RgCJokv1
 LwwrPIPH7Dy4Dqq3Z1/wJFPI+nCdq9XhVYQv9lER7EKMRobBVVmCazkd0VI6FPwQYd
 0aqANlbYbCCg4IAbUW/09Y1bmFZmnmzbyNy0/ajwIsz0dA7ufP/Yer8+FEBJ0alkmD
 C7h1CsWGU6uOFwKET7Igjn6D9mKWpSspjotrIzNqf/5Wvwq23wfp2KPy2h5RhLAsAf
 pjxzISbJRmiew==
Date: Wed, 7 Jun 2023 10:55:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230607-ballverlust-notstand-c4f9b36c6af4@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-18-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-18-hch@lst.de>
X-Headers-End: 1q6ox4-0004s4-Lf
Subject: Re: [f2fs-dev] [PATCH 17/31] block: add a sb_open_mode helper
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

On Tue, Jun 06, 2023 at 09:39:36AM +0200, Christoph Hellwig wrote:
> Add a helper to return the open flags for blkdev_get_by* for passed in
> super block flags instead of open coding the logic in many places.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
