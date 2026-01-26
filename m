Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8544C88E42
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jan 2026 04:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uFmy4qgvKdYZLKZ9Hdvo0yBRUUlV+TDjLMmML6XmhiU=; b=kaEMIaOlBdPvIMddogAJWGUv4v
	4yYHH0wFZHwcFOd5a3+O6zt8Mt5rmC97DIQMJgkFAYlf6JxHeFM1/tqWgBnYdCuSHXSOE+/DSXi3O
	qAwbQz+IU17epaZJOjJ1X9I7ZvH3vBjV59mQ9WbxWB9CKelEtIf9V64riz/hiKrGm6Y8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkEfG-0002Bj-Kw;
	Mon, 26 Jan 2026 04:57:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vkEfF-0002Bd-7q
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 04:57:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CwxH6H2CfkT8iMZqvJXDnqSuSDUBr+iSR8mDT1/rG18=; b=j0/tBnUme2cMLPP52kVLr9CM7h
 aqSGpm3gIs1YCrX5vb6JXHGB0IRxlrelR4WpzD47+k/BbfKnLZ+cgjCv7AKWZjEmoU7oocqPal/V5
 TDldpOzW8BHQBQ4+SphYTSvEDQgCnuzm4Z05DgaPb6evyxB2sjigDoCFvyJxEouf4zNw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CwxH6H2CfkT8iMZqvJXDnqSuSDUBr+iSR8mDT1/rG18=; b=b6whU8Yym1fMzkqVCbBwsxL5Zv
 fEt+K/3fKhJ+b3jOMll+wgirPHhMKyreeX5dsWFkPyEeWXeMnXSIRh08yi4DVe18/1bN4Xu54FCpx
 3SGURKT6Yn3B2FtY/TL+Fp3lPXfX/jMGHpU5KMDM1P30Li7Ms61ibaz/0QB3OxaUVeYA=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkEfE-0002EC-Nq for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 04:57:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F3EC3227A88; Mon, 26 Jan 2026 05:57:16 +0100 (CET)
Date: Mon, 26 Jan 2026 05:57:16 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Message-ID: <20260126045716.GA31683@lst.de>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-5-ckulkarnilinux@gmail.com>
 <942ad29c-cff3-458f-b175-0111de821970@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <942ad29c-cff3-458f-b175-0111de821970@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vkEfE-0002EC-Nq
Subject: Re: [f2fs-dev] [PATCH V3 4/6] nvmet: ignore discard return value
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
Cc: "cem@kernel.org" <cem@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "song@kernel.org" <song@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "agk@redhat.com" <agk@redhat.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "snitzer@kernel.org" <snitzer@kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "yukuai@fnnas.com" <yukuai@fnnas.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jan 24, 2026 at 09:35:16PM +0000, Chaitanya Kulkarni wrote:
> On 11/24/25 15:48, Chaitanya Kulkarni wrote:
> > __blkdev_issue_discard() always returns 0, making the error checking
> > in nvmet_bdev_discard_range() dead code.
> >
> > Kill the function nvmet_bdev_discard_range() and call
> > __blkdev_issue_discard() directly from nvmet_bdev_execute_discard(),
> > since no error handling is needed anymore for __blkdev_issue_discard()
> > call.
> >
> > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> > ---
> 
> Gentle ping on this, can we apply this patch ?

Are we down to three patches now?  Maybe resend the whole series and
get ACKs to merge everything through the block layer?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
