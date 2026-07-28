Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3E3C53219
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6grvVt9wDV2xg0ljOW2/DrZuTlRC6AQ96XovbdxdmSs=; b=F/d33bvF9b2EYNzCIgXaScTDDp
	hE5PMVNQMzTSdWCW7sAQX3IcUj6P03uFLvHXdMv96aJ/xoRdVgYIHFsoMIY0LOMCnF83MGQGUJ0YH
	vQcCXxzZMUxlVoJx4GmhJ3Z0jTCWXNTxGSv9pKfpfRtJo8UvFLOsZvEdct/YehbUHo88=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1woaw4-0000tS-FV;
	Tue, 28 Jul 2026 06:05:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+695790e2dd2d1c4e9532+8374+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1woaw3-0000tH-6B for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 06:05:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M7U7NP830ZAVaCC/7rfjR2Me52NPJumwYpUxGKnNuLc=; b=e2n17TDKugKrMaAv0m32ePplj1
 WR74kafnNwmetTsJ5IuRSDD+8XKjNjgsCE3Woj70IRF5xnlpsrEcihIoesK4CDnwcq5NRKlEx7sui
 Dp7mceC86uHnxHHK+aOrQY0S23An3x4fPlXP0uAiox4atuaRJ6bAIpmeteTP3rw42VQ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M7U7NP830ZAVaCC/7rfjR2Me52NPJumwYpUxGKnNuLc=; b=YSVMRJO+P4Y5chuP9HMBLfU/B8
 nL12xldLLUQvhD6wuTNEA6v+5KBVVZIgc9n5E1e4KvcJ5NXznqx+PJcZGffIpzrXwpIN0a97mYEx3
 rqhHGvokb50dK9Z0CpQU/e0IXrWa4HzWPXfvcDj65wUcS+KRYgEqeq3c1Toj9BFsB2mg=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woaw2-0008Kh-DW for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 06:05:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7U7NP830ZAVaCC/7rfjR2Me52NPJumwYpUxGKnNuLc=; b=IbQOqAH01OoYOUhngfuVxOYuhQ
 0wS0/vNKVcn+fw1uAMeRqigbbLAAFNWT2pfRLLt6J3qUcXWi91/biRxfibRDZskcN8+BKlReCimVm
 485tdq442YwNBTnJ6+76sSrst097jENlnXbo4zkh279CePG8DwhGSoQ4IQhs1341e0m/JFIMgTWLx
 KmA5PkB803aOf6p+53bJAjhhE82gJXXEAYfPllUFq+KWDt4vsRFlaLnoZpTdA5OmbIeW2XICJf6vo
 0totkO6WNfBphuJbd1ecG2myMQzVi9M74Aj4InGToSrjnAi7toFwg5OCbFj1FL3EOz47NXHNSVM+2
 9rdvqdvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1woavw-00000004VKG-14qP;
 Tue, 28 Jul 2026 06:04:56 +0000
Date: Mon, 27 Jul 2026 23:04:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <amhGiIsvNIni_VAE@infradead.org>
References: <20260724133328.1837318-1-neelx@suse.com>
 <amgfuk12imPN2XJe@infradead.org>
 <CAPjX3Fd1KPswrsNe=BeDpkDwi8CmL9HNKcPScMsgGN16MDyVEQ@mail.gmail.com>
 <20260728054847.GB99797@sol>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260728054847.GB99797@sol>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1woaw2-0008Kh-DW
Subject: Re: [f2fs-dev] [PATCH 00/12] fstests: introduce fscrypt support for
 btrfs
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
Cc: linux-xfs@vger.kernel.org, zlang@redhat.com, djwong@kernel.org,
 Daniel Vacek <neelx@suse.com>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-fscrypt@vger.kernel.org, David Sterba <dsterba@suse.com>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jul 27, 2026 at 10:48:47PM -0700, Eric Biggers wrote:
> Please keep sending out the tests along with the kernel patches.  But
> yes, they aren't for immediate merging and should be tagged with RFC,
> and the cover letter should mention that the kernel patches are pending.
> Thanks!

I think the split of the v1 vs v2 policy tests might actually be useful
as-is now, but I'll defer to you.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
