Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D2AC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GuA0+bB6U6iEEpVecQAbUmkOP17auhqr6/TFxbjVvj8=; b=Gq5i17XcnoXuktdW5yen9mzWaG
	7i93ez9l8nwWnvFSsjxO90xrdZgZQeKjDzVDXpNn5VaPekoYr45Wxk9hPd4tPGQAXJVu9IaGE/dLK
	9+Op39TcfAyTDUvu6hxvhksgHi8U/qHclBSS6d0Nwo4e+2GdeGZkvXvFk8tnXOPRN7aA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wi8dW-0004Dn-RE;
	Fri, 10 Jul 2026 10:39:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wi8dV-0004Dc-Ux
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 10:39:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O0b9QDRqZks374+uiS/Ng/4ACV0jy52ju7+YMc5MnWE=; b=WB9OIOM1SfnSJ3l9wb/CaaHtoZ
 AIlUtek+5QCqEhjixOVBicn4GlpAv2on6NyXVo+gx0PckOBjPtIn1RVrb32ABwGFqY+MjDiQRHCKs
 74ADdb2heJsCE9clfBlUysauMa+J7I7xzyfeFcJ8Y0/nAHv4EDGuAvg969kY0MwHzwkA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O0b9QDRqZks374+uiS/Ng/4ACV0jy52ju7+YMc5MnWE=; b=mHQT8/xLbrCv6HYBVr3KEpcHsn
 SbJc+YyVTqEn+oyO1Ale5c3F6VN76Ezwrbs7ylZQ2nqbGTsGK+IrOuGe/HuqWPWNooY7qbcTOHgJT
 TGD4uRHKXE7QIH3MQddYbrn0tbIX9AilNOugQ3qZjCXhWuf79bZ1F7Jz/fDmFHNsj3Tc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wi8dV-0006IS-AJ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 10:39:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7A0840ADF;
 Fri, 10 Jul 2026 10:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3D81F000E9;
 Fri, 10 Jul 2026 10:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783679942;
 bh=O0b9QDRqZks374+uiS/Ng/4ACV0jy52ju7+YMc5MnWE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WKcRXOrijkWnmhJEB2CvAJdJ2aE5JPJfRn5rv0eO+C6DJXqIzMS0k5QbGouU2OR0t
 sXf9f4HQnvEMxMD13g2lcI5SogKWvNITPGSwx3BLMuJA8ev17vY4GZRSWFJ5ajMMvu
 ENkAyCvlK2fRdwkyrOe7ZZMIutJg0mvewLr1mJTrL0rVgta7SzYHKUlx4ID0eipLdD
 DdDJHYfoLHhqlX1llZSdt2BIcvVrrSCqDwuhHH3wO6ocJMzNlLt2zKS+9Iv81lSwTK
 tvXfnoIvz/X2fq9oTz6T9nBosJFkIAvAiMfXAt+Ij/L3ICPSL5qfIIKkDti27rP6cr
 Dnlim9yUwP4nQ==
Date: Fri, 10 Jul 2026 12:38:56 +0200
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Message-ID: <alDJjTPiKRQ0d8bi@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260710085256.3464201-1-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260710085256.3464201-1-aalbersh@kernel.org>
X-Headers-End: 1wi8dV-0006IS-AJ
Subject: Re: [f2fs-dev] [PATCH v11 00/20] fs-verity support for XFS with
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: djwong@kernel.org, david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I will go through the new round of sashiko.dev comments and check if
there's more fixes to be done (looks like double unlock is valid
one).

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
