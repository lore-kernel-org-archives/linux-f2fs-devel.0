Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00992C79FA1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 03:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Letgjh0LdoI6bgTfZFcVojGDbIk9y+NiiKLSmTOMlM0=; b=d/QkjQX4WyjlLuepojRC0lyZ2v
	+l/UCZlkmgXOGZXC2gW/eJ7k5N5GndTSp8QgrFMDol4QawdAEiEw3vg5Kku2JlbtgKz9aVDbWcmqx
	UTjMrirvyaRbNbrhWoVV9crD+mpfYyNkQKZMk02888HGyHDFgQW75qCPF8KEcf3NTkhY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3QJL-00014D-7n;
	Mon, 07 Sep 2026 03:46:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1x3QJJ-000140-Tj
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 03:46:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gs0OP8cN+lCOGkgQ2WUYinOWYGiwVJPpLXsduPSPtTA=; b=S6asTrP9ZcYKjxY2mRMKwmcOn2
 GNYnsE3qHQhY/+cCEFRMQtTxLRc+Ybne+Bi0pkMeHu4xt7TQOmDqEy86PeiVaiW1Fr7JHtCJyE141
 qMNtd0QN1iDmaDGUpM9nTsZZy8lCaoOJSXHFPaK9Il5glJab+SLuv+awTSzIoayoGLI4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Gs0OP8cN+lCOGkgQ2WUYinOWYGiwVJPpLXsduPSPtTA=; b=Y30l0sk0k/zvKshZKk6sp9x2cW
 qEiwhlMCMxXlKUNrXNLLBrmoN9pRaIOmG2tCXq08+zt9+8DJVvSYKXtKQ172iZf8s+C+qjbrmP63E
 TtnJPOL0d7oGq2w8JbvLRloqXwPMNvbAsasHrBxlOw/AhxYyEnLkO2e/s8P7EKtyCt7o=;
Received: from m16.mail.126.com ([117.135.210.6])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3QJI-0007Ij-Oa for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 03:46:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Gs
 0OP8cN+lCOGkgQ2WUYinOWYGiwVJPpLXsduPSPtTA=; b=MPu8EY6q4Menu0S0rH
 PBneF7qsi8Yoq2StecJrq5weDrJlDEMJ3ycn5ORprONHdgYqSZyozi8G73mwekMT
 nmEMr3u2O1zx98G60K+bXTXX1Y5PeYWRikNLNcZcoxKjG4n9h7j2sh4J3DZ/Ax8h
 y6TLRIPMrDw3te0LsDMmKeHTE=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wDX_2FnM55q95+qAg--.5006S2; 
 Mon, 07 Sep 2026 11:45:44 +0800 (CST)
To: daeho43@gmail.com
Date: Mon,  7 Sep 2026 11:45:35 +0800
Message-ID: <20260907034536.2169657-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_xyveu1Dt-UwWFKtEtf0LOZn2TOwqNyXh_DKRs=gCVY9A@mail.gmail.com>
References: <CACOAw_xyveu1Dt-UwWFKtEtf0LOZn2TOwqNyXh_DKRs=gCVY9A@mail.gmail.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wDX_2FnM55q95+qAg--.5006S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUnuWLUUUUU
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBowgp+GqeM2i3hQAA3n
X-Headers-End: 1x3QJI-0007Ij-Oa
Subject: Re: [f2fs-dev] [PATCH 14/14] f2fs: make compressed files compatible
 with large folio
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: baohua@kernel.org, nzzhao@126.com, Ryan.Roberts@arm.com,
 zhaonanzhe@xiaomi.com, jyescas@google.com, Dev.Jain@arm.com,
 David.Hildenbrand@arm.com, linux-f2fs-devel@lists.sourceforge.net,
 zhangbo56@xiaomi.com, kaleshsingh@google.com, jaegeuk@kernel.org,
 lipengfei28@xiaomi.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

Thanks for review.

> However, if a file already contains existing compressed clusters on
> disk (e.g. from earlier writes before large folios or created without
> large folios), 'f2fs_read_data_large_folio()' will issue regular bio
> reads without decompressing them.

Actually, I think such files should already be excluded from the large folio
path, f2fs_mapping_set_large_folio will block compressed file to enable large
folio mapping. Or do I miss something?

Thanks,
Nanzhe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
