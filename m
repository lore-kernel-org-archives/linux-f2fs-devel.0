Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6CAC77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 20 May 2023 16:57:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q0Ptb-000653-BQ;
	Sat, 20 May 2023 16:57:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+2d90232fd80ffab3c8b5+7209+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1q0ErR-00082s-CP for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 20 May 2023 05:10:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IZDwpSbAMestbxTLBfVfseHT/Ao1tda2Hw4YjCVMEYs=; b=TR92yuqDVAtT0/rieQ37Csmr7g
 qvvj269E5LBDqOtG9Qiq8FsFNi5If6b6GGywE3BgpanVopR4IBFDLvPG+KkiLIGqjtKYr0bg4OXny
 FTV1WnUKOIw60XHsx1hGrowzBzY6O+P4ls6Gy97iWaD3QgCLkt4iDWEnXs3ECk8Av2t0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IZDwpSbAMestbxTLBfVfseHT/Ao1tda2Hw4YjCVMEYs=; b=elI0zvWNp2rj1vl0KatY9kZixf
 FpZSnCrHWVJ/Sf1vo2qsG8+nNivL7Y5bXmzoiXjwNSHbNgmMr9SBtnfLDIHZ+hfej7IHBMdPyzgWw
 Y6VN05qBa1ZV6O4h1/TQTbiH6iEUXMfzTdpL2491Aj+1VRmNvCARqPoCIPOJylHP50xU=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q0ErM-0000aa-8m for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 20 May 2023 05:10:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IZDwpSbAMestbxTLBfVfseHT/Ao1tda2Hw4YjCVMEYs=; b=cHkX9gDilxrMdUT4jG8u5OaHR4
 L649r4BgCX/pLuYAkhtU7SfafGHxxnrkUHEgT73x1yGjbRqyAlVK21YJ9K37RG+dA6B4QsRCgDg5u
 AMOqipYZn/a8zn8pcotnMu0xnrY0QfgL3AWKEk2bB7uEqQdxqWYQHjtC3u8IGIjc9BW/mC34TmmPK
 4hfhEzqh4EWdQQP0Rk18v7/YSyzKzOWnHuAu/JZ6gwW/k/cKdTLVGCvGU/aHKgYJaGyj+c4eypG3x
 qMaW3NS65gjbl/lOfjSfziIpL+N28MVHooIGIOoavwJekn2IMwGE+x/KxENxInlUVJdZ6dLPQSnzT
 K0XEfMPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1q0Er9-000kTk-0P; Sat, 20 May 2023 05:10:15 +0000
Date: Fri, 19 May 2023 22:10:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <ZGhWN6zohGXQvPNv@infradead.org>
References: <20230516052306.99600-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230516052306.99600-1-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1q0ErM-0000aa-8m
Subject: Re: [f2fs-dev] [PATCH v2] fsverity: use shash API instead of ahash
 API
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
Cc: fsverity@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I'm not really an expert on fsverify, but the rationale of not using
clumsy external crypto offloads from the file system makes sense, and
the code looks much nicer now:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
