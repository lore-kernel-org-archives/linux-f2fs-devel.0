Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448ECEB64DD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Aug 2023 18:04:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qRcgk-0007oV-Ld;
	Thu, 03 Aug 2023 18:04:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1qRcgj-0007oP-Hj
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Aug 2023 18:04:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=awJQUoCTt8SaB0DubB61kgnpejdGffQxJU6YAMMaHHw=; b=gXpWLt6gjTH1pVusNDuoXrf3dG
 crsjzmjJsgY3DhNxTRWBMeIGTVaWy4SJUr7myPaKFCNmCIFd2UqJ9tuwHr5AaYkNm1TKpds1yoTgC
 8mnL5F7WIeppXqJQnyKYkxuVnCSx1oj/LYLe7+mPbp9VSYEMMZSOH1nGR6fWJzYo14ck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=awJQUoCTt8SaB0DubB61kgnpejdGffQxJU6YAMMaHHw=; b=eqTTkRq5816/ELKLQxxBXyQQmh
 mAzTPbWBZbggIPKhGFkQF0y8gEuYiRV+ya7UY0oKNuwydybKNGvjUY4lwqRPFrUYz4ufR0DFObhjp
 z8yCsNd8V6qXqCRgbNzl9ZLWH0xfB/URLxc7lir+lTFFxkE4pXcP2U0Pd8ynRG0cI37s=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qRcgi-00078l-Mf for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Aug 2023 18:04:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EC1FE61E8C;
 Thu,  3 Aug 2023 18:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC28DC433C7;
 Thu,  3 Aug 2023 18:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1691085874;
 bh=eCLuzrspl2iA9AJzB2yLuYbX5hhAX4e4sNYlXnEkxWg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dl7ePWst+Fn/zB+vTBNyZ407Av71NETccv5s5eg1ogo6vQAFVqCGX2QEDriBXA9la
 h2aslHTXX2U2bsrocTVsZ1nmjo4B6UBq2h91Gx2vahiPi4QQ78UmzOI8LXbNUflrDL
 FAPNfKTTR1fZ0j6/+PdOIbgJ66CpgAdLA76gvCOEtrpv7EtMMR+ReL9GxeLci5PfKd
 P9uXqdRuUap6ECaZ1XEHmFvLYlyxeOd/uUKnWx2wJpCmXSIjDwP0TsCg/27xnBkTRk
 R9xAA/eehNcaM8eGXyancfI9Oj6aRKq8jTXGn9A39bXCqYJ7/awLi7s6Iyj1xU7PWz
 dl2fOfiODVuqQ==
Date: Thu, 3 Aug 2023 20:04:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230803-decken-lernen-3939eb320283@brauner>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-2-hch@lst.de>
X-Headers-End: 1qRcgi-00078l-Mf
Subject: Re: [f2fs-dev] [PATCH 01/12] fs: export setup_bdev_super
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

On Wed, Aug 02, 2023 at 05:41:20PM +0200, Christoph Hellwig wrote:
> We'll want to use setup_bdev_super instead of duplicating it in nilfs2.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
