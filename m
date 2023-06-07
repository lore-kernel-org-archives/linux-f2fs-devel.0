Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39853C7EE2E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 09:28:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6pSS-0004Tc-8n;
	Wed, 07 Jun 2023 09:28:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1q6pSR-0004TW-S4
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 09:28:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O+hcUcDfgstfOiV+FTBV2u5q1ErUaRIB5WUQos9T42I=; b=nEt+N+M1Yxt+Ql1lKha8bsP0VM
 4LyLelPmWjn7IsXBZtOTs8lI7Wf56TopboG8hmDPSZdJmYfGCBPF9/CSjgxFIFCpoIJgl4hdvy/+S
 w4uAx4oORVBVxYZNEVKlOTbkUFVauaSDxpKf+zjVg1xsDaerptN/T1qSfRrB3do6dWyE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O+hcUcDfgstfOiV+FTBV2u5q1ErUaRIB5WUQos9T42I=; b=QlOSEgytVF+rbbmTVGxB1Ux5i7
 yZGkjSP21EEb1cBT/7gZwwOha4GLW4bmiML5dQRv2EufytnhPWdCL9EOEfVCpqrFFjQtSw6MoyrJw
 BNjdBqSfVYCbpr/s9mAGTWp8BIIN/HnAXYkivKph5CtwZEoEI/lVO7MHXgN9OOwIn6/w=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6pSR-00DYgC-Br for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 09:28:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F296A6242E;
 Wed,  7 Jun 2023 09:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5FAC433EF;
 Wed,  7 Jun 2023 09:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686130073;
 bh=I2UkqvXe3LAhxUZQ23TbbFjrzI8zVg3feJWvj1ZjawE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qIF5MQgVjaCU+MRlpJX9bdU66RYDnkWRk2lKrDnWx9ucpiPnToEUkd1U5Dy/rjQz1
 7gmmu48tc7U+A8VzancF/0gAQHUGbi9FiTSsROsD+o+QHAjwmUEZjswQ+A1sXf6nhR
 kfHjaFtOQj0xe1Ze/9BQpoq3Ja0IFOmMU6VIlaGRCOhubKRfuSMlKvTIwpFcJXDmH+
 bMvjKaPX/w+ioU6o6Gr+Ofh5QFO4aw7AuFHZ7RCL6ScePZutaskI4egsGT7OJ0DEfH
 pHBrWWb1KgIkb5itNtMApDVemlwylJZE6KoRZTn9hEkupDRw+s4gfju/aamXpLLVvL
 mKtoh9S4m7YzQ==
Date: Wed, 7 Jun 2023 11:27:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230607-erwandern-posen-d5d15c9c2444@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606-raumtemperatur-languste-045c5472f6a0@brauner>
 <20230606084042.GA30379@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606084042.GA30379@lst.de>
X-Headers-End: 1q6pSR-00DYgC-Br
Subject: Re: [f2fs-dev] decouple block open flags from fmode_t
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

On Tue, Jun 06, 2023 at 10:40:42AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 06, 2023 at 10:27:14AM +0200, Christian Brauner wrote:
> > On Tue, Jun 06, 2023 at 09:39:19AM +0200, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series adds a new blk_mode_t for block open flags instead of abusing
> > 
> > Trying to look at this series applied but doesn't apply cleanly for
> > anything v6.4-rc* related. What tree is this on?
> 
> Jens' for-6.5/block tree.
> 
> I also have a git tree here:
> 
>     git://git.infradead.org/users/hch/block.git blk-open-release
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-open-release


Thanks! I pulled from your tree.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
