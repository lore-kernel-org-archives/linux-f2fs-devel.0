Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F2AC982FF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YoUNbO8FtFncUiDzoLcBEIO6fDwSB3bXnbtx3LhtPKM=; b=nI1hDBusNoW/U6PCks1CEAlLtf
	bHJLrtpLSvwfhZEBvi8WpyhXd1DI+W6dQH3F4GvdDJQdDngBtKRnJjhLfFixtYaFFno9HVFw27N+2
	DD8I4222/BZ2I5s9VVODAj780Owmfl0GT9tOGqcND1TPnuQDuF2iAoadXPU7XdWO4eJQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8zf3-0001iU-H8;
	Tue, 22 Sep 2026 12:31:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+a4e1fe537d2c1e8d4400+8430+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1x8zew-0001hx-Oi for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:31:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TPXKbsrM/p5YokizNFLlIdin91qu/W2cgdUmN8/lRek=; b=YWaqQR8Xi5Rj8AaWmp0V7ZUkIs
 n8MfR+oUnEODYZKn8OhCAvbkZQV5CjS9KLa0/XLaXK5nlLo7oqNg8GM06/6qpJJ71LZJQ3YBpReCP
 j4JBhTc3QjY4VhgiMekAcyrMvpeEbNCtlTT0pMhg2NS0lH7bChXS2/XJJgpJFx85XdZs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TPXKbsrM/p5YokizNFLlIdin91qu/W2cgdUmN8/lRek=; b=McqgXhXiO7Q03/E1TwwA8n8E33
 QB1VgWakoGJDyMGZjZFDtZJgC/MUuclaqjUL4FpR0yXFrpPSjiBoEgN++Jj/KASy9WCoFE5lwAiJZ
 aqhKPINY+es6A/p8lIM3lzle9jaKflzWVWxs3LIjnlx1SefRX9wQYdRn5f9sxbgAWD4Y=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8zew-00087t-6A for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:31:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TPXKbsrM/p5YokizNFLlIdin91qu/W2cgdUmN8/lRek=; b=O9lB0YuGKZDCkQ8DXB6+cM6Jxb
 Vdz7hj+5IBq9I2eoCBE80UDaZ0sXjEGTAQkJ1KkKdfhRXy5sPf2wcFqN9UykbtzUhn38pWaktW+0V
 ziktouxY6s6z/XmyhKaIW777QyquH1xHK4+8F0bXck9rl8iy0Zgea81TBcsnbGuPGmDcpS5HETVgI
 pY3OSd7XfZy6Mx8VTlf7hkciScELm9IXj4x0yLKRpfgdmrz8uXADt9vLSq34gW6FP4ppS8CESscWq
 eaoOZKCId4Otg99jEvP8YBsnppq7qL2A64bLgYS2xnnZ7jekzeXufwzr4bAefvkU9UOshuyDhNrsI
 aScKJB+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1x8zeq-00000005JU0-0Nai;
 Tue, 22 Sep 2026 12:31:36 +0000
Date: Tue, 22 Sep 2026 05:31:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <arJ1KAvP-4fWVvzW@infradead.org>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-13-aalbersh@kernel.org>
 <arIrtgZ3-9zNuru_@infradead.org>
 <arJFUV3WDkY6zmfD@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arJFUV3WDkY6zmfD@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1x8zew-00087t-6A
Subject: Re: [f2fs-dev] [PATCH v16 12/21] xfs: use read ioend for fsverity
 data verification
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Sep 22, 2026 at 11:13:57AM +0200, Andrey Albershteyn wrote:
> > And I think you always need to do the offload because fsverity can
> > synchronously read metadata.
> > 
> 
> hmmm not sure what case you see here.
> 
> Without integrity:
> For data reads we get here. Here, while verifing data page, fsverity
> requests reads of merkle tree pages which WILL NOT go through this
> path as no read completion is done for them.
> 
> With integrity:
> For data reads we get here. Here, while verifing data page, fsverity
> requests reads of merkle tree pages which WILL go through this
> path as they need integrity verification on the read completion.
> Therefore, to use this workqueue for merkle tree pages integrity
> verification we offload data block verification to fsverity
> workqueue.

Yes, but we want to be able to use the bio defer path for other
things including iomap error handling (I'm about to send a series
for that).  So please always make fsverity do it's thing so that
we don't add really complicated dependency chains.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
