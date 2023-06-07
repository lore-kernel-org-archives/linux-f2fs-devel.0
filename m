Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2642AC77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 08:14:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6oJf-0004nM-5m;
	Wed, 07 Jun 2023 08:14:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1q6oJa-0004nF-To
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 08:14:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=idJYnJNs8X8blppL3OUvXfKqnI3BgYcWWssYBP5ZnTI=; b=k08s4LNa9+3Yq/mY6/3p1i0/6l
 EcG3sw6PylX8lqucYK6RP80XNx1dPhZwSKQjmaVFmHWkH2JHgEz+fJrR1GqKIzRfz8C7wOmpUGqdO
 tA6/GLrnO1sWh52UVXouXqaSFQ79gw8/BQy75/b6gIUN0R0HRyalKhEfdubzWeUl4VWo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=idJYnJNs8X8blppL3OUvXfKqnI3BgYcWWssYBP5ZnTI=; b=TIRz2T62/iIK3EhvSIRaLBlL7u
 gBOjmeOzklq/hWzBxqXTU3GlVwF3FfPQRvTBeeuK2XJQQYZY45N2GOvl2NCcfK3V5Qeas5OO232Yd
 phqhDaTH5CAI4l3UBilRbrPmYVTiUpVE4Z2nlwdMXN0uX8VbqGyuDk/lyTTaA9vUf7vw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6oJT-0002Ky-22 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 08:14:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3FBA863894;
 Wed,  7 Jun 2023 08:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DB1C433EF;
 Wed,  7 Jun 2023 08:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686125670;
 bh=OikN0V0gAjgBP+HPzDoTzlQuNrCoReKL8FDM6o8SWL4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LoOtwMsbiODoiTDBOlhy9h+NcaXo/0ty0ho40m0mYf7Tqj+wr2dJZ7vUbOn0Kz7GP
 33AzVbFt/SH4ZtCqtGcyP4wx2pNr5qeOSz7n5llnvQzbkevHbUBwUChjs8tVFu+w+7
 9qFZdhkREWPfruOfyuYqVKvgknYU35bmYym5jzuvpMGmp93SMTqsZWFeVhyuiwJkrs
 LAwyIzU/+kVumnYrd9shzRES4ZrZYHJo9QZXt+wC4ujn3BMrp977Z7B0LOqc0LVlBz
 8OgzOnLLMWqPSlcCNiFoGKY+/fwNpasAfTm2ssRASquxyIwPgu3PSIm5oXJID8PKnw
 l3rqMIfCwdUgQ==
Date: Wed, 7 Jun 2023 10:14:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230607-behelfen-abnormal-8ccf8e1e99c9@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-2-hch@lst.de>
X-Headers-End: 1q6oJT-0002Ky-22
Subject: Re: [f2fs-dev] [PATCH 01/31] block: also call ->open for
 incremental partition opens
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

On Tue, Jun 06, 2023 at 09:39:20AM +0200, Christoph Hellwig wrote:
> For whole devices ->open is called for each open, but for partitions it
> is only called on the first open of a partition.  This is problematic
> as various block drivers look at open flags and might not do all setup
> for ioctl only or NDELAY opens.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

This assumes that all drivers deal with additional ->open() calls for
each partition correctly which I assumed you checked so,
Acked-by: Christian Brauner <brauner@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
