Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5E7C5CFC1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e8qfyoSPyPfjE0jCCqLhRQvm/sqiAGHIjfAWqfboNlU=; b=YWeoyPFMS7JENAyqTf/DDCl2ta
	wB8Ej5ivQVDAO/riF8hzlp1EcTd+mC4KrTjBOB/hWkWT62wkEzAe606KH1qKHJNk0xK4J5dYjI76F
	BH0Z5HsUQES0ImakzfmQybM4cbsy3jWaoV4zNXVfh6JC1CUfu2qKOPjOuWJL0dME1YS0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wvrV7-0006vO-Mk;
	Mon, 17 Aug 2026 07:11:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wvrUu-0006v2-IU
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 07:11:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=f70tMv/G9rwXKKCa81XRUv9VqC
 xJy/dvxc9va6Ixi3zU4JuMhmtnKgwyLF5iDYvGoe3azKATFv8EtVBVIMJRkCEOgiit/xZded70yqU
 bEEjXtHSNBi5o9fjU5F+ryaE3bg3F5Hdb1na7u6/roI9ZOgkZg4sq/dAsNyvXKQXxAmk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=X2DITVI+MIX7wM8hS6wfMLzdEH
 +MIwGk4+mCitgNl8BLqLoSLYEm6Y3ktilshsU4vSblcMhu7XZ/OQiUjcKcUHcvOXRIM2IAIKFo+VN
 4L9o2EvRPS7UND7SQzIRmJcrF/5X4k8tYvi3ZzVEM+BQUxOAETMgUBFarMV/v4G+jLtI=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvrUu-0006yc-89 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 07:11:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2E11868CFE; Mon, 17 Aug 2026 09:10:56 +0200 (CEST)
Date: Mon, 17 Aug 2026 09:10:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260817071055.GC17371@lst.de>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
 <20260814092448.1818082-17-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260814092448.1818082-17-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wvrUu-0006yc-89
Subject: Re: [f2fs-dev] [PATCH v15 16/25] xfs: handle fsverity I/O in
 write/read path
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
Cc: fsverity@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
 linux-ext4@vger.kernel.org, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
 linux-xfs@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
