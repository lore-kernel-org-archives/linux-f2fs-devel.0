Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8417FC7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 09:02:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6p3j-0000j0-TT;
	Wed, 07 Jun 2023 09:02:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1q6p3j-0000ir-5K
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 09:02:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zwQ7mjq/Ray9NFCEILAQk/QKOK885zMQIAzTo533urU=; b=QYlUiE1wpqcJrujUe9fNGPBiQr
 BZWCPQsf+IbPrfIGk1yJ9LP0VZS46uMpXLEwQTfoo+gVZUXOGQ1k1cCLOPYoynSmzQx9uw5vbrhpg
 bCjIG9QgA4jr6L8x7/x+EvWmL7r8kNzHip1U5fD6dLGZ3eruCyt8gf+eacTI3sJsaTgA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zwQ7mjq/Ray9NFCEILAQk/QKOK885zMQIAzTo533urU=; b=K47SkaxoLwB83NSIxg9issPL69
 +lYwHFqYCitJeRPfqWZhmnIin0x9cN26Rg0kB7LSINSULsZXruLvzF5lS3c5PoX0F0M43BvkawQc0
 1A0wyFgeIYnsFuzrmVNnZ+BYT9UtZljOAtQdPGgWvih1lc4aRsNm01fUiLGjV6SACCCQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6p3i-00DXcz-JL for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 09:02:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 372AB61549;
 Wed,  7 Jun 2023 09:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C307C4339B;
 Wed,  7 Jun 2023 09:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686128540;
 bh=F5yK/CebQYGivXkJ/hRkJ11KpKZaKc+G+VOQffjNVTg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sAfQXO5SH40rCtDhbwEvXcSBRhslBvNvKUU+/C6zJmUW7rk4KDZem+SyB7w55qX2y
 S8GP7XOz+Sh1JsNAkUh/43kCDhRagfGOJ6ymJTvy8EvYu8/Y72NkSvyaxeGEoX5NYg
 ZNDcw7HYM0UpR6uCZuSvmtx8nAL3oOFkFGjtbLip/0jPFzG0EsuCrfGiU3+dsUo6Mk
 09/Q8RacrQEXGw7OpkFy06YCu5mCCT4iywdTjXjWEe2cbi2/c6/h5WqzuX58R/oEbv
 wLB23zogewfEPk6rfCC+XUbaeVedBS79aJPk4vzv1kQ3/T/szT3pO6l5YM/nxQqSRl
 uTtUOEbNKxpzw==
Date: Wed, 7 Jun 2023 11:02:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230607-mietpreis-deich-90ec6cba9ca8@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-26-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-26-hch@lst.de>
X-Headers-End: 1q6p3i-00DXcz-JL
Subject: Re: [f2fs-dev] [PATCH 25/31] ubd: remove commented out code in
 ubd_open
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

On Tue, Jun 06, 2023 at 09:39:44AM +0200, Christoph Hellwig wrote:
> This code has been dead forever, make sure it doesn't show up in code
> searches.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
