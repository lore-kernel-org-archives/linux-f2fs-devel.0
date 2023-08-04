Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD18C001DB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Aug 2023 20:35:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qS1Vh-0006Ii-03;
	Fri, 04 Aug 2023 20:34:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tytso@mit.edu>) id 1qS1Vf-0006Ic-Ej
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Aug 2023 20:34:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i+Cv8ZO3I5bUEr/K4+xoZ/gjA4JFPErOdbDf0LaFzCo=; b=fnm6XLYJb0F6ccBnncQVN9wqoP
 0VAT4ZlHmxB3YFhW2s3Z1whKQjqNgkKqRJ4fntiVB0+CF6UPBhN6i/zxJ6PVNtOeKvYKxt44symE/
 zvX7iJjV2hMWjAmV0tv6VRh8vFmJUyjP++GmdZhRDvkugOi/buT2w8E5Itgxge5i2jXk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i+Cv8ZO3I5bUEr/K4+xoZ/gjA4JFPErOdbDf0LaFzCo=; b=MAz/FHfP8PseclmvphjOULpBi2
 6i8biTZM3qwNVk48EQbaGULZV96ZEWgh1URUEahq3TLubcYvFhod0Mck4ALGkd7AhzTC3dPEsq6Dm
 ybvJ1HNkZuH/K045jNQDMjZvsRo11u5wgYgaFkfQwstG+XGuyv/G7equr0V3Ay1hJTho=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qS1Vd-0000GL-Vu for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Aug 2023 20:34:55 +0000
Received: from cwcc.thunk.org (pool-173-48-112-100.bstnma.fios.verizon.net
 [173.48.112.100]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 374KYOoW025102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 4 Aug 2023 16:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1691181272; bh=i+Cv8ZO3I5bUEr/K4+xoZ/gjA4JFPErOdbDf0LaFzCo=;
 h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
 b=LhpVy8vBk/XSt8GuwK8JeXWAhbhaGHwiCvogm7byiRopRon8u+Fy2XpuWbDJ/DJqp
 1MMHjMZrvP/bsYQt+4oPnfh3oX7+RXyu/JpuSynvYo8OM1HCFI//PZ6OtV7t48eW1k
 NczmO7BbNuqBpq+Z1Q/3jmfHsAXJRjU74h7ISZ3IYJA5kgGBxhqB59mAzguEkGCU4Q
 Bwd2anIeqw6Ugk0Z9GGvE76JN2snxvF4uJsmny2lVz8LKkRpZ1vWGxJrBJy7Lvy0+7
 VCsPzXGzk5tcsNFAq0U09qFE0XG9yw9L2KHuZ/yc1old2bUvgfhBiWegJLllkThH6J
 DmzoegwwJSRQg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id D311615C04F1; Fri,  4 Aug 2023 16:34:23 -0400 (EDT)
Date: Fri, 4 Aug 2023 16:34:23 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230804203423.GC903325@mit.edu>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-6-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-6-hch@lst.de>
X-Headers-End: 1qS1Vd-0000GL-Vu
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
 Christian Brauner <brauner@kernel.org>, linux-nilfs@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 "Darrick J. Wong" <djwong@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
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

Acked-by: Theodore Ts'o <tytso@mit.edu>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
