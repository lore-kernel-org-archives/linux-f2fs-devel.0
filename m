Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAA6C44524
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PLw+8vTyTNY5BtHY/FoMu7daenO1a9VViBbJFOA61kY=; b=Vv9SkfThOiIJ5uY9SJNICH+Q8p
	C6J9QpNMq6o4E6V1lhOqQCTQJ8tx98AIoN1RlRNyXYep3jiihP0jLheWY2CjqycsVmazvohmq4//B
	meYDaagKIyXnD2PlZEX0UmlcemBufDjbS+QaV5G910MyMLX/QuktaYEQJf5m01XAdni8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlkIY-0007X2-8V;
	Mon, 20 Jul 2026 09:28:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+e0905d82d93001400e43+8366+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wlkIW-0007Wv-JZ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:28:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=AcQcrHhuayW/Mi4oaqwv+0epku
 KpQTJbsGq36s+13MO4xCLZBt9+BnI4RX5rkhTdzoRkuiSIBHrSNXYDF8OlUrJk/ab+BYYpFoVktCG
 PesH2qcSeV3Up5KwOdsUPuv52aT8ylx/f3NHmcTYYYJrgZQ7gnMkScvLh3UXZRIsg/HA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Mc7q7NbNEbH9tad0lfZzG6trMo
 +A+hLADmDDwi0PblDmD1ruxUBTn4uH5MCZl35FYP1qKGx1CxtsTBXALUJDgzGvpcojwbz6J7U4sKj
 j81+YNkpy0DrPZRiY50OOF6fliwe8IR37ZS1uHRXsJ2wot06ShMrx1HjYMB+vImrU1MY=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlkIW-000109-V2 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:28:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=OWaguAPBPm9Z3nVlFcOTZq1jS4
 M/Mlku2fNVmaQdmSbshIWhaSt81nKXLNVFMK/Js7inGFGwBmq9RPsDW388O8B5y7tAmugBPkC6d9w
 ezcOUMN9v0lyeLyKeVhH83etLExlm0XjB1xwHXeaBEUIQs78DDccx9Gzzcu7cClPMuws7IbkMgbWj
 1i5XsIVsKoeErcMYYFVaoOyaUdHUrnJTR1NQcmOR/CjjxgZpQ63mauULzSLbIi08kbhxoIRtw0b2d
 ESqTfuOaOCXI+McxtpDAVzHWuwKaFPnfjgmbut2tQYiTYTMEHfb0H/EodpdGS9Gsr1pwt+yZTeSpg
 IhmYrA0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wlkIR-00000006JiP-3LAd;
 Mon, 20 Jul 2026 09:28:23 +0000
Date: Mon, 20 Jul 2026 02:28:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <al3qN94nsr8H2gUw@infradead.org>
References: <20260718214655.63186-1-ebiggers@kernel.org>
 <20260718214655.63186-6-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260718214655.63186-6-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wlkIW-000109-V2
Subject: Re: [f2fs-dev] [PATCH 5/6] blk-crypto: Remove unused function
 blk_crypto_config_supported()
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
Cc: linux-doc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
