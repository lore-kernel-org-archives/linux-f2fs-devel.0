Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32023C7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 09:00:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6p1s-0005RY-OU;
	Wed, 07 Jun 2023 09:00:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1q6p1r-0005RR-3N
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 09:00:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t4qHSZMzs3GXEE/fiVPPs4Q+ZH4rYSYVL24l6cHecBQ=; b=kKBsNbySw8fYe4mzbV3EDPmM4V
 1caJnhBffZe4M1YiqJIyQBxuK1BLVqmLj+ag3UPKNWCJE0kLGdR7L/LeAc7eMRF2PpFrkkhF4vkba
 klw5q5S4ODJR0pRI1lq3c2Nym0tvAwQ+aWH88APch8cDtwqdLxuBxQfi25/T2Ay2Tm1k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t4qHSZMzs3GXEE/fiVPPs4Q+ZH4rYSYVL24l6cHecBQ=; b=M0V1SMbkhRdriKG6CjlB6c4g5U
 bmF3Iy1uToEIKaBUZNYwQfefPELoH0OEQ4NMmPh7Jdb54052MH+PK1yVitmKYgARMhodrQVzn3Isc
 lqiWeQ+4K5fUUpY9ccMBY9H+YPDGDI4h/hKQjDLwbPQCpfXVimkzLnQYadRvmTnAzTSI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6p1q-00054P-T8 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 09:00:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 80F3863C9A;
 Wed,  7 Jun 2023 09:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6B9C433D2;
 Wed,  7 Jun 2023 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686128424;
 bh=M5xM1l9LuXkX4mSzz59D4IdQFYmmNTr6OfgkeVyfa04=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bkgRvGgC50EeuypHe3xl97j+bK6/ZhC9326XXBYH1ZIWYaQ5jbu1O85bi3HGmv9M+
 hZ2SFMqNmWRyraR3Jgx4RRg8awjy8xDqCx+4vNdQpqr+khy+3Nr2thG3oUeGWCmFLy
 XyvLCHm2vTS/PPKFg0NhX/7Rvav0gZ/EJtvHCBmt00R9oRm3Ttf4E19bdvBrMVREuf
 /zBjY37bjH2obx9yTShQpHDAYvGzclq+GoqwGhXKZinmsKkN75qgYYwu5ZHTg6eiYP
 J5jVActoZkfoLY/PBMoBsxKMx6RMvbVXquwF1Lct1mLaflpQuIgCkcbVYTKwI3tb6X
 079ePZ3MnBG6Q==
Date: Wed, 7 Jun 2023 11:00:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230607-exakt-fahrzeit-31037992dd33@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-24-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-24-hch@lst.de>
X-Headers-End: 1q6p1q-00054P-T8
Subject: Re: [f2fs-dev] [PATCH 23/31] mtd: block: use a simple bool to track
 open for write
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
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-nvme@lists.infradead.org,
 Phillip Potter <phil@philpotter.co.uk>, Chris Mason <clm@fb.com>,
 dm-devel@redhat.com, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Pavel Machek <pavel@ucw.cz>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Jack Wang <jinpu.wang@ionos.com>, linux-nilfs@vger.kernel.org,
 linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 linux-pm@vger.kernel.org, linux-um@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 06, 2023 at 09:39:42AM +0200, Christoph Hellwig wrote:
> Instead of propagating the fmode_t, just use a bool to track if a mtd
> block device was opened for writing.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
