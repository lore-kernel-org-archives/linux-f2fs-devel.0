Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E0EEF48D1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Feb 2026 06:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e8qfyoSPyPfjE0jCCqLhRQvm/sqiAGHIjfAWqfboNlU=; b=JLufs5B3DTbJt6jWOB9lol4fcz
	xwIosj5jTE3kVa1T1jHi90J8aojdYwxFCZo1NluLUqow1yhDHqzBlwsaxCPWXtQvcEryMrMl7gp2c
	yk117TsB76f3E3Jt5ELY/UuIG5yuhOb65qrwp8PfsleNexGl2eVbxkTpXaQwVdoFDp/0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vqmbj-0006vU-I2;
	Fri, 13 Feb 2026 06:24:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vqmbh-0006vO-FJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Feb 2026 06:24:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=LEavtkhYcvwOZwlhShQyR+Bzbp
 d+T+INqL/8GraiQYICtR+Kkiocli68GqSa8ujIQw7VDfYVFbwrDBp4YmauvryIoF9UKGjEaxEY/0g
 kI7ROl8mnTnD3ilfeCzYsMxRDzlJGA/Gqg0EUAAtVUs7ECQzcawnwtlMggQo0SyF8wyA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=dMgWfbaVAib4jogj3rKnhV2pQA
 leqJuQ8P+bb9TQVTYvcld+KGRCDNw+veCqXcFXlmtyrpFMporHGgRrjkgc0cgdGPhac+fpRbAHpmc
 pV2B5anyUQlylxAGhH6biuQgfPSWxUMvT3LKmcUXCQRBQGDV9X0muXwytGtcBDCSx1Cw=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vqmbg-0000Kd-N4 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Feb 2026 06:24:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4017668B05; Fri, 13 Feb 2026 07:24:35 +0100 (CET)
Date: Fri, 13 Feb 2026 07:24:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Message-ID: <20260213062435.GA27228@lst.de>
References: <CGME20260213055123epcas5p25f52d5961c04b1a1f514827a494a0773@epcas5p2.samsung.com>
 <20260213054634.79785-1-kundan.kumar@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260213054634.79785-1-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vqmbg-0000Kd-N4
Subject: Re: [f2fs-dev] [PATCH v2 0/4] Avoid filesystem references to
 writeback internals
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
Cc: brauner@kernel.org, jack@suse.cz, agruenba@redhat.com, djwong@kernel.org,
 anuj20.g@samsung.com, jlayton@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,
 viro@zeniv.linux.org.uk, anna@kernel.org, gost.dev@samsung.com,
 jaegeuk@kernel.org, vishak.g@samsung.com, linux-nfs@vger.kernel.org,
 hch@lst.de, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
