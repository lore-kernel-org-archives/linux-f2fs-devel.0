Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4D5ED7B87
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cnGjsFsg8EPT+0l+uWk/PFOGXjGS4k7CSMPenqAKGz8=; b=XOneDxDvZsVI4n6OyP1F/WJ4tq
	4yzwCvplkVu5/90I/YkiserBc+wdLmqh6+JWZWx+8AeRPveoQ0BYTxnH4dUBcjcNN9Gz7OeuKUqCK
	c82wU7Y+T0gRYDzadySheUZKLFxMRZKpJtROEqA0yLLOyQXSS9X3u+6qxFMQ/46sTWvU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wCYta-0003xa-Hm;
	Tue, 14 Apr 2026 08:13:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wCYtW-0003uz-II
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Apr 2026 08:13:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sZX6Fhebw706ATb2AKtA4h357tHEeyJwaMnpgengSjc=; b=L6Kr7vOMSXrFI7iWDPbbdcEXxH
 TtRgg5BSH6Ew36yIxzLtQ8HpDE91r7nEc1Pzlp5t5mzvLxRPUfuD/6v/zlaBtOyatrLcLsllhj+4g
 AcMZzB4waXTklBiUDtMYQ+JmTtZd1Dt99FMAEIWNbvdVSvtVr7mnvnh+c+qnXJ3jilY4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sZX6Fhebw706ATb2AKtA4h357tHEeyJwaMnpgengSjc=; b=D63BjAoSpBp9TyU2reHgXYC424
 sBvRznSboP/g4LfoVgTo8SoaV6xA6+hJSwv++HHeI1MTKRQdwElMCP2bSx04yBnMxGXoa9cfmS8kn
 0AWZYNX9tAv74hbxJPgQiMRBlKtQmuk1LvYgVxeZTUmqIzbuB+5F3hDrGjkq0GOSGOm0=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wCYtW-0003xQ-0a for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Apr 2026 08:13:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BD21E68CFE; Tue, 14 Apr 2026 10:13:01 +0200 (CEST)
Date: Tue, 14 Apr 2026 10:13:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260414081301.GB11138@lst.de>
References: <20260409131404.1545834-1-aalbersh@kernel.org>
 <20260409131404.1545834-4-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260409131404.1545834-4-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wCYtW-0003xQ-0a
Subject: Re: [f2fs-dev] [PATCH v7 03/22] ovl: use core fsverity ensure info
 interface
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Apr 09, 2026 at 03:13:35PM +0200, Andrey Albershteyn wrote:
> -	if (!fsverity_active(inode) && IS_VERITY(inode)) {
> -		/*
> -		 * If this inode was not yet opened, the verity info hasn't been
> -		 * loaded yet, so we need to do that here to force it into memory.
> -		 */
> -		filp = kernel_file_open(datapath, O_RDONLY, current_cred());
> -		if (IS_ERR(filp))
> -			return PTR_ERR(filp);
> -		fput(filp);
> -	}
> +	if (fsverity_active(inode))
> +		fsverity_ensure_verity_info(inode);

fsverity_ensure_verity_info already is a no-op for !fsverity_active,
so the check could be remove.  Also we should probably propagate the
error return from fsverity_ensure_verity_info here.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
