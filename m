Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4EFC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 10 Apr 2022 06:27:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ndR2w-0007wE-Na; Sun, 10 Apr 2022 06:27:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <hch@lst.de>)
 id 1ndR2u-0007w4-1D; Sun, 10 Apr 2022 06:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iVxiLNmsOppkSMSfhqU/kcrH7CQ6JSiqPT21EkiHp10=; b=MaWlK3POsyArkW0Q14V8Ng7U0o
 cmSB7oP8SPp/rbKGyXKf5D7X2c8ELp8/JiG+e8lX3MbdRQJbcSmlJZAzFWGuLyp8QCnGIYajjLTLb
 Ewq1C6CVrSK16JgIqluwJI6KrsS6vFWBaJnnlwIRFPS5M0sm094HlXj475bA7kAguO00=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iVxiLNmsOppkSMSfhqU/kcrH7CQ6JSiqPT21EkiHp10=; b=gkmMMsobK8qIhf7VyleTV1MHaM
 bDh1Ua0Wbj4WQGFZvK0+2vGie1zRkBpD05X82dE9J1bob7nJFQYGe09Lm5WpRYYXW5bmci7sQLNkd
 gpQYn4jy4KPLYB8sXihwcOwWp+T02N6R5/pHePuqlwdNhvPrCAbR1lZ6ovK3jamdBkj4=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1ndR2s-00BUX5-E9; Sun, 10 Apr 2022 06:27:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 95E2B68AFE; Sun, 10 Apr 2022 08:27:26 +0200 (CEST)
Date: Sun, 10 Apr 2022 08:27:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Coly Li <colyli@suse.de>
Message-ID: <20220410062726.GB16234@lst.de>
References: <20220409045043.23593-1-hch@lst.de>
 <20220409045043.23593-27-hch@lst.de>
 <f01ac878-9b0d-972b-70dc-6f3f61b9947b@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f01ac878-9b0d-972b-70dc-6f3f61b9947b@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1ndR2s-00BUX5-E9
Subject: Re: [f2fs-dev] [PATCH 26/27] block: decouple REQ_OP_SECURE_ERASE
 from REQ_OP_DISCARD
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
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 dm-devel@redhat.com, target-devel@vger.kernel.org,
 linux-mtd@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org,
 linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 cluster-devel@redhat.com, xen-devel@lists.xenproject.org,
 linux-ext4@vger.kernel.org, linux-um@lists.infradead.org, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 David Sterba <dsterba@suse.com>, ceph-devel@vger.kernel.org,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 linux-raid@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-mmc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org,
 Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Apr 09, 2022 at 10:32:52PM +0800, Coly Li wrote:
>> Acked-by: Coly Li <colyli@suse.de> [drbd]
>
> Hi Christoph,
>
> My ACK is for bcache, not drbd here.

Fixed.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
