Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED71BEB64DD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Aug 2023 18:10:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qRcmc-0000sC-Ud;
	Thu, 03 Aug 2023 18:10:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1qRcma-0000s3-JI
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Aug 2023 18:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q7SObbTF1yfGSH6tv6wtRCFB84lk2kXVjxLa8BAfcQg=; b=MZL9K0+xu+duilDcMKaHllBKSF
 KNC12VyqDiijfdFWSwJfcfebjR0MFoy5fZBhJhJbMECEDX2PCF6qHyUk/7QvxLNZlSoJbwTGcClir
 JxNcr+b7GpUBO1m1zda9etfMtDj0MKqN1O7/FZS3ta57oHFW2T+zNjzyNXX6NfHO3uWY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q7SObbTF1yfGSH6tv6wtRCFB84lk2kXVjxLa8BAfcQg=; b=ax3NZxzivoH1T7kkkkIIql/Qyc
 O6tsdQE2g669OstllWZJl9l+Jks4mnj7Y6tApu/5EcF3kd1xDtxkKUNXU49VcI5R/Y7THYPZCKa+S
 m5qJzacKaqphnjJPayswGxr96cinC6HfhBNZikn8+lahm+nviz7MuTYjJebPI+ThBcNA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qRcma-00CBLo-1p for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Aug 2023 18:10:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7217461E59;
 Thu,  3 Aug 2023 18:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888DDC433C9;
 Thu,  3 Aug 2023 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1691086237;
 bh=l09B4wLLhFie262qfmXA0CveYXOk2JvcJhfIRHAAK4o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MfiQ2gN2z2YzxyG/O3d7GtOXWQ2m6fL49xtZB4NWZWBeLVPdsc4kAabQ8itROH1It
 21T7P0djO9aOpJ5WwnCRkrrEtUHf3uKDbJ1mew383Lt/fdb86kisMz4kq2oDhmj+Cm
 qurmwE1LM1WqgSAR9efG5Fq8Jmbkdlj14b21Xuzk8HjcYIDPRI7lsMh0d3Vha5yCln
 hqeMFKrHRptRejegCyC4bSWm4MvvIMFg9H5P/Pc9QiSz1UCps/9lt5Vhh/F+Sfy4Tb
 Nq31kTyt7Nxxjms3i402ilz2UjoNv7r6S2nPEZ6K3nTsNAyvejcB145/0RXS80IINs
 Cqrwcv6sNoi5A==
Date: Thu, 3 Aug 2023 20:10:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230803-zecken-oberhalb-e30c55d66648@brauner>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-6-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-6-hch@lst.de>
X-Headers-End: 1qRcma-00CBLo-1p
Subject: Re: [f2fs-dev] [PATCH 05/12] ext4: make the IS_EXT2_SB/IS_EXT3_SB
 checks more robust
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nilfs@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Aug 02, 2023 at 05:41:24PM +0200, Christoph Hellwig wrote:
> Check for sb->s_type which is the right place to look at the file system
> type, not the holder, which is just an implementation detail in the VFS
> helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
