Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E14CC4451B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ca4v/kyT77XV69YwB1PKL+pQwpmTgr3o9szB891NwP4=; b=PcNp7MiV5Hy2EmhwrMTAVOejGV
	dLc6YYU8Qzyoq9V/k5j2KBCY1prw3yEhRcJ/Pyy/sbeWpvuf9JtKQwjXdXEKPF8dkDffhh9/E3s+k
	Enl2tMtIqbprFXYnaKrH/HrXxwK99BXAnw7WuDuhEw6s/Q+OVZNhfByJIK3BCVYhU3ec=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlkG5-0007QO-8r;
	Mon, 20 Jul 2026 09:25:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+e0905d82d93001400e43+8366+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wlkFy-0007QC-57 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:25:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ktnqeQzoVZxgTDKDI/x/2lJe/4VTfiBgNSsaGgP1wpg=; b=J+NY8kOlA/uVJe/XnHcNbfmOiX
 CZZlfQyNabMsrvgEV4TNF0HRI0DKBONLDCcn3/Aq1+VtBXaJGjXBA8REvNsS3QA5B6jAFR434iWc6
 0DRSKBWi6e61br3kbE0r2Azp3WCg4erbwKNkJgHttdI8Hpd8eKE/ha83j6aEE+Ov5e20=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ktnqeQzoVZxgTDKDI/x/2lJe/4VTfiBgNSsaGgP1wpg=; b=fILB8z+6RZEBRXQMuIeZ0wyY/7
 fkzquegoA/LVXKp399+0TXG/pUozu/yZiPn6ke/J9ttmWZ4nnRaYBSs+GGrY7Gs/cNswHEd6C8aDI
 ZDGOfQzeLJJiiBBjsZdNpnVi3bP2X/8ncY6PepMLNDlIkh8jkFb5ybr2S6cOzXJUFwY8=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlkFx-0000pO-Bl for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:25:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ktnqeQzoVZxgTDKDI/x/2lJe/4VTfiBgNSsaGgP1wpg=; b=DbGGECAAIpJbLuumRxIiPGTbQF
 6HMC5mHQtNwg6i3w47n1tyL1k0qMIEc4N5rPlavMVCLpIpecrOlZiH4eVp1N+3LxwViUg1BxfNB+1
 9u5KixYeidKc2qVQzZylLtQjRUZyE5EI7FJqIKDhoxtgL6fGpEnJubBAk/8QQGHsvvYLqP6VMyx2t
 +u89APcge6Veamkdp398fABSeBGlnLpbv3HWWZ4J2AjznUvJRoPS9s9JRCq+f6lB/r++8jArHH6MK
 ZuJR3+wRNPVM5pfIsNstzOjXl+L7MptJBEAqFC+y2houd22+1in11FD/ugoMG7OPmQQRCun6p8x/H
 27eJp5Fg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wlkFn-00000006Ifz-0p67;
 Mon, 20 Jul 2026 09:25:39 +0000
Date: Mon, 20 Jul 2026 02:25:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <al3pk9qhwG3gDzcc@infradead.org>
References: <20260718214655.63186-1-ebiggers@kernel.org>
 <20260718214655.63186-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260718214655.63186-2-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wlkFx-0000pO-Bl
Subject: Re: [f2fs-dev] [PATCH 1/6] fs: Update outdated comment for
 SB_INLINECRYPT
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

On Sat, Jul 18, 2026 at 02:46:50PM -0700, Eric Biggers wrote:
> Update the comment for SB_INLINECRYPT to match the latest code, where
> SB_INLINECRYPT now controls whether blk-crypto uses inline encryption
> hardware rather than whether blk-crypto is used.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
