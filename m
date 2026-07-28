Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EB3C53219
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Jul 2026 03:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ccYcHN30qiZuX4zXd8QJ2HcnsIxOaUb2RMsPwO8+1jk=; b=KMBhKCSeC1bWy9SNsA6vRaCooM
	W9Mlq+kmrEntbt3QvUhGkXbAVys2zBBaQPP/qBSU7Isqdr2dizzHogKNPz5ULqcNqHQziFgq2i59n
	xOTab2PYz+RUNraI8iQLJQinviAKsNHXfH5d3bXzZy8sVax9huDau31JUDd2Q5GJHRlI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1woYM5-0004Ci-H6;
	Tue, 28 Jul 2026 03:19:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+695790e2dd2d1c4e9532+8374+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1woYLo-0004CM-1u for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 03:19:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xSdhEtN2PiUGg1VMGAg7W4TmVSqAh9ZHoSwcvtwCMTk=; b=kPDJQuuhWD+cQ7NKw1E3SQwgs2
 WWw0f/wGXl3xAIJI+5T8Ym9wDxwKNj9ZiMuIM3Ag4LJn0ryQyl+kR8pS30LndPFjmK1xWAvvo3EtT
 4LZKIacLf/yFYPedr5rhX8gpqlBvC8E4crx+f5Fe3pmbW+0yZJtiSJk4nwfMFoyZ9+Pk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xSdhEtN2PiUGg1VMGAg7W4TmVSqAh9ZHoSwcvtwCMTk=; b=i1DNRuKSfoiqA9pwdz/Jg/acA7
 5NPo6/yaBsR8xa6+sTWxbZC/chM68d5I/T0ionxIr7xp4LYzCTaafItRtchN/eLV+LvQbsKKtk3M7
 uh2WS7sPKEBhH8neDmDBYDXLTi6Q2ZahlkFcybKV7Qj8RuKX5JBgxhlsASZjaJn1TXOo=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woYLr-0005Uw-FQ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 03:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=xSdhEtN2PiUGg1VMGAg7W4TmVSqAh9ZHoSwcvtwCMTk=; b=0mXvgFf/6FbI/Zy5fdrPBTq2n0
 MSsJdKT01Tp8F4Sd+8R0GAIB0XBX6aXiEjhov1lj0t4IcbE/Wov09YjFcFEIzR+7JW+JeDaYrZwCt
 vMzAW7Z8bXlQnpPg4RxW34Rs1x4683CADzdcAbkl/Up2ziDgWg1ADpB9m9uS9Od2Oy2VBb46U2kpU
 vgsMCcn3NJ9o/kPdgfTVGw3TwGsOJL0nvkQN5yaKP0jdioSUxMN5I1CWZPgaLkw6uvQNlM3sPkvBu
 dgBBJZMJPwYDC8ezwZy39y8rvjrmbXEGojzkWgJITIPUvL/AuHPmPutufSkqbNXQaK2Qnwr88183+
 XWhV9r3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1woYLi-00000004Jxz-0oFO;
 Tue, 28 Jul 2026 03:19:22 +0000
Date: Mon, 27 Jul 2026 20:19:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Vacek <neelx@suse.com>
Message-ID: <amgfuk12imPN2XJe@infradead.org>
References: <20260724133328.1837318-1-neelx@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260724133328.1837318-1-neelx@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1woYLr-0005Uw-FQ
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
Cc: hch@infradead.org, djwong@kernel.org, zlang@redhat.com,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 David Sterba <dsterba@suse.com>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 24, 2026 at 03:33:16PM +0200, Daniel Vacek wrote:
> This is a rebase and cleanup of older patches [0] from Sweet Tea and Josef
> fixed to work with the recent kernel and btrfs-progs changes.

I'm not sure if you post this just for reference or what the intent here
is, especially with a cover letter like this that doesn't have much
information.

Before we doing anything for the btrfs-specific fscrypt changes in
xfstests, those changes should be accepted upstream first.

Maybe some thing like splitting tests might make sense without that,
but then it should be posted separately.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
