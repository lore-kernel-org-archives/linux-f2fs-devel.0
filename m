Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A76C7EE43
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 08:35:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6odn-0005rG-E3;
	Wed, 07 Jun 2023 08:35:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1q6odl-0005pi-BM
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 08:35:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q1zi33mYG6E/159otUyBGkZR4XWOgH+qMjpUmfk9u5o=; b=Gl7BaII+jI43fKsRTCi/1Hlnjt
 io2i2z+K60/PyhnUNsVm0vqsM5BkKQx25UJ+SiH5Q1pdytOsg0BC5bOAuPfcimgEC9xssFFDeJsk8
 9sWpuLq576656sYDwfxTpLRw7ukwO+Nj3Ny53vm/0yc5guGijCfPlSS1dELysosJRnvY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q1zi33mYG6E/159otUyBGkZR4XWOgH+qMjpUmfk9u5o=; b=b5VkIzdSlPEWs44irdKslbNACG
 fER9NSRGKzHzY+AyhT0H3HJVVsnzvf4n8HoGv8Xo9JLk9BSKM8roGcTLncyPsdOKg3J84DfWpzQVe
 GilFgxaGESuewyEtb3QbLVjqEwymkmEn7yb+cx2pVcT9tHsOi5xEaq0dCyfkJr6djOjE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6odk-0003XD-Op for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 08:35:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5D1CB63C51;
 Wed,  7 Jun 2023 08:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78533C433D2;
 Wed,  7 Jun 2023 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686126931;
 bh=OMT81Nj+03/UUqXvR/WATI3J1MFOVo+i3KL8UfpdkEc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cXORTW2prZhLBaGAe7/mLRmhhTZvaBHSnzVd0HFARKJDQ62eKOG4Kzb7xZlfPL9nO
 97zwfyA/DQztpsvm9grNPGz7haRUOQZrQturaW0SFSa0uosZB40SJST0dXmizK2H91
 Vrg9ubXMdO+Gt6gYl3oFWyWVhTdUtfr7NIIdvz5ZfTiIhubmxyIDaIzXV3KgUyxjww
 GcTRPH6U8lSPzfLUWbreqgZvDgNSFImMLsmVidpwIncpJKPPhhlshVQd4J7rrP6eJV
 7nFr4sqb1S0ehPF5Xwg1baPwzoSZ6HowqC26ZK1aX2UPURtsR/Sx1T5MKoxTEoav5Y
 AB2Mai1SAj/KQ==
Date: Wed, 7 Jun 2023 10:35:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230607-renovieren-getier-8fba2cb1185d@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-12-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-12-hch@lst.de>
X-Headers-End: 1q6odk-0003XD-Op
Subject: Re: [f2fs-dev] [PATCH 11/31] block: rename blkdev_close to
 blkdev_release
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

On Tue, Jun 06, 2023 at 09:39:30AM +0200, Christoph Hellwig wrote:
> Make the function name match the method name.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
