Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD91EB64DD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Aug 2023 18:15:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qRcrW-0005fm-M6;
	Thu, 03 Aug 2023 18:15:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1qRcrW-0005fg-3V
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Aug 2023 18:15:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IVySodCPrNfEpsA9iYNRPXBMJ7FTDZ9Jcs3M9WPQ+Ww=; b=a2wvgLKvRDmT2cmkwXeWvx6BaW
 KGmzejB2LJus6aUbWoiNmEE7LwfWK5bVnS8XcOJy0vgbrpkK1RgFKVO3sgNud7jMnzoJ+i76mZZ2/
 cBksBUCBDU1M5W/F3Wq76pG29efkIRxirtjA7Vu0xo1TUmYRhNRbshju4appOEXc6/8w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IVySodCPrNfEpsA9iYNRPXBMJ7FTDZ9Jcs3M9WPQ+Ww=; b=mLqfYH2tS4TxlN2wyb97jFjQ44
 XIXFhVVxQ9KWWVKptqg15VaX9Sh31MJwtVEMyUNiJAZohUjH8QP2UEsTnKlt3030irYkwfZ9AmRt/
 ydbIy+nICacSj/4YDL9XPoswnzUjVaR4t/uUX8lSqIr8tp7mJGRMJZyEhKPie4UToTt4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qRcrT-0007YM-K5 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Aug 2023 18:15:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0384C61D99;
 Thu,  3 Aug 2023 18:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60162C433C8;
 Thu,  3 Aug 2023 18:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1691086541;
 bh=Yz12o17pxjfv8UNlGb+RqV6iHvHIX5yYabFhIVcGnJQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NzNzQ0kZIAWvy0jQWijO38E4IFU1ELuOTm+2z0/vri0vio9s55oaqAQUbTAugZAIc
 pzSwoiINevuBV/XhzNXc0q3NFdO0ZzAFSLxi3cGXgl3HAJB+X2Uh/r/FdNfEqxzs+x
 oEq7YaNNZC/rU+FCceLfXnczQ2a6sngVIJgi7nDzGkT1xBRDxTdPkZIen5+avgHd07
 8LXZzFT3Mn8qRcc0ic5S1kmXh1ScTSp3TgroiVqjyefr1jttGt6WWRWdWDbRFCjKZx
 XR0/Ri/7v2mM1CSXfr+YKoex1c07NyImzjyMt49SbRHVJ4+fuKehgj3MggKmlENRpl
 ceZJCjJnHL38w==
Date: Thu, 3 Aug 2023 20:15:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230803-hergibt-nachzahlen-296067ae0bb8@brauner>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-9-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-9-hch@lst.de>
X-Headers-End: 1qRcrT-0007YM-K5
Subject: Re: [f2fs-dev] [PATCH 08/12] fs: export fs_holder_ops
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

On Wed, Aug 02, 2023 at 05:41:27PM +0200, Christoph Hellwig wrote:
> Export fs_holder_ops so that file systems that open additional block
> devices can use it as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
