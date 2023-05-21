Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5640BC77B7C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 21 May 2023 23:41:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q0sfu-0002rp-Bd;
	Sun, 21 May 2023 23:41:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1q0sft-0002rj-Hx
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 21 May 2023 23:41:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xi/1ic3ts0dI/zKAVwmjvawndGiVSi1VP8xFbd/Ve0E=; b=BqDWI+CFZShNh74fCteymm8xhH
 bNaE9+RIwodsYzjwWGriISo8zrGQRxdkG3TfcPdr9rt2SSne70jIf0LC7A2lcdMw5xEv1zN/lY0W8
 HTtmT5td8dJygm7itcEfLLeP8FCUhZPtPqO8Dt94PvPn8Nc01yOBYMQ74zQ4KPngCiJA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xi/1ic3ts0dI/zKAVwmjvawndGiVSi1VP8xFbd/Ve0E=; b=BTW3iXthghA4iR5ucPgA+AFEYC
 KLG2RFpkOut9mbA0x39/Q+epJv2h1WpL5itBrzN+atzD8WmS7zGrmbwHCcl23PyVu/lntD7ZHRx/O
 K6kQ+DF60ldlakcTU/h1vq/5iJw26WGTb5GtON6fCN13GSp7ZIMu7+S7D71V9FqI9Aos=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q0sfp-0004T4-A7 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 21 May 2023 23:41:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 41E7A60F36;
 Sun, 21 May 2023 23:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF259C433EF;
 Sun, 21 May 2023 23:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684712463;
 bh=tA12yQU00KKUJDHmMiS/p1BMYZTe42VhuQxJI9hnBGs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bbR+hubYRLAGzg/uGQW+S+uObtEMdvAC9Prq09XRey518FIX9V+FA9yn08nrOyJNo
 phX9SlbCCQp1tqYPJmwQQ7TYpLWkj6b+H3zMuc1Z7VQuG4Eo9Q/x02u3s+NMYDXZK7
 y6g4/CCC39Anez1oZFdvYg1ooCDtAlwpyilfm6Q6NNXW5yqA5BSTe0P3z5r+pwBHUD
 0on5F0vG1ouPX4IHgXYeHIp4iq7izeicWegN4YNYFIeZ8chatU4lAHZIfFgH6cpWn+
 WUW1P4+xbujvaU0L10MBQr77eKeg564VpiezTN64057zhcRO/0ww07EJx3udJ/fiyx
 NLclOBUpvfnRw==
Message-ID: <3efbf8c7-b3ad-fbca-f37e-a7b2fd78320d@kernel.org>
Date: Mon, 22 May 2023 08:40:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
References: <20230519093521.133226-1-hch@lst.de>
 <20230519093521.133226-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230519093521.133226-2-hch@lst.de>
X-Headers-End: 1q0sfp-0004T4-A7
Subject: Re: [f2fs-dev] [PATCH 01/13] iomap: update ki_pos a little later in
 iomap_dio_complete
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
 cluster-devel@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
 linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/19/23 18:35, Christoph Hellwig wrote:
> Move the ki_pos update down a bit to prepare for a better common
> helper that invalidates pages based of an iocb.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +		if (dio->flags & IOMAP_DIO_NEED_SYNC)
> +			ret = generic_write_sync(iocb, ret);
> +		if (ret > 0)
> +			ret += dio->done_before;
> +	}
>  	trace_iomap_dio_complete(iocb, dio->error, ret);
>  	kfree(dio);
> -

white line change. Personally, I like a blank line before returns to make them
stand out :)

>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_dio_complete);

-- 
Damien Le Moal
Western Digital Research



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
