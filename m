Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4266CCD5BAC
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 May 2026 09:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sFKEktmipdbtQGFM8Oc8OX91/POnFRMMYyI5kXShOgY=; b=gr044oBNy64GLT0Ik8KfdJ5dg2
	yk6ofMqoid5pmk04vFV3WjHPWishNgR9NhhJcyQVOTxqRdORpC+Lq23lUY63lr3pgKLjU+GJRIYmh
	5dafU5Nk6Sb75jbHR36+mvqvIggqN3gvkR9qrBzaHIbqz/otaBRlII4mo2gErDBUIf/0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPzN9-0005Rv-GZ;
	Thu, 21 May 2026 09:07:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wPzN7-0005Ro-Vu
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 09:07:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MdfiQmc87cBHIQvC77uJHDy/ozw55cZFT4pBHKsRH5k=; b=jUpoxSPCVYhnzYCU7E1Brae6wW
 beO/eJT/C2exhFlSJ8cGXSlgIgKr5hD3Z+UYTSxZg/PlFGTaB2g0Xnq8+PcR8kL4Bw5BEapDeHyTq
 lIaxcoOgO0W5vehTU2fZSvyEfnLFH0sMSnR0a+YaE6UF6A8zdWztJsZ5GxHHFxhv2vBE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MdfiQmc87cBHIQvC77uJHDy/ozw55cZFT4pBHKsRH5k=; b=jC5yXxE+RADrl8Cm349W9X0a+T
 CO1trLueFahY9SyyqJkj/ljefO3aYr5dk/P6kltstoC6Mi2iNuVitztX//Q8mgQz0xcuXwWFgKiTp
 D2PNgLjTt4l9JnU6pe8svpJnHsJouAzXgXZEDOAqbTmLbxGw8l+WDy6LFa70dEFmsswI=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPzN4-00019l-9n for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 09:07:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EBB3568BFE; Thu, 21 May 2026 11:07:05 +0200 (CEST)
Date: Thu, 21 May 2026 11:07:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260521090705.GA14254@lst.de>
References: <20260520123722.405752-1-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260520123722.405752-1-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wPzN4-00019l-9n
Subject: Re: [f2fs-dev] [PATCH v10 00/22] fs-verity support for XFS with
 post EOF merkle tree
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
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, May 20, 2026 at 02:36:58PM +0200, Andrey Albershteyn wrote:
> This series based on v7.1-rc4.

How are we going to merge this?  It touches at three subsystem trees
(fsverity, vfs/iomap, xfs) so some coordination will be needed.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
