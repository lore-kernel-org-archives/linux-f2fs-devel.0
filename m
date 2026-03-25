Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA07109C02F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DcEiTFyb+zOIV8iA97Cee+tOkY3Wwl6aXhwqi94pdks=; b=H7VI9nqoQhJiER14MFfqQAzInL
	l5i8IrGUDUapXsG0vgOtYxWz6PJWgwZTinLCJB2Ha2WUt1zUqgoXLUu876GFG70/0JzLGm8uyIsFx
	/35dEBtvSDC/sBk9Pr3BbyZ9ZCzDb+52uoZnkn8//SIpCo4s33GKoaCkgAIfI364JGfM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w5Pvb-0002xg-Je;
	Wed, 25 Mar 2026 15:13:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1w5PvW-0002wk-8c
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:13:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lkyrVN/yeytDCGV59Hg4yyxI3LvldlmwxgEEOeio8XY=; b=DzyfSYF5Guy5OHgG7j0pZUFjzf
 6LBNTNEI9TLatuxj8H4wszYHAPYgOViruKcEgrxcciXTnc9eJlm+TiMga8bhyeIx4bErEg2fHwR5k
 NWUR7Cg5Z31zGghWT+VcE5MAzS0h8WhBNa6PlzASB8TM8CxZ8O4OV9aubAc1pagkCXI4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lkyrVN/yeytDCGV59Hg4yyxI3LvldlmwxgEEOeio8XY=; b=KgMIko77Y8jKAo3NGJs4TMOZ19
 MG6m8Q4AYjhfPo49ZBas0AGnkC4P0vAarPzrcsjNGrYVpPdT8RQ49obemMejSScJLvDt0s/pKrYNh
 RXQwR1XJXQbFLL7Ttc3zoeif4q+fTZs2u3Obpi4l0WTTqQOhhBDydQFJeGGE5inTwMUU=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w5PvV-0007lh-IB for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:13:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9A6A568D0F; Wed, 25 Mar 2026 09:06:15 +0100 (CET)
Date: Wed, 25 Mar 2026 09:06:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260325080615.GK952@lst.de>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
 <20260319170231.1455553-15-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260319170231.1455553-15-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1w5PvV-0007lh-IB
Subject: Re: [f2fs-dev] [PATCH v5 14/25] xfs: don't allow to enable DAX on
 fs-verity sealed inode
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

On Thu, Mar 19, 2026 at 06:02:01PM +0100, Andrey Albershteyn wrote:
> fs-verity doesn't support DAX. Forbid filesystem to enable DAX on
> inodes which already have fs-verity enabled. The opposite is checked
> when fs-verity is enabled, it won't be enabled if DAX is.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
