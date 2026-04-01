Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5061107636D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Apr 2026 06:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wm6M8g3tNw4J22u0WTkeVmdqoAYabarKedbybINitnY=; b=NrhEn2hdma+ucZX9hJgptVd3/r
	DM5Nto0o/vUGIribpbCMbS/CerT0Odq2KaSsGLMcO6t5KJ4nE5iDCC/TTlJekNfqz6v4Mymfl6vZZ
	PFd0SMBa+AAh05zJQANgM0HNmNK1w1JS+u5eD9U/0UKPTUsb2reQ0rNG+jN6zvnHKhuM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w7owA-0006qk-MH;
	Wed, 01 Apr 2026 06:20:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+83c2b452eb0a1c715696+8256+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1w7ovw-0006qD-23 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 06:20:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VIuJiRmgRUKwoy4fZIyvENNhSRANuGUnd7EenkJHAIg=; b=Nnr/FKAOJnwHyTQuuG2P0AUIW4
 8z+VZUY2II6BKpErlIEoy3BJnboW2OCldx9D/RecpfDk7lGrhGQmja/pmo3A70fUlfpwyy7IQlDWP
 UZSQPdBb9M0J9YK0J+hoMDpXtg4Udisu1btFLlnX+76Z+RIMF2i6XbHRq2QqrIP2Nxk0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VIuJiRmgRUKwoy4fZIyvENNhSRANuGUnd7EenkJHAIg=; b=gmu4ZW0/h2xtB8PDQC3PSG7pT/
 2IjHHXAff1SOQctooOthLe2wekzrB56jCob3eKw+E8ljJvLPVgcke3RvNnf9Dg8CyFFQ2TgTCUn+r
 CoBCinwpHSg+Z64occpsEVf5ZBNeMLC4+QwNT5MxboXZ+qTuWvMM00YcPeCI2BImocpQ=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w7ovv-0000JJ-EH for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 06:20:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=VIuJiRmgRUKwoy4fZIyvENNhSRANuGUnd7EenkJHAIg=; b=livugy9Ca1D/o0BR8zTZKaF20x
 v/BiGYOJmKmznWvsZ/LeezVXLNWGPNxdqr8t0gLl3cesDGvdD3tCZvxtSFlnZFVovNxj/mK298iek
 0PzkjaM1Myc0XbuOtxlK8KE6cpYEK9Z4KJNs5N8h9v4SkVFpGGTWi6RrkOJAEPIwrs5p5VV73ExvI
 N3Cu+pM0zDcHUXqhPn2Gchy2NOqfhwF6+RrNFsdiLTrk41NPigYn2AXNxj4EcuYzzeMF27Q+VEO3d
 NLGM5qKFZonzdcJkDlwjTR2/k5EvedYGIdcpzo5Z4XPzjkp07Dv97Hkm5PkexMyFxFW6/c7neboNe
 qNkT+y8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1w7ovk-0000000E6NX-1IDw;
 Wed, 01 Apr 2026 06:19:56 +0000
Date: Tue, 31 Mar 2026 23:19:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zorro Lang <zlang@redhat.com>
Message-ID: <acy5DBohMXkFXd-_@infradead.org>
References: <20260324025656.493776-1-chao@kernel.org>
 <acN4PWKHvk_33VB7@infradead.org>
 <20260331201105.xxjmqfne4rckc26b@doltdoltdolt>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331201105.xxjmqfne4rckc26b@doltdoltdolt>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1w7ovv-0000JJ-EH
Subject: Re: [f2fs-dev] [PATCH] common/rc: support f2fs in
 _require_fanotify_ioerrors()
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
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Apr 01, 2026 at 04:11:05AM +0800, Zorro Lang wrote:
> On Tue, Mar 24, 2026 at 10:53:01PM -0700, Christoph Hellwig wrote:
> > On Tue, Mar 24, 2026 at 10:56:55AM +0800, Chao Yu wrote:
> > > This patch allows to run generic/791 on f2fs.
> > 
> > When was this introduced?  This doesn't currently exist in mainline,
> 
> Hi Christoph,
> 
> g/791 and _require_fanotify_ioerrors was introduced in v2026.03.20.

I mean the f2fs kernel support, sorry.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
