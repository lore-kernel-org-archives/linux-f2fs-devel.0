Return-Path: <SRS0=zARH=4J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87594C35646
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:35:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5473F208E4;
	Fri, 21 Feb 2020 17:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GcOVs5HO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="gnK8bops";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qv4T8Vov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5473F208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j5CDM-0004ma-Vc; Fri, 21 Feb 2020 17:35:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+b8b070cac54c30a96dd5+6025+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1j5CDL-0004mS-B2
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Feb 2020 17:35:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wf0h9wuAEcKNRqQhK7eYyrG9qa7B8zzOGponbVZ3cRs=; b=GcOVs5HOA3RU2sU9Ak0L9jLaPF
 F5x9s29YUAUpxTS6yjyefga5MUO75g7osVoAS9BdMS+FUeylEopHz4zpW2fLskGjdCFBhpTzXnLdo
 iPPm4el+t745Fcj0n7jg+SlAyNbuNBUgRhOHbkmU1JLqWHswblvq6mKZxP2hlN7y5SV4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Wf0h9wuAEcKNRqQhK7eYyrG9qa7B8zzOGponbVZ3cRs=; b=gnK8bopsCSWvCGM2LzhEowx6m7
 oYMIdzjmPKh3irO5LLXuwBMMRjgcfGsVyKNUbGFk0p95ZtGkqG7tF1S3RGmKv07I/C+WFuWQuPPKw
 LJqY8xj7zpSJSxxa6EiPIt3Z128QvWtvI4xaUAt6nYTJkAvi5X/TMu0HYmUWM3zEEWl8=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j5CDJ-00Cuhv-9x
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Feb 2020 17:35:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Wf0h9wuAEcKNRqQhK7eYyrG9qa7B8zzOGponbVZ3cRs=; b=qv4T8VovROjkqztEW3g3nhCy5f
 gufHvXfCuF+Z6HXVdrnqn11v47JRrQd3KMc2Fb/NXQnDX0L8RgKN14XJA2vlmNyMfe8JNpLhmUVxc
 z25YaTqKCBiGK2Hw+2/bd4pbgopKAf4/ve6jLC7QPgm5ZDn5+iUMGtD+1h9m9riV8t/UT8f4E2FIQ
 ++ryHJSQL+q4p3uXFau3HwiSPe27IGSZ+hWHJ1wE/QCzd7pdwceRoXgVy0rGkR8NzQA6rJe3DsDAG
 fBH7BRytlaQRbZINis5xOw58oyyhiPiKjWEb9vUxnB2uZFIru9OjRckeEqfDgK73xZAiXwS1jNsGy
 osPBEkFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j5CDD-0003J6-9C; Fri, 21 Feb 2020 17:35:39 +0000
Date: Fri, 21 Feb 2020 09:35:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200221173539.GA6525@infradead.org>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-4-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200221115050.238976-4-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1j5CDJ-00Cuhv-9x
Subject: Re: [f2fs-dev] [PATCH v7 3/9] block: blk-crypto-fallback for Inline
 Encryption
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
Cc: linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

High-level question:  Does the whole keyslot manager concept even make
sense for the fallback?  With the work-queue we have item that exectutes
at a time per cpu.  So just allocatea per-cpu crypto_skcipher for
each encryption mode and there should never be a slot limitation.  Or
do I miss something?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
