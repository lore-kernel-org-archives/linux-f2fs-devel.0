Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9E9C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 Jul 2022 08:11:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oEnlI-0004Fs-K3; Fri, 22 Jul 2022 08:11:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+ac08b8ce4c4c68a722ed+6907+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1oEnlG-0004F2-V4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jul 2022 08:11:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ta3rvx+Batm6nlecC0K7iwKchb/Me2mo/w2bTMnndwY=; b=hQimG3DoFJAnkV9vHOHAQIccfi
 wAbw90SzKvMS+RvNz/r6i9OnT/Jo/UVv40RNBfZqQVa9NuPD8Im5gEU4lNKBBqLsBR3IisckrseZm
 Ai+/qsHs/29iL3LTCB1neXoxlIrkfkJyamyQKzDNuFCje4e/XGQXhGYGW8ycB3QiI5Iw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ta3rvx+Batm6nlecC0K7iwKchb/Me2mo/w2bTMnndwY=; b=hP5L6gK8NhHJQkF3gUApfBFcqR
 rlwI/yJ7GWDA1IamnvaKZpdBiQ/wAEbSnskeptUYs59jFeFFSWhXuUW0XoIQoHuaC9xC78pSoEJFz
 j5i3Kav+nTh3lxl/mgynVep9uE06J9Wk06zJxIoquRSAzy599KctNx7Vyjp+P3jqW/40=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oEnlG-006gxY-7W
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jul 2022 08:11:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ta3rvx+Batm6nlecC0K7iwKchb/Me2mo/w2bTMnndwY=; b=Icpp3ZraJ98dzkqejg7ojIFZlW
 twhBghYZj8E0XytNLt5zspXTcWQ9DdL0bSjxTxEf8HvC4iii/6mfrgHZqL+86uIfAarieFyUa4mZk
 QVCe6tpTIigKLnLYC0/U+Cwsn2ooqs/VGY+HpeCzDCbl1QRRbBVyRSGjTTATVDKHepfiwvvOq7X7f
 9ugB6djOL1o1F2qEXRT2AC456mpMcxlXm8ncni/gOi/3Ur5oa8ATDDRQd+3jGJ9ROxV9fIEMxTsR4
 heID/JaqnPVRGe58CI6SMsk28zG5vle3mGee6VSe1P61JQnjJxyIwKKABdDlsVZnth2Gd+iXmdprl
 TTE2a/fA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1oEnl9-000uTi-6h; Fri, 22 Jul 2022 08:11:43 +0000
Date: Fri, 22 Jul 2022 01:11:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <Ytpbv1sDoh8pqWXx@infradead.org>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-10-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220722071228.146690-10-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1oEnlG-006gxY-7W
Subject: Re: [f2fs-dev] [PATCH v4 9/9] xfs: support STATX_DIOALIGN
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
Cc: linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 22, 2022 at 12:12:28AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add support for STATX_DIOALIGN to xfs, so that direct I/O alignment
> restrictions are exposed to userspace in a generic way.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
