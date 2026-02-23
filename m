Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFAFEA4FBA
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e8qfyoSPyPfjE0jCCqLhRQvm/sqiAGHIjfAWqfboNlU=; b=dhlHScm4J+oZ7/eg3K9cidqCbN
	rTk36um5sp/cV4k75RQ7JBNbLiDxerGDFHZUdWMqibg/HyTvQJRBQAkRYnQ44JbMYlMRzU70aJeyA
	ZPN7ukEIzgdfdqWtAHA+0GBkXpPMfR+HxShLcMuZAjk+0EhTUAu5bFQkIbHJ4LN2ApA0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vuVkz-0002B2-EJ;
	Mon, 23 Feb 2026 13:13:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+48176073e30864d8fa6b+8219+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vuVkw-0002At-Ir for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Feb 2026 13:13:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=XZ+vrH7MpTGKMKM+Q9L/z2XSbn
 xV+BM5adBKXevd4a7bS0ySqlYMLnth6JSv4K1DaKOm8BQ4QWEh8ZALe7AyfN0mP2YYi8YSsr05SzF
 nrCIyS/90uTT65l1HZ0RKChYLqlFSIoeueLDh8upZCn4DRDo8eBGk3F+3/H+aPg5MkI8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=FpT7KhGHDMuJpneUaLZZAFbJ2+
 xuUEuV493W4GZwoXBTrVAA/VEYCY2CednQKuFCxSRXkMhP3yhfMdLANj+yPUON2p5CNtOacMUro5D
 IS3+QAZYMkx/YbMNRCEAuOewd4kAIxzhIMYUMjrC2O6TFa1pG19sI0jr0CkTpVhSYGyM=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vuVkv-00042N-Uc for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Feb 2026 13:13:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tq3wFb+A/83Qww07qI+bjaPz9f
 r2HWrPYAc5LQQnj9ppl8hn38dfuzv6Fi1pUT2sew48u+foBbxm44ge+Tzdts6Skoq413eZwM1/YRc
 ihwuQ9U+Ve3vY0lQjxDEvWSUgCEMuAoZ8kcraweAKD0lzpmohmJ8VujbNb/h3W6bZ7h1DVG7XDtTQ
 M7C/05MrA+mPuL0QiaVxIrJ3LBRRWwnesqHgGEUZ+GEE3FzGj8Pfwh5CmPoW/dA/1xs4a0JP83nwt
 XRRqiMurFuzFjsLzvlxRk/i872uxmLy4iKKOMgtaO60nGswzQ7lqvEm67gmBOmrLhSJrw8rNccpDj
 Npb/KWRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1vuVkq-00000000Ktk-1ty7;
 Mon, 23 Feb 2026 13:13:40 +0000
Date: Mon, 23 Feb 2026 05:13:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <aZxShDPF9K4h4ZfI@infradead.org>
References: <20260221201316.22025-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260221201316.22025-1-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vuVkv-00042N-Uc
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unreachable code in
 f2fs_encrypt_one_page()
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
Cc: linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
