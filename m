Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C715C7EE2E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 09:23:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6pON-0002H8-Dy;
	Wed, 07 Jun 2023 09:23:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1q6pOM-0002H2-GT
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 09:23:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hpPUFur1NR7UlPEpkmElz4URwOJ3of5eksDXZ/E9+Mw=; b=XdcmBssP/BnYAEuAlk49lGwxG+
 EOnDJeZkV1zkUdOYpzR3Zb26lmtGHLEzrbLeog9JAox4lvcRF4aqghkDRhJWfnHgHZR1ET2+ngqtD
 /lOpeIPnBMe92bdw9Fralq7epXZOIFivLgJiGFlj6Rbb6QX850HjZHj7dAD0JPMtwP/s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hpPUFur1NR7UlPEpkmElz4URwOJ3of5eksDXZ/E9+Mw=; b=EkiRVlMGRe1Sh8Oa5qz7qRpn5n
 73jsLTcDXZtDgJlQlfPa4WufKXBlI30i6x2OHeBLssZjYiiaAe/3muCkA0ripLEA+ZYsrfxVhTmBG
 ILI4SVnzaYTuWyojutmEuM3PTiIUuqmfKmPYYAI1AD5uK4YNrtbiYv+Ya1xUXqelma2o=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6pOL-0005nj-Nh for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 09:23:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 53E8661645;
 Wed,  7 Jun 2023 09:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B328C433EF;
 Wed,  7 Jun 2023 09:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686129819;
 bh=2dBZxelf4g0w/gdLM0HKDBqAqVXwuGv1PlJcXlPn9lY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FA37ryzewz3+4K4l8Ktr97eYBVVqBLv2pVXW0viLjV+m+r/uNhWaJUioMBllxDrcb
 m/2rQlbq2vyk3xPBmVzj29M7JVrvLsSMjwUJJkNN8B6XdEYn5s49h4hyw6bLTtoi9p
 EjTM+zpv2Dhmnnkhitfx/vj2brk5MHkYyJoQRtsq8+0xWW/1nK8yf7e6n1c+pCWVlV
 C1XYMaOxwobfzPLR8thTUoG0bwIiC1DRhAZeaP57LjbKOs0qtf1boJvs5JbZewwmWa
 ZNyTmf20EjV9XQz4d8qaTsyPbhurixlhBxn2jxz+gzDDr74A/rLls/VWc0tFau9VX+
 GD8kCkpo5IuUg==
Date: Wed, 7 Jun 2023 11:23:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230607-thermal-sohlen-1ff852d8a99d@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-30-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-30-hch@lst.de>
X-Headers-End: 1q6pOL-0005nj-Nh
Subject: Re: [f2fs-dev] [PATCH 29/31] block: always use I_BDEV on
 file->f_mapping->host to find the bdev
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

On Tue, Jun 06, 2023 at 09:39:48AM +0200, Christoph Hellwig wrote:
> Always use I_BDEV(file->f_mapping->host) to find the bdev for a file to
> free up file->private_data for other uses.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
