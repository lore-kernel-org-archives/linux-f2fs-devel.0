Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B07C77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Jun 2023 04:07:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q4Zay-0003jh-Bs;
	Thu, 01 Jun 2023 04:07:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tytso@mit.edu>) id 1q4Zaw-0003jV-HB
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Jun 2023 04:07:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pcqpw1QSxFJZ0laXH9+QWQRNycHSOlFzpRuiP0DXgks=; b=gTNFGkPsUK8cwxvQqCvG5n2LCb
 y1VxX87oZJ/3v3LT6CxN26ywElnD6ucNvPQdmSlGbjt9sCDhNs/A6N59546Rn7GFOOD+ktwH4HhbD
 MQ8m5D0PXjY9uIh0xX+IQxUlqoHn/DanbKK98ZPq1jzPj0KQ/Lihjh9vv6sXsqfWkydQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Pcqpw1QSxFJZ0laXH9+QWQRNycHSOlFzpRuiP0DXgks=; b=BXmX05M+kaxrkMv8GTX9eR4xUo
 dqkLEiV05O2WqTTzFlIdza+JTtqoA75CV90TC+qWEOko2llD9buHCl1wjcezvvy2kBUeaSeea4EF7
 qQoIZ19Hlob8s3ccNIMQ1czwsVJVvFbuZGIxy3/VIWrqTbld50F52tOEiPujTXBn0I4c=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q4Zau-0001UZ-D3 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Jun 2023 04:07:26 +0000
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net
 [173.48.119.27]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35146rfn026616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 1 Jun 2023 00:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1685592418; bh=Pcqpw1QSxFJZ0laXH9+QWQRNycHSOlFzpRuiP0DXgks=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FjRInq5K/Q3cIGhgP5U9E5iShqilarKB9GHVrxpK7UTub19CoZpiUGVYb2Kd/qTiO
 60WVYoMBBeuCMkLY0PBqv2lvD0rBxGigRShQtB3TFTi72Q36gZXIOQZlVfbKoWgQja
 MiN7Kpoj30BBOMjqnNaw5noqs9AprbSoEVjkZmfrr0gkBtRm/pfeSS7xWPQAA92PTB
 7+LobHEEkerjTevwU1Dz3lLidbde40aBREVBPnGEJcvu/AEVDU1auLGuWQOWhoRvJL
 AB5IgvwmjasK1wNGrzxcGznmZSUPOPGT3bAl3rdT3hOxMOgEqb0Ucdg/1RPWYp/3Vw
 Jt3BLckbYB7sw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id 5765C15C02EE; Thu,  1 Jun 2023 00:06:53 -0400 (EDT)
Date: Thu, 1 Jun 2023 00:06:53 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230601040653.GB896851@mit.edu>
References: <20230531075026.480237-1-hch@lst.de>
 <20230531075026.480237-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230531075026.480237-4-hch@lst.de>
X-Headers-End: 1q4Zau-0001UZ-D3
Subject: Re: [f2fs-dev] [PATCH 03/12] filemap: update ki_pos in
 generic_perform_write
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
 Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, May 31, 2023 at 09:50:17AM +0200, Christoph Hellwig wrote:
> All callers of generic_perform_write need to updated ki_pos, move it into
> common code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Xiubo Li <xiubli@redhat.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Acked-by: Darrick J. Wong <djwong@kernel.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
