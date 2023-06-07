Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE6AC83005
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 08:33:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6obO-0003bx-VR;
	Wed, 07 Jun 2023 08:33:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1q6obN-0003bq-3z
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 08:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y/0t9c4SY3SShfmM/+4Kp5Hz5Wz8u51E8hCvz4NiAPs=; b=WRaFHjus5t24xqeKnl8z8lYkhb
 0KGb29xgLTjoHeZUuaYn6Oj9TKeAySu0hiWnMR6g4eBq/9vL9SWjvpDjR/kzN5KoWYvFyI55xdD65
 6YTBkZ3SjtFMwTBtym5ozhzu+JTQ4EQ07e/+gxOEBK8RfQrZO1rnxNx951WjZvws5rTI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y/0t9c4SY3SShfmM/+4Kp5Hz5Wz8u51E8hCvz4NiAPs=; b=l8t3IWdgedVVKHnq6zZrnvCEQx
 qXLpZuLqUoT2l+ysk2qsabyAFSI18nOjB5pr1u0AxEIrli4fwNkFC9DvHPMN6XJRa65ZgwAJjw+pI
 ZOaziOECdLKsIP5MsrS7sMivSPo4AY1fkeZIicFIfi2Cct0MylWH0VxjWoZneEQ8N+8E=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6obL-0003Pv-Fe for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 08:33:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E15E86732D; Wed,  7 Jun 2023 10:32:53 +0200 (CEST)
Date: Wed, 7 Jun 2023 10:32:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <20230607083253.GA29653@lst.de>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-2-hch@lst.de>
 <20230607-behelfen-abnormal-8ccf8e1e99c9@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230607-behelfen-abnormal-8ccf8e1e99c9@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1q6obL-0003Pv-Fe
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
 Jack Wang <jinpu.wang@ionos.com>, Christoph Hellwig <hch@lst.de>,
 linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linux-pm@vger.kernel.org,
 linux-um@lists.infradead.org, Josef Bacik <josef@toxicpanda.com>,
 Coly Li <colyli@suse.de>, linux-block@vger.kernel.org,
 linux-bcache@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 David Sterba <dsterba@suse.com>, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jun 07, 2023 at 10:14:22AM +0200, Christian Brauner wrote:
> This assumes that all drivers deal with additional ->open() calls for
> each partition correctly which I assumed you checked so,

They have to, because they already get the additional open for
extra opens of the whole device.  The current behavior is:

open("/dev/vdb", ...)
  ->open called

open("/dev/vdb", ...)
  ->open called

----

open("/dev/vdb", ...)
  ->open called

open("/dev/vdb1", ...)
  ->open called

----

open("/dev/vdb1", ...)
  ->open called

open("/dev/vdb1", ...)
  ->open NOT called

which is very inconsistent.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
