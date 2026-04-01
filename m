Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A26107636D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Apr 2026 06:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ITkcWZmSVClbFzgwo1vrV/JcSKo39Fw/LK3Jw2nj8rY=; b=iOtww78JnsPEBbZc0+1RdqqtPW
	8nwxry9rR1mbFm1AoBC0nqDSax5j0464WjnhiSR1od+C7w2HHHPpsNyKVkw3Hp1bW83KS04mFPtER
	ppmX5xI6Ecb7uvA72wKR6oZ2iCo747Z2QTD0iHdm0cacoGVWkXERmghHj1fvml54tBBw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w7p33-0007Y9-4Y;
	Wed, 01 Apr 2026 06:27:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1w7p2i-0007WR-Pm
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 06:27:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BPyb9KK0KgIdBW0N0Y1mh8pAR45CoohCM3ukLu6iucg=; b=CiQAuF1F486DSPswga6DbxXrws
 ktuiLs/4j5ihBLL8AdeI9XwwRvZNoKDtZNz+c17Fk4csJFUKJnqA4kDA/zTr2x9QfNDuB6GVQXIm6
 rYhss5ZDQUqxI38f0CgZdhxJqqOjBDqOi0QzJ/ibfboQ5XnwDsM/YBfeNESbkqvQeBlw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BPyb9KK0KgIdBW0N0Y1mh8pAR45CoohCM3ukLu6iucg=; b=dFdlInY6Ua99oO8+IFqHFK2uDd
 nqcAt/EhZPx/YInzaAektXpazmkoZmj7BF9V7gL5EKoZ/gA88ckrgUGk+fvk+8n5Bsh/RFUYhemsR
 63Cq3t8nYv4zC9QLVHYce5gcnbqWE8+LCKqfchL0fv4bm5fvFzZNLlOW5G1YWyFG80yY=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w7p2i-0000Zy-Vd for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 06:27:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4154168AFE; Wed,  1 Apr 2026 08:27:00 +0200 (CEST)
Date: Wed, 1 Apr 2026 08:27:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260401062700.GA24459@lst.de>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
 <20260331212827.2631020-3-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331212827.2631020-3-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1w7p2i-0000Zy-Vd
Subject: Re: [f2fs-dev] [PATCH v6 02/22] fsverity: expose
 ensure_fsverity_info()
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

> +/**
> + * fsverity_ensure_verity_info() - create verity info if it's not in memory yet
> + * @inode: the inode for which verity info should be created
> + *
> + * Ensure this inode has verity info attached to it. Read fsverity descriptor
> + * and creates verity based on that. Inodes opened outside of
> + * file_operations->open will not have any verity info attached. This
> + * info is required for any fsverity related operations.
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +int fsverity_ensure_verity_info(struct inode *inode);

kerneldoc comments go next to the definition, not the prototype.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
