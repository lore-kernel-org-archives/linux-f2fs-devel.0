Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C39EA3F27
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SGlJWkqH3YvEo6V+/NyZRVj++a7K/VzM9CEO+YZDN5c=; b=aMtRcI6IfLjw/MxGoOx0ZJ/Iun
	PxQIdv7qpIX7BRGiNyCvcrXQyvcgWv9nL4CnQESN3RuN8EOTUUxIowGI8ZQly2WnbHMA8pnGO6e1b
	LNZcUFerVHuS6+ppXKTczj7k08VjtvCyD17SguexdmTqCmFkTwTjbqW8EYtS0Ye4DCI4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vqCXS-0000Cu-Sg;
	Wed, 11 Feb 2026 15:54:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vqCXR-0000Cb-BA
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Feb 2026 15:54:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bQpzoySm9WxiL3m+AQgKRKyIaZ51ZZa5CoaKD8psjFk=; b=TX9p9wVyh/qSi07ca22pTPxvmc
 IgRvlLVvjZg/vKPoa2frySeyo1oF9qCEfUPRB3ltvT476xsCX+UdygOj5UCAV0+pMmYmjGwEsc/3Q
 ioXSRlcu1bhG8TtyJyctupXdX4Xz5pCRVVAPIBsze76UqQuizrQbZH1DyFWM3gk5K4T4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bQpzoySm9WxiL3m+AQgKRKyIaZ51ZZa5CoaKD8psjFk=; b=VtgtNpHkvctF8Wa8yfHzccMmdm
 yeTq0RgAFQTlOZEn2LP+zmcy8bR9PGnlvJTDGGTAmR8xFIk9RE7FfiMX3vfrrrodOiu52ddZM1bN+
 N9wrtSWGTzb+iadGa01xI0EEgWf+mTSbDpd74BZQMZncoJtar4F5jR+0GXuty59zFm/s=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vqCXQ-0004ci-VH for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Feb 2026 15:54:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 35A4668C7B; Wed, 11 Feb 2026 16:53:47 +0100 (CET)
Date: Wed, 11 Feb 2026 16:53:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Message-ID: <20260211155346.GA10445@lst.de>
References: <CGME20260211070533epcas5p32f50f317b20250bb61b1b5a0b3a2a5d9@epcas5p3.samsung.com>
 <20260211070057.22001-1-kundan.kumar@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260211070057.22001-1-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vqCXQ-0004ci-VH
Subject: Re: [f2fs-dev] [PATCH 0/4] Avoid filesystem references to writeback
 internals
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
Cc: brauner@kernel.org, jack@suse.cz, agruenba@redhat.com,
 pankaj.raghav@linux.dev, djwong@kernel.org, anuj20.g@samsung.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 gfs2@lists.linux.dev, mcgrof@kernel.org, viro@zeniv.linux.org.uk,
 anna@kernel.org, gost.dev@samsung.com, jaegeuk@kernel.org,
 vishak.g@samsung.com, linux-nfs@vger.kernel.org, hch@lst.de,
 trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Looks fine as a cleanup, but maybe add comments that these functions
must not be used by file systems that support cgroup writeback and
thus can have multiple bdi_writeback structures per bdi?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
